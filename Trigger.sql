CREATE TRIGGER [dbo].[BlockUpdateOnAttributes]
ON [dbo].[TaiKhoan]
AFTER UPDATE
AS
    IF UPDATE(_CreateAt)
    BEGIN
        RAISERROR ('Update on _CreateAt is not allowed', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
GO

CREATE TRIGGER [dbo].[BlockUpdateOnAttributes]
ON [dbo].[LopHocPhan]
AFTER UPDATE
AS
    IF UPDATE(_CreateAt)
    BEGIN
        RAISERROR ('Update on _CreateAt is not allowed', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
GO

CREATE TRIGGER [dbo].[BlockUpdateOnAttributes]
ON [dbo].[LichMuonPhong]
AFTER UPDATE
AS
    IF UPDATE(_CreateAt)
    BEGIN
        RAISERROR ('Update on _CreateAt is not allowed', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
GO

CREATE TRIGGER [dbo].[BlockUpdateOnAttributes]
ON [dbo].[MonHoc]
AFTER UPDATE
AS
    IF UPDATE(_ActiveAt)
    BEGIN
        RAISERROR ('Update on _ActiveAt is not allowed', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
GO

CREATE TRIGGER [dbo].[BlockUpdateOnAttributes]
ON [dbo].[PhongHoc]
AFTER UPDATE
AS
    IF UPDATE(_ActiveAt)
    BEGIN
        RAISERROR ('Update on _ActiveAt is not allowed', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
GO

CREATE TRIGGER [dbo].[OverrideUpdateOnAttributes]
ON [dbo].[TaiKhoan]
AFTER UPDATE
AS
    UPDATE [dbo].[TaiKhoan]
    SET _UpdateAt = GETDATE()
    WHERE EXISTS (SELECT 1 FROM inserted WHERE inserted.IdTaiKhoan = [dbo].[TaiKhoan].IdTaiKhoan)
GO

CREATE TRIGGER [dbo].[OverrideUpdateOnAttributes]
ON [dbo].[LopHocPhan]
AFTER UPDATE
AS
    UPDATE [dbo].[LopHocPhan]
    SET _UpdateAt = GETDATE()
    WHERE EXISTS (SELECT 1 FROM inserted WHERE inserted.IdLHP = [dbo].[LopHocPhan].IdLHP)
GO

CREATE TRIGGER [dbo].[OverrideUpdateOnAttributes]
ON [dbo].[DsMPH_LopHoc]
AFTER UPDATE
AS
    UPDATE [dbo].[DsMPH_LopHoc]
    SET _UpdateAt = GETDATE()
    WHERE EXISTS (SELECT 1 FROM inserted WHERE inserted.IdLHP = [dbo].[DsMPH_LopHoc].IdLHP 
                                            AND inserted.MaNgMPH = [dbo].[DsMPH_LopHoc].MaNgMPH)
GO

CREATE TRIGGER [dbo].[CheckInsertAndUpdateOnAttributes]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
    BEGIN
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

CREATE TRIGGER [dbo].[CheckInsertAndUpdateOnUniqueAttributes]
ON [dbo].[NguoiMuonPhong]
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[QuanLy] AS QL ON i.IdTaiKhoan = QL.IdTaiKhoan
        )
        BEGIN
            RAISERROR ('The IdTaiKhoan of NguoiMuonPhong cannot be duplicate with IdTaiKhoan of QuanLy', 16, 1)
            ROLLBACK TRANSACTION
        END
    END

    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[QuanLy] AS QL ON i.Email = QL.Email
        )
        BEGIN
            RAISERROR ('The Email of NguoiMuonPhong cannot be duplicate with Email of QuanLy', 16, 1)
            ROLLBACK TRANSACTION
        END
    END

    BEGIN
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

CREATE TRIGGER [dbo].[CheckInsertAndUpdateOnUniqueAttributes]
ON [dbo].[QuanLy] 
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.IdTaiKhoan = NMP.IdTaiKhoan
        )
        BEGIN
            RAISERROR ('The IdTaiKhoan of QuanLy cannot be duplicate with IdTaiKhoan of NguoiMuonPhong', 16, 1)
            ROLLBACK TRANSACTION
        END
    END

    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.Email = NMP.Email
        )
        BEGIN
            RAISERROR ('The Email of NguoiMuonPhong cannot be duplicate with Email of QuanLy', 16, 1)
            ROLLBACK TRANSACTION
        END
    END

    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.SDT = NMP.SDT
        )
        BEGIN
            RAISERROR ('The SDT of NguoiMuonPhong cannot be duplicate with SDT of QuanLy', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan]
ON [dbo].[QuanLy]
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[IdTaiKhoan] = TK.[IdTaiKhoan]
            WHERE TK.[IdVaiTro] = (SELECT [IdVaiTro] FROM [dbo].[VaiTro] WHERE [MaVaiTro] = 'QL')
        )
        BEGIN
            RAISERROR('QuanLy cannot reference to TaiKhoan with MaVaiTro = ''QL''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan]
ON [dbo].[NguoiMuonPhong]
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[IdTaiKhoan] = TK.[IdTaiKhoan]
            WHERE TK.[IdVaiTro] = (SELECT [IdVaiTro] FROM [dbo].[VaiTro] WHERE [MaVaiTro] = 'NMP')
        )
        BEGIN
            RAISERROR('NguoiMuonPhong cannot reference to TaiKhoan with MaVaiTro = ''NMP''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToNguoiMuonPhong]
ON [dbo].[GiangVien]
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[NguoiMuonPhong] n ON i.[MaGV] = n.[MaNgMPH]
            WHERE n.[IdDoiTuongNgMPH] = (SELECT [IdDoiTuongNgMPH] FROM [dbo].[DoiTuongNgMPH] WHERE [MaDoiTuongNgMPH] = 'GV')
        )
        BEGIN
            RAISERROR('GiangVien cannot reference to NguoiMuonPhong with MaDoiTuongNgMPH = ''GV''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[CheckReferenceToNguoiMuonPhong]
ON [dbo].[SinhVien]
AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[NguoiMuonPhong] n ON i.[MaSV] = n.[MaNgMPH]
            WHERE n.[IdDoiTuongNgMPH] = (SELECT [IdDoiTuongNgMPH] FROM [dbo].[DoiTuongNgMPH] WHERE [MaDoiTuongNgMPH] = 'SV')
        )
        BEGIN
            RAISERROR('SinhVien cannot reference to NguoiMuonPhong with MaDoiTuongNgMPH = ''SV''', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
GO

CREATE TRIGGER [dbo].[BlockDelete]
ON [dbo].[NguoiMuonPhong]
INSTEAD OF DELETE
AS
    BEGIN
        ROLLBACK;
        PRINT 'Delete operation is not allowed on this table.';
    END
GO

GO

CREATE TRIGGER [dbo].[BlockDelete]
ON [dbo].[SinhVien]
INSTEAD OF DELETE
AS
BEGIN
    ROLLBACK;
    PRINT 'Delete operation is not allowed on this table.';
END

GO

CREATE TRIGGER [dbo].[BlockDelete]
ON [dbo].[QuanLy]
INSTEAD OF DELETE
AS
BEGIN
    ROLLBACK;
    PRINT 'Delete operation is not allowed on this table.';
END

GO

CREATE TRIGGER [dbo].[BlockDelete]
ON [dbo].[MuonPhongHoc]
INSTEAD OF DELETE
AS
BEGIN
    ROLLBACK;
    PRINT 'Delete operation is not allowed on this table.';
END