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
import qlmph.models.QLTaiKhoan.SinhVien;

public class SinhVienDAO {
    
    public static List<SinhVien> getAll() {
        // Tạo danh sách để lưu trữ thông tin
        List<SinhVien> dsSinhVien = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM SinhVien");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	UUID idSV = (UUID) resultSet.getObject("IdSV");
                String maLopSV = resultSet.getString("MaLopSV");
                String maSV = resultSet.getString("MaSV");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String chucVu = resultSet.getString("ChucVu");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                SinhVien sinhVien = new SinhVien(idSV, maLopSV, maSV, hoTen, email, sDT, ngaySinh, gioiTinh, chucVu);

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

        // Tạo đối tượng SinhVien để lưu trữ thông tin
        SinhVien sinhVien = null;

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Truy vấn để tìm IdSV và MaSV trong bảng SinhVien
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM SinhVien WHERE IdSV = ?");
            statement.setObject(1, IdSV);
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
            
            // Duyệt qua kết quả để tìm UUID phù hợp
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maSV = resultSet.getString("MaSV");
                String maLopSV = resultSet.getString("MaLopSV");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");	
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String chucVu = resultSet.getString("ChucVu");
                // Lưu trữ thông tin vào class
                sinhVien = new SinhVien(IdSV, maLopSV, maSV, hoTen, email, sDT, ngaySinh, gioiTinh, chucVu);
            }

            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return sinhVien;
    }

}
