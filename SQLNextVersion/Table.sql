USE QLMuonPhongHoc

GO
-- Drop all foreign keys
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += COALESCE('ALTER TABLE ' + QUOTENAME(sch.name) + '.' + QUOTENAME(tp.name) 
            + ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + ';' + CHAR(13), '')
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables AS tp ON fkc.parent_object_id = tp.object_id
INNER JOIN sys.schemas AS sch ON tp.schema_id = sch.schema_id
INNER JOIN sys.tables AS tr ON fkc.referenced_object_id = tr.object_id

EXEC sp_executesql @sql;

GO
-- Drop all tables
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += COALESCE('DROP TABLE ' + QUOTENAME(name) + ';' + CHAR(13), '')
FROM sys.tables

EXEC sp_executesql @sql;

GO
-- Create all tables
CREATE TABLE [dbo].[VaiTro]
(
    [idVaiTro] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [maVaiTro] VARCHAR(7) NOT NULL CHECK (maVaiTro NOT LIKE '[^a-zA-Z0-9]') INDEX [AK_VaiTro_maVaiTro] UNIQUE,
    [tenVaiTro] VARCHAR(63) NOT NULL CHECK (tenVaiTro NOT LIKE '[^a-zA-Z ]'),
    [moTaVaiTro] NVARCHAR(MAX) NOT NULL
)

CREATE TABLE [dbo].[LopSinhVien]
(
    [maLopSinhVien] VARCHAR(15) NOT NULL PRIMARY KEY,
    [startYear_NienKhoa] SMALLINT NOT NULL CHECK (startYear_NienKhoa >= 1980),
    [endYear_NienKhoa] SMALLINT NOT NULL CHECK (endYear_NienKhoa <= 2100),
    [maNganh] INT NOT NULL,
    [tenKhoa] NVARCHAR(31) NOT NULL CHECK (tenKhoa NOT LIKE '%[^a-zA-ZÀ-ÿ0-9 ]%'),
    [maHeDaoTao] CHAR(2) NOT NULL CHECK (maHeDaoTao IN ('CQ', 'TX')), -- CQ: Chính quy, TX: Từ xa
    [maChatLuongDaoTao] CHAR(2) NOT NULL CHECK (maChatLuongDaoTao IN ('DT', 'CL')), -- DT: Đại trà, CL: Chất lượng cao
    CONSTRAINT [CK_LopSinhVien_Timeframe_NienKhoa] CHECK ([startYear_NienKhoa] <= [endYear_NienKhoa])
)

CREATE TABLE [dbo].[MonHoc]
(
    [maMonHoc] VARCHAR(15) NOT NULL PRIMARY KEY NONCLUSTERED,
    [tenMonHoc] NVARCHAR(31) NOT NULL,
    -- [soTinChi] TINYINT NOT NULL CHECK (soTinChi > 0),
    [_ActiveAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_Status] CHAR(1) NOT NULL CHECK (_Status IN ('A', 'U')), -- A: Available, U: Unavailable
    INDEX [CI_MonHoc_maMonHoc] UNIQUE CLUSTERED ([_ActiveAt] ASC, [_Status] ASC, [maMonHoc] ASC)
)

CREATE TABLE [dbo].[PhongHoc]
(
    [idPhongHoc] INT NOT NULL IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,
    [maPhongHoc] VARCHAR(7) NOT NULL CHECK (maPhongHoc NOT LIKE '%[^a-zA-Z0-9/-]%' ESCAPE '/') INDEX [AK_PhongHoc_maPhongHoc],
    [sucChua] TINYINT NOT NULL CHECK (sucChua > 0),
    [_ActiveAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_Status] CHAR(1) NOT NULL CHECK (_Status IN ('A', 'U', 'M')), -- A: Available, U: Unavailable, M: Maintenance
    INDEX [CI_PhongHoc_maPhongHoc] CLUSTERED ([_ActiveAt] ASC, [_Status] ASC, [idPhongHoc] ASC)
)

