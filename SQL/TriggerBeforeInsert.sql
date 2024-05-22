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
--     WHERE i.startAt < HK.startAt OR i.endAt > HK.endAt
--     )
--     BEGIN
--         RAISERROR ('startAt and endAt should be within startAt and endAt of HocKy', 0, 0)
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
            INNER JOIN [dbo].[NhomToHocPhan] AS LHP_S ON i.idNhomToHocPhan = LHP_S.idNhomToHocPhan
            WHERE i.endAt < LHP_S.startAt OR i.endAt > LHP_S.endAt
        )
        BEGIN
            RAISERROR ('endAt and endAt should be within startAt and endAt of NhomToHocPhan', 0, 0)
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
            WHERE i._TransferAt < DATEADD(MINUTE, -30, LMP.startAt)
                OR i._TransferAt > LMP.endAt
        )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('_TransferAt must be between endAt - 30 minutes and endAt of LichMuonPhong with idLichMuonPhong = %d', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- MARK: CheckOnUniqueAttributes

-- CREATE TRIGGER [dbo].[CheckOnUniqueAttributes_NguoiDung]
-- ON [dbo].[NguoiDung]
-- AFTER INSERT, UPDATE
-- AS
-- 	BEGIN
--     SET NOCOUNT ON

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.idTaiKhoan = QL.idTaiKhoan
-- 		)
-- 		BEGIN
--         RAISERROR ('The idTaiKhoan of NguoiDung cannot be duplicate with idTaiKhoan of QuanLy', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.Email = QL.Email
-- 		)
-- 		BEGIN
--         RAISERROR ('The Email of NguoiDung cannot be duplicate with Email of QuanLy', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.SDT = QL.SDT
-- 		)
-- 		BEGIN
--         RAISERROR ('The SDT of NguoiDung cannot be duplicate with SDT of QuanLy', 16, 1)
--         ROLLBACK TRANSACTION
--     END
-- END
-- GO

-- CREATE TRIGGER [dbo].[CheckOnUniqueAttributes_QuanLy]
-- ON [dbo].[QuanLy] 
-- AFTER INSERT, UPDATE
-- AS
-- 	BEGIN
--     SET NOCOUNT ON

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NguoiDung] AS NMP ON i.idTaiKhoan = NMP.idTaiKhoan
-- 		)
-- 		BEGIN
--         RAISERROR ('The idTaiKhoan of QuanLy cannot be duplicate with idTaiKhoan of NguoiDung', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NguoiDung] AS NMP ON i.Email = NMP.Email
-- 		)
-- 		BEGIN
--         RAISERROR ('The Email of QuanLy cannot be duplicate with Email of NguoiDung', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NguoiDung] AS NMP ON i.SDT = NMP.SDT
-- 		)
-- 		BEGIN
--         RAISERROR ('The SDT of QuanLy cannot be duplicate with SDT of NguoiDung', 16, 1)
--         ROLLBACK TRANSACTION
--     END
-- END
-- GO

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
-- Check On Attributes for NhomToHocPhan when ngay_BD and ngay_KT of NhomToHocPhan is between startAt and endAt of HocKy
