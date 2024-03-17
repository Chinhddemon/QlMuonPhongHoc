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

public class QuanLyDAO {
    
    public static List<QuanLy> getAll() {
        // Tạo danh sách để lưu trữ thông tin
        List<QuanLy> dsQuanLy = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	String idGV = resultSet.getString("IdGV");
            	String idTaiKhoan = resultSet.getString("IdTaiKhoan");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                QuanLy quanLy = new QuanLy(idGV, idTaiKhoan, hoTen, ngaySinh, gioiTinh, email, sDT);
                dsQuanLy.add(quanLy);
            }

            // Đóng kết nối và các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return dsQuanLy;
    }

    public static QuanLy getByIdQL(UUID IdQL) {
        // Tạo danh sách để lưu trữ thông tin
        QuanLy quanLy = null;
    
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdQL = ?");
            statement.setObject(1, IdQL);
    
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
    
            // Xử lý kết quả
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	String idGV = resultSet.getString("IdGV");
            	String idTaiKhoan = resultSet.getString("IdTaiKhoan");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                // Lưu trữ thông tin vào class
                quanLy = new QuanLy(idGV, idTaiKhoan, hoTen, ngaySinh, gioiTinh, email, sDT);
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
    
        return quanLy;
    }

}
