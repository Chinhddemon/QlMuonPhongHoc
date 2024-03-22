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

        List<QuanLy> dsQuanLy = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM SinhVien");) {

            try (ResultSet resultSet = statement.executeQuery();) {
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
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsQuanLy;
    }

    public static QuanLy getByIdQL(UUID IdQL) {

        QuanLy quanLy = null;

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM QuanLy WHERE IdQL = ?");) {

            statement.setObject(1, IdQL);

            try (ResultSet resultSet = statement.executeQuery();) {
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
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return quanLy;
    }

}
