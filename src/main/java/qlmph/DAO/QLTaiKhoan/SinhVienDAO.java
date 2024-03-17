package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.QuanLy;
import qlmph.models.QLTaiKhoan.SinhVien;

public class SinhVienDAO {
    
    public static List<SinhVien> getAll() {
        // Tạo danh sách để lưu trữ thông tin
        List<SinhVien> dsSinhVien = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
                UUID idGV = (UUID) resultSet.getObject("IdGV");
                UUID idTaiKhoan = (UUID) resultSet.getObject("IdTaiKhoan");
                String maLopSV = resultSet.getString("MaLopSV");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                Boolean gioiTinh = resultSet.getBoolean("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                String maSV = resultSet.getString("MaSV");
                String chucVu = resultSet.getString("ChucVu");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                SinhVien sinhVien = new SinhVien(idGV, idTaiKhoan,maLopSV, hoTen, ngaySinh, gioiTinh, email, sDT, maSV, chucVu);
                dsSinhVien.add(sinhVien);
            }

            // Đóng kết nối và các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return dsSinhVien;
    }

    public static SinhVien getByIdSV(UUID IdSV) {
        // Tạo danh sách để lưu trữ thông tin
        SinhVien sinhVien = null;
    
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdSV = ?");
            statement.setObject(1, IdSV);
    
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
    
            // Xử lý kết quả
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                UUID idGV = (UUID) resultSet.getObject("IdGV");
                UUID idTaiKhoan = (UUID) resultSet.getObject("IdTaiKhoan");
                String maLopSV = resultSet.getString("MaLopSV");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                Boolean gioiTinh = resultSet.getBoolean("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                String maSV = resultSet.getString("MaSV");
                String chucVu = resultSet.getString("ChucVu");
                // Lưu trữ thông tin vào class
                sinhVien = new SinhVien(idGV, idTaiKhoan,maLopSV, hoTen, ngaySinh, gioiTinh, email, sDT, maSV, chucVu);
            } else {
                // Không tìm thấy bản ghi nào với ID cụ thể
            }
    
            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
            // Đảm bảo đóng kết nối sau khi sử dụng
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
    
        return sinhVien;
    }

}
