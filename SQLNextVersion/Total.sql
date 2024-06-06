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

GO

---- Ràng buộc nhóm tổ phù hợp với mục đích sử dụng (Deprecated)
-- Ghi đè thứ tự nhóm tổ khi thêm mới nhóm tổ học phần
CREATE TRIGGER [dbo].[OverrideOnAttributesWhenInserted_NhomToHocPhan]
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
                idNhomToHocPhan,
                idNhomHocPhan,
                maGiangVienGiangDay,
                nhomTo,
                mucDich,
                startDate,
                endDate,
                _CreateAt,
                _LastUpdateAt
            )
            SELECT
                idNhomToHocPhan,
                idNhomHocPhan,
                maGiangVienGiangDay,
                0,
                mucDich,
                startDate,
                endDate,
                _CreateAt,
                _LastUpdateAt
            FROM inserted
            RETURN
        END

        INSERT INTO [dbo].[NhomToHocPhan] (
            idNhomToHocPhan,
            idNhomHocPhan,
            maGiangVienGiangDay,
            nhomTo,
            mucDich,
            startDate,
            endDate,
            _CreateAt,
            _LastUpdateAt
        )
        SELECT
            idNhomToHocPhan,
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
            endDate,
            _CreateAt,
            _LastUpdateAt
        FROM inserted
    END
GO

-- Ràng buộc duy nhất nhóm học phần với học kỳ, lớp sinh viên, môn học, nhóm thông qua _DeleteAt (Deprecated)
-- Ghi đè thứ tự nhóm khi thêm mới nhóm học phần
CREATE TRIGGER [dbo].[OverrideOnAttributesWhenInserted_NhomHocPhan]
ON [dbo].[NhomHocPhan]
INSTEAD OF INSERT
AS
    BEGIN
        SET NOCOUNT ON

        INSERT INTO [dbo].[NhomHocPhan] (
            idNhomHocPhan,
            idHocKy_LopSinhVien,
            maMonHoc,
            maQuanLyKhoiTao,
            nhom,
            _CreateAt,
            _LastUpdateAt
        )
        SELECT
            idNhomHocPhan,
            idHocKy_LopSinhVien,
            maMonHoc,
            maQuanLyKhoiTao,
            (
                SELECT COUNT(*) + 1
                FROM [dbo].[NhomHocPhan] AS NHP
                WHERE NHP.idHocKy_LopSinhVien = inserted.idHocKy_LopSinhVien
                    AND NHP.maMonHoc = inserted.maMonHoc
                    AND NHP._DeleteAt IS NULL
            ),
            _CreateAt,
            _LastUpdateAt
        FROM inserted
    END
GO

