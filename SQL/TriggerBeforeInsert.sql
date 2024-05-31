
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
-- Ràng buộc mượn phòng học với NguoiMuonPhong phải là sinh viên trong danh sách Sinh viên mà học phần sử dụng hoặc là Giảng viên
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
            WHERE i._TransferAt < DATEADD(MINUTE, -30, LMP.startDateTime)
                OR i._TransferAt > LMP.endDateTime
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: MuonPhongHoc._TransferAt must be between LichMuonPhong.startDateTime - 30 minutes and LichMuonPhong.endDateTime with idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
            RETURN
        END

        IF NOT EXISTS ( -- Nếu mã vai trò không phải là sinh viên hoặc là giảng viên
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
            DECLARE @idLichMuonPhong2 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: MuonPhongHoc.idNguoiMuonPhong must be the role SinhVien in DsSinhVien_NhomHocPhan_LyThuyet or role GiangVien. idLichMuonPhong = %s', 16, 1, @idLichMuonPhong2)
            ROLLBACK TRANSACTION
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
            DECLARE @idLichMuonPhong3 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Can insert or update MuonPhongHoc but GiangVien cannot be in NhomToHocPhan of LichMuonPhong. idLichMuonPhong = %s', 10, 1, @idLichMuonPhong3)
        END
    END
GO

-- Ràng buộc cảnh báo thời gian lịch mượn phòng trong khoảng thời gian học của nhóm tổ học phần
CREATE TRIGGER [dbo].[CheckOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON i.idNhomToHocPhan = nthp.idNhomToHocPhan
            WHERE i.startDateTime < nthp.startDate OR i.endDateTime > nthp.endDate
        )
        BEGIN
            DECLARE @idLichMuonPhong VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Can insert or update LichMuonPhong but LichMuonPhong.startDateTime and LichMuonPhong.endDateTime should be within NhomToHocPhan.startDate and NhomToHocPhan.endDate with idLichMuonPhong = %s', 10, 1, @idLichMuonPhong)
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

        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomHocPhan] AS NHP ON i.idNhomHocPhan = NHP.idNhomHocPhan
            INNER JOIN [dbo].[HocKy_LopSinhVien] AS HKLSV ON NHP.idHocKy_LopSinhVien = HKLSV.idHocKy_LopSinhVien
            WHERE i.startDate < HKLSV.startDate OR i.endDate > HKLSV.endDate
        )
        BEGIN
            DECLARE @idNhomToHocPhan VARCHAR(50) = (SELECT CAST(i.[idNhomToHocPhan] AS VARCHAR(50)) FROM inserted i)
            RAISERROR ('Cannot insert or update: NhomToHocPhan.startDate and NhomToHocPhan.endDate must be within HocKy.startDate and HocKy.endDate with idNhomToHocPhan = %s', 16, 1, @idNhomToHocPhan)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc cấm xóa mượn phòng học khi thời gian mượn phòng chưa kết thúc
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
            RAISERROR('Cannot delete: MuonPhongHoc._ReturnAt must be not null with idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc cấm xóa lịch mượn phòng khi thời gian mượn phòng chưa kết thúc
CREATE TRIGGER [dbo].[BlockDelete_LichMuonPhong]
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
            RAISERROR('Cannot delete LichMuonPhong when _ReturnAt of MuonPhongHoc is not null with idLichMuonPhong = %s', 16, 1, @idLichMuonPhong)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc duy nhất nhóm học phần với học kỳ, lớp sinh viên, môn học, nhóm thông qua _DeleteAt
CREATE TRIGGER [dbo].[CheckUnique_NhomHocPhan]
ON [dbo].[NhomHocPhan]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS (
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomHocPhan] AS NHP 
                ON i.idHocKy_LopSinhVien = NHP.idHocKy_LopSinhVien
                AND i.maMonHoc = NHP.maMonHoc
                AND i.nhom = NHP.nhom
            WHERE i._DeleteAt IS NULL AND NHP._DeleteAt IS NULL
            GROUP BY i.idHocKy_LopSinhVien, i.maMonHoc, i.nhom
            HAVING COUNT(*) > 1
        )
        BEGIN
            DECLARE @idNhomHocPhan VARCHAR(50) = (SELECT CAST(i.[idNhomHocPhan] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('Cannot insert or update: NhomHocPhan.idHocKy_LopSinhVien, NhomHocPhan.maMonHoc, NhomHocPhan.nhom must be unique with _DeleteAt is null. idNhomHocPhan = %s', 16, 1, @idNhomHocPhan)
            ROLLBACK TRANSACTION
        END
    END
GO
-- add test data to test trigger

-- Ràng buộc duy nhất nhóm tổ học phần với nhóm học phần và nhóm tổ thông qua _DeleteAt
-- Ràng buộc nhóm tổ học phần có tổ và không có tổ
CREATE TRIGGER [dbo].[CheckUnique_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS ( -- Nếu nhóm tổ học phần không duy nhất với 'nhóm học phần' và 'nhóm tổ'
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomToHocPhan] AS NTHP 
                ON i.idNhomHocPhan = NTHP.idNhomHocPhan
                AND i.nhomTo = NTHP.nhomTo
            WHERE NTHP._DeleteAt IS NULL
                AND i.nhomTo <> 0
            GROUP BY i.idNhomHocPhan, i.idNhomToHocPhan
            HAVING COUNT(*) > 1
        )
        BEGIN -- Thông báo lỗi và rollback
            DECLARE @idNhomToHocPhan1 VARCHAR(50) = (SELECT CAST(i.[idNhomToHocPhan] AS VARCHAR(50)) FROM inserted i)
            RAISERROR('Cannot insert or update: NhomToHocPhan.idNhomHocPhan, NhomToHocPhan.nhomTo must be unique with _DeleteAt is null. idNhomToHocPhan = %s', 16, 1, @idNhomToHocPhan1)
            ROLLBACK TRANSACTION
        END
    END
GO

-- Ràng buộc cảnh báo nhóm học phần khi học kỳ đang diễn ra
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
            RAISERROR('Warning!: Delete NhomHocPhan when HocKy_LopSinhVien is in progress leads to inconsistency! It still could be deleted. First idNhomHocPhan = %s', 10, 1, @idNhomHocPhan)
        END
    END
GO

---- Ràng buộc phòng học khả dụng với Phòng học với trạng thái là khả dụng thông qua _ActiveAt, update database