GO
-- MARK: CheckOnAttributes

-- CREATE TRIGGER [dbo].[CheckOnAttributes_NhomToHocPhan]
-- ON [dbo].[NhomToHocPhan]
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     IF EXISTS (
--         SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NhomHocPhan] AS NHP ON i.IdNHP = NHP.IdNHP
--         INNER JOIN [dbo].[HocKy_LopSV] AS HKLSV ON NHP.IdHocKy_LopSV = HKLSV.IdHocKy_LopSV
--     WHERE i.startDateTime < HK.startDateTime OR i.endDateTime > HK.endDateTime
--     )
--     BEGIN
--         RAISERROR ('startDateTime and endDateTime should be within startDateTime and endDateTime of HocKy', 0, 0)
--     END
-- END
-- GO

CREATE TRIGGER [dbo].[CheckOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON i.idNhomToHocPhan = nthp.idNhomToHocPhan
            WHERE i.startDateTime < nthp.startDate OR i.endDateTime > nthp.endDate
        )
        BEGIN
            RAISERROR ('Can insert or update LichMuonPhong but startDateTime and endDateTime should be within startDate and endDate of NhomToHocPhan', 0, 0)
        END
    END
GO

CREATE TRIGGER [dbo].[CheckOnAttributes_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON;

        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
            WHERE i._TransferAt < DATEADD(MINUTE, -30, LMP.startDateTime)
                OR i._TransferAt > LMP.endDateTime
        )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update MuonPhongHoc _TransferAt must be between endDateTime - 30 minutes and endDateTime of LichMuonPhong with idLichMuonPhong = %d', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- MARK: CheckReferenceToTables

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_QuanLy]
ON [dbo].[QuanLy]
AFTER INSERT, UPDATE
AS
	BEGIN
        SET NOCOUNT ON
        DECLARE @idTaiKhoan VARCHAR(50) = (SELECT CONVERT(VARCHAR(50), i.[idTaiKhoan]) FROM inserted i)

        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'MV' OR VT.[maVaiTro] = 'MD' OR VT.[maVaiTro] = 'MM' OR VT.[maVaiTro] = 'MB' OR VT.[maVaiTro] = 'A'
        )
        BEGIN
            RAISERROR('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''MV'' or maVaiTro <> ''MD'' or maVaiTro <> ''MM'' or maVaiTro <> ''MB'' or maVaiTro <> ''A''', 16, 1)
            ROLLBACK TRANSACTION
        END
        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'U'
        )
        BEGIN
            RAISERROR('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''U''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_GiangVien]
ON [dbo].[GiangVien]
AFTER INSERT, UPDATE
AS
	BEGIN
        SET NOCOUNT ON

        IF NOT EXISTS (
			SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'L'
		) 
        BEGIN
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''L''', 16, 1)
            ROLLBACK TRANSACTION
        END
        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'U'
        )
		BEGIN
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''U''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_SinhVien]
ON [dbo].[SinhVien]
AFTER INSERT, UPDATE
AS
	BEGIN
        SET NOCOUNT ON

        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'S'
        )
        BEGIN
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''S''', 16, 1)
            ROLLBACK TRANSACTION
        END
        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] = 'U'
        )
        BEGIN
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''U''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

-- MARK: BlockDeleteFromTables

CREATE TRIGGER [dbo].[BlockDeleteFromAttributes_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER DELETE
AS
	BEGIN
        SET NOCOUNT ON;

        IF EXISTS ( 
                SELECT 1
        FROM deleted i
        WHERE _TransferAt IS NOT NULL
            AND _ReturnAt IS NULL
            )
        BEGIN
            RAISERROR('Cannot delete MuonPhongHoc when _TransferAt is not null and _ReturnAt is null', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO


-- Pretend INSERT, UPDATE NhomToHocPhan when attribute NhomTo = 0 and NhomTo <> 0 exists for the same IdNHP
-- CREATE TRIGGER [dbo].[CheckOnAttributes_NhomToHocPhan]
-- ON [dbo].[NhomToHocPhan]
-- AFTER INSERT, UPDATE
-- AS
--   BEGIN
--     SET NOCOUNT ON;

--     IF EXISTS (
--       SELECT 1
--       FROM inserted AS i
--       WHERE i.NhomTo = 0
--       AND EXISTS (
--         SELECT 1
--         FROM [dbo].[NhomToHocPhan] AS LHP_S
--         WHERE LHP_S.IdNHP = i.IdNHP
--         AND (LHP_S.NhomTo <> 0 OR LHP_S.NhomTo <> 255)
--         GROUP BY LHP_S.IdNHP
--         HAVING COUNT(LHP_S.IdNHP) > 1
--       )
--     ) 
--     OR EXISTS(
--       SELECT 1
--       FROM inserted AS i
--       WHERE i.NhomTo <> 0 AND i.NhomTo <> 255
--       AND EXISTS (
--         SELECT 1
--         FROM [dbo].[NhomToHocPhan] AS LHP_S
--         WHERE LHP_S.IdNHP = i.IdNHP
--         AND LHP_S.NhomTo = 0
--         GROUP BY LHP_S.IdNHP
--         HAVING COUNT(LHP_S.IdNHP) > 1
--       )
--     )
--     BEGIN
--       RAISERROR ('Cannot have NhomTo = 0 and NhomTo <> 0 for the same IdNHP in NhomToHocPhan', 16, 1)
--       ROLLBACK TRANSACTION
--     END
--   END
-- GO

-- Triggers need to check:
-- Block UPDATE, DELETE NhomToHocPhan when ngay_BD and ngay_KT of NhomToHocPhan is between current date
-- INSTEAD OF UPDATE, DELETE NhomHocPhan when ngay_BD and ngay_KT of NhomToHocPhan referenced to NhomHocPhan is between current date

-- Triggers need to add:
-- Check On Attributes for NhomToHocPhan when ngay_BD and ngay_KT of NhomToHocPhan is between startDateTime and endDateTime of HocKy