-- Cập nhật lặp qua tất cả nhóm tổ học phần có cùng nhóm tổ, ghi đè lại thứ tự nhóm tổ
CREATE TRIGGER [dbo].[OverrideOnAttributesWhenDeleted_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
AFTER UPDATE, DELETE
AS
    BEGIN TRY
        SET NOCOUNT ON

        IF EXISTS( -- Nếu nhóm tổ học phần không thay đổi mục đích và trạng thái xóa
            SELECT 1
            FROM deleted
            INNER JOIN inserted ON deleted.idNhomToHocPhan = inserted.idNhomToHocPhan
            WHERE (inserted.mucDich <> 'TH'
                AND deleted.mucDich <> 'TH')
                OR (inserted._DeleteAt IS NULL
                AND deleted._DeleteAt IS NULL)
        ) 
        BEGIN -- Kết thúc trigger
            RETURN
        END

        -- every trigger using cur with other name

        DECLARE cur CURSOR FOR
        SELECT NTHP.idNhomToHocPhan
        FROM [dbo].[NhomToHocPhan] AS NTHP
        INNER JOIN deleted d ON d.idNhomHocPhan = NTHP.idNhomHocPhan
        WHERE NTHP._DeleteAt IS NULL
            AND NTHP.mucDich = 'TH'
        ORDER BY [idNhomToHocPhan]

        DECLARE @count INT = 1
        DECLARE @idNhomToHocPhan INT

        OPEN cur
        FETCH NEXT FROM cur INTO @idNhomToHocPhan
        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE [dbo].[NhomToHocPhan]
            SET nhomTo = @count
            WHERE idNhomToHocPhan = @idNhomToHocPhan

            SET @count = @count + 1

            FETCH NEXT FROM cur INTO @idNhomToHocPhan
        END

        CLOSE cur
        DEALLOCATE cur
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @NhomToHocPhan INT = (SELECT TOP 1 CAST(idNhomToHocPhan AS INT) FROM deleted)
        RAISERROR('Error when update or delete NhomToHocPhan. idNhomToHocPhan = %d. 
                    Error message: %s ', 16, 1, @NhomToHocPhan, @ErrorMessage)
    END CATCH
GO

-- Cập nhật lặp qua tất cả nhóm học phần có cùng nhóm, ghi đè lại thứ tự nhóm
CREATE TRIGGER [dbo].[OverrideOnAttributesWhenDeleted_NhomHocPhan]
ON [dbo].[NhomHocPhan]
AFTER UPDATE, DELETE
AS
    BEGIN TRY
        SET NOCOUNT ON

        IF EXISTS(
            SELECT 1
            FROM deleted
            INNER JOIN inserted ON deleted.idNhomHocPhan = inserted.idNhomHocPhan
            WHERE (inserted._DeleteAt IS NULL
                AND deleted._DeleteAt IS NULL)
        )
        BEGIN
            RETURN
        END

        IF EXISTS ( -- Nếu nhóm học phần không thay đổi nhóm và trạng thái xóa
            SELECT 1
            FROM deleted d
            INNER JOIN [dbo].[NhomHocPhan] AS NHP ON d.idNhomHocPhan = NHP.idNhomHocPhan
            WHERE d._DeleteAt = NHP._DeleteAt
        )
        BEGIN
            RETURN
        END

        DECLARE cur CURSOR FOR
        SELECT NHP.idNhomHocPhan
        FROM [dbo].[NhomHocPhan] AS NHP
        INNER JOIN deleted d ON d.idHocKy_LopSinhVien = NHP.idHocKy_LopSinhVien
            AND d.maMonHoc = NHP.maMonHoc
        WHERE NHP._DeleteAt IS NULL
        ORDER BY [idNhomHocPhan]

        DECLARE @count INT = 1
        DECLARE @idNhomHocPhan INT

        OPEN cur
        FETCH NEXT FROM cur INTO @idNhomHocPhan
        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE [dbo].[NhomHocPhan]
            SET nhom = @count
            WHERE idNhomHocPhan = @idNhomHocPhan

            SET @count = @count + 1

            FETCH NEXT FROM cur INTO @idNhomHocPhan
        END

        CLOSE cur
        DEALLOCATE cur
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        RAISERROR('Error when update or delete NhomHocPhan. idNhomHocPhan = %d. Error message: %s
            ', 16, 1, @IdNhomHocPhan, @ErrorMessage)
    END CATCH
GO

-- Ràng buộc vai trò của tài khoản, vai trò từng đối tượng
CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_QuanLy]
ON [dbo].[QuanLy]
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
            WHERE VT.[maVaiTro] = 'MV' OR VT.[maVaiTro] = 'MD' OR VT.[maVaiTro] = 'MM' OR VT.[maVaiTro] = 'MB' OR VT.[maVaiTro] = 'A'
        )
        BEGIN
            DECLARE @maQuanLy1 VARCHAR(50) = (SELECT TOP 1 CAST(i.[maQuanLy] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''MV'' or maVaiTro <> ''MD'' or maVaiTro <> ''MM'' or maVaiTro <> ''MB'' or maVaiTro <> ''A''. First maQuanLy = %s', 16, 1, @maQuanLy1)
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
            DECLARE @maQuanLy2 VARCHAR(50) = (SELECT TOP 1 CAST(i.[maQuanLy] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''U''. First maQuanLy = %s', 16, 1, @maQuanLy2)
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
            DECLARE @maGiangVien1 VARCHAR(50) = (SELECT TOP 1 CAST(i.[maGiangVien] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''L''. First maGiangVien = %s', 16, 1, @maGiangVien1)
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
            DECLARE @maGiangVien2 VARCHAR(50) = (SELECT TOP 1 CAST(i.[maGiangVien] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''U''. First maGiangVien = %s', 16, 1, @maGiangVien2)
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
            DECLARE @maSinhVien1 VARCHAR(50) = (SELECT TOP 1 [maSinhVien] FROM inserted i)
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''S''. First maSinhVien = %s', 16, 1, @maSinhVien1)
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
            DECLARE @maSinhVien2 VARCHAR(50) = (SELECT TOP 1 [maSinhVien] FROM inserted i)
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''U''. First maSinhVien = %s', 16, 1, @maSinhVien2)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc vai trò người mượn phòng khi mượn phòng học
CREATE TRIGGER [dbo].[CheckReferenceToVaiTro_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF NOT EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[VaiTro] VT ON i.[idVaiTro_NguoiMuonPhong] = VT.[idVaiTro]
            WHERE VT.[maVaiTro] = 'S' OR VT.[maVaiTro] = 'L'
        )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('MuonPhongHoc cannot reference to VaiTro with maVaiTro <> ''S'' or maVaiTro <> ''L'', idLichMuonPhong: %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc thời gian mượn phòng học trong khoảng thời gian của lịch mượn phòng
-- Ràng buộc mượn phòng học với phòng học phải ở trạng thái sẵn sàng
-- Ràng buộc mượn phòng học với Người mượn phòng phải là sinh viên trong danh sách Sinh viên mà học phần sử dụng hoặc là Giảng viên
-- Ràng buộc kiểm tra người dùng có đang mượn phòng học không
-- Ràng buộc cảnh báo giảng viên không thuộc nhóm tổ học phần của lịch mượn phòng
CREATE TRIGGER [dbo].[CheckOnAttributes_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS ( -- Nếu thời gian bắt đầu mượn phòng không nằm trong khoảng thời gian của lịch mượn phòng
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
            WHERE i._TransferAt < DATEADD(MINUTE, -30, LMP.startDateTime) -- 30 phút trước thời gian bắt đầu
                OR i._TransferAt > LMP.endDateTime -- hoặc sau thời gian kết thúc
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong1 VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: MuonPhongHoc._TransferAt must be between LichMuonPhong.startDateTime - 30 minutes and LichMuonPhong.endDateTime. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong1)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF NOT EXISTS ( -- Nếu không phải là phòng học có trạng thái sẵn sàng
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
            INNER JOIN [dbo].[PhongHoc] AS PH ON LMP.idPhongHoc = PH.idPhongHoc
            WHERE PH._Status = 'A'
                AND PH._ActiveAt = (
                    SELECT MAX(PH2._ActiveAt)
                    FROM [dbo].[PhongHoc] AS PH2
                    WHERE PH2.idPhongHoc = PH.idPhongHoc
                )
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong2 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: PhongHoc._Status must be ''A''. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong2)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF EXISTS ( -- Nếu người dùng đang mượn phòng học khác
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[MuonPhongHoc] AS MPH ON i.idNguoiMuonPhong = MPH.idNguoiMuonPhong
            WHERE i.idLichMuonPhong <> MPH.idLichMuonPhong 
                AND MPH._ReturnAt IS NULL
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong3 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('Cannot insert or update: NguoiDung is currently borrowing a room. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong3)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF NOT EXISTS ( -- Nếu mã vai trò cập nhật không phải là sinh viên hoặc là giảng viên
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[VaiTro] AS VT ON i.idVaiTro_NguoiMuonPhong = VT.idVaiTro
            WHERE VT.maVaiTro = 'S' OR VT.maVaiTro = 'L'
        ) OR NOT EXISTS ( -- Hoặc người mượn phòng không thuộc trong danh sách sinh viên mà học phần sử dụng (cũng đồng nghĩa không phải Sinh viên)
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiDung] AS ND ON i.idNguoiMuonPhong = ND.idNguoiDung
            INNER JOIN [dbo].[SinhVien] AS SV ON ND.idNguoiDung = SV.idNguoiDung
            INNER JOIN [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] AS DSSV_NHP_LT ON SV.maSinhVien = DSSV_NHP_LT.maSinhVien
            INNER JOIN [dbo].[NhomHocPhan] AS NHP ON DSSV_NHP_LT.idNhomHocPhan = NHP.idNhomHocPhan
            INNER JOIN [dbo].[NhomToHocPhan] AS NTHP ON NHP.idNhomHocPhan = NTHP.idNhomHocPhan
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
        ) AND NOT EXISTS ( -- Và người mượn phòng không phải là giảng viên
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiDung] AS ND ON i.idNguoiMuonPhong = ND.idNguoiDung
            INNER JOIN [dbo].[GiangVien] AS GV ON ND.idNguoiDung = GV.idNguoiDung
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong4 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: MuonPhongHoc.idNguoiMuonPhong must be the role SinhVien in DsSinhVien_NhomHocPhan_LyThuyet or role GiangVien. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong4)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF EXISTS ( -- Nếu lịch mượn phòng đã trả
            SELECT 1
            FROM inserted AS i
            WHERE i._ReturnAt IS NOT NULL
        )
        BEGIN 
            RETURN
        END

        IF NOT EXISTS ( -- Nếu là giảng viên không giảng dạy học phần mà lịch mượn phòng đang sử dụng cho học phần
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiDung] AS ND ON i.idNguoiMuonPhong = ND.idNguoiDung
            INNER JOIN [dbo].[GiangVien] AS GV ON ND.idNguoiDung = GV.idNguoiDung
            INNER JOIN [dbo].[NhomToHocPhan] AS NTHP ON GV.maGiangVien = NTHP.maGiangVienGiangDay
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
        )
        BEGIN -- Thông báo lỗi nhưng không rollback
            DECLARE @idLichMuonPhong5 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Can insert or update MuonPhongHoc but GiangVien is not in NhomToHocPhan of LichMuonPhong. idLichMuonPhong = %s', 10, 1, @idLichMuonPhong5)
        END
    END
GO

-- Ràng buộc cảnh báo thời gian lịch mượn phòng trong khoảng thời gian học của nhóm tổ học phần
-- Ràng buộc cảnh báo thời gian lịch mượn phòng không nên trùng với lịch mượn phòng khác trong cùng một nhóm tổ học phần
CREATE TRIGGER [dbo].[CheckOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF NOT EXISTS ( -- Nếu phòng học không bị xóa
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[PhongHoc] AS PH ON i.idPhongHoc = PH.idPhongHoc
            WHERE PH._Status = 'A'
                AND PH._ActiveAt = (
                    SELECT MAX(PH2._ActiveAt)
                    FROM [dbo].[PhongHoc] AS PH2
                    WHERE PH2.idPhongHoc = PH.idPhongHoc
                )
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: PhongHoc._ActiveAt must be the latest available. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF EXISTS ( -- Nếu lịch mượn phòng bị xóa
            SELECT 1
            FROM inserted AS i
            WHERE i._DeleteAt IS NOT NULL
        )
        BEGIN 
            RETURN
        END

        IF EXISTS ( -- Nếu thời gian bắt đầu, kết thúc của lịch mượn phòng không nằm trong khoảng thời gian của nhóm tổ học phần
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON i.idNhomToHocPhan = nthp.idNhomToHocPhan
            WHERE i.startDateTime < nthp.startDate OR i.endDateTime > nthp.endDate
        )
        BEGIN -- Thông báo lỗi nhưng không rollback
            DECLARE @idLichMuonPhong3 VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Can insert or update LichMuonPhong but LichMuonPhong.startDateTime and LichMuonPhong.endDateTime should be within NhomToHocPhan.startDate and NhomToHocPhan.endDate. idLichMuonPhong = %s', 10, 1, @idLichMuonPhong3)
        END

        IF EXISTS ( -- Nếu thời gian bắt đầu, kết thúc và phòng học của lịch mượn phòng trùng với lịch mượn phòng khác trong cùng một nhóm tổ học phần
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idPhongHoc = LMP.idPhongHoc
            WHERE i.idLichMuonPhong <> LMP.idLichMuonPhong
                AND (i.startDateTime < LMP.endDateTime AND i.startDateTime > LMP.startDateTime
                    OR i.endDateTime < LMP.endDateTime AND i.endDateTime > LMP.startDateTime)
        )
        BEGIN -- Thông báo cảnh báo
            DECLARE @idLichMuonPhong4 VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            DECLARE @idPhongHoc VARCHAR(50) = (SELECT TOP 1 CAST(i.[idPhongHoc] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('Warning!: LichMuonPhong.startDateTime and LichMuonPhong.endDateTime should not overlap with another LichMuonPhong in the same PhongHoc. First idLichMuonPhong = %s and idPhongHoc = %s', 10, 1, @idLichMuonPhong4, @idPhongHoc)
        END
    END
GO

-- Ràng buộc thời gian nhóm tổ học phần trong khoảng thời gian của học kỳ
CREATE TRIGGER [dbo].[CheckOnAttributes_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS ( -- Nếu thời gian nhóm tổ học phần không nằm trong khoảng thời gian của học kỳ
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomHocPhan] AS NHP ON i.idNhomHocPhan = NHP.idNhomHocPhan
            INNER JOIN [dbo].[HocKy_LopSinhVien] AS HKLSV ON NHP.idHocKy_LopSinhVien = HKLSV.idHocKy_LopSinhVien
            WHERE i.startDate < HKLSV.startDate OR i.endDate > HKLSV.endDate
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idNhomToHocPhan VARCHAR(50) = (SELECT CAST(i.[idNhomToHocPhan] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: NhomToHocPhan.startDate and NhomToHocPhan.endDate must be within HocKy.startDate and HocKy.endDate. idNhomToHocPhan = %s', 16, 1, @idNhomToHocPhan)
            ROLLBACK TRANSACTION
            RETURN
        END
    END
GO

-- Ràng buộc kiểm tra môn học có khả dụng không
CREATE TRIGGER [dbo].[CheckOnAttributes_NhomHocPhan]
ON [dbo].[NhomHocPhan]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF NOT EXISTS ( -- Nếu môn học không bị xóa
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[MonHoc] AS MH ON i.maMonHoc = MH.maMonHoc
            WHERE MH._Status = 'A'
                AND MH._ActiveAt = (
                    SELECT MAX(MH2._ActiveAt)
                    FROM [dbo].[MonHoc] AS MH2
                    WHERE MH2.maMonHoc = MH.maMonHoc
                )
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idNhomHocPhan VARCHAR(50) = (SELECT CAST(i.[idNhomHocPhan] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: MonHoc._DeleteAt must be null. idNhomHocPhan = %s', 16, 1, @idNhomHocPhan)
            ROLLBACK TRANSACTION
            RETURN
        END
    END
GO

-- Ràng buộc cấm xóa mượn phòng học khi chưa trả phòng
CREATE TRIGGER [dbo].[BlockDelete_MuonPhongHoc]
ON [dbo].[MuonPhongHoc]
AFTER DELETE
AS
	BEGIN
        SET NOCOUNT ON

        IF EXISTS ( 
                SELECT 1
        FROM deleted i
        WHERE _ReturnAt IS NULL
            )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM deleted i)
            RAISERROR('Cannot delete: MuonPhongHoc._ReturnAt must be not null. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc cấm xóa lịch mượn phòng khi chưa trả phòng
CREATE TRIGGER [dbo].[BlockDeleteFromMuonPhongHoc_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER DELETE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS ( 
            SELECT 1
            FROM deleted i
            INNER JOIN [dbo].[MuonPhongHoc] AS MPH ON i.idLichMuonPhong = MPH.idLichMuonPhong
            WHERE MPH._ReturnAt IS NOT NULL
            )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM deleted i)
            RAISERROR('Cannot delete LichMuonPhong when _ReturnAt of MuonPhongHoc is not null. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc cảnh báo xóa nhóm học phần khi học kỳ đang diễn ra
CREATE TRIGGER [dbo].[WarningDelete_NhomHocPhan]
ON [dbo].[NhomHocPhan]
AFTER DELETE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS (
            SELECT 1
            FROM deleted AS d
            INNER JOIN [dbo].[HocKy_LopSinhVien] AS HKLSV ON d.idHocKy_LopSinhVien = HKLSV.idHocKy_LopSinhVien
            WHERE HKLSV.startDate <= GETDATE() AND HKLSV.endDate >= GETDATE()
        )
        BEGIN
            DECLARE @idNhomHocPhan VARCHAR(50) = (SELECT TOP 1 CAST(d.[idNhomHocPhan] AS VARCHAR(50)) FROM deleted d)
            RAISERROR('Warning!: Delete NhomHocPhan when HocKy_LopSinhVien is in progress leads to inconsistency! 
            It still could be deleted, please restore it if necessary. idNhomHocPhan = %s', 10, 1, @idNhomHocPhan)
        END
    END
GO

---- Ràng buộc phòng học khả dụng với trạng thái là khả dụng thông qua _ActiveAt, update databaseGO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributes]
    @TableName VARCHAR(128),
    @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF
    @TriggerActionOn CHAR(3) = 'U' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY

        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @InsertedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra tham số đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger

        -- Đặt tên cho trigger
        SET @HeadName = 'OverrideOnAttributes_'
        SET @TailName = ''
        IF @TriggerType = 'I' SET @TailName = '_UsingInsteadOf'

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableName + '.' + ColumnName + ' = ' + OverrideValue
        FROM #TableSetup t
        WHERE TableName = @TableName

        -- Thiết lập điều kiện join
        SELECT @InsertedJoinOn = COALESCE(@InsertedJoinOn + ' AND
                ', '') + @TableName + '.' + COLUMN_NAME + ' = i.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @InsertedJoinOn IS NULL RAISERROR ('@InsertedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableName + ']
            INNER JOIN inserted i 
                ON ' + @InsertedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables]
    @TableName VARCHAR(128),
    @TableRefName VARCHAR(128),
    @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF
    @TriggerActionOn CHAR(3) = 'IUD' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @TableRefJoinOn VARCHAR(MAX)
        DECLARE @InsertedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
                AND TableRefName = @TableRefName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' or table ' + @TableRefName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END
        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableRefName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableRefName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'OverrideOnAttributesAtOtherTables_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableRefName + '.' + ColumnRefName + ' = ' + OverrideValue
        FROM #TableSetup
        WHERE TableName = @TableName
            AND TableRefName = @TableRefName

        -- Thiết lập điều kiện join
        SELECT @TableRefJoinOn = COALESCE(@TableRefJoinOn + ' AND
                ', '
                ') + 
            CASE 
                WHEN p.TABLE_NAME = @TableName THEN @TableRefName + '.' + f.COLUMN_NAME + ' = ' + @TableName + '.' + p.COLUMN_NAME
                ELSE @TableRefName + '.' + p.COLUMN_NAME + ' = ' + @TableName + '.' + f.COLUMN_NAME
            END
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE p
        INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS c ON c.UNIQUE_CONSTRAINT_NAME = p.CONSTRAINT_NAME
        INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE f ON c.CONSTRAINT_NAME = f.CONSTRAINT_NAME
        WHERE (p.TABLE_NAME = @TableName AND f.TABLE_NAME = @TableRefName)
            OR (p.TABLE_NAME = @TableRefName AND f.TABLE_NAME = @TableName)

        SELECT @InsertedJoinOn = COALESCE(@InsertedJoinOn + ' AND
                ', '
                ') + @TableName + '.' + COLUMN_NAME + ' = i.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @TableRefJoinOn IS NULL RAISERROR ('@TableRefJoinOn is NULL', 16, 1)
        IF @InsertedJoinOn IS NULL RAISERROR ('@InsertedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableRefName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableRefName + ']
            INNER JOIN ' + @TableName + ' ON ' + @TableRefJoinOn + '
            INNER JOIN inserted i ON ' + @InsertedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_BlockOnAttributes]
    @TableName VARCHAR(128),
    @HeadName VARCHAR(128) = 'BlockOnAttributes_',
    @TailName VARCHAR(128) = '',
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    @TriggerActionOn CHAR(3) = 'I' -- I: INSERT, U: UPDATE, D: DELETE
AS
    BEGIN TRY
        DECLARE @TriggerType CHAR(1) = 'A'
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger

        -- Thiết lập hành động của trigger
        IF CHARINDEX('I', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'INSERT'
        IF CHARINDEX('U', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'UPDATE'
        IF CHARINDEX('D', @TriggerActionOn) > 0 SET @ActionCommand = COALESCE(@ActionCommand + ', ', '') + 'DELETE'
        IF CHARINDEX('A', @TriggerType) > 0 SET @ActionCommand = 'AFTER ' + @ActionCommand
        ELSE IF CHARINDEX('I', @TriggerType) > 0 SET @ActionCommand = 'INSTEAD OF ' + @ActionCommand

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + 'inserted.' + ColumnName + ' IS NOT NULL'
        FROM #TableSetup
        WHERE TableName = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            IF EXISTS (
                SELECT 1
                FROM inserted
                WHERE ' + @Columns + '
            )
            BEGIN
                RAISERROR(''Can not insert data because _DeletedAt is not null'', 16, 1)
            END
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDelete]
    @TableName VARCHAR(128)
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    -- @TriggerActionOn CHAR(3) = 'D' -- I: INSERT, U: UPDATE, D: DELETE -- Not used
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @DeletedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'PretendDelete_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        SET @ActionCommand = 'INSTEAD OF DELETE'

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableName + '._DeleteAt = GETDATE()'
        FROM #TableSetup
        WHERE TableName = @TableName

        -- Thiết lập điều kiện join
        SELECT @DeletedJoinOn = COALESCE(@DeletedJoinOn + ' AND
                ', '') + @TableName + '.' + COLUMN_NAME + ' = d.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @DeletedJoinOn IS NULL RAISERROR ('@DeletedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
        ON [dbo].[' + @TableName + ']
        ' + @ActionCommand + '
        AS
        BEGIN
            SET NOCOUNT ON

            UPDATE ' + @TableName + '
            SET ' + @Columns + '
            FROM [dbo].[' + @TableName + ']
            INNER JOIN deleted d 
                ON ' + @DeletedJoinOn + '
        END'

        EXEC (@SQL)

        PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables]
    @TableName VARCHAR(128),
    @TableRefedName VARCHAR(128)
    -- @TriggerType CHAR(1) = 'A', -- A: AFTER, I: INSTEAD OF -- Not used
    -- @TriggerActionOn CHAR(3) = 'D' -- I: INSERT, U: UPDATE, D: DELETE -- Not used
AS
    BEGIN TRY
        DECLARE @HeadName VARCHAR(MAX)
        DECLARE @TailName VARCHAR(MAX)
        DECLARE @ActionCommand VARCHAR(MAX)
        DECLARE @Columns VARCHAR(MAX)
        DECLARE @TableRefJoinOn VARCHAR(MAX)
        DECLARE @DeletedJoinOn VARCHAR(MAX)
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @SQL_REPLACEMENT NVARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        -- MARK: Kiểm tra dữ liệu đầu vào
        IF OBJECT_ID('tempdb..#TableSetup') IS NULL
        BEGIN
            RAISERROR('Table template #TableSetup is not existed', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
            FROM #TableSetup
            WHERE TableName = @TableName
                AND TableRefedName = @TableRefedName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' or table ' + @TableRefedName + ' is not included in the template #TableSetup'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END
        IF NOT EXISTS (
            SELECT 1
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @TableRefedName
        )
        BEGIN
            SET @ERROR_MESSAGE = 'Trigger can not be created because table ' + @TableRefedName + ' is not existed'
            RAISERROR (@ERROR_MESSAGE, 16, 1)
        END

        -- MARK: Thiết lập dữ liệu cho trigger
        -- Đặt tên cho trigger
        SET @HeadName = 'PretendDeleteAtOtherTables_'
        SET @TailName = ''

        -- Thiết lập hành động của trigger
        SET @ActionCommand = 'INSTEAD OF DELETE'

        -- Thiết lập cột cần cập nhật
        SELECT @Columns = COALESCE(@Columns + ',
            ', '') + @TableRefedName + '._DeleteAt = GETDATE()'
        FROM #TableSetup
        WHERE TableName = @TableName
            AND TableRefedName = @TableRefedName

        -- Thiết lập điều kiện join
        SELECT @TableRefJoinOn = COALESCE(@TableRefJoinOn + ' AND ', '') + 
            CASE 
                WHEN p.TABLE_NAME = @TableName THEN @TableRefedName + '.' + f.COLUMN_NAME + ' = ' + @TableName + '.' + p.COLUMN_NAME
                ELSE @TableRefedName + '.' + p.COLUMN_NAME + ' = ' + @TableName + '.' + f.COLUMN_NAME
            END
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE p
        INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS c ON c.UNIQUE_CONSTRAINT_NAME = p.CONSTRAINT_NAME
        INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE f ON c.CONSTRAINT_NAME = f.CONSTRAINT_NAME
        WHERE (p.TABLE_NAME = @TableName AND f.TABLE_NAME = @TableRefedName)
            OR (p.TABLE_NAME = @TableRefedName AND f.TABLE_NAME = @TableName)

        SELECT @DeletedJoinOn = COALESCE(@DeletedJoinOn + ' AND ', '') + @TableName + '.' + COLUMN_NAME + ' = d.' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
            AND TABLE_NAME = @TableName

        -- MARK: Kiểm tra dữ liệu trước khi tạo trigger
        IF @HeadName IS NULL RAISERROR ('@HeadName is NULL', 16, 1)
        IF @TailName IS NULL RAISERROR ('@TailName is NULL', 16, 1)
        IF @ActionCommand IS NULL RAISERROR ('@ActionCommand is NULL', 16, 1)
        IF @Columns IS NULL RAISERROR ('@Columns is NULL', 16, 1)
        IF @TableRefJoinOn IS NULL RAISERROR ('@TableRefJoinOn is NULL', 16, 1)
        IF @DeletedJoinOn IS NULL RAISERROR ('@DeletedJoinOn is NULL', 16, 1)

        -- MARK: Tạo trigger
        
        SELECT @SQL_REPLACEMENT = OBJECT_DEFINITION(OBJECT_ID('PretendDelete_' + @TableName))
        IF @SQL_REPLACEMENT IS NOT NULL
        BEGIN
            SET @SQL_REPLACEMENT = REPLACE(@SQL_REPLACEMENT, 'CREATE', 'ALTER')
            SET @SQL_REPLACEMENT = REPLACE(@SQL_REPLACEMENT, 'SET NOCOUNT ON',
            'SET NOCOUNT ON

            DELETE FROM ' + @TableRefedName + '
            FROM [dbo].[' + @TableRefedName + ']
            INNER JOIN ' + @TableName + '
                ON ' + @TableRefJoinOn + '
            INNER JOIN deleted d 
                ON ' + @DeletedJoinOn)

            EXEC (@SQL_REPLACEMENT)

            PRINT 'Trigger PretendDelete_' + @TableName + ' has been updated from content ' + @HeadName + @TableName + @TailName
        END
        ELSE
        BEGIN
            SET @SQL = 'CREATE TRIGGER [dbo].[' + @HeadName + @TableName + @TailName + ']
            ON [dbo].[' + @TableName + ']
            ' + @ActionCommand + '
            AS
            BEGIN
                SET NOCOUNT ON

                UPDATE ' + @TableRefedName + '
                SET ' + @Columns + '
                FROM [dbo].[' + @TableRefedName + ']
                INNER JOIN ' + @TableName + '
                    ON ' + @TableRefJoinOn + '
                INNER JOIN deleted d 
                    ON ' + @DeletedJoinOn + '
            END'

            EXEC (@SQL)

            PRINT 'Trigger ' + @HeadName + @TableName + @TailName + ' has been created'
        END

        
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when creating trigger: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[DropIfExists]
    @selectType VARCHAR(2), -- NULL if not specified object type
    @tableName VARCHAR(128),
    @headName VARCHAR(128),
    @tailName VARCHAR(128) = '',
    @schemaName VARCHAR(128) = 'dbo'
AS
    BEGIN TRY
        DECLARE @DescribeAction VARCHAR(MAX)
        DECLARE @ActionDone VARCHAR(MAX)
        DECLARE @ObjectName VARCHAR(MAX) = @headName + @tableName + @tailName
        DECLARE @ObjectType VARCHAR(MAX) = 'Object '
        DECLARE @SQL VARCHAR(MAX)
        DECLARE @ERROR_MESSAGE NVARCHAR(4000)

        SET NOCOUNT ON

        CREATE TABLE #ObjectDrop (objectName VARCHAR(128), objectType VARCHAR(128))
        INSERT INTO #ObjectDrop (objectName, objectType)
        SELECT name, type
        FROM sys.objects
        WHERE SCHEMA_NAME(schema_id) = @schemaName
            AND name = @ObjectName

        SET NOCOUNT OFF

        IF @selectType IS NOT NULL
        BEGIN
            SET @ObjectType = 
                CASE @selectType
                    WHEN 'P' THEN 'Procedure '
                    WHEN 'V' THEN 'View '
                    WHEN 'U' THEN 'Table '
                    WHEN 'FN' THEN 'Function '
                    WHEN 'IF' THEN 'Function '
                    WHEN 'TF' THEN 'Function '
                    WHEN 'TR' THEN 'Trigger '
                    WHEN 'C' THEN 'Constraint '
                    WHEN 'S' THEN 'Sequence '
                    WHEN 'K' THEN 'Key '
                    WHEN 'I' THEN 'Index '
                    WHEN 'D' THEN 'Default '
                    WHEN 'X' THEN 'XML Schema Collection '
                    WHEN 'UQ' THEN 'Unique Constraint '
                    WHEN 'PK' THEN 'Primary Key Constraint '
                    WHEN 'F' THEN 'Foreign Key Constraint '
                    ELSE NULL
                END
            IF @ObjectType IS NULL 
                RAISERROR('@selectType is not valid', 16, 1)
        END

        IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('P')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'P'
        )
        BEGIN
            SET @SQL = 'DROP PROCEDURE '
            SET @ObjectType = 'Procedure '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('V')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'V'
        )
        BEGIN
            SET @SQL = 'DROP VIEW '
            SET @ObjectType = 'View '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('U')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'U'
        )
        BEGIN
            SET @SQL = 'DROP TABLE '
            SET @ObjectType = 'Table '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('FN', 'IF', 'TF')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'FN' OR @selectType = 'IF' OR @selectType = 'TF'
        )
        BEGIN
            SET @SQL = 'DROP FUNCTION '
            SET @ObjectType = 'Function '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('TR')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'TR'
        )
        BEGIN
            SET @SQL = 'DROP TRIGGER '
            SET @ObjectType = 'Trigger '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('C')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'C'
        )
        BEGIN
            SET @SQL = 'DROP CONSTRAINT '
            SET @ObjectType = 'Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('S')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'S'
        )
        BEGIN
            SET @SQL = 'DROP SEQUENCE '
            SET @ObjectType = 'Sequence '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('K')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'K'
        )
        BEGIN
            SET @SQL = 'DROP KEY '
            SET @ObjectType = 'Key '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('I')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'I'
        )
        BEGIN
            SET @SQL = 'DROP INDEX '
            SET @ObjectType = 'Index '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('D')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'D'
        )
        BEGIN
            SET @SQL = 'DROP DEFAULT '
            SET @ObjectType = 'Default '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('X')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'X'
        )
        BEGIN
            SET @SQL = 'DROP XML SCHEMA COLLECTION '
            SET @ObjectType = 'XML Schema Collection '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('UQ')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'UQ'
        )
        BEGIN
            SET @SQL = 'DROP UNIQUE CONSTRAINT '
            SET @ObjectType = 'Unique Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('PK')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'PK'
        )
        BEGIN
            SET @SQL = 'DROP PRIMARY KEY CONSTRAINT '
            SET @ObjectType = 'Primary Key Constraint '
        END
        ELSE IF EXISTS (
            SELECT 1
            FROM #ObjectDrop
            WHERE objectType IN ('F')
                AND objectName = @ObjectName
                AND @selectType IS NULL OR @selectType = 'F'
        )
        BEGIN
            SET @SQL = 'DROP FOREIGN KEY CONSTRAINT '
            SET @ObjectType = 'Foreign Key Constraint '
        END

        DROP TABLE #ObjectDrop

        SET @DescribeAction = ' has been '
        SET @ActionDone = 'dropped'

        SET @SQL = @SQL + @schemaName + '.' + @ObjectName

        EXEC(@SQL)
    END TRY
    BEGIN CATCH
        SET @ERROR_MESSAGE = ERROR_MESSAGE()
        RAISERROR('Error when dropping object: %s', 16, 1, @ERROR_MESSAGE)
    END CATCH
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128), OverrideValue VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME, 'GETDATE()'
        FROM INFORMATION_SCHEMA.COLUMNS TABLE_NAME
        WHERE COLUMN_NAME = '_LastUpdateAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'OverrideOnAttributes_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_OverrideOnAttributes] @TableName, 'A', 'U'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), TableRefName VARCHAR(128), ColumnRefName VARCHAR(128), OverrideValue VARCHAR(128))
        INSERT INTO #TableSetup (TableName, TableRefName, ColumnRefName, OverrideValue) VALUES
            ('GiangVien', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('SinhVien', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('QuanLy', 'TaiKhoan', '_LastUpdateAt', 'GETDATE()'),
            ('NhomToHocPhan', 'NhomHocPhan', '_LastUpdateAt', 'GETDATE()'),
            ('MuonPhongHoc', 'LichMuonPhong', '_LastUpdateAt', 'GETDATE()')

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName, TableRefName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @TableRefName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'OverrideOnAttributesAtOtherTables_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables] @TableName, @TableRefName, 'A' ,'IUD'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE COLUMN_NAME = '_DeleteAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableNameInput VARCHAR(128)
        DECLARE @HeadNameInput VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableNameInput
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadNameInput = 'PrevertInsertOnAttributes_'
            EXEC [dbo].[DropIfExists] 'TR', @TableNameInput, @HeadNameInput
            EXEC [dbo].[GENERATE_TRIGGER_BlockOnAttributes] 
                @TableName = @TableNameInput, 
                @HeadName = @HeadNameInput, 
                @TriggerActionOn = 'I'
            FETCH NEXT FROM CURSOR_TABLE INTO @TableNameInput
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDelete]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), ColumnName VARCHAR(128))
        INSERT INTO #TableSetup
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE COLUMN_NAME = '_DeleteAt'

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'PretendDelete_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_PretendDelete] @TableName
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

CREATE PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
AS
    BEGIN
        CREATE TABLE #TableSetup (TableName VARCHAR(128), TableRefedName VARCHAR(128))
        INSERT INTO #TableSetup (TableName, TableRefedName) VALUES
            ('NhomHocPhan', 'NhomToHocPhan'),
            ('NhomToHocPhan', 'LichMuonPhong')

        DECLARE CURSOR_TABLE CURSOR FOR
        SELECT TableName, TableRefedName FROM #TableSetup

        OPEN CURSOR_TABLE
        DECLARE @TableName VARCHAR(128)
        DECLARE @TableRefedName VARCHAR(128)
        DECLARE @HeadName VARCHAR(128)
        FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefedName
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @HeadName = 'PretendDeleteAtOtherTables_'
            EXEC [dbo].[DropIfExists] 'TR', @TableName, @HeadName
            EXEC [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables] @TableName, @TableRefedName
            FETCH NEXT FROM CURSOR_TABLE INTO @TableName, @TableRefedName
        END
        CLOSE CURSOR_TABLE
        DEALLOCATE CURSOR_TABLE

        DROP TABLE #TableSetup
    END
GO

EXEC [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
EXEC [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
EXEC [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
EXEC [dbo].[GeneratePackage_Trigger_PretendDelete]
EXEC [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributes]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_OverrideOnAttributesAtOtherTables]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_BlockOnAttributes]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDelete]
DROP PROCEDURE [dbo].[GeneratePackage_Trigger_PretendDeleteAt_OtherTables]
DROP PROCEDURE [dbo].[DropIfExists]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributes]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_OverrideOnAttributesAt_OtherTables]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_BlockOnAttributes]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDelete]
DROP PROCEDURE [dbo].[GENERATE_TRIGGER_PretendDeleteAt_OtherTables]
GO
USE [QLMuonPhongHoc]
GO
SET NOCOUNT ON
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (1, N'U', N'User', N'Người dùng')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (2, N'MB', N'ManagerBorrowRoom', N'Quản lý mượn phòng')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (3, N'A', N'Admin', N'Quản trị viên')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (4, N'MM', N'ManagerManagement', N'Quản lý ứng dụng')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (5, N'MDB', N'ManagerDevelopmentBorrowRoom', N'Quản lý phát triển - Mượn phòng học')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (6, N'L', N'Lecturer', N'Giảng viên')
INSERT [dbo].[VaiTro] ([idVaiTro], [maVaiTro], [tenVaiTro], [moTaVaiTro]) VALUES (7, N'S', N'Student', N'Sinh viên')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (1, N'Lưu Văn Thành', CAST(N'1992-08-08' AS Date), 1, N'671-141 Đường Trịnh Hoài Đức, Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (2, N'Nguyễn Hữu Vinh', CAST(N'1990-04-09' AS Date), 1, N'Ký túc xá Cỏ May trường Đại học Nông Lâm, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (3, N'Thái Văn Anh Chính', CAST(N'2003-12-20' AS Date), 1, N'Ký túc xá Học viện Công Nghệ Bưu Chính Viễn Thông, 97 Đ. Man Thiện, Hiệp Phú, Thủ Đức, Thành phố Hồ Chí Minh 70000, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (4, N'Ngô Cao Hy', CAST(N'1991-10-15' AS Date), 1, N'Hẻm 2/45, Phường Tân Phú, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (5, N'Hà Văn Cao', CAST(N'1899-08-07' AS Date), 1, N'75/6 Đường 18, Phường Linh Trung, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (6, N'Nguyễn Thị Bích Nguyên', CAST(N'1990-07-07' AS Date), 1, N'16-52 Đ. Đoàn Như Hài, Phường 12, Quận 4, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (7, N'Giang Lâm', CAST(N'1998-06-05' AS Date), 1, N'59/31 Đ. Trần Phú, Phường 4, Quận 5, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (8, N'Lưu Nguyễn Kỳ thư', CAST(N'1990-09-07' AS Date), 0, N'24-6 An Nhơn, Phường 17, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (9, N'Cao Văn Hà', CAST(N'1990-09-09' AS Date), 1, N'Hẻm 27 Nguyễn Thượng Hiền, Phường 5, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (10, N'Đức Hoàng', CAST(N'1997-07-05' AS Date), 1, N'Hẻm 40, Trường Thọ, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (11, N'Trần Công Hùng', CAST(N'2003-03-03' AS Date), 0, N'Hẻm 93 Vạn Kiếp, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (12, N'Phan Thanh Hy', CAST(N'1990-09-06' AS Date), 0, N'43-41 Võ Trường Toản, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (13, N'Huỳnh Trung Trụ', CAST(N'1997-09-02' AS Date), 0, N'An Bình, Dĩ An, Binh Duong, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (14, N'Lê Tư Phương', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (15, N'Lê Phạm Công Toàn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (16, N'Tô Gia Bảo', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (17, N'Phạm Minh Quang', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (18, N'Nguyễn Anh Tuấn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (19, N'Nguyễn Khánh Ý', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (20, N'Trịnh Khánh Quân', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (21, N'Trần Kim An', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (22, N'Bùi Vũ Tuấn Anh', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (23, N'Nguyễn Quang Anh', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (24, N'Nguyễn Duy Bảo', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (25, N'Phạm Phú Bảo', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (26, N'Võ Gia Bảo', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (27, N'Nguyễn Văn Chiến', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (29, N'Phạm Đỗ Nguyên Chương', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (30, N'Nguyễn Ngọc Đạt', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (31, N'Triệu Quốc Đạt', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (32, N'Nguyễn Văn Dũng', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (33, N'Lê Văn Dũng', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (34, N'Phạm Quốc Dương', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (35, N'Nguyễn Đức Duy', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (36, N'Nguyễn Trường Giang', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (37, N'Bùi Quang Hiệp', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (38, N'Đào Phan Quốc Hoài', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (39, N'Nguyễn Đức Khải Hoàn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (40, N'Nguyễn Minh Hoàng', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (41, N'Hà Gia Huy', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (43, N'Võ Anh Kiệt', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (44, N'Nguyễn Quang Linh', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (45, N'Lương Thành Lợi', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (46, N'Bùi Văn Minh', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (47, N'Lê Trung Nguyên', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (48, N'Trần Bình Phương Nhã', CAST(N'2003-03-03' AS Date), 1, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (49, N'Dư Trọng Nhân', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (50, N'Hoàng Ngọc Ninh', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (51, N'Nguyễn Ngọc Quý', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (52, N'Nguyễn Bá Sang', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (54, N'Dương Hoàng Thiện', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (55, N'Lê Minh Thông', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (56, N'Phan Văn Tiến', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (57, N'Trần Đình Toàn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (58, N'Nguyễn Thành Trung', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (59, N'Phạm Thanh Trường', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (60, N'Nguyễn Anh Tuấn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (62, N'Nguyễn Văn Vũ', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (63, N'Huỳnh Như Ý', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (64, N'Nguyễn Lê Hoài Bắc', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (65, N'Vũ Quốc Bảo', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (66, N'Lương Đạt Thiện', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (67, N'Vũ Đức Trọng', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (68, N'Phan Quang Trung', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (69, N'Lê Văn Tuấn', CAST(N'2003-03-03' AS Date), 0, N'Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (70, N'Nguyễn Tâm Trân', CAST(N'2000-08-08' AS Date), 0, N'15 Trương Văn Hải, Tăng Nhơn Phú B, Quận 9, Thành phố Hồ Chí Minh, Vietnam')
INSERT [dbo].[NguoiDung] ([idNguoiDung], [hoTen], [ngaySinh], [gioiTinh], [diaChi]) VALUES (71, N'Nguyễn Minh Thư', CAST(N'2000-07-09' AS Date), 0, N'42 Đường 5, Linh Chiểu, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam')
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'7c157b1b-56ef-49f9-a911-022ed128359e', N'N21DCCN057', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.023' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', N'N21DCCN178', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.033' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'dae51e7b-4159-44ca-bc24-0bae945603cf', N'N21DCCN087', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'4459b4b4-7cac-45aa-b67a-0d39a2241934', N'GVN20238', N'123                                                         ', CAST(N'2024-04-30T15:52:03.847' AS DateTime), CAST(N'2024-05-25T10:16:29.233' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', N'N21DCCN002', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', N'N21DCCN070', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.027' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'f3c4c098-c7f2-48ea-963a-27741b8da530', N'N21DCCN050', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', N'QL793761', N'1234                                                        ', CAST(N'2024-04-09T21:41:37.697' AS DateTime), CAST(N'2024-05-25T10:16:29.140' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', N'N21DCCN022', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.017' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', N'N21DCCN040', N'123                                                         ', CAST(N'2024-04-09T21:40:25.173' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'a2c883ea-0be4-4472-b1de-35689acf4b45', N'N21DCCN023', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.017' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'b0a3b390-0805-40ca-b702-37622e05e34f', N'N18DCAT074', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.003' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', N'N19DCCN016', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.003' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', N'N19DCCN232', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.007' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'31d07ffa-3a82-4892-8806-4311ba702711', N'N21DCCN102', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.033' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'54695652-a894-4d53-80b6-43378ab19378', N'N21DCCN033', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'b40c1d88-d187-4a2a-86d5-445fe7c02304', N'N21DCCN011', N'123                                                         ', CAST(N'2024-04-30T15:46:53.983' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', N'N21DCCN008', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'4f1e43bd-2189-4924-a378-4630cda5d1cd', N'N21DCCN047', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'108800e8-1be0-4a62-be15-48dc89eacfad', N'N19DCCN178', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.007' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'28ceff2f-260a-40f9-8284-542f4045d1bc', N'N19DCCN151', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.003' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'31a22554-28e5-4c7e-8e76-5638a1932061', N'N18DCAT060', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.003' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', N'GV0211047', N'$2y$10$4MAeFQO6giTZiQDwC.kLTeJPgkNEQTW9jLf1wwhWEDkhb2.p5BuAy', CAST(N'2024-04-10T07:29:36.183' AS DateTime), CAST(N'2024-05-25T10:16:29.233' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', N'N21DCCN020', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'65d509ee-934e-419c-bd1f-65d7df3349fc', N'QL196832', N'1234                                                        ', CAST(N'2024-04-09T21:42:16.800' AS DateTime), CAST(N'2024-05-25T10:16:29.140' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', N'GV0211040', N'$2y$10$maYuhvBh2IP.g9MCcvq0FOexUoF6s6W5eJII6e3ucK1KKuQxUOP7K', CAST(N'2024-04-10T07:29:50.487' AS DateTime), CAST(N'2024-05-25T10:16:29.233' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'196a8844-2540-44c5-a8f0-6c7b8deb2013', N'N21DCCN021', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'a62a2c62-ef50-4c39-a987-6cfde9149c68', N'N21DCCN090', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'2a54a348-8922-4612-85cd-6f31228b9577', N'N21DCCN003', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'f253339a-6d9e-470d-9e75-6f517b29f415', N'N21DCCN038', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'2712dd24-a140-4655-9249-722a4717920d', N'N21DCCN010', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', N'N21DCCN013', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', N'N21DCCN095', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', N'GV0211039', N'123                                                         ', CAST(N'2024-04-10T07:29:24.840' AS DateTime), CAST(N'2024-05-25T10:16:29.233' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'02c4a53e-5b04-47c2-aa77-78f48439f140', N'N21DCCN006', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'af032f73-3409-4951-925c-836131b11faa', N'N21DCCN190', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.033' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'629371e6-e4f3-45e7-a7e5-8427705c91d2', N'GVN20193', N'123                                                         ', CAST(N'2024-04-30T15:52:17.087' AS DateTime), CAST(N'2024-05-25T10:16:29.230' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'c3d957e6-f97d-475f-bc68-86cc71f95b12', N'TG368059', N'$2y$10$xqfNgcMUnUtp59L6MvpRsu5EutPNdNJrFHR/ZGRyGN3d616hY58hq', CAST(N'2024-04-30T15:54:05.647' AS DateTime), CAST(N'2024-05-25T10:16:29.237' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', N'N21DCCN026', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.017' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'78020f69-876b-4a2f-8b91-913c5bea2ba5', N'N21DCCN086', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', N'N21DCCN081', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.027' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'b24aa366-9b00-435b-8399-96d71caa2737', N'N21DCCN005', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', N'N21DCCN193', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.037' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', N'N21DCCN079', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.027' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1eeed331-604e-4755-8740-9f7c401e21e2', N'N21DCCN012', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', N'N21DCCN045', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'83de2683-d635-4b82-b007-a17cf9c9440b', N'QL054723', N'1234                                                        ', CAST(N'2024-04-09T21:42:04.833' AS DateTime), CAST(N'2024-05-25T10:16:29.140' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'85ddf715-c4cb-47c3-9123-a61a803fcb43', N'TG256530', N'123                                                         ', CAST(N'2024-04-30T15:54:40.973' AS DateTime), CAST(N'2024-05-25T10:16:29.237' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'c61e8766-c1af-4390-a513-a8431eac84d5', N'N21DCCN034', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'afd61e61-79a1-4e65-9de5-accc7f255d7b', N'N21DCCN084', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'127e0703-46ed-402f-86b8-b7be12084441', N'N21DCCN060', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.023' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', N'N21DCCN077', N'123                                                         ', CAST(N'2024-04-09T21:40:56.270' AS DateTime), CAST(N'2024-05-25T10:16:29.027' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', N'N21DCCN059', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.023' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', N'GVN20173', N'123                                                         ', CAST(N'2024-04-30T15:51:45.540' AS DateTime), CAST(N'2024-05-25T10:16:29.230' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', N'N21DCCN030', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.017' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'30820deb-f796-425d-a33f-d61fdc69b7fa', N'N21DCCN103', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.033' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'09a00370-b03b-437d-91dc-d71491791c6e', N'GVN20288', N'123                                                         ', CAST(N'2024-04-30T15:52:31.110' AS DateTime), CAST(N'2024-05-25T10:16:29.233' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', N'N21DCCN016', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.013' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', N'N21DCCN052', N'123                                                         ', CAST(N'2024-05-01T13:08:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.023' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'62cad6fa-3626-4295-8a83-de01e38310aa', N'N20DCCN057', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', N'N21DCCN088', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', N'N21DCCN062', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.023' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'dd3986a3-4284-429a-a9af-e6b1046a49f8', N'N21DCCN007', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.010' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'338946eb-51d8-4201-a53f-ea4380f1593c', N'N21DCCN071', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.027' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', N'N21DCCN032', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.020' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', N'N21DCCN096', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', N'QL684374', N'1234                                                        ', CAST(N'2024-04-09T21:41:53.823' AS DateTime), CAST(N'2024-05-25T10:16:29.140' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'f4298638-9e03-4920-bb5b-ed8739164534', N'N21DCCN192', N'123                                                         ', CAST(N'2024-05-01T13:22:00.000' AS DateTime), CAST(N'2024-05-25T10:16:29.037' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'1cf67def-6367-4b80-a066-ef57ce83996b', N'GVN20226', N'123                                                         ', CAST(N'2024-04-10T07:28:48.910' AS DateTime), CAST(N'2024-05-25T10:16:29.230' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', N'N21DCCN094', N'123                                                         ', CAST(N'2024-04-09T21:41:09.473' AS DateTime), CAST(N'2024-05-25T10:16:29.030' AS DateTime), NULL, 0)
INSERT [dbo].[TaiKhoan] ([idTaiKhoan], [tenDangNhap], [matKhau], [_CreateAt], [_LastUpdateAt], [_DeleteAt], [_IsInactive]) VALUES (N'757c4419-14c1-49ef-821c-ff0bb63b8b60', N'GVN20191', N'123                                                         ', CAST(N'2024-04-10T07:28:26.127' AS DateTime), CAST(N'2024-05-25T10:16:29.230' AS DateTime), NULL, 0)
GO
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'7c157b1b-56ef-49f9-a911-022ed128359e', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'7c157b1b-56ef-49f9-a911-022ed128359e', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'dae51e7b-4159-44ca-bc24-0bae945603cf', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'dae51e7b-4159-44ca-bc24-0bae945603cf', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4459b4b4-7cac-45aa-b67a-0d39a2241934', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4459b4b4-7cac-45aa-b67a-0d39a2241934', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f3c4c098-c7f2-48ea-963a-27741b8da530', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f3c4c098-c7f2-48ea-963a-27741b8da530', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', 2, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a2c883ea-0be4-4472-b1de-35689acf4b45', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a2c883ea-0be4-4472-b1de-35689acf4b45', 7, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b0a3b390-0805-40ca-b702-37622e05e34f', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b0a3b390-0805-40ca-b702-37622e05e34f', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', 1, CAST(N'2024-05-18T13:14:52.370' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'31d07ffa-3a82-4892-8806-4311ba702711', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'31d07ffa-3a82-4892-8806-4311ba702711', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'54695652-a894-4d53-80b6-43378ab19378', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'54695652-a894-4d53-80b6-43378ab19378', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b40c1d88-d187-4a2a-86d5-445fe7c02304', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b40c1d88-d187-4a2a-86d5-445fe7c02304', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4f1e43bd-2189-4924-a378-4630cda5d1cd', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4f1e43bd-2189-4924-a378-4630cda5d1cd', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'108800e8-1be0-4a62-be15-48dc89eacfad', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'108800e8-1be0-4a62-be15-48dc89eacfad', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'28ceff2f-260a-40f9-8284-542f4045d1bc', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'28ceff2f-260a-40f9-8284-542f4045d1bc', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'31a22554-28e5-4c7e-8e76-5638a1932061', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'31a22554-28e5-4c7e-8e76-5638a1932061', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'65d509ee-934e-419c-bd1f-65d7df3349fc', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'65d509ee-934e-419c-bd1f-65d7df3349fc', 2, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'196a8844-2540-44c5-a8f0-6c7b8deb2013', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'196a8844-2540-44c5-a8f0-6c7b8deb2013', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a62a2c62-ef50-4c39-a987-6cfde9149c68', 1, CAST(N'2024-05-18T13:14:52.373' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a62a2c62-ef50-4c39-a987-6cfde9149c68', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2a54a348-8922-4612-85cd-6f31228b9577', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2a54a348-8922-4612-85cd-6f31228b9577', 7, CAST(N'2024-05-18T13:14:52.387' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f253339a-6d9e-470d-9e75-6f517b29f415', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f253339a-6d9e-470d-9e75-6f517b29f415', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2712dd24-a140-4655-9249-722a4717920d', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'2712dd24-a140-4655-9249-722a4717920d', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'02c4a53e-5b04-47c2-aa77-78f48439f140', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'02c4a53e-5b04-47c2-aa77-78f48439f140', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'af032f73-3409-4951-925c-836131b11faa', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'af032f73-3409-4951-925c-836131b11faa', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'629371e6-e4f3-45e7-a7e5-8427705c91d2', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'629371e6-e4f3-45e7-a7e5-8427705c91d2', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c3d957e6-f97d-475f-bc68-86cc71f95b12', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c3d957e6-f97d-475f-bc68-86cc71f95b12', 6, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'78020f69-876b-4a2f-8b91-913c5bea2ba5', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'78020f69-876b-4a2f-8b91-913c5bea2ba5', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b24aa366-9b00-435b-8399-96d71caa2737', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'b24aa366-9b00-435b-8399-96d71caa2737', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', 1, CAST(N'2024-05-18T13:14:52.377' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1eeed331-604e-4755-8740-9f7c401e21e2', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1eeed331-604e-4755-8740-9f7c401e21e2', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'83de2683-d635-4b82-b007-a17cf9c9440b', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'83de2683-d635-4b82-b007-a17cf9c9440b', 2, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'85ddf715-c4cb-47c3-9123-a61a803fcb43', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'85ddf715-c4cb-47c3-9123-a61a803fcb43', 6, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c61e8766-c1af-4390-a513-a8431eac84d5', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c61e8766-c1af-4390-a513-a8431eac84d5', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'afd61e61-79a1-4e65-9de5-accc7f255d7b', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'afd61e61-79a1-4e65-9de5-accc7f255d7b', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
GO
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'127e0703-46ed-402f-86b8-b7be12084441', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'127e0703-46ed-402f-86b8-b7be12084441', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', 6, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'30820deb-f796-425d-a33f-d61fdc69b7fa', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'30820deb-f796-425d-a33f-d61fdc69b7fa', 7, CAST(N'2024-05-18T13:14:52.390' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'09a00370-b03b-437d-91dc-d71491791c6e', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'09a00370-b03b-437d-91dc-d71491791c6e', 6, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'62cad6fa-3626-4295-8a83-de01e38310aa', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'62cad6fa-3626-4295-8a83-de01e38310aa', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'dd3986a3-4284-429a-a9af-e6b1046a49f8', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'dd3986a3-4284-429a-a9af-e6b1046a49f8', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'338946eb-51d8-4201-a53f-ea4380f1593c', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'338946eb-51d8-4201-a53f-ea4380f1593c', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', 1, CAST(N'2024-05-18T13:14:52.380' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', 1, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', 2, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f4298638-9e03-4920-bb5b-ed8739164534', 1, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'f4298638-9e03-4920-bb5b-ed8739164534', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1cf67def-6367-4b80-a066-ef57ce83996b', 1, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'1cf67def-6367-4b80-a066-ef57ce83996b', 6, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 1, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 7, CAST(N'2024-05-18T13:14:52.393' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 1, CAST(N'2024-05-18T13:14:52.383' AS DateTime))
INSERT [dbo].[NhomVaiTro_TaiKhoan] ([idTaiKhoan], [idVaiTro], [_CreateAt]) VALUES (N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 6, CAST(N'2024-05-18T13:14:52.397' AS DateTime))
GO
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20173', 5, N'e1635225-d5c2-40c2-bf1c-ca9bdd0c994c', N'havancao@ptithcm.edu.vn', N'0346707226', N'V.07.01.01')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20191', 6, N'757c4419-14c1-49ef-821c-ff0bb63b8b60', N'bichnguyen@ptithcm.edu.vn', N'0684674664', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20193', 7, N'629371e6-e4f3-45e7-a7e5-8427705c91d2', N'gianglam@ptithcm.edu.vn', N'0337948217', N'V.07.01.03')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20226', 8, N'1cf67def-6367-4b80-a066-ef57ce83996b', N'kythu@ptithcm.edu.vn', N'0939630575', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20238', 9, N'4459b4b4-7cac-45aa-b67a-0d39a2241934', N'caovanha@gmail.comptithcm.edu.vn', N'0929878201', N'V.07.01.01')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV/N-20288', 10, N'09a00370-b03b-437d-91dc-d71491791c6e', N'duchoang@ptithcm.edu.vn', N'0248361949', N'V.07.01.03')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV0211039', 11, N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', N'tranconghung@ptithcm.edu.vn', N'0636402034', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV0211040', 12, N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', N'thanhhy@ptithcm.edu.vn', N'0904858378', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'GV0211047', 13, N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', N'trungtru@ptithcm.edu.vn', N'0987475677', N'V.07.01.02')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'TG256530', 70, N'85ddf715-c4cb-47c3-9123-a61a803fcb43', N'trannguyen@ptithcm.edu.vn', N'0906463849', N'V.07.01.23')
INSERT [dbo].[GiangVien] ([maGiangVien], [idNguoiDung], [idTaiKhoan], [emailGiangVien], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'TG368059', 71, N'c3d957e6-f97d-475f-bc68-86cc71f95b12', N'nguyenthu@ptithcm.edu.vn', N'0792894050', N'V.07.01.23')
GO
INSERT [dbo].[QuanLy] ([maQuanLy], [idNguoiDung], [idTaiKhoan], [emailQuanLy], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'QL054723', 1, N'83de2683-d635-4b82-b007-a17cf9c9440b', N'n21dccn077@student.ptithcm.edu.vn', N'0906968495', N'V.05.02.08')
INSERT [dbo].[QuanLy] ([maQuanLy], [idNguoiDung], [idTaiKhoan], [emailQuanLy], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'QL196832', 2, N'65d509ee-934e-419c-bd1f-65d7df3349fc', N'n21dccn094@student.ptithcm.edu.vn', N'0783849559', N'V.05.02.08')
INSERT [dbo].[QuanLy] ([maQuanLy], [idNguoiDung], [idTaiKhoan], [emailQuanLy], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'QL684374', 3, N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', N'n21dccn011@student.ptithcm.edu.vn', N'0836490622', N'V.05.02.08')
INSERT [dbo].[QuanLy] ([maQuanLy], [idNguoiDung], [idTaiKhoan], [emailQuanLy], [sdt], [maChucDanh_NgheNghiep]) VALUES (N'QL793761', 4, N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', N'n21dccn040@student.ptithcm.edu.vn', N'0794058390', N'V.05.02.08')
GO
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1341', N'Nhập Môn Trí Tuệ nhân tạo', CAST(N'2024-04-09T20:34:38.540' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1319', N'Hệ Điều Hành', CAST(N'2024-04-09T20:36:02.040' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'BAS1153', N'Lịch Sử Đảng Cộng Sản Việt Nam', CAST(N'2024-04-09T20:36:44.300' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1340', N'Nhập Môn Công Nghệ Phần Mềm', CAST(N'2024-04-09T20:37:45.010' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT13147', N'Thực Tập Cở Sở', CAST(N'2024-04-09T20:38:20.850' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1434-3', N'Lập Trình Web', CAST(N'2024-04-09T20:38:50.883' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'BAS1160', N'Tiếng Anh Course 3', CAST(N'2024-04-09T20:45:37.820' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT13162', N'Lập Trình Python', CAST(N'2024-04-09T20:46:13.613' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1313', N'Cơ Sở Dữ Liệu', CAST(N'2024-04-09T20:47:06.750' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1336', N'Mạng Máy Tính', CAST(N'2024-04-09T20:50:07.240' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1332', N'Lập Trình Hướng Đối Tượng', CAST(N'2024-04-09T20:50:45.800' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT1306', N'Cấu Trúc Dữ Liệu và Giải Thuật', CAST(N'2024-04-09T20:52:05.327' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT 1359-3', N'Toán Rời Rạc 2', CAST(N'2024-04-09T20:52:37.833' AS DateTime), N'A')
INSERT [dbo].[MonHoc] ([maMonHoc], [tenMonHoc], [_ActiveAt], [_Status]) VALUES (N'INT13145', N'Kiến Trúc Máy Tính', CAST(N'2024-04-09T20:53:09.613' AS DateTime), N'A')
GO
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D18CQAT02-N', 2018, 2023, 7480201, N'An toàn Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D19CQCNHT01-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D19CQCNPM01-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D19CQCNPM02-N', 2019, 2024, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D20CQCN01-N', 2020, 2025, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D20CQDTDT01-N', 2020, 2025, 7510301, N'Công Nghệ Kỹ Thuật Điện 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D21CQAT01-N', 2021, 2026, 7480202, N'An toàn Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D21CQCN01-N', 2021, 2026, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D21CQCN02-N', 2021, 2026, 7480201, N'Công Nghệ Thông Tin 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D21TXVTMD01-N', 2021, 2026, 7520207, N'Kỹ Thuật Điện Tử Viễn Thông 2', N'TX', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D22CQQT01-N', 2022, 2027, 7340101, N'Quản Trị Kinh Doanh 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D23CQKT01-N', 2023, 2028, 7340301, N'Kế Toán 2', N'CQ', N'DT')
INSERT [dbo].[LopSinhVien] ([maLopSinhVien], [startYear_NienKhoa], [endYear_NienKhoa], [maNganh], [tenKhoa], [maHeDaoTao], [maChatLuongDaoTao]) VALUES (N'D23CQPT02-N', 2023, 2028, 7329001, N'Công Nghệ Đa Phương Tiện 2', N'CQ', N'DT')
GO
SET IDENTITY_INSERT [dbo].[HocKy_LopSinhVien] ON 

INSERT [dbo].[HocKy_LopSinhVien] ([idHocKy_LopSinhVien], [maHocKy], [maLopSinhVien], [startDate], [endDate]) VALUES (2, N'K2024-2', N'D21CQCN01-N', CAST(N'2024-01-10' AS Date), CAST(N'2024-06-21' AS Date))
INSERT [dbo].[HocKy_LopSinhVien] ([idHocKy_LopSinhVien], [maHocKy], [maLopSinhVien], [startDate], [endDate]) VALUES (3, N'K2024-2', N'D20CQCN01-N', CAST(N'2024-01-10' AS Date), CAST(N'2024-06-21' AS Date))
INSERT [dbo].[HocKy_LopSinhVien] ([idHocKy_LopSinhVien], [maHocKy], [maLopSinhVien], [startDate], [endDate]) VALUES (4, N'K2024-2', N'D21CQAT01-N', CAST(N'2024-01-10' AS Date), CAST(N'2024-06-21' AS Date))
INSERT [dbo].[HocKy_LopSinhVien] ([idHocKy_LopSinhVien], [maHocKy], [maLopSinhVien], [startDate], [endDate]) VALUES (5, N'K2024-2', N'D20CQDTDT01-N', CAST(N'2024-01-10' AS Date), CAST(N'2024-06-21' AS Date))
SET IDENTITY_INSERT [dbo].[HocKy_LopSinhVien] OFF
GO
SET IDENTITY_INSERT [dbo].[NhomHocPhan] ON 

INSERT [dbo].[NhomHocPhan] ([idNhomHocPhan], [maMonHoc], [idHocKy_LopSinhVien], [maQuanLyKhoiTao], [nhom], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (1, N'INT13145', 5, N'QL054723', 1, CAST(N'2024-04-10T09:03:08.373' AS DateTime), CAST(N'2024-05-25T10:16:29.317' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([idNhomHocPhan], [maMonHoc], [idHocKy_LopSinhVien], [maQuanLyKhoiTao], [nhom], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (3, N'BAS1160', 2, N'QL684374', 10, CAST(N'2024-04-10T09:04:47.640' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([idNhomHocPhan], [maMonHoc], [idHocKy_LopSinhVien], [maQuanLyKhoiTao], [nhom], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (5, N'INT1306', 4, N'QL793761', 3, CAST(N'2024-04-10T09:06:11.783' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([idNhomHocPhan], [maMonHoc], [idHocKy_LopSinhVien], [maQuanLyKhoiTao], [nhom], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (6, N'INT1340', 3, N'QL196832', 2, CAST(N'2024-04-10T09:07:14.600' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomHocPhan] ([idNhomHocPhan], [maMonHoc], [idHocKy_LopSinhVien], [maQuanLyKhoiTao], [nhom], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (14, N'BAS1160', 2, N'QL684374', 12, CAST(N'2024-05-01T11:56:24.560' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[NhomHocPhan] OFF
GO
SET IDENTITY_INSERT [dbo].[NhomToHocPhan] ON 

INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (1, 3, N'GV/N-20191', 0, CAST(N'2024-01-10' AS Date), CAST(N'2024-06-11' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.467' AS DateTime), CAST(N'2024-05-25T10:16:29.253' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (2, 5, N'GV0211047', 1, CAST(N'2024-01-11' AS Date), CAST(N'2024-04-12' AS Date), N'TH', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.317' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (3, 1, N'GV0211039', 0, CAST(N'2024-01-10' AS Date), CAST(N'2024-04-11' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.317' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (4, 5, N'GV0211047', 0, CAST(N'2024-01-11' AS Date), CAST(N'2024-04-12' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (5, 3, N'TG368059', 0, CAST(N'2024-01-13' AS Date), CAST(N'2024-06-14' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (6, 6, N'GV/N-20226', 0, CAST(N'2024-01-15' AS Date), CAST(N'2024-04-16' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (8, 5, N'GV0211040', 2, CAST(N'2024-02-03' AS Date), CAST(N'2024-03-02' AS Date), N'TH', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (9, 5, N'GV/N-20226', 3, CAST(N'2024-02-15' AS Date), CAST(N'2024-03-07' AS Date), N'TH', CAST(N'2024-05-18T13:14:52.473' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (10, 14, N'GV/N-20193', 0, CAST(N'2024-01-11' AS Date), CAST(N'2024-06-18' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.477' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
INSERT [dbo].[NhomToHocPhan] ([idNhomToHocPhan], [idNhomHocPhan], [maGiangVienGiangDay], [nhomTo], [startDate], [endDate], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (11, 14, N'TG368059', 0, CAST(N'2024-02-04' AS Date), CAST(N'2024-04-19' AS Date), N'LT', CAST(N'2024-05-18T13:14:52.477' AS DateTime), CAST(N'2024-05-25T10:16:29.320' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[NhomToHocPhan] OFF
GO
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 

INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (1, N'2A23', 100, CAST(N'2024-04-09T21:23:28.587' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (3, N'2A26', 100, CAST(N'2024-04-09T21:26:08.447' AS DateTime), N'U')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (4, N'2A27', 100, CAST(N'2024-04-09T21:26:31.210' AS DateTime), N'M')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (5, N'2E0405', 60, CAST(N'2024-04-09T21:28:42.453' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (6, N'2E17', 60, CAST(N'2024-04-09T21:29:04.043' AS DateTime), N'U')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (7, N'2E15', 60, CAST(N'2024-04-09T21:29:22.310' AS DateTime), N'M')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (8, N'2A08', 160, CAST(N'2024-04-09T21:29:56.130' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (9, N'2A16', 160, CAST(N'2024-04-09T21:30:09.420' AS DateTime), N'U')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (10, N'2A35', 60, CAST(N'2024-04-09T21:30:53.510' AS DateTime), N'M')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (11, N'2B24', 100, CAST(N'2024-04-09T21:32:20.880' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (12, N'2B11', 100, CAST(N'2024-04-09T21:32:37.880' AS DateTime), N'U')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (13, N'2B27', 100, CAST(N'2024-04-09T21:32:50.230' AS DateTime), N'M')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (14, N'2A2425', 100, CAST(N'2024-04-09T21:33:48.567' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (15, N'SAN-B1', 200, CAST(N'2024-04-09T21:34:20.560' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (16, N'2D05', 25, CAST(N'2024-04-09T21:36:41.147' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (17, N'2D12', 40, CAST(N'2024-04-09T21:36:43.543' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (18, N'2A27', 100, CAST(N'2024-05-01T12:18:02.763' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (19, N'2E17', 60, CAST(N'2024-05-01T12:18:29.830' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (20, N'2E05', 100, CAST(N'2024-05-01T12:18:46.177' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (21, N'2A16', 160, CAST(N'2024-05-01T12:18:59.170' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (22, N'2B11', 100, CAST(N'2024-05-01T12:19:23.330' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (23, N'2B32', 60, CAST(N'2024-05-01T12:19:45.987' AS DateTime), N'A')
INSERT [dbo].[PhongHoc] ([idPhongHoc], [maPhongHoc], [sucChua], [_ActiveAt], [_Status]) VALUES (24, N'2B31', 100, CAST(N'2024-05-01T12:19:55.530' AS DateTime), N'A')
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LichMuonPhong] ON 

INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (155, 3, 1, N'QL793761', CAST(N'2024-01-04T07:00:08.400' AS DateTime), CAST(N'2024-01-04T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.470' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (156, 6, 5, N'QL196832', CAST(N'2024-04-03T13:00:00.000' AS DateTime), CAST(N'2024-04-03T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:40:51.240' AS DateTime), CAST(N'2024-05-25T10:16:29.470' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (158, 5, 8, N'QL054723', CAST(N'2024-03-06T07:00:00.000' AS DateTime), CAST(N'2024-03-06T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.350' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (159, 4, 11, N'QL684374', CAST(N'2024-04-08T13:00:00.000' AS DateTime), CAST(N'2024-04-08T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:44:15.427' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (160, 2, 22, N'QL684374', CAST(N'2024-04-06T13:00:00.000' AS DateTime), CAST(N'2024-04-06T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:44:15.427' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (161, 1, 20, N'QL684374', CAST(N'2024-05-03T07:00:00.000' AS DateTime), CAST(N'2024-05-03T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:09:28.250' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (163, 1, 20, N'QL684374', CAST(N'2024-05-10T07:00:00.000' AS DateTime), CAST(N'2024-05-10T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:11:26.887' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (164, 1, 20, N'QL684374', CAST(N'2024-05-17T07:00:00.000' AS DateTime), CAST(N'2024-05-17T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:11:56.440' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (165, 1, 20, N'QL684374', CAST(N'2024-05-23T07:00:00.000' AS DateTime), CAST(N'2024-05-23T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:12:16.110' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (166, 5, 19, N'QL684374', CAST(N'2024-05-08T07:00:00.000' AS DateTime), CAST(N'2024-05-08T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:13:26.180' AS DateTime), CAST(N'2024-05-25T10:16:29.353' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (167, 5, 19, N'QL684374', CAST(N'2024-05-15T07:00:00.000' AS DateTime), CAST(N'2024-05-15T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:13:52.810' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (168, 5, 19, N'QL684374', CAST(N'2024-05-22T07:00:00.000' AS DateTime), CAST(N'2024-05-22T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:14:07.427' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (171, 1, 20, N'QL684374', CAST(N'2024-05-30T07:00:00.000' AS DateTime), CAST(N'2024-05-30T10:30:00.000' AS DateTime), N'C', CAST(N'2024-05-01T12:15:02.920' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (174, 2, 8, N'QL054723', CAST(N'2024-03-13T07:00:00.000' AS DateTime), CAST(N'2024-03-13T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (175, 2, 8, N'QL054723', CAST(N'2024-03-13T07:00:00.000' AS DateTime), CAST(N'2024-03-13T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (176, 2, 8, N'QL054723', CAST(N'2024-03-20T07:00:00.000' AS DateTime), CAST(N'2024-03-20T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.357' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (177, 4, 1, N'QL793761', CAST(N'2024-02-12T07:00:00.000' AS DateTime), CAST(N'2024-02-12T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (178, 4, 1, N'QL793761', CAST(N'2024-02-19T07:00:00.000' AS DateTime), CAST(N'2024-02-19T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (179, 4, 1, N'QL793761', CAST(N'2024-02-26T07:00:00.000' AS DateTime), CAST(N'2024-02-26T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (180, 4, 1, N'QL793761', CAST(N'2024-03-04T07:00:00.000' AS DateTime), CAST(N'2024-03-04T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (181, 4, 1, N'QL793761', CAST(N'2024-03-11T07:00:00.000' AS DateTime), CAST(N'2024-03-11T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (183, 4, 1, N'QL793761', CAST(N'2024-03-18T07:00:00.000' AS DateTime), CAST(N'2024-03-18T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (184, 4, 1, N'QL793761', CAST(N'2024-03-25T07:00:00.000' AS DateTime), CAST(N'2024-03-25T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.360' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (185, 4, 1, N'QL793761', CAST(N'2024-04-01T07:00:00.000' AS DateTime), CAST(N'2024-04-01T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (186, 4, 1, N'QL793761', CAST(N'2024-04-08T07:00:00.000' AS DateTime), CAST(N'2024-04-08T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (187, 4, 1, N'QL793761', CAST(N'2024-04-15T07:00:00.000' AS DateTime), CAST(N'2024-04-15T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (188, 8, 8, N'QL054723', CAST(N'2024-03-15T07:00:00.000' AS DateTime), CAST(N'2024-03-15T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (189, 8, 8, N'QL054723', CAST(N'2024-03-22T07:00:00.000' AS DateTime), CAST(N'2024-03-22T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (190, 8, 8, N'QL054723', CAST(N'2024-03-29T07:00:00.000' AS DateTime), CAST(N'2024-03-29T10:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (191, 9, 8, N'QL054723', CAST(N'2024-02-27T13:00:00.000' AS DateTime), CAST(N'2024-02-27T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.363' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (192, 9, 8, N'QL054723', CAST(N'2024-02-05T13:00:00.000' AS DateTime), CAST(N'2024-02-05T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.367' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([idLichMuonPhong], [idNhomToHocPhan], [idPhongHoc], [maQuanLyKhoiTao], [startDateTime], [endDateTime], [mucDich], [_CreateAt], [_LastUpdateAt], [_DeleteAt]) VALUES (193, 9, 8, N'QL054723', CAST(N'2024-02-12T13:00:00.000' AS DateTime), CAST(N'2024-02-12T16:30:00.000' AS DateTime), N'C', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-05-25T10:16:29.367' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LichMuonPhong] OFF
GO


INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N18DCAT060', 14, N'31a22554-28e5-4c7e-8e76-5638a1932061', N'D18CQAT02-N', N'n18dcat060@student.ptithcm.edu.vn', N'0894278273', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N18DCAT074', 15, N'b0a3b390-0805-40ca-b702-37622e05e34f', N'D18CQAT02-N', N'n18dcat074@student.ptithcm.edu.vn', N'0986907092', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N19DCCN016', 16, N'4b4024c5-aba8-4213-a4aa-3e3f0474cc1f', N'D19CQCNPM01-N', N'n19dccn016@student.ptithcm.edu.vn', N'0517859585', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N19DCCN151', 17, N'28ceff2f-260a-40f9-8284-542f4045d1bc', N'D19CQCNPM02-N', N'n19dccn151@student.ptithcm.edu.vn', N'0208454837', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N19DCCN178', 18, N'108800e8-1be0-4a62-be15-48dc89eacfad', N'D19CQCNHT01-N', N'n19dccn178@student.ptithcm.edu.vn', N'0440031417', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N19DCCN232', 19, N'88644fdf-4af9-430f-9ab8-3f6c828c0f16', N'D19CQCNPM02-N', N'n19dccn232@student.ptithcm.edu.vn', N'0611310626', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N20DCCN057', 20, N'62cad6fa-3626-4295-8a83-de01e38310aa', N'D20CQCN01-N', N'n20dccn057@student.ptithcm.edu.vn', N'0468110604', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN002', 21, N'2f6151b4-dd49-4eec-b929-1eaa7fbcd353', N'D21CQCN01-N', N'n21dccn002@student.ptithcm.edu.vn', N'0934901030', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN003', 22, N'2a54a348-8922-4612-85cd-6f31228b9577', N'D21CQCN01-N', N'n21dccn003@student.ptithcm.edu.vn', N'0724717607', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN005', 23, N'b24aa366-9b00-435b-8399-96d71caa2737', N'D21CQCN01-N', N'n21dccn005@student.ptithcm.edu.vn', N'0542718826', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN006', 24, N'02c4a53e-5b04-47c2-aa77-78f48439f140', N'D21CQCN01-N', N'n21dccn006@student.ptithcm.edu.vn', N'0855683586', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN007', 25, N'dd3986a3-4284-429a-a9af-e6b1046a49f8', N'D21CQCN01-N', N'n21dccn007@student.ptithcm.edu.vn', N'0248646485', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN008', 26, N'0f48a41c-4328-4d1b-87f9-45c1d6cb55d7', N'D21CQCN01-N', N'n21dccn008@student.ptithcm.edu.vn', N'0942010291', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN010', 27, N'2712dd24-a140-4655-9249-722a4717920d', N'D21CQCN01-N', N'n21dccn010@student.ptithcm.edu.vn', N'0638618111', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN011', 3, N'b40c1d88-d187-4a2a-86d5-445fe7c02304', N'D21CQCN01-N', N'n21dccn011@student.ptithcm.edu.vn', N'0904863784', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN012', 29, N'1eeed331-604e-4755-8740-9f7c401e21e2', N'D21CQCN01-N', N'n21dccn012@student.ptithcm.edu.vn', N'0208230080', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN013', 30, N'1d7f3396-9d71-42df-927d-72be8b3fcfdf', N'D21CQCN01-N', N'n21dccn013@student.ptithcm.edu.vn', N'0844008699', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN016', 31, N'1f3fd1e7-d587-4750-9b4b-d71b805bbc25', N'D21CQCN01-N', N'n21dccn016@student.ptithcm.edu.vn', N'0844851512', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN020', 32, N'5ed70b90-c397-4c03-85cc-65a3c0509cd4', N'D21CQCN01-N', N'n21dccn020@student.ptithcm.edu.vn', N'0856707060', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN021', 33, N'196a8844-2540-44c5-a8f0-6c7b8deb2013', N'D21CQCN01-N', N'n21dccn021@student.ptithcm.edu.vn', N'0634299103', N'LP')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN022', 34, N'48a2a798-228e-4d4e-96ef-32d9d89d0c82', N'D21CQCN01-N', N'n21dccn022@student.ptithcm.edu.vn', N'0608706100', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN023', 35, N'a2c883ea-0be4-4472-b1de-35689acf4b45', N'D21CQCN01-N', N'n21dccn023@student.ptithcm.edu.vn', N'0395575467', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN026', 36, N'ce8a2bc0-5474-4e80-997a-8fddfd5bcf02', N'D21CQCN01-N', N'n21dccn026@student.ptithcm.edu.vn', N'0227100487', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN030', 37, N'6e92389e-ac4f-4238-9904-d1b42ac42c1f', N'D21CQCN01-N', N'n21dccn03@student.ptithcm.edu.vn', N'0402168332', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN032', 38, N'fc8ddba0-f2aa-4fc9-b396-ea8516c5d097', N'D21CQCN01-N', N'n21dccn032@student.ptithcm.edu.vn', N'0154167378', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN033', 39, N'54695652-a894-4d53-80b6-43378ab19378', N'D21CQCN01-N', N'n21dccn033@student.ptithcm.edu.vn', N'0316694514', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN034', 40, N'c61e8766-c1af-4390-a513-a8431eac84d5', N'D21CQCN01-N', N'n21dccn034@student.ptithcm.edu.vn', N'0547873627', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN038', 41, N'f253339a-6d9e-470d-9e75-6f517b29f415', N'D21CQCN01-N', N'n21dccn038@student.ptithcm.edu.vn', N'0855340636', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN040', 4, N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', N'D21CQCN01-N', N'n21dccn040@student.ptithcm.edu.vn', N'0794895090', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN045', 43, N'f3471da3-3a66-4fb5-b0a9-a0fc48f868cd', N'D21CQCN01-N', N'n21dccn045@student.ptithcm.edu.vn', N'0690595371', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN047', 44, N'4f1e43bd-2189-4924-a378-4630cda5d1cd', N'D21CQCN01-N', N'n21dccn047@student.ptithcm.edu.vn', N'0192396976', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN050', 45, N'f3c4c098-c7f2-48ea-963a-27741b8da530', N'D21CQCN01-N', N'n21dccn050@student.ptithcm.edu.vn', N'0667106056', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN052', 46, N'e9c1c128-80f3-46dc-b625-d8f1a38b30d6', N'D21CQCN01-N', N'n21dccn052@student.ptithcm.edu.vn', N'0935407504', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN057', 47, N'7c157b1b-56ef-49f9-a911-022ed128359e', N'D21CQCN01-N', N'n21dccn057@student.ptithcm.edu.vn', N'0972953146', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN059', 48, N'9e9a94aa-c567-4ca5-b4b3-c67fb5988a95', N'D21CQCN01-N', N'n21dccn059@student.ptithcm.edu.vn', N'0781795159', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN060', 49, N'127e0703-46ed-402f-86b8-b7be12084441', N'D21CQCN01-N', N'n21dccn060@student.ptithcm.edu.vn', N'0961968425', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN062', 50, N'ffdc9679-0d5b-4881-9e67-e4a9e2f31478', N'D21CQCN01-N', N'n21dccn062@student.ptithcm.edu.vn', N'0755321576', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN070', 51, N'0dcf28c2-c16c-4e43-b3a5-202d84b5656e', N'D21CQCN01-N', N'n21dccn070@student.ptithcm.edu.vn', N'0691585956', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN071', 52, N'338946eb-51d8-4201-a53f-ea4380f1593c', N'D21CQCN01-N', N'n21dccn071@student.ptithcm.edu.vn', N'0747995682', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN077', 1, N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', N'D21CQCN01-N', N'n21dccn077@student.ptithcm.edu.vn', N'0907658389', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN079', 54, N'1fddd977-af9e-4d5e-8685-9eaf43cc4c28', N'D21CQCN01-N', N'n21dccn079@student.ptithcm.edu.vn', N'0674038180', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN081', 55, N'5d95e1bd-b44d-4f72-9d3d-913eb31665d7', N'D21CQCN01-N', N'n21dccn081@student.ptithcm.edu.vn', N'0193542181', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN084', 56, N'afd61e61-79a1-4e65-9de5-accc7f255d7b', N'D21CQCN01-N', N'n21dccn084@student.ptithcm.edu.vn', N'0406907045', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN086', 57, N'78020f69-876b-4a2f-8b91-913c5bea2ba5', N'D21CQCN01-N', N'n21dccn086@student.ptithcm.edu.vn', N'0253320839', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN087', 58, N'dae51e7b-4159-44ca-bc24-0bae945603cf', N'D21CQCN01-N', N'n21dccn087@student.ptithcm.edu.vn', N'0830244486', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN088', 59, N'fbdb5977-996c-4f97-93f9-e3b532e5a95b', N'D21CQCN01-N', N'n21dccn088@student.ptithcm.edu.vn', N'0634902067', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN090', 60, N'a62a2c62-ef50-4c39-a987-6cfde9149c68', N'D21CQCN01-N', N'n21dccn090@student.ptithcm.edu.vn', N'0684351930', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN094', 2, N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', N'D21CQCN01-N', N'n21dccn094@student.ptithcm.edu.vn', N'0936473884', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN095', 62, N'5e63607f-47e6-43e9-9ff4-772f3ab3367b', N'D21CQCN01-N', N'n21dccn095@student.ptithcm.edu.vn', N'0243841100', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN096', 63, N'9db4246e-2c9a-4f55-8c4a-eb74e21faaf5', N'D21CQCN01-N', N'n21dccn096@student.ptithcm.edu.vn', N'0737929879', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN102', 64, N'31d07ffa-3a82-4892-8806-4311ba702711', N'D21CQCN02-N', N'n21dccn102@student.ptithcm.edu.vn', N'0784688337', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN103', 65, N'30820deb-f796-425d-a33f-d61fdc69b7fa', N'D21CQCN02-N', N'n21dccn103@student.ptithcm.edu.vn', N'0493693789', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN178', 66, N'1e2245a3-eba0-48a1-838a-08ba5cea77ca', N'D21CQCN02-N', N'n21dccn178@student.ptithcm.edu.vn', N'0631378026', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN190', 67, N'af032f73-3409-4951-925c-836131b11faa', N'D21CQCN02-N', N'n21dccn190@student.ptithcm.edu.vn', N'0988045671', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN192', 68, N'f4298638-9e03-4920-bb5b-ed8739164534', N'D21CQCN02-N', N'n21dccn192@student.ptithcm.edu.vn', N'0668295853', N'TV')
INSERT [dbo].[SinhVien] ([maSinhVien], [idNguoiDung], [idTaiKhoan], [maLopSinhVien], [emailSinhVien], [sdt], [maChucVu_LopSinhVien]) VALUES (N'N21DCCN193', 69, N'8ecf88cb-be05-4cc1-bbf3-988bbe3054a9', N'D21CQCN02-N', N'n21dccn193@student.ptithcm.edu.vn', N'0823945928', N'TV')
GO

INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (3, N'N21DCCN077', CAST(N'2024-05-01T12:41:33.490' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (3, N'N21DCCN094', CAST(N'2024-05-01T12:41:38.677' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (3, N'N21DCCN011', CAST(N'2024-05-01T12:41:22.623' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (3, N'N21DCCN040', CAST(N'2024-05-01T12:41:28.217' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN077', CAST(N'2024-05-01T12:41:33.490' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN094', CAST(N'2024-05-01T12:41:38.677' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN011', CAST(N'2024-05-01T12:41:22.623' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN040', CAST(N'2024-05-01T12:41:28.217' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N18DCAT060', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N18DCAT074', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N19DCCN016', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N19DCCN151', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N19DCCN178', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N19DCCN232', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N20DCCN057', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN002', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN003', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN005', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN006', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN007', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN008', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN010', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN012', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN013', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN016', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN020', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN021', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN022', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN023', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN026', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN030', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN032', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN033', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN034', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN038', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN045', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN047', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN050', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN052', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN057', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN059', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN060', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN062', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN070', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN071', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN079', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN081', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN084', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN086', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN087', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN088', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN090', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN095', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN096', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN102', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN103', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN178', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN190', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN192', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
INSERT [dbo].[DsSinhVien_NhomHocPhan_LyThuyet] ([idNhomHocPhan], [maSinhVien], [_CreateAt]) VALUES (6, N'N21DCCN193', CAST(N'2024-05-01T15:10:00.000' AS DateTime))
GO
INSERT [dbo].[MuonPhongHoc] ([idLichMuonPhong], [idNguoiMuonPhong], [maQuanLyDuyet], [idVaiTro_NguoiMuonPhong], [yeuCau], [_TransferAt], [_ReturnAt]) VALUES (156, 34, N'QL196832', 6, N'MC + K + MT', CAST(N'2024-04-03T12:47:00.000' AS DateTime), NULL)
INSERT [dbo].[MuonPhongHoc] ([idLichMuonPhong], [idNguoiMuonPhong], [maQuanLyDuyet], [idVaiTro_NguoiMuonPhong], [yeuCau], [_TransferAt], [_ReturnAt]) VALUES (155, 71, N'QL793761', 7, N'MC + K + MT', CAST(N'2024-01-04T07:15:08.400' AS DateTime), CAST(N'2024-01-04T10:34:35.657' AS DateTime))
GO
SET NOCOUNT OFF
GO
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
