package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.GiangVien;

public class GiangVienDAO {

    public static List<GiangVien> getAll() {
        // Tạo danh sách để lưu trữ thông tin
        List<GiangVien> dsGiangVien = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	String idGV = resultSet.getString("idGV");
            	String idTaiKhoan = resultSet.getString("idTaiKhoan");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                Boolean gioiTinh = resultSet.getBoolean("GioiTinh");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                String maGV = resultSet.getString("MaGV");
                String chucDanh = resultSet.getString("ChucDanh");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                GiangVien giangVien = new GiangVien(idGV, idTaiKhoan, hoTen, ngaySinh, gioiTinh, email, sDT, maGV, chucDanh);
                dsGiangVien.add(giangVien);
            }

            // Đóng kết nối và các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return dsGiangVien;
    }
    
    public static GiangVien getByIdGV(String IdGV) {
        // Tạo danh sách để lưu trữ thông tin
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
            	String idGV = resultSet.getString("idGV");
            	String idTaiKhoan = resultSet.getString("idTaiKhoan");
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
