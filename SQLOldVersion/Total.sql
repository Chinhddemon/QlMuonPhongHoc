-- Last Update: 2024-05-01  16:32
-- Files Synced TriggerBeforeInsert.sql, RawData.sql, TriggerAfterInsert.sql

CREATE TABLE [dbo].[VaiTro]
(
    [IdVaiTro] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaVaiTro] [varchar](7) NOT NULL UNIQUE CHECK (MaVaiTro IN ('User', 'Manager', 'Admin')) -- User: Người mượn phòng, Manager: Quản lý, Admin: Quản trị viên
)

CREATE TABLE [dbo].[DoiTuongNgMPH]
(
    [IdDoiTuongNgMPH] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaDoiTuongNgMPH] [varchar](7) NOT NULL UNIQUE CHECK (MaDoiTuongNgMPH IN ('GV', 'SV')) -- GV: Giảng viên, SV: Sinh viên
)

CREATE TABLE [dbo].[LopSV]
(
    [MaLopSV] [varchar](15) NOT NULL PRIMARY KEY,
    [NienKhoa_BD] [smallint] NOT NULL CHECK (NienKhoa_BD >= 1980 AND NienKhoa_BD <= 2100),
    [NienKhoa_KT] [smallint] NOT NULL CHECK (NienKhoa_KT >= 1980 AND NienKhoa_KT <= 2100),
    [MaNganh] [int] NOT NULL,
    [Khoa] NVARCHAR(31) NOT NULL CHECK (Khoa NOT LIKE '%[^a-zA-ZÀ-ÿ0-9 ]%'),
    [HeDaoTao] [char](2) NOT NULL CHECK (HeDaoTao IN ('CQ', 'TX')), -- CQ: Chính quy, TX: Từ xa
    CONSTRAINT [CK_LopSV_NienKhoa] CHECK ([NienKhoa_BD] < [NienKhoa_KT])
)

CREATE TABLE [dbo].[MonHoc]
(
    [MaMH] [varchar](15) NOT NULL PRIMARY KEY,
    [TenMH] [nvarchar](31) NOT NULL,
    [_ActiveAt] [datetime] NOT NULL DEFAULT GETDATE()
)

CREATE TABLE [dbo].[PhongHoc]
(
    [IdPH] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaPH] [varchar](7) NOT NULL,
    [SucChua] [tinyint] NOT NULL CHECK (SucChua > 0),
    [TinhTrang] [char](1) NOT NULL CHECK (TinhTrang IN ('A', 'U', 'M')), -- A: Available, U: Unavailable, M: Maintenance
    [_ActiveAt] [datetime] NOT NULL DEFAULT GETDATE()
)

-- CREATE TABLE [dbo].[HocKy_LopSV]
-- (
--     [IdHocKy_LopSV] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
--     [MaHocKy] [char](7) NOT NULL CHECK (MaHocKy LIKE '[K][0-9]{4}-[0-9]{1,2,3}'), -- [K][YYYY]-[N]: K2021-1, K2022-2, K2122-3
--     [MaLopSV] [varchar](15) NOT NULL,
--     [Ngay_BD] [date] NOT NULL,
--     [Ngay_KT] [date] NOT NULL,
--     FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
--     CONSTRAINT [UQ_HocKy_LopSV_MaHocKy_MaLopSV] UNIQUE ([MaHocKy], [MaLopSV]),
--     CONSTRAINT [CK_HocKy_Ngay] CHECK ([Ngay_BD] < [Ngay_KT])
-- )

CREATE TABLE [dbo].[TaiKhoan]
(
    [IdTaiKhoan] [uniqueidentifier] NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [IdVaiTro] [smallint] NOT NULL,
    [TenDangNhap] [varchar](30) NOT NULL CHECK (LEN(TenDangNhap) >= 8 AND TenDangNhap NOT LIKE '%[^a-zA-Z0-9]%'),
    [MatKhau] [char](60) NOT NULL,
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    -- [_ExpireAt] DATE NOT NULL,
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([IdVaiTro]) REFERENCES [dbo].[VaiTro]([IdVaiTro])
)

CREATE TABLE [dbo].[NguoiMuonPhong]
(
    [MaNgMPH] [varchar](15) NOT NULL PRIMARY KEY,
    [IdTaiKhoan] [uniqueidentifier] NOT NULL UNIQUE,
    [IdDoiTuongNgMPH] [smallint] NOT NULL,
    [HoTen] [nvarchar](63) NOT NULL CHECK (HoTen NOT LIKE '[^a-zA-ZÀ-ÿ ]'),
    [Email] NVARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%.%'), 
    [SDT] CHAR(10) NOT NULL UNIQUE, -- CHECK (SDT LIKE '+[0-9]{1,3}-[0-9]{9,11}')
    [NgaySinh] DATE NOT NULL CHECK (NgaySinh < GETDATE() AND DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 17), 
    [GioiTinh] TINYINT NOT NULL CHECK (GioiTinh IN (0, 1)), -- 0: Nam, 1: Nữ
    [DiaChi] NVARCHAR(127) NOT NULL CHECK (DiaChi NOT LIKE '%[^a-zA-ZÀ-ÿ0-9., _()/-//./?/;//]%' ESCAPE '/'),
    FOREIGN KEY ([IdTaiKhoan]) REFERENCES [dbo].[TaiKhoan]([IdTaiKhoan]) ON DELETE CASCADE,
    FOREIGN KEY ([IdDoiTuongNgMPH]) REFERENCES [dbo].[DoiTuongNgMPH]([IdDoiTuongNgMPH])
)

