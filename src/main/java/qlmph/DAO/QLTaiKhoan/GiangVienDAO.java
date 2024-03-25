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
                "INSERT INTO GiangVien (IdGV, MaGV, HoTen, Email, SDT, NgaySinh, GioiTinh, ChucDanh) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            // Xử lý kết quả
            int count = 0;
            Statement.setUUIDRanDom(++count, statement);
            Statement.setVarcharNotNull(++count, giangVien.getMaGV(), statement);
            Statement.setNvarcharNotNull(++count, giangVien.getHoTen(), statement);
            Statement.setVarcharAllowsNull(++count, giangVien.getEmail(), statement);
            Statement.setCharAllowsNull(++count,giangVien.getsDT(), statement);
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

        List<GiangVien> dsGiangVien = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idGV = UUID.fromString(resultSet.getString("IdGV"));
                    UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan"));
                    String maGV = resultSet.getString("MaGV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucDanh = resultSet.getString("ChucDanh");
                    // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                    GiangVien giangVien = new GiangVien(idGV, idTaiKhoan, maGV, hoTen, email, sDT, ngaySinh, gioiTinh, chucDanh);
                    dsGiangVien.add(giangVien);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsGiangVien;
    }
    
    public static GiangVien getByIdGV(UUID IdGV) {

        GiangVien giangVien = null;

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdGV = ?");) {

            statement.setObject(1, IdGV);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan"));
                    String maGV = resultSet.getString("MaGV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");    
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucDanh = resultSet.getString("ChucDanh");
                    // Tạo đối tượng GiangVien với các thông tin lấy từ kết quả truy vấn
                    giangVien = new GiangVien(IdGV, idTaiKhoan, maGV, hoTen, email, sDT, ngaySinh, gioiTinh, chucDanh);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return giangVien;
    }

    public static GiangVien getByIdTaiKhoan(UUID IdTaiKhoan) {

        GiangVien giangVien = null;

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM GiangVien WHERE IdTaiKhoan = ?");) {

            statement.setObject(1, IdTaiKhoan);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idGV = UUID.fromString(resultSet.getString("IdGV"));
                    String maGV = resultSet.getString("MaGV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");    
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucDanh = resultSet.getString("ChucDanh");
                    // Tạo đối tượng GiangVien với các thông tin lấy từ kết quả truy vấn
                    giangVien = new GiangVien(idGV, IdTaiKhoan, maGV, hoTen, email, sDT, ngaySinh, gioiTinh, chucDanh);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return giangVien;
    }

    public static void putByIdGV() {

    }

    public static void deleteByIdGV() {

    }

}
