CREATE TABLE [dbo].[VaiTro](
    [IdVaiTro] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaVaiTro] [varchar](7) NOT NULL UNIQUE CHECK (MaVaiTro IN ('NgMPH', 'QL', 'Admin'))
)

CREATE TABLE [dbo].[TaiKhoan](
    [IdTaiKhoan] [uniqueidentifier] NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [IdVaiTro] [smallint] NOT NULL,
    [TenDangNhap] [varchar](30) NOT NULL CHECK (LEN(TenDangNhap) >= 8),
    [MatKhau] [char](60) NOT NULL,
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([IdVaiTro]) REFERENCES [dbo].[VaiTro]([IdVaiTro])
)

CREATE TABLE [dbo].[DoiTuongNgMPH](
    [IdDoiTuongNgMPH] [smallint] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaDoiTuongNgMPH] [varchar](7) NOT NULL UNIQUE CHECK (MaDoiTuongNgMPH IN ('GV', 'SV'))
)

CREATE TABLE [dbo].[NguoiMuonPhong](
    [MaNgMPH] [varchar](15) NOT NULL PRIMARY KEY,
    [IdTaiKhoan] [uniqueidentifier] NOT NULL UNIQUE,
    [IdDoiTuongNgMPH] [smallint] NOT NULL,
    [HoTen] [nvarchar](63) NOT NULL CHECK (HoTen LIKE N'%[^a-zA-ZÀ-ÿ ]%'),
    [Email] [varchar](255) NOT NULL UNIQUE CHECK (Email LIKE '%@%' AND Email NOT LIKE '%@%@%'),
    [SDT] [char](12) NOT NULL UNIQUE CHECK (SDT LIKE '%[0-9]%'),
    [NgaySinh] [date] NOT NULL CHECK (DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 17),
    [GioiTinh] [tinyint] NOT NULL,
    [DiaChi] [nvarchar](127) NOT NULL,
    FOREIGN KEY ([IdTaiKhoan]) REFERENCES [dbo].[TaiKhoan]([IdTaiKhoan]) ON DELETE CASCADE,
    FOREIGN KEY ([IdDoiTuongNgMPH]) REFERENCES [dbo].[DoiTuongNgMPH]([IdDoiTuongNgMPH])
)

CREATE TABLE [dbo].[GiangVien](
    [MaGV] [varchar](15) NOT NULL PRIMARY KEY,
    [ChucDanh] [nvarchar](31) NOT NULL,
    FOREIGN KEY ([MaGV]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]) ON DELETE CASCADE
)

CREATE TABLE [dbo].[LopSV](
    [MaLopSV] [varchar](15) NOT NULL PRIMARY KEY,
    [TenLopSV] [nvarchar](127) NOT NULL,
    [NienKhoa_BD] [smallint] NOT NULL CHECK (NienKhoa_BD >= 1980 AND NienKhoa_BD <= 2100),
    [NienKhoa_KT] [smallint] NOT NULL CHECK (NienKhoa_KT >= 1980 AND NienKhoa_KT <= 2100),
    CONSTRAINT [CK_LopSV_NienKhoa] CHECK ([NienKhoa_BD] < [NienKhoa_KT])
)

CREATE TABLE [dbo].[SinhVien](
    [MaSV] [varchar](15) NOT NULL PRIMARY KEY,
    [MaLopSV] [varchar](15) NOT NULL,
    [ChucVu] [varchar](7) NULL CHECK (ChucVu IN ('LT', 'LP', 'TV')),
    [MaNgMPH] [varchar](15) NOT NULL,
    FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
    FOREIGN KEY ([MaNgMPH]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]) ON DELETE CASCADE
)

CREATE TABLE [dbo].[QuanLy](
    [MaQL] [varchar](15) NOT NULL PRIMARY KEY,
    [IdTaiKhoan] [uniqueidentifier] NOT NULL UNIQUE,
    [HoTen] [nvarchar](63) NOT NULL CHECK (HoTen LIKE N'%[^a-zA-ZÀ-ÿ ]%'),
    [Email] [varchar](255) NOT NULL UNIQUE CHECK (Email LIKE '%@%' AND Email NOT LIKE '%@%@%'),
    [SDT] [char](12) NOT NULL UNIQUE CHECK (SDT LIKE '%[0-9]%'),
    [NgaySinh] [date] NOT NULL CHECK (DATEDIFF(YEAR, NgaySinh, GETDATE()) >= 17),
    [GioiTinh] [tinyint] NOT NULL,
    [DiaChi] [nvarchar](127) NOT NULL,
    FOREIGN KEY ([IdTaiKhoan]) REFERENCES [dbo].[TaiKhoan]([IdTaiKhoan]) ON DELETE CASCADE
)