CREATE TABLE [dbo].[GiangVien]
(
    [MaGV] [varchar](15) NOT NULL PRIMARY KEY,
    [MaChucDanh] [varchar](15) NOT NULL,
    FOREIGN KEY ([MaGV]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE [dbo].[SinhVien]
(
    [MaSV] [varchar](15) NOT NULL PRIMARY KEY,
    [MaLopSV] [varchar](15) NOT NULL,
    [ChucVu] [varchar](7) NULL CHECK (ChucVu IN ('LT', 'LP', 'TV')), -- LT: Lớp trưởng, LP: Lớp phó, TV: Thành viên
    FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
    FOREIGN KEY ([MaSV]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE [dbo].[QuanLy]
(
    [MaQL] [varchar](15) NOT NULL PRIMARY KEY,
    [IdTaiKhoan] [uniqueidentifier] NOT NULL UNIQUE,
    [HoTen] NVARCHAR(63) NOT NULL CHECK (HoTen NOT LIKE '%[^a-zA-ZÀ-ÿ ]%'),
    [Email] NVARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%.%'),
    [SDT] CHAR(10) NOT NULL UNIQUE, -- CHECK (SDT LIKE '+[0-9]{1,3}-[0-9]{9,11}'),
    [NgaySinh] DATE NOT NULL CHECK (NgaySinh < GETDATE() AND DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 18),
    [GioiTinh] TINYINT NOT NULL CHECK (GioiTinh IN (0, 1)), -- 0: Nam, 1: Nữ
    [DiaChi] NVARCHAR(127) NOT NULL CHECK (DiaChi NOT LIKE '%[^a-zA-ZÀ-ÿ0-9., _()/-//./?/;//]%' ESCAPE '/'),
    FOREIGN KEY ([IdTaiKhoan]) REFERENCES [dbo].[TaiKhoan]([IdTaiKhoan]) ON DELETE CASCADE
)

CREATE TABLE [dbo].[NhomHocPhan]
(
    [IdNHP] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [MaMH] [varchar](15) NOT NULL,
    -- [IdHocKy_LopSV] [int] NOT NULL,
    [MaLopSV] [varchar](15) NOT NULL,
    [MaQLKhoiTao] [varchar](15) NOT NULL,
    [Nhom] [tinyint] NOT NULL CHECK (Nhom > 0),
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([MaMH]) REFERENCES [dbo].[MonHoc]([MaMH]),
    -- FOREIGN KEY ([IdHocKy_LopSV]) REFERENCES [dbo].[HocKy_LopSV]([IdHocKy_LopSV]),
    FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
    FOREIGN KEY ([MaQLKhoiTao]) REFERENCES [dbo].[QuanLy]([MaQL]),
    CONSTRAINT [UQ_NhomHocPhan_MaMH_Nhom] UNIQUE ([MaMH], [MaLopSV], [Nhom])
)

CREATE TABLE [dbo].[LopHocPhanSection]
(
    [IdLHPSection] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [IdNHP] [int] NOT NULL,
    [MaGVGiangDay] [varchar](15) NOT NULL,
    [NhomTo] [tinyint] NOT NULL DEFAULT 255, -- 255: Phân nhóm, 0: Không phân tổ, 1: Phân tổ 1, 2: Phân tổ 2, ...
    [Ngay_BD] [date] NOT NULL,
    [Ngay_KT] [date] NOT NULL,
    [MucDich] [char](2) NOT NULL CHECK (MucDich IN ('LT', 'TH', 'TN', 'U')), -- LT: Lý thuyết, TH: Thực hành, TN: Thí nghiệm, U: Unknown
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([IdNHP]) REFERENCES [dbo].[NhomHocPhan]([IdNHP]) ON DELETE CASCADE,
    FOREIGN KEY ([MaGVGiangDay]) REFERENCES [dbo].[GiangVien]([MaGV]),
    CONSTRAINT [UQ_LopHocPhanSection_IdNHP_NhomTo] UNIQUE ([IdNHP], [NhomTo]),
    CONSTRAINT [CK_LopHocPhanSection_Ngay] CHECK ([Ngay_BD] < [Ngay_KT])
)

CREATE TABLE [dbo].[LichMuonPhong]
(
    [IdLMPH] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [IdLHPSection] [int] NOT NULL,
    [IdPH] [int] NOT NULL,
    [MaQLKhoiTao] [varchar](15) NOT NULL,
    [ThoiGian_BD] [datetime] NOT NULL,
    [ThoiGian_KT] [datetime] NOT NULL,
    [LyDo] [nvarchar](31) NULL,
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([IdLHPSection]) REFERENCES [dbo].[LopHocPhanSection]([IdLHPSection]),
    FOREIGN KEY ([IdPH]) REFERENCES [dbo].[PhongHoc]([IdPH]),
    FOREIGN KEY ([MaQLKhoiTao]) REFERENCES [dbo].[QuanLy]([MaQL]),
    CONSTRAINT [CK_LichMuonPhong_ThoiGian] CHECK ([ThoiGian_BD] < [ThoiGian_KT])
)

CREATE TABLE [dbo].[MuonPhongHoc]
(
    [IdLMPH] [int] NOT NULL PRIMARY KEY,
    [MaNgMPH] [varchar](15) NOT NULL,
    [MaQLDuyet] [varchar](15) NOT NULL,
    [ThoiGian_MPH] [datetime] NOT NULL DEFAULT GETDATE(),
    [ThoiGian_TPH] [datetime] NULL CHECK (ThoiGian_TPH < GETDATE()),
    [YeuCau] [nvarchar](127) NULL,
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([IdLMPH]) REFERENCES [dbo].[LichMuonPhong]([IdLMPH]) ON DELETE CASCADE,
    FOREIGN KEY ([MaNgMPH]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]),
    FOREIGN KEY ([MaQLDuyet]) REFERENCES [dbo].[QuanLy]([MaQL]),
    CONSTRAINT [CK_MuonPhongHoc_ThoiGian] CHECK ([ThoiGian_MPH] < [ThoiGian_TPH])
)

CREATE TABLE [dbo].[DsNgMPH_NhomHocPhan]
(
    [IdNHP] [int] NOT NULL,
    [MaNgMPH] [varchar](15) NOT NULL,
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY ([IdNHP], [MaNgMPH]),
    FOREIGN KEY ([IdNHP]) REFERENCES [dbo].[NhomHocPhan]([IdNHP]) ON DELETE CASCADE,
    FOREIGN KEY ([MaNgMPH]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH])
)

GO

-- MARK: Insert trigger before Insert data

-- MARK: ForceOverrideOnAttributes

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

-- MARK: ForceOverrideOnAttributesAtTables

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

-- MARK: CheckOnAttributes

-- CREATE TRIGGER [dbo].[CheckOnAttributes_LopHocPhanSection]
-- ON [dbo].[LopHocPhanSection]
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     IF EXISTS (
--         SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NhomHocPhan] AS NHP ON i.IdNHP = NHP.IdNHP
--         INNER JOIN [dbo].[HocKy_LopSV] AS HKLSV ON NHP.IdHocKy_LopSV = HKLSV.IdHocKy_LopSV
--     WHERE i.Ngay_BD < HK.Ngay_BD OR i.Ngay_KT > HK.Ngay_KT
--     )
--     BEGIN
--         RAISERROR ('Ngay_BD and Ngay_KT should be within Ngay_BD and Ngay_KT of HocKy', 0, 0)
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

-- MARK: CheckOnUniqueAttributes

-- CREATE TRIGGER [dbo].[CheckOnUniqueAttributes_NguoiMuonPhong]
-- ON [dbo].[NguoiMuonPhong]
-- AFTER INSERT, UPDATE
-- AS
-- 	BEGIN
--     SET NOCOUNT ON

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.IdTaiKhoan = QL.IdTaiKhoan
-- 		)
-- 		BEGIN
--         RAISERROR ('The IdTaiKhoan of NguoiMuonPhong cannot be duplicate with IdTaiKhoan of QuanLy', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.Email = QL.Email
-- 		)
-- 		BEGIN
--         RAISERROR ('The Email of NguoiMuonPhong cannot be duplicate with Email of QuanLy', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[QuanLy] AS QL ON i.SDT = QL.SDT
-- 		)
-- 		BEGIN
--         RAISERROR ('The SDT of NguoiMuonPhong cannot be duplicate with SDT of QuanLy', 16, 1)
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
--         INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.IdTaiKhoan = NMP.IdTaiKhoan
-- 		)
-- 		BEGIN
--         RAISERROR ('The IdTaiKhoan of QuanLy cannot be duplicate with IdTaiKhoan of NguoiMuonPhong', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.Email = NMP.Email
-- 		)
-- 		BEGIN
--         RAISERROR ('The Email of QuanLy cannot be duplicate with Email of NguoiMuonPhong', 16, 1)
--         ROLLBACK TRANSACTION
--     END

