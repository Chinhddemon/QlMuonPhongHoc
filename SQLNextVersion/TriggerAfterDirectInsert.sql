--MARK: Insert trigger after Insert data
GO

CREATE TRIGGER [dbo].[BlockDeletedFromAttributes_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
AFTER INSERT, UPDATE, DELETE
AS
	BEGIN
        SET NOCOUNT ON

        IF EXISTS (
            SELECT 1
            FROM deleted AS d
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON d.idNhomToHocPhan = nthp.idNhomToHocPhan
            WHERE nthp.startDate <= GETDATE() AND nthp.endDate >= GETDATE()
        )
        BEGIN
            RAISERROR ('Cannot insert, update or delete NhomToHocPhan when startDate and endDate are between current date', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Loại bỏ nhập liệu chi tiết
ALTER TRIGGER [dbo].[OverrideOnAttributesWhenInserted_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
INSTEAD OF INSERT
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS(
            SELECT 1
            FROM inserted
            WHERE mucDich <> 'TH'
        ) -- Nếu là nhóm tổ học phần không phải thực hành
        BEGIN
            INSERT INTO [dbo].[NhomToHocPhan] (
                idNhomHocPhan,
                maGiangVienGiangDay,
                nhomTo,
                mucDich,
                startDate,
                endDate
            )
            SELECT
                idNhomHocPhan,
                maGiangVienGiangDay,
                0,
                mucDich,
                startDate,
                endDate
            FROM inserted
            RETURN
        END

        INSERT INTO [dbo].[NhomToHocPhan] (
            idNhomHocPhan,
            maGiangVienGiangDay,
            nhomTo,
            mucDich,
            startDate,
            endDate
        )
        SELECT
            idNhomHocPhan,
            maGiangVienGiangDay,
            (
                SELECT COUNT(*) + 1
                FROM [dbo].[NhomToHocPhan] AS NTHP
                WHERE NTHP.idNhomHocPhan = inserted.idNhomHocPhan
                    AND NTHP._DeleteAt IS NULL
                    AND NTHP.mucDich = 'TH'
            ),
            mucDich,
            startDate,
            endDate
        FROM inserted
    END
GO

ALTER TRIGGER [dbo].[OverrideOnAttributesWhenInserted_NhomHocPhan]
ON [dbo].[NhomHocPhan]
INSTEAD OF INSERT
AS
    BEGIN
        SET NOCOUNT ON

        INSERT INTO [dbo].[NhomHocPhan] (
            idHocKy_LopSinhVien,
            maMonHoc,
            maQuanLyKhoiTao,
            nhom
        )
        SELECT
            idHocKy_LopSinhVien,
            maMonHoc,
            maQuanLyKhoiTao,
            (
                SELECT COUNT(*) + 1
                FROM [dbo].[NhomHocPhan] AS NHP
                WHERE NHP.idHocKy_LopSinhVien = inserted.idHocKy_LopSinhVien
                    AND NHP.maMonHoc = inserted.maMonHoc
                    AND NHP._DeleteAt IS NULL
            )
        FROM inserted
    END
GO
