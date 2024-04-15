CREATE TABLE [dbo].[VaiTro]
(
	[IdVaiTro] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[MaVaiTro] [varchar](7) NOT NULL UNIQUE CHECK (MaVaiTro IN ('User', 'Manager', 'Admin'))
	-- User: Người mượn phòng, Manager: Quản lý, Admin: Quản trị viên
)

CREATE TABLE [dbo].[DoiTuongNgMPH]
(
	[IdDoiTuongNgMPH] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[MaDoiTuongNgMPH] [varchar](7) NOT NULL UNIQUE CHECK (MaDoiTuongNgMPH IN ('GV', 'SV'))
	-- GV: Giảng viên, SV: Sinh viên
)

CREATE TABLE [dbo].[LopSV]
(
	[MaLopSV] [varchar](15) NOT NULL PRIMARY KEY,
	[NienKhoa_BD] [smallint] NOT NULL CHECK (NienKhoa_BD >= 1980 AND NienKhoa_BD <= 2100),
	[NienKhoa_KT] [smallint] NOT NULL CHECK (NienKhoa_KT >= 1980 AND NienKhoa_KT <= 2100),
	[MaNganh] [int] NOT NULL,
	[Khoa] NVARCHAR(31) NOT NULL CHECK (Khoa NOT LIKE '%[^a-zA-ZÀ-ÿ0-9 ]%'),
	[HeDaoTao] [char](2) NOT NULL CHECK (HeDaoTao IN ('CQ', 'TX')),
	-- CQ: Chính quy, TX: Từ xa
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
	[TinhTrang] [char](1) NOT NULL CHECK (TinhTrang IN ('A', 'U', 'M')),
	-- A: Available, U: Unavailable, M: Maintenance
	[_ActiveAt] [datetime] NOT NULL DEFAULT GETDATE()
)

CREATE TABLE [dbo].[TaiKhoan]
(
	[IdTaiKhoan] [uniqueidentifier] NOT NULL PRIMARY KEY DEFAULT NEWID(),
	[IdVaiTro] [smallint] NOT NULL,
	[TenDangNhap] [varchar](30) NOT NULL CHECK (LEN(TenDangNhap) >= 8 AND TenDangNhap NOT LIKE '%[^a-zA-Z0-9]%'),
	[MatKhau] [char](60) NOT NULL,
	[_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
	[_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
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
	[SDT] CHAR(16) NOT NULL UNIQUE,
	-- CHECK (SDT LIKE '+[0-9]{1,3}-[0-9]{9,11}'),
	[NgaySinh] DATE NOT NULL CHECK (NgaySinh < GETDATE() AND DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 17),
	[GioiTinh] TINYINT NOT NULL CHECK (GioiTinh IN (0, 1)),
	-- 0: Nam, 1: Nữ
	[DiaChi] NVARCHAR(127) NOT NULL CHECK (DiaChi NOT LIKE '%[^a-zA-ZÀ-ÿ0-9., _-()\-\.\?\;\/]%'),
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
	[ChucVu] [varchar](7) NULL CHECK (ChucVu IN ('LT', 'LP', 'TV')),
	-- LT: Lớp trưởng, LP: Lớp phó, TV: Thành viên
	FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
	FOREIGN KEY ([MaSV]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE [dbo].[QuanLy]
(
	[MaQL] [varchar](15) NOT NULL PRIMARY KEY,
	[IdTaiKhoan] [uniqueidentifier] NOT NULL UNIQUE,
	[HoTen] NVARCHAR(63) NOT NULL CHECK (HoTen NOT LIKE '%[^a-zA-ZÀ-ÿ ]%'),
	[Email] NVARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%.%'),
	[SDT] CHAR(16) NOT NULL UNIQUE,
	-- CHECK (SDT LIKE '+[0-9]{1,3}-[0-9]{9,11}'),
	[NgaySinh] DATE NOT NULL CHECK (NgaySinh < GETDATE() AND DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 18),
	[GioiTinh] TINYINT NOT NULL CHECK (GioiTinh IN (0, 1)),
	-- 0: Nam, 1: Nữ
	[DiaChi] NVARCHAR(127) NOT NULL CHECK (DiaChi NOT LIKE '%[^a-zA-ZÀ-ÿ0-9., _-()\-\.\?\;\/]%'),
	FOREIGN KEY ([IdTaiKhoan]) REFERENCES [dbo].[TaiKhoan]([IdTaiKhoan]) ON DELETE CASCADE
)

CREATE TABLE [dbo].[NhomHocPhan]
(
	[IdNHP] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[MaMH] [varchar](15) NOT NULL,
	[MaLopSV] [varchar](15) NOT NULL,
	[MaQLKhoiTao] [varchar](15) NOT NULL,
	[Nhom] [tinyint] NOT NULL CHECK (Nhom > 0),
	[_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
	[_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
	[_DeleteAt] [datetime] NULL,
	FOREIGN KEY ([MaMH]) REFERENCES [dbo].[MonHoc]([MaMH]),
	FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
	FOREIGN KEY ([MaQLKhoiTao]) REFERENCES [dbo].[QuanLy]([MaQL]),
	CONSTRAINT [UQ_NhomHocPhan_MaMH_Nhom] UNIQUE ([MaMH], [MaLopSV], [Nhom])
)

CREATE TABLE [dbo].[LopHocPhanSection]
(
	[IdLHPSection] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IdNHP] [int] NOT NULL,
	[MaGVGiangDay] [varchar](15) NOT NULL,
	[NhomTo] [tinyint] NOT NULL DEFAULT 255,
	-- 255: Phân nhóm, 0: Không phân tổ, 1: Phân tổ 1, 2: Phân tổ 2, ...
	[Ngay_BD] [date] NOT NULL,
	[Ngay_KT] [date] NOT NULL,
	[MucDich] [char](2) NOT NULL CHECK (MucDich IN ('LT', 'TH', 'TN', 'U')),
	-- LT: Lý thuyết, TH: Thực hành, TN: Thí nghiệm, U: Unknown
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
	[ThoiGian_TPH] [datetime] NULL,
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