--     IF EXISTS (
-- 			SELECT 1
--     FROM inserted AS i
--         INNER JOIN [dbo].[NguoiMuonPhong] AS NMP ON i.SDT = NMP.SDT
-- 		)
-- 		BEGIN
--         RAISERROR ('The SDT of QuanLy cannot be duplicate with SDT of NguoiMuonPhong', 16, 1)
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

-- Triggers need to add:
-- Check On Attributes for LopHocPhanSection when ngay_BD and ngay_KT of LopHocPhanSection is between Ngay_BD and Ngay_KT of HocKy


GO
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 

INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (1, N'2A23', 100, N'A', CAST(N'2024-04-09T21:23:28.587' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (3, N'2A26', 100, N'U', CAST(N'2024-04-09T21:26:08.447' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (4, N'2A27', 100, N'M', CAST(N'2024-04-09T21:26:31.210' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (5, N'2E0405', 60, N'A', CAST(N'2024-04-09T21:28:42.453' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (6, N'2E17', 60, N'U', CAST(N'2024-04-09T21:29:04.043' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (7, N'2E15', 60, N'M', CAST(N'2024-04-09T21:29:22.310' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (8, N'2A08', 160, N'A', CAST(N'2024-04-09T21:29:56.130' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (9, N'2A16', 160, N'U', CAST(N'2024-04-09T21:30:09.420' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (10, N'2A35', 60, N'M', CAST(N'2024-04-09T21:30:53.510' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (11, N'2B24', 100, N'A', CAST(N'2024-04-09T21:32:20.880' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (12, N'2B11', 100, N'U', CAST(N'2024-04-09T21:32:37.880' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (13, N'2B27', 100, N'M', CAST(N'2024-04-09T21:32:50.230' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (14, N'2A2425', 100, N'A', CAST(N'2024-04-09T21:33:48.567' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (15, N'SAN-B1', 200, N'A', CAST(N'2024-04-09T21:34:20.560' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (16, N'2D05', 25, N'A', CAST(N'2024-04-09T21:36:41.147' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (17, N'2D12', 40, N'A', CAST(N'2024-04-09T21:36:43.543' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (18, N'2A27', 100, N'A', CAST(N'2024-05-01T12:18:02.763' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (19, N'2E17', 60, N'A', CAST(N'2024-05-01T12:18:29.830' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (20, N'2E05', 100, N'A', CAST(N'2024-05-01T12:18:46.177' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (21, N'2A16', 160, N'A', CAST(N'2024-05-01T12:18:59.170' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (22, N'2B11', 100, N'A', CAST(N'2024-05-01T12:19:23.330' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (23, N'2B32', 60, N'A', CAST(N'2024-05-01T12:19:45.987' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (24, N'2B31', 100, N'A', CAST(N'2024-05-01T12:19:55.530' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (3, N'Admin')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (2, N'Manager')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (1, N'User')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'7c157b1b-56ef-49f9-a911-022ed128359e', 1, N'N21DCCN057', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', 1, N'N21DCCN178', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'dae51e7b-4159-44ca-bc24-0bae945603cf', 1, N'N21DCCN087', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4459b4b4-7cac-45aa-b67a-0d39a2241934', 1, N'GVN20238', N'123                                                         ', CAST(N'2024-04-30T15:52:03.847' AS DateTime), CAST(N'2024-04-30T20:52:02.667' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', 1, N'N21DCCN002', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', 1, N'N21DCCN070', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'f3c4c098-c7f2-48ea-963a-27741b8da530', 1, N'N21DCCN050', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', 2, N'QL793761', N'1234                                                        ', CAST(N'2024-04-09T21:41:37.697' AS DateTime), CAST(N'2024-04-30T20:52:02.173' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', 1, N'N21DCCN022', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 1, N'N21DCCN040', N'123                                                         ', CAST(N'2024-04-09T21:40:25.173' AS DateTime), CAST(N'2024-04-30T20:56:34.917' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'a2c883ea-0be4-4472-b1de-35689acf4b45', 1, N'N21DCCN023', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'b0a3b390-0805-40ca-b702-37622e05e34f', 1, N'N18DCAT074', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', 1, N'N19DCCN016', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', 1, N'N19DCCN232', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'31d07ffa-3a82-4892-8806-4311ba702711', 1, N'N21DCCN102', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'54695652-a894-4d53-80b6-43378ab19378', 1, N'N21DCCN033', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'b40c1d88-d187-4a2a-86d5-445fe7c02304', 1, N'N21DCCN011', N'123                                                         ', CAST(N'2024-04-30T15:46:53.983' AS DateTime), CAST(N'2024-04-30T20:52:02.140' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', 1, N'N21DCCN008', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4f1e43bd-2189-4924-a378-4630cda5d1cd', 1, N'N21DCCN047', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'108800e8-1be0-4a62-be15-48dc89eacfad', 1, N'N19DCCN178', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'28ceff2f-260a-40f9-8284-542f4045d1bc', 1, N'N19DCCN151', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'31a22554-28e5-4c7e-8e76-5638a1932061', 1, N'N18DCAT060', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 1, N'GV0211047', N'$2y$10$4MAeFQO6giTZiQDwC.kLTeJPgkNEQTW9jLf1wwhWEDkhb2.p5BuAy', CAST(N'2024-04-10T07:29:36.183' AS DateTime), CAST(N'2024-04-30T20:52:02.600' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', 1, N'N21DCCN020', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'65d509ee-934e-419c-bd1f-65d7df3349fc', 2, N'QL196832', N'1234                                                        ', CAST(N'2024-04-09T21:42:16.800' AS DateTime), CAST(N'2024-04-30T20:52:02.203' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 1, N'GV0211040', N'$2y$10$maYuhvBh2IP.g9MCcvq0FOexUoF6s6W5eJII6e3ucK1KKuQxUOP7K', CAST(N'2024-04-10T07:29:50.487' AS DateTime), CAST(N'2024-04-30T20:52:02.590' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'196a8844-2540-44c5-a8f0-6c7b8deb2013', 1, N'N21DCCN021', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'a62a2c62-ef50-4c39-a987-6cfde9149c68', 1, N'N21DCCN090', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2a54a348-8922-4612-85cd-6f31228b9577', 1, N'N21DCCN003', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'f253339a-6d9e-470d-9e75-6f517b29f415', 1, N'N21DCCN038', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2712dd24-a140-4655-9249-722a4717920d', 1, N'N21DCCN010', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', 1, N'N21DCCN013', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', 1, N'N21DCCN095', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 1, N'GV0211039', N'123                                                         ', CAST(N'2024-04-10T07:29:24.840' AS DateTime), CAST(N'2024-04-30T20:52:02.563' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'02c4a53e-5b04-47c2-aa77-78f48439f140', 1, N'N21DCCN006', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'af032f73-3409-4951-925c-836131b11faa', 1, N'N21DCCN190', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'629371e6-e4f3-45e7-a7e5-8427705c91d2', 1, N'GVN20193', N'123                                                         ', CAST(N'2024-04-30T15:52:17.087' AS DateTime), CAST(N'2024-04-30T20:52:02.640' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'c3d957e6-f97d-475f-bc68-86cc71f95b12', 1, N'TG368059', N'$2y$10$xqfNgcMUnUtp59L6MvpRsu5EutPNdNJrFHR/ZGRyGN3d616hY58hq', CAST(N'2024-04-30T15:54:05.647' AS DateTime), CAST(N'2024-04-30T20:52:02.697' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', 1, N'N21DCCN026', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'78020f69-876b-4a2f-8b91-913c5bea2ba5', 1, N'N21DCCN086', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', 1, N'N21DCCN081', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'b24aa366-9b00-435b-8399-96d71caa2737', 1, N'N21DCCN005', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', 1, N'N21DCCN193', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', 1, N'N21DCCN079', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1eeed331-604e-4755-8740-9f7c401e21e2', 1, N'N21DCCN012', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', 1, N'N21DCCN045', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'83de2683-d635-4b82-b007-a17cf9c9440b', 2, N'QL054723', N'1234                                                        ', CAST(N'2024-04-09T21:42:04.833' AS DateTime), CAST(N'2024-04-30T20:52:02.220' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'85ddf715-c4cb-47c3-9123-a61a803fcb43', 1, N'TG256530', N'123                                                         ', CAST(N'2024-04-30T15:54:40.973' AS DateTime), CAST(N'2024-04-30T20:52:02.710' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'c61e8766-c1af-4390-a513-a8431eac84d5', 1, N'N21DCCN034', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'afd61e61-79a1-4e65-9de5-accc7f255d7b', 1, N'N21DCCN084', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'127e0703-46ed-402f-86b8-b7be12084441', 1, N'N21DCCN060', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 1, N'N21DCCN077', N'123                                                         ', CAST(N'2024-04-09T21:40:56.270' AS DateTime), CAST(N'2024-04-30T20:57:12.297' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', 1, N'N21DCCN059', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', 1, N'GVN20173', N'123                                                         ', CAST(N'2024-04-30T15:51:45.540' AS DateTime), CAST(N'2024-04-30T20:52:02.613' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', 1, N'N21DCCN030', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'30820deb-f796-425d-a33f-d61fdc69b7fa', 1, N'N21DCCN103', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'09a00370-b03b-437d-91dc-d71491791c6e', 1, N'GVN20288', N'123                                                         ', CAST(N'2024-04-30T15:52:31.110' AS DateTime), CAST(N'2024-04-30T20:52:02.680' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', 1, N'N21DCCN016', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', 1, N'N21DCCN052', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-01T13:08:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', 1, N'N21DCCN088', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', 1, N'N21DCCN062', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'dd3986a3-4284-429a-a9af-e6b1046a49f8', 1, N'N21DCCN007', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'338946eb-51d8-4201-a53f-ea4380f1593c', 1, N'N21DCCN071', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', 1, N'N21DCCN032', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', 1, N'N21DCCN096', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', 2, N'QL684374', N'1234                                                        ', CAST(N'2024-04-09T21:41:53.823' AS DateTime), CAST(N'2024-04-30T20:52:02.233' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'f4298638-9e03-4920-bb5b-ed8739164534', 1, N'N21DCCN192', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1cf67def-6367-4b80-a066-ef57ce83996b', 1, N'GVN20226', N'123                                                         ', CAST(N'2024-04-10T07:28:48.910' AS DateTime), CAST(N'2024-04-30T20:52:02.653' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 1, N'N21DCCN094', N'123                                                         ', CAST(N'2024-04-09T21:41:09.473' AS DateTime), CAST(N'2024-04-30T20:58:01.373' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 1, N'GVN20191', N'123                                                         ', CAST(N'2024-04-10T07:28:26.127' AS DateTime), CAST(N'2024-04-30T20:52:02.630' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'62cad6fa-3626-4295-8a83-de01e38310aa', 1, N'N20DCCN057', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-01T13:22:00.000' AS DateTime), NULL)

GO
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL054723', N'83de2683-d635-4b82-b007-a17cf9c9440b', N'Lưu Văn Thành', N'n21dccn077@student.ptithcm.edu.vn', N'0906968495', CAST(N'1992-08-08' AS Date), 1, N'671-141 Đường Trịnh Hoài Đức, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL196832', N'65d509ee-934e-419c-bd1f-65d7df3349fc', N'Nguyễn Hữu Vinh', N'n21dccn094@student.ptithcm.edu.vn', N'0783849559', CAST(N'1990-04-09' AS Date), 1, N'Ký túc xá Cỏ May trường Đại học Nông Lâm, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL684374', N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', N'Thái Văn Anh Chính', N'n21dccn011@student.ptithcm.edu.vn', N'0836490622', CAST(N'2003-12-20' AS Date), 1, N'Ký túc xá Học viện Công Nghệ Bưu Chính Viễn Thông, 97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, Thành phố Hồ Chí Minh 70000, Vietnam')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL793761', N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', N'Ngô Cao Hy', N'n21dccn040@student.ptithcm.edu.vn', N'0794058390', CAST(N'1991-10-15' AS Date), 1, N'Hẻm 2/45, Phường Tân Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
GO
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] ON 

INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (3, N'GV')
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (4, N'SV')
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] OFF
GO
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20173', N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', 3, N'Hà Văn Cao', N'havancao@ptithcm.edu.vn', N'0346707226', CAST(N'1899-08-07' AS Date), 1, N'75/6 Đường 18, Phường Linh Trung, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20191', N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 3, N'Nguyễn Thị Bích Nguyên', N'bichnguyen@ptithcm.edu.vn', N'0684674664', CAST(N'1990-07-07' AS Date), 1, N'16-52 Đ. Đoàn Như Hài, Phường 12, Quận 4, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20193', N'629371e6-e4f3-45e7-a7e5-8427705c91d2', 3, N'Giang Lâm', N'gianglam@ptithcm.edu.vn', N'0337948217', CAST(N'1998-06-05' AS Date), 1, N'59/31 Đ. Trần Phú, Phường 4, Quận 5, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20226', N'1cf67def-6367-4b80-a066-ef57ce83996b', 3, N'Lưu Nguyễn Kỳ thư', N'kythu@ptithcm.edu.vn', N'0939630575', CAST(N'1990-09-07' AS Date), 0, N'24-6 An Nhơn, Phường 17, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20238', N'4459b4b4-7cac-45aa-b67a-0d39a2241934', 3, N'Cao Văn Hà', N'caovanha@gmail.comptithcm.edu.vn', N'0929878201', CAST(N'1990-09-09' AS Date), 1, N'Hẻm 27 Nguyễn Thượng Hiền, Phường 5, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV/N-20288', N'09a00370-b03b-437d-91dc-d71491791c6e', 3, N'Đức Hoàng', N'duchoang@ptithcm.edu.vn', N'0248361949', CAST(N'1997-07-05' AS Date), 1, N'Hẻm 40, Trường Thọ, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV0211039', N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 3, N'Trần Công Hùng', N'tranconghung@ptithcm.edu.vn', N'0636402034', CAST(N'2003-03-03' AS Date), 0, N'Hẻm 93 Vạn Kiếp, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV0211040', N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 3, N'Phan Thanh Hy', N'thanhhy@ptithcm.edu.vn', N'0904858378', CAST(N'1990-09-06' AS Date), 0, N'43-41 Võ Trường Toản, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV0211047', N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 3, N'Huỳnh Trung Trụ', N'trungtru@ptithcm.edu.vn', N'0987475677', CAST(N'1997-09-02' AS Date), 0, N'An Bình, Dĩ An, Binh Duong, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN011', N'b40c1d88-d187-4a2a-86d5-445fe7c02304', 4, N'Thái Văn Anh Chính', N'n21dccn011@student.ptithcm.edu.vn', N'0904863784', CAST(N'2003-07-07' AS Date), 0, N'Ký túc xá Học viện Công Nghệ Bưu Chính Viễn Thông, 97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, Thành phố Hồ Chí Minh 70000, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN040', N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 4, N'Ngô Cao Hy', N'n21dccn040@student.ptithcm.edu.vn', N'0794895090', CAST(N'2003-06-06' AS Date), 0, N'Hẻm 2/45, Phường Tân Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN077', N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 4, N'Lưu Văn Thành', N'n21dccn077@student.ptithcm.edu.vn', N'0907658389', CAST(N'2003-07-09' AS Date), 0, N'671-141 Đường Trịnh Hoài Đức, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN094', N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 4, N'Nguyễn Hữu Vinh', N'n21dccn094@student.ptithcm.edu.vn', N'0936473884', CAST(N'2003-09-08' AS Date), 0, N'Ký túc xá Cỏ May trường Đại học Nông Lâm, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'TG256530', N'85ddf715-c4cb-47c3-9123-a61a803fcb43', 3, N'Nguyễn Tâm Trân', N'trannguyen@ptithcm.edu.vn', N'0906463849', CAST(N'2000-08-08' AS Date), 0, N'15 Trương Văn Hải, Tăng Nhơn Phú B, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'TG368059', N'c3d957e6-f97d-475f-bc68-86cc71f95b12', 3, N'Nguyễn Minh Thư', N'nguyenthu@ptithcm.edu.vn', N'0792894050', CAST(N'2000-07-09' AS Date), 0, N'42 Đường 5, Linh Chiểu, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN002', N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', 4, N'Trần Kim An', N'n21dccn002@student.ptithcm.edu.vn', N'0934901030', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN023', N'a2c883ea-0be4-4472-b1de-35689acf4b45', 4, N'Nguyễn Đức Duy', N'n21dccn023@student.ptithcm.edu.vn', N'0395575467', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN052', N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', 4, N'Bùi Văn Minh', N'n21dccn052@student.ptithcm.edu.vn', N'0935407504', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN084', N'afd61e61-79a1-4e65-9de5-accc7f255d7b', 4, N'Phan Văn Tiến', N'n21dccn084@student.ptithcm.edu.vn', N'0406907045', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN003', N'2a54a348-8922-4612-85cd-6f31228b9577', 4, N'Bùi Vũ Tuấn Anh', N'n21dccn003@student.ptithcm.edu.vn', N'0724717607', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN022', N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', 4, N'Phạm Quốc Dương', N'n21dccn022@student.ptithcm.edu.vn', N'0608706100', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN057', N'7c157b1b-56ef-49f9-a911-022ed128359e', 4, N'Lê Trung Nguyên', N'n21dccn057@student.ptithcm.edu.vn', N'0972953146', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N18DCAT074', N'b0a3b390-0805-40ca-b702-37622e05e34f', 4, N'Lê Phạm Công Toàn', N'n18dcat074@student.ptithcm.edu.vn', N'0986907092', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN005', N'b24aa366-9b00-435b-8399-96d71caa2737', 4, N'Nguyễn Quang Anh', N'n21dccn005@student.ptithcm.edu.vn', N'0542718826', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN013', N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', 4, N'Nguyễn Ngọc Đạt', N'n21dccn013@student.ptithcm.edu.vn', N'0844008699', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN059', N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', 4, N'Trần Bình Phương Nhã', N'n21dccn059@student.ptithcm.edu.vn', N'0781795159', CAST(N'2003-03-03' AS Date), 1, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN086', N'78020f69-876b-4a2f-8b91-913c5bea2ba5', 4, N'Trần Đình Toàn', N'n21dccn086@student.ptithcm.edu.vn', N'0253320839', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN006', N'02c4a53e-5b04-47c2-aa77-78f48439f140', 4, N'Nguyễn Duy Bảo', N'n21dccn006@student.ptithcm.edu.vn', N'0855683586', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN016', N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', 4, N'Triệu Quốc Đạt', N'n21dccn016@student.ptithcm.edu.vn', N'0844851512', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN060', N'127e0703-46ed-402f-86b8-b7be12084441', 4, N'Dư Trọng Nhân', N'n21dccn060@student.ptithcm.edu.vn', N'0961968425', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN190', N'af032f73-3409-4951-925c-836131b11faa', 4, N'Vũ Đức Trọng', N'n21dccn190@student.ptithcm.edu.vn', N'0988045671', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN007', N'dd3986a3-4284-429a-a9af-e6b1046a49f8', 4, N'Phạm Phú Bảo', N'n21dccn007@student.ptithcm.edu.vn', N'0248646485', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN026', N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', 4, N'Nguyễn Trường Giang', N'n21dccn026@student.ptithcm.edu.vn', N'0227100487', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN062', N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', 4, N'Hoàng Ngọc Ninh', N'n21dccn062@student.ptithcm.edu.vn', N'0755321576', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN087', N'dae51e7b-4159-44ca-bc24-0bae945603cf', 4, N'Nguyễn Thành Trung', N'n21dccn087@student.ptithcm.edu.vn', N'0830244486', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N19DCCN016', N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', 4, N'Tô Gia Bảo', N'n19dccn016@student.ptithcm.edu.vn', N'0517859585', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN030', N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', 4, N'Bùi Quang Hiệp', N'n21dccn03@student.ptithcm.edu.vn', N'0402168332', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N18DCAT060', N'31a22554-28e5-4c7e-8e76-5638a1932061', 4, N'Lê Tư Phương', N'n18dcat060@student.ptithcm.edu.vn', N'0894278273', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN192', N'f4298638-9e03-4920-bb5b-ed8739164534', 4, N'Phan Quang Trung', N'n21dccn192@student.ptithcm.edu.vn', N'0668295853', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN008', N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', 4, N'Võ Gia Bảo', N'n21dccn008@student.ptithcm.edu.vn', N'0942010291', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN032', N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', 4, N'Đào Phan Quốc Hoài', N'n21dccn032@student.ptithcm.edu.vn', N'0154167378', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N19DCCN151', N'28ceff2f-260a-40f9-8284-542f4045d1bc', 4, N'Phạm Minh Quang', N'n19dccn151@student.ptithcm.edu.vn', N'0208454837', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN088', N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', 4, N'Phạm Thanh Trường', N'n21dccn088@student.ptithcm.edu.vn', N'0634902067', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN103', N'30820deb-f796-425d-a33f-d61fdc69b7fa', 4, N'Vũ Quốc Bảo', N'n21dccn103@student.ptithcm.edu.vn', N'0493693789', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN033', N'54695652-a894-4d53-80b6-43378ab19378', 4, N'Nguyễn Đức Khải Hoàn', N'n21dccn033@student.ptithcm.edu.vn', N'0316694514', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N20DCCN057', N'62cad6fa-3626-4295-8a83-de01e38310aa', 4, N'Trịnh Khánh Quân', N'n20dccn057@student.ptithcm.edu.vn', N'0468110604', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN193', N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', 4, N'Lê Văn Tuấn', N'n21dccn193@student.ptithcm.edu.vn', N'0823945928', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN102', N'31d07ffa-3a82-4892-8806-4311ba702711', 4, N'Nguyễn Lê Hoài Bắc', N'n21dccn102@student.ptithcm.edu.vn', N'0784688337', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN034', N'c61e8766-c1af-4390-a513-a8431eac84d5', 4, N'Nguyễn Minh Hoàng', N'n21dccn034@student.ptithcm.edu.vn', N'0547873627', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN070', N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', 4, N'Nguyễn Ngọc Quý', N'n21dccn070@student.ptithcm.edu.vn', N'0691585956', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N19DCCN178', N'108800e8-1be0-4a62-be15-48dc89eacfad', 4, N'Nguyễn Anh Tuấn', N'n19dccn178@student.ptithcm.edu.vn', N'0440031417', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN010', N'2712dd24-a140-4655-9249-722a4717920d', 4, N'Nguyễn Văn Chiến', N'n21dccn010@student.ptithcm.edu.vn', N'0638618111', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN038', N'f253339a-6d9e-470d-9e75-6f517b29f415', 4, N'Hà Gia Huy', N'n21dccn038@student.ptithcm.edu.vn', N'0855340636', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN071', N'338946eb-51d8-4201-a53f-ea4380f1593c', 4, N'Nguyễn Bá Sang', N'n21dccn071@student.ptithcm.edu.vn', N'0747995682', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN090', N'a62a2c62-ef50-4c39-a987-6cfde9149c68', 4, N'Nguyễn Anh Tuấn', N'n21dccn090@student.ptithcm.edu.vn', N'0684351930', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN012', N'1eeed331-604e-4755-8740-9f7c401e21e2', 4, N'Phạm Đỗ Nguyên Chương', N'n21dccn012@student.ptithcm.edu.vn', N'0208230080', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN045', N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', 4, N'Võ Anh Kiệt', N'n21dccn045@student.ptithcm.edu.vn', N'0690595371', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN079', N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', 4, N'Dương Hoàng Thiện', N'n21dccn079@student.ptithcm.edu.vn', N'0674038180', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN095', N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', 4, N'Nguyễn Văn Vũ', N'n21dccn095@student.ptithcm.edu.vn', N'0243841100', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN021', N'196a8844-2540-44c5-a8f0-6c7b8deb2013', 4, N'Lê Văn Dũng', N'n21dccn021@student.ptithcm.edu.vn', N'0634299103', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN047', N'4f1e43bd-2189-4924-a378-4630cda5d1cd', 4, N'Nguyễn Quang Linh', N'n21dccn047@student.ptithcm.edu.vn', N'0192396976', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN178', N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', 4, N'Lương Đạt Thiện', N'n21dccn178@student.ptithcm.edu.vn', N'0631378026', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN096', N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', 4, N'Huỳnh Như Ý', N'n21dccn096@student.ptithcm.edu.vn', N'0737929879', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN020', N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', 4, N'Nguyễn Văn Dũng', N'n21dccn020@student.ptithcm.edu.vn', N'0856707060', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN050', N'f3c4c098-c7f2-48ea-963a-27741b8da530', 4, N'Lương Thành Lợi', N'n21dccn050@student.ptithcm.edu.vn', N'0667106056', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN081', N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', 4, N'Lê Minh Thông', N'n21dccn081@student.ptithcm.edu.vn', N'0193542181', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N19DCCN232', N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', 4, N'Nguyễn Khánh Ý', N'n19dccn232@student.ptithcm.edu.vn', N'0611310626', CAST(N'2003-03-03' AS Date), 0, 'Hồ Chí Minh, Vietnam')

GO
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20173', N'V.07.01.01')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20191', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20193', N'V.07.01.03')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20226', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20238', N'V.07.01.01')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV/N-20288', N'V.07.01.03')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV0211039', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV0211040', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'GV0211047', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'TG256530', N'V.07.01.23')
INSERT [dbo].[GiangVien] ([MaGV], [MaChucDanh]) VALUES (N'TG368059', N'V.07.01.23')
GO

INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D20CQCN01-N', 2020, 2025, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D20CQDTDT01-N', 2020, 2025, 7510301, N'Công Nghệ Kỹ Thuật Điện 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQAT01-N', 2021, 2026, 7480202, N'An toàn Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQCN01-N', 2021, 2026, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQCN02-N', 2021, 2026, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21TXVTMD01-N', 2021, 2026, 7520207, N'Kỹ Thuật Điện Tử Viễn Thông 2', N'TX')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D22CQQT01-N', 2022, 2027, 7340101, N'Quản Trị Kinh Doanh 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D23CQKT01-N', 2023, 2028, 7340301, N'Kế Toán 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D23CQPT02-N', 2023, 2028, 7329001, N'Công Nghệ Đa Phương Tiện 2', N'CQ')

INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D18CQAT02-N', 2018, 2023, 7480201, N'An toàn Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D19CQCNPM01-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D19CQCNPM02-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D19CQCNHT01-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ')

GO
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'BAS1153', N'Lịch Sử Đảng Cộng Sản Việt Nam', CAST(N'2024-04-09T20:36:44.300' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'BAS1160', N'Tiếng Anh Course 3', CAST(N'2024-04-09T20:45:37.820' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT 1359-3', N'Toán Rời Rạc 2', CAST(N'2024-04-09T20:52:37.833' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1306', N'Cấu Trúc Dữ Liệu và Giải Thuật', CAST(N'2024-04-09T20:52:05.327' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1313', N'Cơ Sở Dữ Liệu', CAST(N'2024-04-09T20:47:06.750' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13145', N'Kiến Trúc Máy Tính', CAST(N'2024-04-09T20:53:09.613' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13147', N'Thực Tập Cở Sở', CAST(N'2024-04-09T20:38:20.850' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13162', N'Lập Trình Python', CAST(N'2024-04-09T20:46:13.613' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1319', N'Hệ Điều Hành', CAST(N'2024-04-09T20:36:02.040' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1332', N'Lập Trình Hướng Đối Tượng', CAST(N'2024-04-09T20:50:45.800' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1336', N'Mạng Máy Tính', CAST(N'2024-04-09T20:50:07.240' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1340', N'Nhập Môn Công Nghệ Phần Mềm', CAST(N'2024-04-09T20:37:45.010' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1341', N'Nhập Môn Trí Tuệ nhân tạo', CAST(N'2024-04-09T20:34:38.540' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1434-3', N'Lập Trình Web', CAST(N'2024-04-09T20:38:50.883' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[NhomHocPhan] ON 

INSERT [dbo].[NhomHocPhan] ([IdNHP], [MaMH], [MaLopSV], [MaQLKhoiTao], [Nhom], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (1, N'INT13145', N'D20CQDTDT01-N', N'QL054723', 1, CAST(N'2024-04-10T09:03:08.373' AS DateTime), CAST(N'2024-04-30T20:52:02.860' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([IdNHP], [MaMH], [MaLopSV], [MaQLKhoiTao], [Nhom], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (3, N'BAS1160', N'D21CQCN01-N', N'QL684374', 10, CAST(N'2024-04-10T09:04:47.640' AS DateTime), CAST(N'2024-04-30T20:52:02.897' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([IdNHP], [MaMH], [MaLopSV], [MaQLKhoiTao], [Nhom], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (5, N'INT1306', N'D21CQAT01-N', N'QL793761', 3, CAST(N'2024-04-10T09:06:11.783' AS DateTime), CAST(N'2024-04-30T20:52:02.880' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([IdNHP], [MaMH], [MaLopSV], [MaQLKhoiTao], [Nhom], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (6, N'INT1340', N'D20CQCN01-N', N'QL196832', 2, CAST(N'2024-04-10T09:07:14.600' AS DateTime), CAST(N'2024-04-30T20:52:02.917' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([IdNHP], [MaMH], [MaLopSV], [MaQLKhoiTao], [Nhom], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (14, N'BAS1160', N'D21CQCN01-N', N'QL684374', 12, CAST(N'2024-05-01T11:56:24.560' AS DateTime), CAST(N'2024-05-01T11:56:24.560' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[NhomHocPhan] OFF
GO
SET IDENTITY_INSERT [dbo].[LopHocPhanSection] ON 

INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (1, 3, N'GV/N-20191', 255, CAST(N'2024-01-10' AS Date), CAST(N'2024-06-11' AS Date), N'LT', CAST(N'2024-04-30T20:52:02.800' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (2, 5, N'GV0211047', 1, CAST(N'2024-01-11' AS Date), CAST(N'2024-04-12' AS Date), N'TH', CAST(N'2024-04-30T20:52:02.830' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (3, 1, N'GV0211039', 255, CAST(N'2024-01-10' AS Date), CAST(N'2024-04-11' AS Date), N'LT', CAST(N'2024-04-30T20:52:02.847' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (4, 5, N'GV0211047', 255, CAST(N'2024-01-11' AS Date), CAST(N'2024-04-12' AS Date), N'LT', CAST(N'2024-04-30T20:52:02.867' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (5, 3, N'TG368059', 0, CAST(N'2024-01-13' AS Date), CAST(N'2024-06-14' AS Date), N'LT', CAST(N'2024-04-30T20:52:02.887' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (6, 6, N'GV/N-20226', 255, CAST(N'2024-01-15' AS Date), CAST(N'2024-04-16' AS Date), N'LT', CAST(N'2024-04-30T20:52:02.900' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (8, 5, N'GV0211040', 2, CAST(N'2024-02-03' AS Date), CAST(N'2024-03-02' AS Date), N'TH', CAST(N'2024-05-01T11:54:42.303' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (9, 5, N'GV/N-20226', 3, CAST(N'2024-02-15' AS Date), CAST(N'2024-03-07' AS Date), N'TH', CAST(N'2024-05-01T11:55:38.157' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (10, 14, N'GV/N-20193', 255, CAST(N'2024-01-11' AS Date), CAST(N'2024-06-18' AS Date), N'LT', CAST(N'2024-05-01T11:57:43.590' AS DateTime))
INSERT [dbo].[LopHocPhanSection] ([IdLHPSection], [IdNHP], [MaGVGiangDay], [NhomTo], [Ngay_BD], [Ngay_KT], [MucDich], [_UpdateAt]) VALUES (11, 14, N'TG368059', 0, CAST(N'2024-02-04' AS Date), CAST(N'2024-04-19' AS Date), N'LT', CAST(N'2024-05-01T11:58:31.537' AS DateTime))
SET IDENTITY_INSERT [dbo].[LopHocPhanSection] OFF
GO
SET IDENTITY_INSERT [dbo].[LichMuonPhong] ON 


INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (155, 3, 1, N'QL793761', CAST(N'2024-02-04T07:00:08.400' AS DateTime), CAST(N'2024-02-04T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (156, 6, 5, N'QL196832', CAST(N'2024-04-03T13:00:00.000' AS DateTime), CAST(N'2024-04-03T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:40:51.240' AS DateTime), CAST(N'2024-04-30T20:52:03.007' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (158, 5, 8, N'QL054723', CAST(N'2024-03-06T07:00:00.000' AS DateTime), CAST(N'2024-03-06T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (159, 4, 11, N'QL684374', CAST(N'2024-04-08T13:00:00.000' AS DateTime), CAST(N'2024-04-08T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:44:15.427' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (160, 2, 22, N'QL684374', CAST(N'2024-04-06T13:00:00.000' AS DateTime), CAST(N'2024-04-06T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:44:15.427' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (161, 1, 20, N'QL684374', CAST(N'2024-05-03T07:00:00.000' AS DateTime), CAST(N'2024-05-03T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:09:28.250' AS DateTime), CAST(N'2024-05-01T12:09:28.250' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (163, 1, 20, N'QL684374', CAST(N'2024-05-10T07:00:00.000' AS DateTime), CAST(N'2024-05-10T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:11:26.887' AS DateTime), CAST(N'2024-05-01T12:11:26.887' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (164, 1, 20, N'QL684374', CAST(N'2024-05-17T07:00:00.000' AS DateTime), CAST(N'2024-05-17T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:11:56.440' AS DateTime), CAST(N'2024-05-01T12:11:56.440' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (165, 1, 20, N'QL684374', CAST(N'2024-05-23T07:00:00.000' AS DateTime), CAST(N'2024-05-23T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:12:16.110' AS DateTime), CAST(N'2024-05-01T12:12:16.110' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (166, 5, 19, N'QL684374', CAST(N'2024-05-08T07:00:00.000' AS DateTime), CAST(N'2024-05-08T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:13:26.180' AS DateTime), CAST(N'2024-05-01T12:13:26.180' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (167, 5, 19, N'QL684374', CAST(N'2024-05-15T07:00:00.000' AS DateTime), CAST(N'2024-05-15T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:13:52.810' AS DateTime), CAST(N'2024-05-01T12:13:52.810' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (168, 5, 19, N'QL684374', CAST(N'2024-05-22T07:00:00.000' AS DateTime), CAST(N'2024-05-22T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:14:07.427' AS DateTime), CAST(N'2024-05-01T12:14:07.427' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (171, 1, 20, N'QL684374', CAST(N'2024-05-30T07:00:00.000' AS DateTime), CAST(N'2024-05-30T10:30:00.000' AS DateTime), NULL, CAST(N'2024-05-01T12:15:02.920' AS DateTime), CAST(N'2024-05-01T12:15:02.920' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (174, 2, 8, N'QL054723', CAST(N'2024-03-13T07:00:00.000' AS DateTime), CAST(N'2024-03-13T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (175, 2, 8, N'QL054723', CAST(N'2024-03-13T07:00:00.000' AS DateTime), CAST(N'2024-03-13T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (176, 2, 8, N'QL054723', CAST(N'2024-03-20T07:00:00.000' AS DateTime), CAST(N'2024-03-20T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (177, 4, 1, N'QL793761', CAST(N'2024-02-12T07:00:00.000' AS DateTime), CAST(N'2024-02-12T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (178, 4, 1, N'QL793761', CAST(N'2024-02-19T07:00:00.000' AS DateTime), CAST(N'2024-02-19T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (179, 4, 1, N'QL793761', CAST(N'2024-02-26T07:00:00.000' AS DateTime), CAST(N'2024-02-26T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (180, 4, 1, N'QL793761', CAST(N'2024-03-04T07:00:00.000' AS DateTime), CAST(N'2024-03-04T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (181, 4, 1, N'QL793761', CAST(N'2024-03-11T07:00:00.000' AS DateTime), CAST(N'2024-03-11T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (183, 4, 1, N'QL793761', CAST(N'2024-03-18T07:00:00.000' AS DateTime), CAST(N'2024-03-18T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (184, 4, 1, N'QL793761', CAST(N'2024-03-25T07:00:00.000' AS DateTime), CAST(N'2024-03-25T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (185, 4, 1, N'QL793761', CAST(N'2024-04-01T07:00:00.000' AS DateTime), CAST(N'2024-04-01T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (186, 4, 1, N'QL793761', CAST(N'2024-04-08T07:00:00.000' AS DateTime), CAST(N'2024-04-08T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (187, 4, 1, N'QL793761', CAST(N'2024-04-15T07:00:00.000' AS DateTime), CAST(N'2024-04-15T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-30T20:52:02.973' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (188, 8, 8, N'QL054723', CAST(N'2024-03-15T07:00:00.000' AS DateTime), CAST(N'2024-03-15T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (189, 8, 8, N'QL054723', CAST(N'2024-03-22T07:00:00.000' AS DateTime), CAST(N'2024-03-22T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (190, 8, 8, N'QL054723', CAST(N'2024-03-29T07:00:00.000' AS DateTime), CAST(N'2024-03-29T10:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (191, 9, 8, N'QL054723', CAST(N'2024-02-27T13:00:00.000' AS DateTime), CAST(N'2024-02-27T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (192, 9, 8, N'QL054723', CAST(N'2024-02-05T13:00:00.000' AS DateTime), CAST(N'2024-03-05T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdLHPSection], [IdPH], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (193, 9, 8, N'QL054723', CAST(N'2024-02-12T13:00:00.000' AS DateTime), CAST(N'2024-03-12T16:30:00.000' AS DateTime), NULL, CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-30T20:52:02.940' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LichMuonPhong] OFF
GO
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau], [_UpdateAt]) VALUES (155, N'N21DCCN040', N'QL793761', CAST(N'2024-04-04T07:15:08.400' AS DateTime), CAST(N'2024-04-04T10:00:00.000' AS DateTime), N'MC + K + MT', CAST(N'2024-04-30T20:52:02.957' AS DateTime))
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau], [_UpdateAt]) VALUES (156, N'GV0211039', N'QL196832', CAST(N'2024-04-03T12:47:00.000' AS DateTime), NULL, N'MC + K + MT', CAST(N'2024-04-30T20:52:02.987' AS DateTime))
GO

INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN011', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN040', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN077', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN094', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN002', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN023', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN052', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN084', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN003', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN022', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN057', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N18DCAT074', N'D18CQAT02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN005', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN013', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN059', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN086', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN006', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN016', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN060', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN190', N'D21CQCN02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN007', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN026', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN062', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN087', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N19DCCN016', N'D19CQCNPM01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN030', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N18DCAT060', N'D18CQAT02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN192', N'D21CQCN02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN008', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN032', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N19DCCN151', N'D19CQCNPM02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN088', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN103', N'D21CQCN02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN033', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN193', N'D21CQCN02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN102', N'D21CQCN02-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN034', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN070', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N19DCCN178', N'D19CQCNHT01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN010', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN038', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN071', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN090', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN021', N'D21CQCN01-N', N'LP')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN012', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN045', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN079', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN095', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN047', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN178', N'D21CQCN02-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN096', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN020', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN050', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN081', N'D21CQCN01-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N19DCCN232', N'D19CQCNPM02-N', 'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N20DCCN057', N'D20CQCN01-N', 'TV')


GO
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (1, N'GV0211039', CAST(N'2024-04-30T20:52:03.140' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'GV/N-20191', CAST(N'2024-04-30T20:52:03.147' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'N21DCCN011', CAST(N'2024-05-01T12:41:22.623' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'N21DCCN040', CAST(N'2024-05-01T12:41:28.217' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'N21DCCN077', CAST(N'2024-05-01T12:41:33.490' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'N21DCCN094', CAST(N'2024-05-01T12:41:38.677' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'TG368059', CAST(N'2024-05-01T12:39:50.010' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (5, N'GV/N-20226', CAST(N'2024-05-01T12:40:26.550' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (5, N'GV0211040', CAST(N'2024-05-01T12:40:21.660' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (5, N'GV0211047', CAST(N'2024-04-30T20:52:03.150' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'GV/N-20226', CAST(N'2024-04-30T20:52:03.157' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN011', CAST(N'2024-05-01T12:41:22.623' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN040', CAST(N'2024-05-01T12:41:28.217' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN077', CAST(N'2024-05-01T12:41:33.490' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN094', CAST(N'2024-05-01T12:41:38.677' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN002', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN023', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN052', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN084', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN003', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN022', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN057', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N18DCAT074', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN005', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN013', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN059', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN086', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN006', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN016', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN060', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN190', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN007', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN026', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN062', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN087', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N19DCCN016', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN030', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N18DCAT060', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN192', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN008', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN032', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N19DCCN151', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN088', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN103', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN033', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N20DCCN057', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN193', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN102', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN034', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN070', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N19DCCN178', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN010', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN038', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN071', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN090', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN012', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN045', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN079', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN095', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN021', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN047', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN178', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN096', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN020', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN050', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N21DCCN081', CAST(N'2024-05-01T15:10:00' AS DateTime))
INSERT [dbo].[DsNgMPH_NhomHocPhan] ([IdNHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'N19DCCN232', CAST(N'2024-05-01T15:10:00' AS DateTime))

GO
--MARK: Insert trigger after Insert data
GO

CREATE TRIGGER [dbo].[BlockDeletedFromAttributes_LopHocPhanSection]
ON [dbo].[LopHocPhanSection]
AFTER UPDATE, DELETE
AS
	BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
			SELECT 1
    FROM deleted AS d
        INNER JOIN [dbo].[LopHocPhanSection] AS lhp ON d.IdLHPSection = lhp.IdLHPSection
    WHERE lhp.Ngay_BD <= GETDATE() AND lhp.Ngay_KT >= GETDATE()
		)
		BEGIN
        RAISERROR ('Cannot update or delete LopHocPhanSection when Ngay_BD and Ngay_KT are between current date', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO
