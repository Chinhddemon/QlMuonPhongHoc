
-- MARK: Insert trigger before Insert data
CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan]
ON [dbo].[TaiKhoan]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;

    UPDATE tk
		SET tk._UpdateAt = GETDATE()
		FROM [dbo].[TaiKhoan] tk
		WHERE tk.IdTaiKhoan IN (SELECT IdTaiKhoan
    FROM inserted);
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_NhomHocPhan]
ON [dbo].[NhomHocPhan]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;

    UPDATE nhp
		SET nhp._UpdateAt = GETDATE()
		FROM [dbo].[NhomHocPhan] nhp
		WHERE nhp.IdNHP IN (SELECT IdNHP
    FROM inserted);
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_LopHocPhanSection]
ON [dbo].[LopHocPhanSection]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;

    UPDATE lhp_p
		SET lhp_p._UpdateAt = GETDATE()
		FROM [dbo].[LopHocPhanSection] lhp_p
		WHERE lhp_p.IdLHPSection IN (SELECT IdLHPSection
    FROM inserted);
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;

    UPDATE lmp
		SET lmp._UpdateAt = GETDATE()
		FROM [dbo].[LichMuonPhong] lmp
		WHERE lmp.IdLMPH IN (SELECT IdLMPH
    FROM inserted);
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_LichMuonPhong] ON [dbo].[LichMuonPhong];

    UPDATE mph
		SET mph._UpdateAt = GETDATE()
		FROM [dbo].[MuonPhongHoc] mph
		WHERE mph.IdLMPH IN (SELECT IdLMPH
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_LichMuonPhong] ON [dbo].[LichMuonPhong];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributes_DsNgMPH_NhomHocPhan]
ON [dbo].[DsNgMPH_NhomHocPhan]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_NhomHocPhan] ON [dbo].[NhomHocPhan];

    UPDATE ds
		SET ds._UpdateAt = GETDATE()
		FROM [dbo].[DsNgMPH_NhomHocPhan] ds
		WHERE ds.IdNHP IN (SELECT IdNHP
        FROM inserted) AND ds.MaNgMPH IN (SELECT MaNgMPH
        FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_NhomHocPhan] ON [dbo].[NhomHocPhan];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtTaiKhoan_NguoiMuonPhong]
ON [dbo].[NguoiMuonPhong] 
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];

    UPDATE tk
		SET tk._UpdateAt = GETDATE()
		FROM [dbo].[TaiKhoan] tk
		WHERE tk.IdTaiKhoan IN (SELECT IdTaiKhoan
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtTaiKhoan_QuanLy]
ON [dbo].[QuanLy] 
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];

    UPDATE tk
		SET tk._UpdateAt = GETDATE()
		FROM [dbo].[TaiKhoan] tk
		WHERE tk.IdTaiKhoan IN (SELECT IdTaiKhoan
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtTaiKhoan_GiangVien]
ON [dbo].[GiangVien]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];

    UPDATE tk
		SET tk._UpdateAt = GETDATE()
		FROM [dbo].[TaiKhoan] tk
        INNER JOIN [dbo].[NguoiMuonPhong] nmp ON tk.IdTaiKhoan = nmp.IdTaiKhoan
        INNER JOIN [dbo].[GiangVien] gv ON nmp.MaNgMPH = gv.MaGV
		WHERE gv.MaGV IN (SELECT MaGV
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtTaiKhoan_SinhVien]
ON [dbo].[SinhVien]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];

    UPDATE tk
		SET tk._UpdateAt = GETDATE()
		FROM [dbo].[TaiKhoan] tk
        INNER JOIN [dbo].[NguoiMuonPhong] nmp ON tk.IdTaiKhoan = nmp.IdTaiKhoan
        INNER JOIN [dbo].[SinhVien] sv ON nmp.MaNgMPH = sv.MaSV
		WHERE sv.MaSV IN (SELECT MaSV
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_TaiKhoan] ON [dbo].[TaiKhoan];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtLichMuonPhong_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_LichMuonPhong] ON [dbo].[LichMuonPhong];

    UPDATE lmp
		SET lmp._UpdateAt = GETDATE()
		FROM [dbo].[LichMuonPhong] lmp
		WHERE lmp.IdLMPH IN (SELECT IdLMPH
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_LichMuonPhong] ON [dbo].[LichMuonPhong];
END
GO

CREATE TRIGGER [dbo].[ForceOverrideOnAttributesAtNhomHocPhan_LopHocPhanSection]
ON [dbo].[LopHocPhanSection] 
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;
    DISABLE TRIGGER [dbo].[ForceOverrideOnAttributes_NhomHocPhan] ON [dbo].[NhomHocPhan];

    UPDATE nhp
		SET nhp._UpdateAt = GETDATE()
		FROM [dbo].[NhomHocPhan] nhp
		WHERE nhp.IdNHP IN (SELECT IdNHP
    FROM inserted);

    ENABLE TRIGGER [dbo].[ForceOverrideOnAttributes_NhomHocPhan] ON [dbo].[NhomHocPhan];
END
GO


CREATE TRIGGER [dbo].[CheckOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[LopHocPhanSection] AS LHP_S ON i.IdLHPSection = LHP_S.IdLHPSection
    WHERE i.ThoiGian_BD < LHP_S.Ngay_BD OR i.ThoiGian_KT > LHP_S.Ngay_KT
		)
		BEGIN
        RAISERROR ('ThoiGian_BD and ThoiGian_KT should be within Ngay_BD and Ngay_KT of LopHocPhanSection', 0, 0)
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
        INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.IdLMPH = LMP.IdLMPH
    WHERE i.ThoiGian_MPH < DATEADD(MINUTE, -30, LMP.ThoiGian_BD)
        OR i.ThoiGian_MPH > LMP.ThoiGian_KT
		)
		BEGIN
        RAISERROR ('ThoiGian_MPH must be between ThoiGian_BD - 30 minutes and ThoiGian_KT', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckOnUniqueAttributes_NguoiMuonPhong]
ON [dbo].[NguoiMuonPhong]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[QuanLy] AS QL ON i.IdTaiKhoan = QL.IdTaiKhoan
		)
		BEGIN
        RAISERROR ('The IdTaiKhoan of NguoiMuonPhong cannot be duplicate with IdTaiKhoan of QuanLy', 16, 1)
        ROLLBACK TRANSACTION
    END

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[QuanLy] AS QL ON i.Email = QL.Email
		)
		BEGIN
        RAISERROR ('The Email of NguoiMuonPhong cannot be duplicate with Email of QuanLy', 16, 1)
        ROLLBACK TRANSACTION
    END

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[QuanLy] AS QL ON i.SDT = QL.SDT
		)
		BEGIN
        RAISERROR ('The SDT of NguoiMuonPhong cannot be duplicate with SDT of QuanLy', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckOnUniqueAttributes_QuanLy]
ON [dbo].[QuanLy] 
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.IdTaiKhoan = NMP.IdTaiKhoan
		)
		BEGIN
        RAISERROR ('The IdTaiKhoan of QuanLy cannot be duplicate with IdTaiKhoan of NguoiMuonPhong', 16, 1)
        ROLLBACK TRANSACTION
    END

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.Email = NMP.Email
		)
		BEGIN
        RAISERROR ('The Email of QuanLy cannot be duplicate with Email of NguoiMuonPhong', 16, 1)
        ROLLBACK TRANSACTION
    END

    IF EXISTS (
			SELECT 1
    FROM inserted AS i
        INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.SDT = NMP.SDT
		)
		BEGIN
        RAISERROR ('The SDT of QuanLy cannot be duplicate with SDT of NguoiMuonPhong', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_QuanLy]
ON [dbo].[QuanLy]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (
			SELECT 1
    FROM inserted i
        INNER JOIN [dbo].[TaiKhoan] TK ON i.[IdTaiKhoan] = TK.[IdTaiKhoan]
        INNER JOIN [dbo].[VaiTro] VT ON TK.[IdVaiTro] = VT.[IdVaiTro]
    WHERE VT.[MaVaiTro] = 'Manager' OR VT.[MaVaiTro] = 'Admin'
		)
		BEGIN
        RAISERROR('QuanLy cannot reference to TaiKhoan with MaVaiTro <> ''Manager'' and ''Admin''', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_NguoiMuonPhong]
ON [dbo].[NguoiMuonPhong]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (
			SELECT 1
    FROM inserted i
        INNER JOIN [dbo].[TaiKhoan] TK ON i.[IdTaiKhoan] = TK.[IdTaiKhoan]
        INNER JOIN [dbo].[VaiTro] VT ON TK.[IdVaiTro] = VT.[IdVaiTro]
    WHERE VT.[MaVaiTro] = 'User'
		)
		BEGIN
        RAISERROR('NguoiMuonPhong cannot reference to TaiKhoan with MaVaiTro <> ''User''', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckReferenceToNguoiMuonPhong_GiangVien]
ON [dbo].[GiangVien]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (
			SELECT 1
    FROM inserted i
        INNER JOIN [dbo].[NguoiMuonPhong] n ON i.[MaGV] = n.[MaNgMPH]
        INNER JOIN [dbo].[DoiTuongNgMPH] d ON n.[IdDoiTuongNgMPH] = d.[IdDoiTuongNgMPH]
    WHERE d.[MaDoiTuongNgMPH] = 'GV'
		)
		BEGIN
        RAISERROR('GiangVien cannot reference to NguoiMuonPhong with MaDoiTuongNgMPH <> ''GV''', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[CheckReferenceToNguoiMuonPhong_SinhVien]
ON [dbo].[SinhVien]
AFTER INSERT, UPDATE
AS
	BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (
			SELECT 1
    FROM inserted i
        INNER JOIN [dbo].[NguoiMuonPhong] n ON i.[MaSV] = n.[MaNgMPH]
        INNER JOIN [dbo].[DoiTuongNgMPH] d ON n.[IdDoiTuongNgMPH] = d.[IdDoiTuongNgMPH]
    WHERE d.[MaDoiTuongNgMPH] = 'SV'
		)
		BEGIN
        RAISERROR('SinhVien cannot reference to NguoiMuonPhong with MaDoiTuongNgMPH <> ''SV''', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

CREATE TRIGGER [dbo].[BlockDeleteFromAttributes_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER DELETE
AS
	BEGIN
    SET NOCOUNT ON;

    IF EXISTS ( 
			SELECT 1
    FROM deleted i
    WHERE ThoiGian_MPH IS NOT NULL
        AND ThoiGian_TPH IS NULL
		)
		BEGIN
        RAISERROR('Cannot delete MuonPhongHoc when ThoiGian_MPH is not null and ThoiGian_TPH is null', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO


-- Pretend INSERT, UPDATE LopHocPhanSection when attribute NhomTo = 0 and NhomTo <> 0 exists for the same IdNHP
-- CREATE TRIGGER [dbo].[CheckOnAttributes_LopHocPhanSection]
-- ON [dbo].[LopHocPhanSection]
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
--         FROM [dbo].[LopHocPhanSection] AS LHP_S
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
--         FROM [dbo].[LopHocPhanSection] AS LHP_S
--         WHERE LHP_S.IdNHP = i.IdNHP
--         AND LHP_S.NhomTo = 0
--         GROUP BY LHP_S.IdNHP
--         HAVING COUNT(LHP_S.IdNHP) > 1
--       )
--     )
--     BEGIN
--       RAISERROR ('Cannot have NhomTo = 0 and NhomTo <> 0 for the same IdNHP in LopHocPhanSection', 16, 1)
--       ROLLBACK TRANSACTION
--     END
--   END
-- GO

-- Triggers need to check:
-- Block UPDATE, DELETE LopHocPhanSection when ngay_BD and ngay_KT of LopHocPhanSection is between current date


-- INSTEAD OF UPDATE, DELETE NhomHocPhan when ngay_BD and ngay_KT of LopHocPhanSection referenced to NhomHocPhan is between current date
