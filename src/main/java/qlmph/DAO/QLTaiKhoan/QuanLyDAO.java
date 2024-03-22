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
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM QuanLy");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	UUID idQL = (UUID) resultSet.getObject("IdQL");
                String maQL = resultSet.getString("MaQL");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                QuanLy quanLy = new QuanLy(idQL, maQL, hoTen, email, sDT, ngaySinh, gioiTinh);
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

        // Tạo đối tượng QuanLy để lưu trữ thông tin
        QuanLy quanLy = null;

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Truy vấn để tìm IdQL và MaQL trong bảng QuanLy
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM QuanLy WHERE IdQL = ?");
            statement.setObject(1, IdQL);
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
            
            // Duyệt qua kết quả để tìm UUID phù hợp
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maQL = resultSet.getString("MaQL");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");	
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                // Lưu trữ thông tin vào class
                quanLy = new QuanLy(IdQL, maQL, hoTen, email, sDT, ngaySinh, gioiTinh);
            }

            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
    
        return quanLy;
    }

}