CREATE TABLE [dbo].[HocKy_LopSinhVien]
(
    [idHocKy_LopSinhVien] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [maHocKy] CHAR(7) NOT NULL CHECK (maHocKy LIKE 'K20[0-9][0-9]-[1-3]'), -- [K][YYYY]-[N]: K2021-1, K2022-2, K2122-3
    [maLopSinhVien] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[LopSinhVien]([maLopSinhVien]),
    [startDate] DATE NOT NULL,
    [endDate] DATE NOT NULL,
    CONSTRAINT [CK_HocKy_Ngay] CHECK ([startDate] < [endDate]),
    INDEX [UK_HocKy_LopSinhVien_maHocKy_maLopSinhVien] UNIQUE ([maHocKy] ASC, [maLopSinhVien] ASC) 
)

CREATE TABLE [dbo].[NguoiDung]
(
    [idNguoiDung] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [hoTen] NVARCHAR(63) NOT NULL CHECK (hoTen NOT LIKE '[^a-zA-ZÀ-ÿ ]'),
    [ngaySinh] DATE NOT NULL CHECK (DATEDIFF(YEAR, ngaySinh, GETDATE()) >= 17), 
    [gioiTinh] TINYINT NOT NULL CHECK (gioiTinh IN (0, 1, 9)), -- 0: Nam, 1: Nữ, 9 : Không ghi nhận
    [diaChi] NVARCHAR(127) NOT NULL CHECK (diaChi NOT LIKE '%[^a-zA-ZÀ-ÿ0-9., _()/-//./?/;//]%' ESCAPE '/')
)

CREATE TABLE [dbo].[TaiKhoan]
(
    [idTaiKhoan] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() PRIMARY KEY NONCLUSTERED,
    [tenDangNhap] VARCHAR(30) NOT NULL CHECK (tenDangNhap NOT LIKE '%[^a-zA-Z0-9]%' AND LEN(tenDangNhap) >= 6) INDEX [AK_TaiKhoan_tenDangNhap] UNIQUE,
    [matKhau] CHAR(60) NOT NULL,
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_LastUpdateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] DATETIME NULL,
    [_IsInactive] BIT NOT NULL DEFAULT 0,
    INDEX [CI_TaiKhoan_idTaiKhoan] CLUSTERED ([_DeleteAt] ASC, [_IsInactive] ASC, [idTaiKhoan] ASC)
)

CREATE TABLE [dbo].[GiangVien]
(
    [maGiangVien] VARCHAR(15) NOT NULL PRIMARY KEY,
    [idNguoiDung] INT NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[NguoiDung]([idNguoiDung]), -- ON DELETE CASCADE, -- need using trigger INSTEAD OF DELETE to check constraint
    [idTaiKhoan] UNIQUEIDENTIFIER NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[TaiKhoan]([idTaiKhoan]) ON DELETE CASCADE ON UPDATE CASCADE,
    [emailGiangVien] VARCHAR(255) NOT NULL UNIQUE CHECK (emailGiangVien LIKE '%@%.%' AND emailGiangVien NOT LIKE '[^a-zA-Z0-9.@]'),
	[sdt] CHAR(10) NOT NULL UNIQUE CHECK (SDT LIKE '0%' AND SDT NOT LIKE '[^0-9]'),
    -- [phoneGlobal] CHAR(15) NOT NULL UNIQUE, -- CHECK (phoneGlobal LIKE '+[0-9]{1,3}-[0-9]{9,11}')
    [maChucDanh_NgheNghiep] VARCHAR(15) NOT NULL
)

CREATE TABLE [dbo].[SinhVien]
(
    [maSinhVien] VARCHAR(15) NOT NULL PRIMARY KEY,
    [idNguoiDung] INT NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[NguoiDung]([idNguoiDung]), -- ON DELETE CASCADE, -- need using trigger INSTEAD OF DELETE to check constraint
    [idTaiKhoan] UNIQUEIDENTIFIER NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[TaiKhoan]([idTaiKhoan]) ON DELETE CASCADE ON UPDATE CASCADE,
    [maLopSinhVien] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[LopSinhVien]([maLopSinhVien]),
    [emailSinhVien] VARCHAR(255) NOT NULL CHECK (emailSinhVien LIKE '%@%.%' AND emailSinhVien NOT LIKE '[^a-zA-Z0-9.@]') INDEX [AK_SinhVien_email] UNIQUE,
	[sdt] CHAR(10) NOT NULL CHECK (SDT LIKE '0%' AND SDT NOT LIKE '[^0-9]') INDEX [AK_SinhVien_sdt] UNIQUE,
    -- [phoneGlobal] CHAR(15) NOT NULL UNIQUE, -- CHECK (phoneGlobal LIKE '+[0-9]{1,3}-[0-9]{9,11}')
    [maChucVu_LopSinhVien] CHAR(2) NOT NULL CHECK (maChucVu_LopSinhVien IN ('LT', 'LP', 'TV')) -- LT: Lớp trưởng, LP: Lớp phó, TV: Thành viên
)

