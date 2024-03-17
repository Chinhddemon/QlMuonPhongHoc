package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.GiangVien;

public class GiangVienDAO {
    
    public static GiangVien getByIdGV(UUID IdGV) {
        // Tạo class lưu giữ thông tin truy vấn 
        GiangVien giangVien = null;
    
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdGV = ?");
            statement.setObject(1, IdGV);
    
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
    
            // Xử lý kết quả
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                UUID idGV = (UUID) resultSet.getObject("IdGV");
                UUID idTaiKhoan = (UUID) resultSet.getObject("IdTaiKhoan");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                Boolean gioiTinh = resultSet.getBoolean("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                String maGV = resultSet.getString("MaGV");
                String chucDanh = resultSet.getString("ChucDanh");
                // Lưu trữ thông tin vào class
                giangVien = new GiangVien(idGV, idTaiKhoan, hoTen, ngaySinh, gioiTinh, email, sDT, maGV, chucDanh);
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
    
        return giangVien;
    }

}
