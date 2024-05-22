-- Last synced with database: not yet

-- MARK: Temporary Permissions Setup

-- Permission/UserLogin (UL):
    -- Login to the system (TaiKhoan)
    -- Logout from the system (TaiKhoan)
    -- Create account (TaiKhoan) -- Not allow for this database
    -- Deactivate account (TaiKhoan) -- Not allow for this database
    -- Change password (TaiKhoan)
-- Permission/UserAccountView (UAV):
    -- View account information for a specific user (self) (TaiKhoan, NguoiDung)
        -- If is SinhVien (SinhVien, LopSV)
        -- If is QuanLy (QuanLy)
        -- If is NhanVien (NhanVien, DonViToChuc)
    -- View permission and role information for a specific user (self)

-- Permission/ManagerAccountView (MAV):
    -- View account information for all users
    -- Check permission and role information for all users
-- Permission/ManagerStructureView (MSV):
    -- View information of DonViToChuc table (DonViToChuc, VaiTroDVTC)
    -- View information of NhanVienHoatDong table (NhanVien, DonViToChuc)
    -- View information of LopSV table (LopSV, SinhVien)
-- Permission/ManagerAccountManagement (MAM):
    -- Manage information of TaiKhoan table
    -- Manage information of NguoiDung, SinhVien, NhanVienHoatDong table
    -- Manage information of Quyen, NhomQuyen table
    -- Manage information of VaiTro, NhomVaiTro table
    -- Manage information of DonViToChuc table
    -- Manage information of LopSV table
-- Permission/ManagerStructureManagement (MSM):
    -- Manage information of DonViToChuc table
    -- Manage information of NhanVienHoatDong table
    -- Manage information of LopSV table

-- Permission/Admin (A):
    -- Manage basic role and permission information for all managers

-- Permisssion/StudentAccountView (SAV):
    -- View LopSV information for a specific user (self) (LopSV, SinhVien)

-- Permission/LecturerAccountView (LAV):
    -- View NhomHocPhan, NhomToHocPhan and DsNguoiMuon_NhomHocPhan information for a specific user (self) (GiangVien, NhomHocPhan, NhomToHocPhan, DsNguoiMuon_NhomHocPhan)

-- MARK: Temporary Roles Setup

-- Role/User (U):
    -- Permission/UserLogin (UL)
    -- Permission/UserAccountView (UAV)

-- Role/ManagerView (MV):
    -- Permission/ManagerAccountView (MAV)
    -- Permission/ManagerStructureView (MSV)
-- Role/ManagerDevelopment (MD):
    -- Permission/ManagerStructureView (MSV)
    -- Permission/ManagerStructureManagement (MSM)
-- Role/ManagerManagement (MM):
    -- Permission/ManagerAccountView (MAV)
    -- Permission/ManagerStructureView (MSV)
    -- Permission/ManagerAccountManagement (MAM)
    -- Permission/ManagerStructureManagement (MSM)
-- Role/ManagerBorrowRoom (MB):
    -- Permission/ManagerAccountView (MAV)
    -- Permission/ManagerStructureView (MSV)
    -- Permission/ManagerBorrowRoomView (MBV)
    -- Permission/ManagerBorrowRoomManagement (MBM)
-- Role/Admin (A):
    -- Permission/Admin (A)

-- Role/Student (S):
    -- Permission/StudentAccountView (SAV)

-- Role/Lecturer (L):
    -- Permission/LecturerAccountView (LAV)


-- MARK: Roles Placing On Tables

    -- NhomVaiTro_TaiKhoan:
        --1 Role/User (U)
        --1--1 Role/Student (S)
        --1--3 Role/ManagerView (MV)
        --1--3 Role/ManagerDevelopment (MD)
        --1--3 Role/ManagerManagement (MM)
        --1--3--2 Role/Admin (A)

REVOKE SELECT, INSERT, UPDATE, DELETE, EXEC ON DATABASE::[databaseName] TO PUBLIC -- Thử 1 phát và tạm biệt database

-- Một số quan điểm cần cân nhắc khi thiết kế CSDL:
-- Bổ sung quản lý có vai trò phân công lịch trình trực mượn phòng học

