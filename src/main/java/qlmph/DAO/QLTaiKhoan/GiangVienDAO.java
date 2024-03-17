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
                "INSERT INTO GiangVien (IdGV, IdTaiKhoan, HoTen, NgaySinh, GioiTinh, Email, SDT, MaGV, ChucDanh) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            // Xử lý kết quả
            int count = 0;
            Statement.setUUIDRanDom(++count, statement);
            Statement.setUUIDAllowsNull(++count, giangVien.getIdTaiKhoan(), statement);
            Statement.setNvarcharNotNull(++count, giangVien.getHoTen(), statement);
            Statement.setDateAllowsNull(++count, giangVien.getNgaySinh(), statement);
            Statement.setTinyintAllowsNull(++count, giangVien.getGioiTinh(), statement);
            Statement.setVarcharAllowsNull(++count, giangVien.getEmail(), statement);
            Statement.setCharAllowsNull(++count,giangVien.getsDT(), statement);
            Statement.setVarcharAllowsNull(++count, giangVien.getMaGV(), statement);
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
            	String idGV = resultSet.getString("IdGV");
            	String idTaiKhoan = resultSet.getString("IdTaiKhoan");
                String hoTen = resultSet.getString("HoTen");
                Date ngaySinh = resultSet.getDate("NgaySinh");
                byte  gioiTinh = resultSet.getByte("GioiTinh");
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
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }
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
                byte gioiTinh = resultSet.getByte("GioiTinh");
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

    public static void putByIdGV() {

    }

    public static void deleteByIdGV() {

    }

}
