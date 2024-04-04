USE [master]
GO
/****** Object:  Database [QLMPH]    Script Date: 01-Apr-24 22:04:12 ******/
CREATE DATABASE [QLMPH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLMPH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\QLMPH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLMPH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\QLMPH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLMPH] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLMPH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLMPH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLMPH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLMPH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLMPH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLMPH] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLMPH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLMPH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLMPH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLMPH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLMPH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLMPH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLMPH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLMPH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLMPH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLMPH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLMPH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLMPH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLMPH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLMPH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLMPH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLMPH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLMPH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLMPH] SET RECOVERY FULL 
GO
ALTER DATABASE [QLMPH] SET  MULTI_USER 
GO
ALTER DATABASE [QLMPH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLMPH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLMPH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLMPH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLMPH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLMPH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLMPH', N'ON'
GO
ALTER DATABASE [QLMPH] SET QUERY_STORE = ON
GO
ALTER DATABASE [QLMPH] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QLMPH]
GO
USE [QLMPH]
GO
/****** Object:  Sequence [dbo].[lichmuonphong_seq]    Script Date: 01-Apr-24 22:04:12 ******/
CREATE SEQUENCE [dbo].[lichmuonphong_seq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 50
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [QLMPH]
GO
/****** Object:  Sequence [dbo].[lophoc_seq]    Script Date: 01-Apr-24 22:04:12 ******/
CREATE SEQUENCE [dbo].[lophoc_seq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 50
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [QLMPH]
GO
/****** Object:  Sequence [dbo].[phonghoc_seq]    Script Date: 01-Apr-24 22:04:12 ******/
CREATE SEQUENCE [dbo].[phonghoc_seq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 50
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [dbo].[DoiTuongNgMPH]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiTuongNgMPH](
	[IdDoiTuongNgMPH] [smallint] NOT NULL,
	[TenDoiTuongNgMPH] [nvarchar](31) NOT NULL,
 CONSTRAINT [PK_VaiTroNgMPH] PRIMARY KEY CLUSTERED 
(
	[IdDoiTuongNgMPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [UQ_TenDoiTuongNgMPH] UNIQUE ([TenDoiTuongNgMPH])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DsMPH_LopHoc]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DsMPH_LopHoc](
	[IdLHP] [int] NOT NULL,
	[MaNgMPH] [varchar](15) NOT NULL,
	[_UpdateAt] [datetime] NOT NULL,
 CONSTRAINT [PK_DsMPH_LopHoc] PRIMARY KEY CLUSTERED 
(
	[IdLHP] ASC,
	[MaNgMPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGV] [varchar](15) NOT NULL,
	[ChucDanh] [nvarchar](31) NOT NULL,
 CONSTRAINT [PK_GiangVien] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichMuonPhong]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichMuonPhong](
	[IdLMPH] [int] NOT NULL,
	[IdPH] [int] NOT NULL,
	[IdLHP] [int] NOT NULL,
	[MaQLKhoiTao] [varchar](15) NOT NULL,
	[ThoiGian_BD] [datetime] NOT NULL,
	[ThoiGian_KT] [datetime] NOT NULL,
	[MucDich] [nvarchar](15) NOT NULL,
	[LyDo] [nvarchar](31) NULL,
	[_CreateAt] [datetime] NOT NULL,
	[_DeleteAt] [datetime] NULL,
 CONSTRAINT [PK_lichmuonphong] PRIMARY KEY CLUSTERED 
(
	[IdLMPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHocPhan]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHocPhan](
	[IdLHP] [int] NOT NULL,
	[MaGVGiangDay] [varchar](15) NOT NULL,
	[MaMH] [varchar](15) NOT NULL,
	[MaLopSV] [varchar](15) NOT NULL,
	[Ngay_BD] [date] NOT NULL,
	[Ngay_KT] [date] NOT NULL,
	[_CreateAt] [datetime] NOT NULL,
	[_UpdateAt] [datetime] NOT NULL,
	[_DeleteAt] [datetime] NULL,
 CONSTRAINT [PK_LopHoc] PRIMARY KEY CLUSTERED 
(
	[IdLHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopSV]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopSV](
	[MaLopSV] [varchar](15) NOT NULL,
	[TenLopSV] [nvarchar](127) NOT NULL,
	[NienKhoa_BD] [smallint] NOT NULL,
	[NienKhoa_KT] [smallint] NOT NULL,
 CONSTRAINT [PK_LopSV] PRIMARY KEY CLUSTERED 
(
	[MaLopSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMH] [varchar](15) NOT NULL,
	[TenMH] [nvarchar](31) NOT NULL,
	[_ActiveAt] [datetime] NOT NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MuonPhongHoc]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MuonPhongHoc](
	[IdLMPH] [int] NOT NULL,
	[MaNgMPH] [varchar](15) NOT NULL,
	[MaQLDuyet] [varchar](15) NOT NULL,
	[ThoiGian_MPH] [datetime] NOT NULL,
	[ThoiGian_TPH] [datetime] NULL,
	[YeuCau] [nvarchar](127) NULL,
 CONSTRAINT [PK_MuonPhongHoc] PRIMARY KEY CLUSTERED 
(
	[IdLMPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiMuonPhong]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiMuonPhong](
	[MaNgMPH] [varchar](15) NOT NULL,
	[IdTaiKhoan] [uniqueidentifier] NOT NULL,
	[IdDoiTuongNgMPH] [smallint] NOT NULL,
	[HoTen] [nvarchar](63) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[SDT] [char](12) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [tinyint] NOT NULL,
	[DiaChi] [nvarchar](127) NOT NULL,
 CONSTRAINT [PK_NguoiMuonPhong] PRIMARY KEY CLUSTERED 
(
	[MaNgMPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongHoc]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongHoc](
	[IdPH] [int] NOT NULL,
	[MaPH] [varchar](7) NOT NULL,
	[TinhTrang] [nvarchar](15) NOT NULL,
	[_ActiveAt] [datetime] NOT NULL,
 CONSTRAINT [PK_PhongHoc] PRIMARY KEY CLUSTERED 
(
	[IdPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuanLy]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanLy](
	[MaQL] [varchar](15) NOT NULL,
	[IdTaiKhoan] [uniqueidentifier] NOT NULL,
	[HoTen] [nvarchar](63) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[SDT] [char](12) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [tinyint] NOT NULL,
	[DiaChi] [nvarchar](127) NOT NULL,
 CONSTRAINT [PK_QuanLy] PRIMARY KEY CLUSTERED 
(
	[MaQL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MaSV] [varchar](15) NOT NULL,
	[MaLopSV] [varchar](15) NOT NULL,
	[ChucVu] [nvarchar](31) NULL,
 CONSTRAINT [PK_SinhVien] PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[IdTaiKhoan] [uniqueidentifier] NOT NULL,
	[IdVaiTro] [smallint] NOT NULL,
	[TenDangNhap] [varchar](31) NOT NULL,
	[MatKhau] [varchar](63) NOT NULL,
	[_CreateAt] [datetime] NOT NULL,
	[_UpdateAt] [datetime] NOT NULL,
	[_DeleteAt] [datetime] NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[IdTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 01-Apr-24 22:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[IdVaiTro] [smallint] NOT NULL,
	[TenVaiTro] [nvarchar](31) NOT NULL,
 CONSTRAINT [PK_VaiTro] PRIMARY KEY CLUSTERED 
(
	[IdVaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [TenDoiTuongNgMPH]) VALUES (1, N'Sinh viên')
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [TenDoiTuongNgMPH]) VALUES (2, N'Giảng viên')
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [TenDoiTuongNgMPH]) VALUES (255, N'Khác')
GO
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'MaGV', N'Trợ giảng')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'MaGV01.01.02', N'Giảng viên chính')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'MaGV01.01.03', N'Giảng viên chính')
GO
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_DeleteAt]) VALUES (1235, 126, 1234, N'MaQL.2.01.002', CAST(N'2024-03-22T07:00:00.000' AS DateTime), CAST(N'2024-03-22T10:30:00.000' AS DateTime), N'Học lý thuyết', NULL, CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_DeleteAt]) VALUES (5342, 126, 1234, N'MaQL.2.01.002', CAST(N'2024-03-29T07:00:00.000' AS DateTime), CAST(N'2024-03-29T10:30:00.000' AS DateTime), N'Học lý thuyết', NULL, CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_DeleteAt]) VALUES (25362, 128, 1234, N'MaQL01.01.003', CAST(N'2024-03-27T07:00:00.000' AS DateTime), CAST(N'2024-03-27T10:30:00.000' AS DateTime), N'Học thực hành', NULL, CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_DeleteAt]) VALUES (25368, 126, 1234, N'MaQL.2.01.002', CAST(N'2024-03-15T07:00:00.000' AS DateTime), CAST(N'2024-03-15T10:30:00.000' AS DateTime), N'Học lý thuyết', NULL, CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (1234, N'MaGV01.01.03', N'INT1434-3', N'D21CQCN01-N', CAST(N'2024-01-11' AS Date), CAST(N'2024-03-28' AS Date), CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (1235, N'MaGV01.01.02', N'INT1340', N'D21CQCN01-N', CAST(N'2024-01-09' AS Date), CAST(N'2024-04-02' AS Date), CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[LopSV] ([MaLopSV], [TenLopSV], [NienKhoa_BD], [NienKhoa_KT]) VALUES (N'D21CQCN01-N', N'Lớp Công nghệ thông tin 1 khóa 2021 Đại học chính quy cơ sở miền Nam', 2021, 2026)
INSERT [dbo].[LopSV] ([MaLopSV], [TenLopSV], [NienKhoa_BD], [NienKhoa_KT]) VALUES (N'D21CQCN02-N', N'Lớp Công nghệ thông tin 2 khóa 2021 Đại học chính quy cơ sở miền Nam', 2021, 2026)
GO
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1340', N'Nhập môn công nghệ phần mềm', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1434-3', N'Lập trình Web', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
GO
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (1235, N'MaGV01.01.03', N'MaQL.2.01.002', CAST(N'2024-03-31T13:05:07.797' AS DateTime), NULL, N'123')
GO
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'MaGV', N'1f9c15f3-6e9d-4856-ad5f-53131cfaf453', 2, N'Nguyễn Văn A', N'nguyenvana@ptithcm.edu.vn', N'0113322445  ', CAST(N'1988-07-05' AS Date), 2, N'Quận Thủ Đức, TP.HCM')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'MaGV01.01.02', N'609f8d4d-d98d-470b-afb6-839bb7ae9ef1', 2, N'Nguyễn Thị Bích Nguyên', N'nguyenthibichnguyen@ptithcm.edu.vn', N'0123654789  ', CAST(N'1990-04-09' AS Date), 1, N'Man Thiện, Quận Thủ Đức, TP.Hồ Chí Minh')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'MaGV01.01.03', N'87c872d8-07fe-41b2-8529-430f45792a13', 2, N'Nguyễn Trung Hiếu', N'nguyntrunghieu@ptithcm.edu.vn', N'0345678912  ', CAST(N'1982-06-04' AS Date), 2, N'Đường Man Thiện, Quận Thủ Đức, TP.Hồ Chí Minh')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN011', N'5df6334e-da3b-4843-81ef-46ddffd3d98c', 1, N'Thái Văn Anh Chính', N'n21dccn011@student.ptithcm.edu.vn', N'0123456879  ', CAST(N'2003-12-20' AS Date), 2, N'Man Thiên, Quận Thủ Đức, TP.Hồ Chí Minh')
GO
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (123, N'2A08', N'Sử dụng', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (124, N'2A08', N'Bảo dưỡng', CAST(N'2024-03-08T10:30:00.000' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (125, N'2A08', N'Sử dụng ', CAST(N'2024-03-23T07:00:00.000' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (126, N'2B32', N'Sử dụng', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (127, N'2B37', N'Đã hủy', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [TinhTrang], [_ActiveAt]) VALUES (128, N'2B21', N'Sử dụng', CAST(N'2024-03-02T07:00:00.000' AS DateTime))
GO
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'MaQL.2.01.002', N'58edb354-1115-4550-a437-b3425aabc60a', N'Ngô Cao Hy', N'caohyngoctsv@ptithcm.edu.vn', N'0345678912  ', CAST(N'2000-06-04' AS Date), 2, N'Man Thiện, Quận Thủ Đức, TP.Hồ Chí Minh')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'MaQL01.01.003', N'cbd799c7-96da-4d22-98d3-e4e59a58b671', N'Thái Văn Anh Chính', N'chinhhvcs@ptithcm.edu.vn', N'0123456789  ', CAST(N'1987-12-20' AS Date), 2, N'Man Thiện, Quận Thủ Đức, TP.Hồ Chí Minh')
GO
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN011', N'D21CQCN01-N', N'Thành viên')
GO
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'09caad31-7ca7-45a2-a582-16c91055444a', 3, N'nguyenthibichnguyen', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'87c872d8-07fe-41b2-8529-430f45792a13', 3, N'nguyentrunghieu', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'5df6334e-da3b-4843-81ef-46ddffd3d98c', 3, N'n21dccn011', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1f9c15f3-6e9d-4856-ad5f-53131cfaf453', 3, N'nguyenvana', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'c3f9f9cc-8699-4ab8-a9ea-70e549567a53', 3, N'n21dccn097', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'609f8d4d-d98d-470b-afb6-839bb7ae9ef1', 3, N'nguyenthibichnguyen', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'58edb354-1115-4550-a437-b3425aabc60a', 2, N'ngocaohy', N'123456', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'cbd799c7-96da-4d22-98d3-e4e59a58b671', 1, N'admin', N'123', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[VaiTro] ([IdVaiTro], [TenVaiTro]) VALUES (1, N'Admin')
INSERT [dbo].[VaiTro] ([IdVaiTro], [TenVaiTro]) VALUES (2, N'Quản lý')
INSERT [dbo].[VaiTro] ([IdVaiTro], [TenVaiTro]) VALUES (3, N'Người mượn phòng')
INSERT [dbo].[VaiTro] ([IdVaiTro], [TenVaiTro]) VALUES (255, N'Khác')
GO
ALTER TABLE [dbo].[DsMPH_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DsMPH_LopHoc_lophoc] FOREIGN KEY([IdLHP])
REFERENCES [dbo].[LopHocPhan] ([IdLHP])
GO
ALTER TABLE [dbo].[DsMPH_LopHoc] CHECK CONSTRAINT [FK_DsMPH_LopHoc_lophoc]
GO
ALTER TABLE [dbo].[DsMPH_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DsMPH_LopHoc_NguoiMuonPhong] FOREIGN KEY([MaNgMPH])
REFERENCES [dbo].[NguoiMuonPhong] ([MaNgMPH])
GO
ALTER TABLE [dbo].[DsMPH_LopHoc] CHECK CONSTRAINT [FK_DsMPH_LopHoc_NguoiMuonPhong]
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD  CONSTRAINT [FK_GiangVien_NguoiMuonPhong] FOREIGN KEY([MaGV])
REFERENCES [dbo].[NguoiMuonPhong] ([MaNgMPH])
GO
ALTER TABLE [dbo].[GiangVien] CHECK CONSTRAINT [FK_GiangVien_NguoiMuonPhong]
GO
ALTER TABLE [dbo].[LichMuonPhong]  WITH CHECK ADD  CONSTRAINT [FK_LichMuonPhong_LopHoc] FOREIGN KEY([IdLHP])
REFERENCES [dbo].[LopHocPhan] ([IdLHP])
GO
ALTER TABLE [dbo].[LichMuonPhong] CHECK CONSTRAINT [FK_LichMuonPhong_LopHoc]
GO
ALTER TABLE [dbo].[LichMuonPhong]  WITH CHECK ADD  CONSTRAINT [FK_LichMuonPhong_phonghoc] FOREIGN KEY([IdPH])
REFERENCES [dbo].[PhongHoc] ([IdPH])
GO
ALTER TABLE [dbo].[LichMuonPhong] CHECK CONSTRAINT [FK_LichMuonPhong_phonghoc]
GO
ALTER TABLE [dbo].[LichMuonPhong]  WITH CHECK ADD  CONSTRAINT [FK_LichMuonPhong_QuanLy] FOREIGN KEY([MaQLKhoiTao])
REFERENCES [dbo].[QuanLy] ([MaQL])
GO
ALTER TABLE [dbo].[LichMuonPhong] CHECK CONSTRAINT [FK_LichMuonPhong_QuanLy]
GO
ALTER TABLE [dbo].[LopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_LopHoc_GiangVien] FOREIGN KEY([MaGVGiangDay])
REFERENCES [dbo].[GiangVien] ([MaGV])
GO
ALTER TABLE [dbo].[LopHocPhan] CHECK CONSTRAINT [FK_LopHoc_GiangVien]
GO
ALTER TABLE [dbo].[LopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_LopHoc_lopsv] FOREIGN KEY([MaLopSV])
REFERENCES [dbo].[LopSV] ([MaLopSV])
GO
ALTER TABLE [dbo].[LopHocPhan] CHECK CONSTRAINT [FK_LopHoc_lopsv]
GO
ALTER TABLE [dbo].[LopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_LopHoc_monhoc] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMH])
GO
ALTER TABLE [dbo].[LopHocPhan] CHECK CONSTRAINT [FK_LopHoc_monhoc]
GO
ALTER TABLE [dbo].[MuonPhongHoc]  WITH CHECK ADD  CONSTRAINT [FK_MuonPhongHoc_lichmuonphong] FOREIGN KEY([IdLMPH])
REFERENCES [dbo].[LichMuonPhong] ([IdLMPH])
GO
ALTER TABLE [dbo].[MuonPhongHoc] CHECK CONSTRAINT [FK_MuonPhongHoc_lichmuonphong]
GO
ALTER TABLE [dbo].[MuonPhongHoc]  WITH CHECK ADD  CONSTRAINT [FK_MuonPhongHoc_NguoiMuonPhong] FOREIGN KEY([MaNgMPH])
REFERENCES [dbo].[NguoiMuonPhong] ([MaNgMPH])
GO
ALTER TABLE [dbo].[MuonPhongHoc] CHECK CONSTRAINT [FK_MuonPhongHoc_NguoiMuonPhong]
GO
ALTER TABLE [dbo].[MuonPhongHoc]  WITH CHECK ADD  CONSTRAINT [FK_MuonPhongHoc_QuanLy] FOREIGN KEY([MaQLDuyet])
REFERENCES [dbo].[QuanLy] ([MaQL])
GO
ALTER TABLE [dbo].[MuonPhongHoc] CHECK CONSTRAINT [FK_MuonPhongHoc_QuanLy]
GO
ALTER TABLE [dbo].[NguoiMuonPhong]  WITH CHECK ADD  CONSTRAINT [FK_NguoiMuonPhong_DoiTuongNgMPH] FOREIGN KEY([IdDoiTuongNgMPH])
REFERENCES [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH])
GO
ALTER TABLE [dbo].[NguoiMuonPhong] CHECK CONSTRAINT [FK_NguoiMuonPhong_DoiTuongNgMPH]
GO
ALTER TABLE [dbo].[NguoiMuonPhong]  WITH CHECK ADD  CONSTRAINT [FK_NguoiMuonPhong_NguoiMuonPhong] FOREIGN KEY([MaNgMPH])
REFERENCES [dbo].[NguoiMuonPhong] ([MaNgMPH])
GO
ALTER TABLE [dbo].[NguoiMuonPhong] CHECK CONSTRAINT [FK_NguoiMuonPhong_NguoiMuonPhong]
GO
ALTER TABLE [dbo].[QuanLy]  WITH CHECK ADD  CONSTRAINT [FK_QuanLy_TaiKhoan] FOREIGN KEY([IdTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([IdTaiKhoan])
GO
ALTER TABLE [dbo].[QuanLy] CHECK CONSTRAINT [FK_QuanLy_TaiKhoan]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_NguoiMuonPhong] FOREIGN KEY([MaSV])
REFERENCES [dbo].[NguoiMuonPhong] ([MaNgMPH])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_NguoiMuonPhong]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_vaitro] FOREIGN KEY([IdVaiTro])
REFERENCES [dbo].[VaiTro] ([IdVaiTro])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_vaitro]
GO
USE [master]
GO
ALTER DATABASE [QLMPH] SET  READ_WRITE 
GO
