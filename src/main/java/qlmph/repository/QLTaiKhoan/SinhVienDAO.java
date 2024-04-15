package qlmph.repository.QLTaiKhoan;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.model.QLTaiKhoan.SinhVien;

public class SinhVienDAO {

    public static List<SinhVien> getAll() {

        List<SinhVien> dsSinhVien = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement("SELECT * FROM SinhVien");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idSV = UUID.fromString(resultSet.getString("IdSV"));
                    UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan"));
                    String maLopSV = resultSet.getString("MaLopSV");
                    String maSV = resultSet.getString("MaSV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucVu = resultSet.getString("ChucVu");
                    // Tạo đối tượng với thông tin lấy được và thêm vào danh sách
                    SinhVien sinhVien = new SinhVien(idSV, idTaiKhoan, maLopSV, maSV, hoTen, email, sDT, ngaySinh,
                            gioiTinh, chucVu);

                    dsSinhVien.add(sinhVien);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy
            // thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsSinhVien;
    }

    public static SinhVien getByIdSV(UUID IdSV) {

        SinhVien sinhVien = null;

        try (Connection connection = DBUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement("SELECT * FROM SinhVien WHERE IdSV = ?");) {

            statement.setObject(1, IdSV);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan"));
                    String maSV = resultSet.getString("MaSV");
                    String maLopSV = resultSet.getString("MaLopSV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucVu = resultSet.getString("ChucVu");
                    // Lưu trữ thông tin vào class
                    sinhVien = new SinhVien(IdSV, idTaiKhoan, maLopSV, maSV, hoTen, email, sDT, ngaySinh, gioiTinh,
                            chucVu);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy
            // thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return sinhVien;
    }

    public static SinhVien getByIdTaiKhoan(UUID IdTaiKhoan) {

        SinhVien sinhVien = null;

        try (Connection connection = DBUtil.getConnection();
                PreparedStatement statement = connection
                        .prepareStatement("SELECT * FROM SinhVien WHERE IdTaiKhoan = ?");) {

            statement.setObject(1, IdTaiKhoan);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    UUID idSV = UUID.fromString(resultSet.getString("IdSV"));
                    String maSV = resultSet.getString("MaSV");
                    String maLopSV = resultSet.getString("MaLopSV");
                    String hoTen = resultSet.getString("HoTen");
                    String email = resultSet.getString("Email");
                    String sDT = resultSet.getString("SDT");
                    Date ngaySinh = resultSet.getDate("NgaySinh");
                    byte gioiTinh = resultSet.getByte("GioiTinh");
                    String chucVu = resultSet.getString("ChucVu");
                    // Lưu trữ thông tin vào class
                    sinhVien = new SinhVien(idSV, IdTaiKhoan, maLopSV, maSV, hoTen, email, sDT, ngaySinh, gioiTinh,
                            chucVu);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy
            // thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return sinhVien;
    }

}