CREATE TABLE [dbo].[QuanLy]
(
    [maQuanLy] VARCHAR(15) NOT NULL PRIMARY KEY,
    [idNguoiDung] INT NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[NguoiDung]([idNguoiDung]) ON DELETE CASCADE, -- need using trigger INSTEAD OF DELETE to check constraint
    [idTaiKhoan] UNIQUEIDENTIFIER NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[TaiKhoan]([idTaiKhoan]) ON DELETE CASCADE ON UPDATE CASCADE,
    [emailQuanLy] VARCHAR(255) NOT NULL UNIQUE CHECK (emailQuanLy LIKE '%@%.%' AND emailQuanLy NOT LIKE '[^a-zA-Z0-9.@]'),
	[sdt] CHAR(10) NOT NULL UNIQUE CHECK (SDT LIKE '0%' AND SDT NOT LIKE '[^0-9]'),
    [maChucDanh_NgheNghiep] VARCHAR(15) NOT NULL
)

CREATE TABLE [dbo].[NhomHocPhan]
(
    [idNhomHocPhan] INT IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
    [maMonHoc] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[MonHoc]([maMonHoc]),
    [idHocKy_LopSinhVien] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[HocKy_LopSinhVien]([idHocKy_LopSinhVien]),
    [maQuanLyKhoiTao] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[QuanLy]([maQuanLy]),
    [nhom] TINYINT NOT NULL CHECK (nhom > 0 AND nhom < 100),
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_LastUpdateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] DATETIME NULL,
    -- CONSTRAINT [UQ_NhomHocPhan_maMonHoc_idHocKy_LopSinhVien_Nhom] UNIQUE ([maMonHoc], [idHocKy_LopSinhVien], [nhom]) -- Need using trigger INSTEAD OF INSERT, UPDATE to check duplicate
    INDEX [CI_NhomHocPhan_idNhomHocPhan] ([_DeleteAt] ASC, [idNhomHocPhan] ASC),
    INDEX [IX_NhomHocPhan_maMonHoc_idHocKy_LopSinhVien_nhom] ([maMonHoc] ASC, [idHocKy_LopSinhVien] ASC, [nhom] ASC)
)

CREATE TABLE [dbo].[NhomToHocPhan]
(
    [idNhomToHocPhan] INT IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
    [idNhomHocPhan] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[NhomHocPhan]([idNhomHocPhan]),
    [maGiangVienGiangDay] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[GiangVien]([maGiangVien]),
    [nhomTo] TINYINT NOT NULL DEFAULT 0 CHECK (nhomTo < 100 OR nhomTo = 255), -- 0: Thuộc nhóm, 1: Phân tổ 1, 2: Phân tổ 2, ...
    [startDate] DATE NOT NULL,
    [endDate] DATE NOT NULL,
    [mucDich] CHAR(2) NOT NULL CHECK (mucDich IN ('LT', 'TH', 'U')), -- LT: Lý thuyết, TH: Thực hành, U: Unknown
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_LastUpdateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] DATETIME NULL,
    -- CONSTRAINT [UQ_NhomToHocPhan_idNhomHocPhan_nhomTo] UNIQUE ([idNhomHocPhan], [nhomTo]) -- Need using trigger INSTEAD OF INSERT, UPDATE to check duplicate
    CONSTRAINT [CK_NhomToHocPhan_Timeframe] CHECK ([startDate] < [endDate]),
    INDEX [CI_NhomToHocPhan_idNhomToHocPhan] CLUSTERED ([_DeleteAt] ASC, [idNhomToHocPhan] ASC),
    INDEX [IX_NhomToHocPhan_Timeframe] ([startDate] ASC, [endDate] ASC)
)

