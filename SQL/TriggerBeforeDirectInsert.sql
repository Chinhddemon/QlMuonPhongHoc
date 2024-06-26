
GO

---- Ràng buộc nhóm tổ phù hợp với mục đích sử dụng (Deprecated)
-- Ghi đè thứ tự nhóm tổ khi thêm mới nhóm tổ học phần
CREATE TRIGGER [dbo].[OverrideOnAttributesWhenInserted_NhomToHocPhan]
ON [dbo].[NhomToHocPhan]
INSTEAD OF INSERT
AS
    BEGIN
        SET NOCOUNT ON

        IF EXISTS( -- Nếu là nhóm tổ học phần không phải thực hành
            SELECT 1
            FROM inserted
            WHERE mucDich <> 'TH'
        )
        BEGIN -- Cập nhật nhóm tổ là 0
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

        INSERT INTO [dbo].[NhomToHocPhan] ( -- Ngược lại cập nhật nhóm tổ là số thứ tự nhóm tổ học phần
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

        INSERT INTO [dbo].[NhomHocPhan] ( -- Cập nhật nhóm là số thứ tự nhóm học phần
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

        DECLARE cur CURSOR FOR -- Lặp qua tất cả nhóm tổ học phần có cùng nhóm tổ
        SELECT NTHP.idNhomToHocPhan
        FROM [dbo].[NhomToHocPhan] AS NTHP
        INNER JOIN deleted d ON d.idNhomHocPhan = NTHP.idNhomHocPhan
        WHERE NTHP._DeleteAt IS NULL
            AND NTHP.mucDich = 'TH'
        ORDER BY [NTHP.startDate]

        DECLARE @count INT = 1
        DECLARE @idNhomToHocPhan INT

        OPEN cur
        FETCH NEXT FROM cur INTO @idNhomToHocPhan
        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE [dbo].[NhomToHocPhan]
            SET nhomTo = @count -- Cập nhật thứ tự nhóm tổ và tăng thứ tự nhóm tổ
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

        IF EXISTS( -- Nếu nhóm học phần không thay đổi trạng thái xóa
            SELECT 1
            FROM deleted
            INNER JOIN inserted ON deleted.idNhomHocPhan = inserted.idNhomHocPhan
            WHERE (inserted._DeleteAt IS NULL
                AND deleted._DeleteAt IS NULL)
        )
        BEGIN -- Kết thúc trigger
            RETURN
        END

        DECLARE cur CURSOR FOR -- Lặp qua tất cả nhóm học phần có cùng nhóm
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
            SET nhom = @count -- Cập nhật thứ tự nhóm và tăng thứ tự nhóm
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
	BEGIN TRY
        SET NOCOUNT ON

        IF NOT EXISTS ( -- Nếu không phải là quản lý
            SELECT 1
            FROM inserted i
            INNER JOIN [dbo].[TaiKhoan] TK ON i.[idTaiKhoan] = TK.[idTaiKhoan]
            INNER JOIN [dbo].[NhomVaiTro_TaiKhoan] NVTK ON TK.[idTaiKhoan] = NVTK.[idTaiKhoan]
            INNER JOIN [dbo].[VaiTro] VT ON NVTK.[IdVaiTro] = VT.[IdVaiTro]
            WHERE VT.[maVaiTro] IN ('MB', 'MM', 'MDB', 'A')
        )
        BEGIN -- Thông báo lỗi và rollback
            RAISERROR ('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''MB'', ''MM'', ''MDB'', ''A''.', 16, 1)
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
            RAISERROR ('QuanLy cannot reference to TaiKhoan with maVaiTro <> ''U''.', 16, 1)
        END
    END TRY
    BEGIN CATCH
        DECLARE @maQuanLy VARCHAR(50) = (SELECT TOP 1 [maQuanLy] FROM inserted i)

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        
        IF @ErrorSeverity >= 16
        BEGIN
            RAISERROR('Error! maQuanLy = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maQuanLy, @ErrorMessage)
            ROLLBACK TRANSACTION
        END
        ELSE IF @ErrorSeverity >= 10
        BEGIN
            RAISERROR('Warning! maQuanLy = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maQuanLy, @ErrorMessage)
        END
        ELSE IF @ErrorSeverity >= 0
        BEGIN
            RAISERROR('Information of maQuanLy = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maQuanLy, @ErrorMessage)
        END
    END CATCH
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_GiangVien]
ON [dbo].[GiangVien]
AFTER INSERT, UPDATE
AS
	BEGIN TRY
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
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''L''.', 16, 1)
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
            RAISERROR('GiangVien cannot reference to TaiKhoan with maVaiTro <> ''U''.', 16, 1)
        END
    END TRY
    BEGIN CATCH
        DECLARE @maGiangVien VARCHAR(50) = (SELECT TOP 1 [maGiangVien] FROM inserted i)

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        
        IF @ErrorSeverity >= 16
        BEGIN
            RAISERROR('Error! maGiangVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maGiangVien, @ErrorMessage)
            ROLLBACK TRANSACTION
        END
        ELSE IF @ErrorSeverity >= 10
        BEGIN
            RAISERROR('Warning! maGiangVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maGiangVien, @ErrorMessage)
        END
        ELSE IF @ErrorSeverity >= 0
        BEGIN
            RAISERROR('Information of maGiangVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maGiangVien, @ErrorMessage)
        END
    END CATCH
GO

CREATE TRIGGER [dbo].[CheckReferenceToTaiKhoan_SinhVien]
ON [dbo].[SinhVien]
AFTER INSERT, UPDATE
AS
	BEGIN TRY
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
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''S''.', 16, 1)
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
            RAISERROR('SinhVien cannot reference to TaiKhoan with maVaiTro <> ''U''.', 16, 1)
        END
    END TRY
    BEGIN CATCH
        DECLARE @maSinhVien VARCHAR(50) = (SELECT TOP 1 [maSinhVien] FROM inserted i)

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        
        IF @ErrorSeverity >= 16
        BEGIN
            RAISERROR('Error! maSinhVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maSinhVien, @ErrorMessage)
            ROLLBACK TRANSACTION
        END
        ELSE IF @ErrorSeverity >= 10
        BEGIN
            RAISERROR('Warning! maSinhVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maSinhVien, @ErrorMessage)
        END
        ELSE IF @ErrorSeverity >= 0
        BEGIN
            RAISERROR('Information of maSinhVien = %s. Error message: %s', @ErrorSeverity, @ErrorState, @maSinhVien, @ErrorMessage)
        END
    END CATCH
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
    BEGIN TRY
        SET NOCOUNT ON

        IF EXISTS ( -- Nếu thời gian bắt đầu mượn phòng không nằm trong khoảng thời gian của lịch mượn phòng
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
            WHERE i._TransferAt < DATEADD(MINUTE, -30, LMP.startDateTime) -- 30 phút trước thời gian bắt đầu
                OR i._TransferAt > LMP.endDateTime -- hoặc sau thời gian kết thúc
        )
        BEGIN -- Thông báo lỗi và rollback
            RAISERROR ('Cannot insert or update: MuonPhongHoc._TransferAt must be within LichMuonPhong.startDateTime and LichMuonPhong.endDateTime.', 16, 1)
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
            RAISERROR ('Cannot insert or update: PhongHoc._ActiveAt must be the latest available.', 16, 1)
        END

        IF EXISTS ( -- Nếu người dùng đang mượn phòng học khác
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[MuonPhongHoc] AS MPH ON i.idNguoiMuonPhong = MPH.idNguoiMuonPhong
            WHERE i.idLichMuonPhong <> MPH.idLichMuonPhong 
                AND MPH._ReturnAt IS NULL
        )
        BEGIN -- Thông báo lỗi và rollback
            RAISERROR ('Cannot insert or update: NguoiMuonPhong is using another LichMuonPhong.', 16, 1)
        END

        IF NOT EXISTS ( -- Nếu mã vai trò cập nhật không phải là sinh viên hoặc là giảng viên
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[VaiTro] AS VT ON i.idVaiTro_NguoiMuonPhong = VT.idVaiTro
            WHERE VT.maVaiTro IN ('S', 'L')
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
            RAISERROR ('Cannot insert or update: NguoiMuonPhong must be a SinhVien in DsSinhVien_NhomHocPhan_LyThuyet or a GiangVien in NhomToHocPhan.', 16, 1)
        END

        IF EXISTS ( -- Nếu lịch mượn phòng đã trả
            SELECT 1
            FROM inserted AS i
            WHERE i._ReturnAt IS NOT NULL
        )
        BEGIN 
            RETURN
        END

        DECLARE @StackMessage NVARCHAR(4000) = ''

        IF NOT EXISTS ( -- Nếu là giảng viên không giảng dạy học phần mà lịch mượn phòng đang sử dụng cho học phần
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NguoiDung] AS ND ON i.idNguoiMuonPhong = ND.idNguoiDung
            INNER JOIN [dbo].[GiangVien] AS GV ON ND.idNguoiDung = GV.idNguoiDung
            INNER JOIN [dbo].[NhomToHocPhan] AS NTHP ON GV.maGiangVien = NTHP.maGiangVienGiangDay
            INNER JOIN [dbo].[LichMuonPhong] AS LMP ON i.idLichMuonPhong = LMP.idLichMuonPhong
        )
        BEGIN -- Thông báo lỗi nhưng không rollback
            SET @StackMessage = @StackMessage + '
            Warning!: GiangVien does not belong to NhomToHocPhan of LichMuonPhong. '
        END

        IF @StackMessage <> ''
        BEGIN
            RAISERROR (@StackMessage, 10, 1)
        END
    END TRY
    BEGIN CATCH
        DECLARE @idLichMuonPhong6 VARCHAR(50) = (SELECT CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        
        IF @ErrorSeverity >= 16
        BEGIN
            RAISERROR('Error! idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong6, @ErrorMessage)
            ROLLBACK TRANSACTION
        END
        ELSE IF @ErrorSeverity >= 10
        BEGIN
            RAISERROR('Warning! idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong6, @ErrorMessage)
        END
        ELSE IF @ErrorSeverity >= 0
        BEGIN
            RAISERROR('Information of idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong6, @ErrorMessage)
        END
    END CATCH
GO

-- Ràng buộc cảnh báo thời gian lịch mượn phòng trong khoảng thời gian học của nhóm tổ học phần
-- Ràng buộc cảnh báo thời gian lịch mượn phòng không nên trùng với lịch mượn phòng khác trong cùng một nhóm tổ học phần
CREATE TRIGGER [dbo].[CheckOnAttributes_LichMuonPhong]
ON [dbo].[LichMuonPhong]
AFTER INSERT, UPDATE
AS
    BEGIN TRY
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
            RAISERROR ('Cannot insert or update: PhongHoc._ActiveAt must be the latest available.', 16, 1)
        END

        IF EXISTS ( -- Nếu lịch mượn phòng bị xóa
            SELECT 1
            FROM inserted AS i
            WHERE i._DeleteAt IS NOT NULL
        )
        BEGIN 
            RETURN
        END

        DECLARE @StackMessage NVARCHAR(4000) = ''

        IF EXISTS ( -- Nếu thời gian bắt đầu, kết thúc của lịch mượn phòng không nằm trong khoảng thời gian của nhóm tổ học phần
            SELECT 1
            FROM inserted AS i
            INNER JOIN [dbo].[NhomToHocPhan] AS nthp ON i.idNhomToHocPhan = nthp.idNhomToHocPhan
            WHERE i.startDateTime < nthp.startDate OR i.endDateTime > nthp.endDate
        )
        BEGIN -- Thông báo lỗi nhưng không rollback
            SET @StackMessage = @StackMessage + '
            Warning!: LichMuonPhong.startDateTime and LichMuonPhong.endDateTime must be within NhomToHocPhan.startDate and NhomToHocPhan.endDate. '
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
            SET @StackMessage = @StackMessage + '
            Warning!: LichMuonPhong.startDateTime and LichMuonPhong.endDateTime must not be overlapped with another LichMuonPhong in the same NhomToHocPhan. '
        END
    END TRY
    BEGIN CATCH
        DECLARE @idLichMuonPhong5 VARCHAR(50) = (SELECT TOP 1 CAST(i.[idLichMuonPhong] AS VARCHAR(50)) FROM inserted i)

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        
        IF @ErrorSeverity >= 16
        BEGIN
            RAISERROR('Error! idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong5, @ErrorMessage)
            ROLLBACK TRANSACTION
        END
        ELSE IF @ErrorSeverity >= 10
        BEGIN
            RAISERROR('Warning! idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong5, @ErrorMessage)
        END
        ELSE IF @ErrorSeverity >= 0
        BEGIN
            RAISERROR('Information of idLichMuonPhong = %s. Error message: %s', @ErrorSeverity, @ErrorState, @idLichMuonPhong5, @ErrorMessage)
        END
    END CATCH
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

---- Ràng buộc phòng học khả dụng với trạng thái là khả dụng thông qua _ActiveAt, update database