CREATE TABLE [dbo].[MonHoc](
    [MaMH] [varchar](15) NOT NULL PRIMARY KEY,
    [TenMH] [nvarchar](31) NOT NULL,
    [_ActiveAt] [datetime] NOT NULL DEFAULT GETDATE()
)

CREATE TABLE [dbo].[LopHocPhan](
    [IdLHP] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [MaGVGiangDay] [varchar](15) NOT NULL,
    [MaMH] [varchar](15) NOT NULL,
    [MaLopSV] [varchar](15) NOT NULL,
    [Ngay_BD] [date] NOT NULL,
    [Ngay_KT] [date] NOT NULL,
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([MaGVGiangDay]) REFERENCES [dbo].[GiangVien]([MaGV]),
    FOREIGN KEY ([MaMH]) REFERENCES [dbo].[MonHoc]([MaMH]),
    FOREIGN KEY ([MaLopSV]) REFERENCES [dbo].[LopSV]([MaLopSV]),
    CONSTRAINT [CK_LopHocPhan_Ngay] CHECK ([Ngay_BD] < [Ngay_KT])
)

CREATE TABLE [dbo].[PhongHoc](
    [IdPH] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [MaPH] [varchar](7) NOT NULL,
    [SucChua] [tinyint] NOT NULL,
    [TinhTrang] [char](1) NOT NULL CHECK (TinhTrang IN ('A', 'U', 'M')),
    [_ActiveAt] [datetime] NOT NULL DEFAULT GETDATE()
)

CREATE TABLE [dbo].[LichMuonPhong](
    [IdLMPH] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [IdPH] [int] NOT NULL,
    [IdLHP] [int] NOT NULL,
    [MaQLKhoiTao] [varchar](15) NOT NULL,
    [ThoiGian_BD] [datetime] NOT NULL CHECK (ThoiGian_BD > GETDATE()),
    [ThoiGian_KT] [datetime] NOT NULL,
    [MucDich] [char](2) NOT NULL CHECK (MucDich IN ('LT', 'TH', 'U')),
    [LyDo] [nvarchar](31) NULL,
    [_CreateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] [datetime] NULL,
    FOREIGN KEY ([IdPH]) REFERENCES [dbo].[PhongHoc]([IdPH]),
    FOREIGN KEY ([IdLHP]) REFERENCES [dbo].[LopHocPhan]([IdLHP]),
    FOREIGN KEY ([MaQLKhoiTao]) REFERENCES [dbo].[QuanLy]([MaQL]),
    CONSTRAINT [CK_LichMuonPhong_ThoiGian] CHECK ([ThoiGian_BD] < [ThoiGian_KT])
)

CREATE TABLE [dbo].[MuonPhongHoc](
    [IdLMPH] [int] NOT NULL PRIMARY KEY,
    [MaNgMPH] [varchar](15) NOT NULL,
    [MaQLDuyet] [varchar](15) NOT NULL,
    [ThoiGian_MPH] [datetime] NOT NULL CHECK (ThoiGian_MPH > GETDATE()) DEFAULT GETDATE(),
    [ThoiGian_TPH] [datetime] NULL,
    [YeuCau] [nvarchar](127) NULL,
    FOREIGN KEY ([IdLMPH]) REFERENCES [dbo].[LichMuonPhong]([IdLMPH]) ON DELETE CASCADE,
    FOREIGN KEY ([MaNgMPH]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH]),
    FOREIGN KEY ([MaQLDuyet]) REFERENCES [dbo].[QuanLy]([MaQL]),
    CONSTRAINT [CK_MuonPhongHoc_ThoiGian] CHECK ([ThoiGian_MPH] < [ThoiGian_TPH])
)

CREATE TABLE [dbo].[DsMPH_LopHoc](
    [IdLHP] [int] NOT NULL PRIMARY KEY,
    [MaNgMPH] [varchar](15) NOT NULL PRIMARY KEY,
    [_UpdateAt] [datetime] NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([IdLHP]) REFERENCES [dbo].[LopHocPhan]([IdLHP]) ON DELETE CASCADE,
    FOREIGN KEY ([MaNgMPH]) REFERENCES [dbo].[NguoiMuonPhong]([MaNgMPH])
)