CREATE TABLE [dbo].[LichMuonPhong]
(
    [idLichMuonPhong] INT IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
    [idNhomToHocPhan] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[NhomToHocPhan]([idNhomToHocPhan]),
    [idPhongHoc] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[PhongHoc]([idPhongHoc]),
    [maQuanLyKhoiTao] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[QuanLy]([maQuanLy]),
    [startDateTime] DATETIME NOT NULL,
    [endDateTime] DATETIME NOT NULL,
    [mucDich] CHAR(1) NOT NULL CHECK (mucDich IN ('C', 'E', 'F', 'O')), -- C: Course, E: Exam, F: Final exam, O: Other
    -- [currentStatus] CHAR(1) NOT NULL CHECK (currentStatus IN ('O', 'P', 'C', 'R')), -- O: Open, P: Pending, C: Close, R: Reject
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_LastUpdateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [_DeleteAt] DATETIME NULL,
    CONSTRAINT [CK_LichMuonPhong_ThoiGian] CHECK ([startDateTime] < [endDateTime]),
    INDEX [CI_LichMuonPhong_idLichMuonPhong] CLUSTERED ([_DeleteAt] ASC, [idLichMuonPhong] ASC),
    INDEX [IX_LichMuonPhong_Timeframe] ([startDateTime] ASC, [endDateTime] ASC)
)

CREATE TABLE [dbo].[MuonPhongHoc] -- NOT EXISTS: Chưa mượn phòng học, EXISTS: Đang hoặc đã mượn phòng học
(
    [idLichMuonPhong] INT NOT NULL PRIMARY KEY NONCLUSTERED FOREIGN KEY REFERENCES [dbo].[LichMuonPhong]([idLichMuonPhong]),
    [idNguoiMuonPhong] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[NguoiDung]([idNguoiDung]),
    [maQuanLyDuyet] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[QuanLy]([maQuanLy]),
    [idVaiTro_NguoiMuonPhong] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[VaiTro]([idVaiTro]), -- add trigger AFTER INSERT, UPDATE to check constraint WHERE maVaiTro = 'S' OR maVaiTro = 'L'
    [yeuCau] NVARCHAR(127) NULL,
    -- [status] CHAR(1) NOT NULL CHECK (status IN ('S', 'V', 'X')), -- S: Stable, V: Violate, X: Violate seriously
    [_TransferAt] DATETIME NOT NULL DEFAULT GETDATE(), -- Thời gian mượn
    [_ReturnAt] DATETIME NULL CHECK (_ReturnAt < GETDATE()), -- Thời gian trả
    CONSTRAINT [CK_MuonPhongHoc_Timeframe] CHECK ([_TransferAt] < [_ReturnAt]),
    INDEX [CI_MuonPhongHoc_idLichMuonPhong] CLUSTERED ([_ReturnAt] ASC, [idLichMuonPhong] ASC),
    INDEX [IX_MuonPhongHoc__TransferAt] ([_TransferAt] ASC)
)

CREATE TABLE [dbo].[NhomVaiTro_TaiKhoan]
(
    [idTaiKhoan] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[TaiKhoan]([idTaiKhoan]) ON DELETE CASCADE ON UPDATE CASCADE,
    [idVaiTro] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[VaiTro]([idVaiTro]),
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY ([idTaiKhoan], [idVaiTro])
)

CREATE TABLE [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] -- Danh sách người mượn phòng học của nhóm học phần chỉ áp dụng cho nhóm tổ học phần có mục đích là học lý thuyết
(
    [idNhomHocPhan] INT NOT NULL FOREIGN KEY REFERENCES [dbo].[NhomHocPhan]([idNhomHocPhan]) ON DELETE CASCADE,
    [maSinhVien] VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES [dbo].[SinhVien]([maSinhVien]) ON DELETE CASCADE,
    [_CreateAt] DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY ([idNhomHocPhan], [maSinhVien])
)
