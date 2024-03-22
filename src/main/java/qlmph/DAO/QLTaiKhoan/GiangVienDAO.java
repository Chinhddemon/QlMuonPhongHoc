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
import qlmph.models.QLTaiKhoan.GiangVien;
import qlmph.utils.Statement;

public class GiangVienDAO {

    public static void post(GiangVien giangVien) {

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return;
            }
            PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO GiangVien (MaGV, HoTen, Email, SDT, NgaySinh, GioiTinh, ChucDanh) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)");
            // Xử lý kết quả
            int count = 0;
            // Statement.setUUIDRanDom(++count, statement);
            Statement.setVarcharAllowsNull(++count, giangVien.getMaGV(), statement);
            Statement.setVarcharAllowsNull(++count, giangVien.getEmail(), statement);
            Statement.setCharAllowsNull(++count,giangVien.getsDT(), statement);
            Statement.setNvarcharNotNull(++count, giangVien.getHoTen(), statement);
            Statement.setDateAllowsNull(++count, giangVien.getNgaySinh(), statement);
            Statement.setTinyintAllowsNull(++count, giangVien.getGioiTinh(), statement);
            Statement.setNvarcharAllowsNull(++count, giangVien.getChucDanh(), statement);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Dữ liệu đã được chèn thành công!");
            }
            // Đóng kết nối và các tài nguyên
            statement.close();
            connection.close(); 
        } catch (SQLException e) {  
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
        
    }

    public static List<GiangVien> getAll() {
        // Tạo danh sách để lưu trữ thông tin
        List<GiangVien> dsGiangVien = new ArrayList<>();

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien");

            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();

            // Xử lý kết quả
            while (resultSet.next()) {
                // Lấy thông tin từ kết quả
            	UUID idGV = (UUID) resultSet.getObject("idGV");
                String maGV = resultSet.getString("MaGV");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");	
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String chucDanh = resultSet.getString("ChucDanh");
                // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                GiangVien giangVien = new GiangVien(idGV, maGV, hoTen, email, sDT, ngaySinh, gioiTinh, chucDanh);
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
    
    public static GiangVien getByIdGV(UUID IdGV) {

        // Tạo đối tượng GiangVien để lưu trữ thông tin
        GiangVien giangVien = null;

        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Truy vấn SQL để lấy IdGV và MaGV từ bảng GiangVien
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdGV = ?");
            statement.setObject(1, IdGV);
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
            
            // Duyệt qua các kết quả trả về từ truy vấn
            if (resultSet.next()) {
                // Lấy thông tin từ kết quả
                String maGV = resultSet.getString("MaGV");
                String hoTen = resultSet.getString("HoTen");
                String email = resultSet.getString("Email");    
                String sDT = resultSet.getString("SDT");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte gioiTinh = resultSet.getByte("GioiTinh");
                String chucDanh = resultSet.getString("ChucDanh");
                // Tạo đối tượng GiangVien với các thông tin lấy từ kết quả truy vấn
                giangVien = new GiangVien(IdGV, maGV, hoTen, email, sDT, ngaySinh, gioiTinh, chucDanh);
            }

            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
    
        return giangVien;
    }

    public static void putByIdGV() {

    }

    public static void deleteByIdGV() {

    }

}
