package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.TaiKhoan;

public class TaiKhoanDAO {
    public static TaiKhoan getByTenDangNhapAndMatKhau(String TenDangNhap, String MatKhau) {

        TaiKhoan taiKhoan = null;

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM TaiKhoan WHERE TenDangNhap = ? AND MatKhau = ?");) {
            
            statement.setString(1, TenDangNhap);
            statement.setString(2, MatKhau);

            try(ResultSet resultSet = statement.executeQuery();) {
                // Duyệt qua kết quả để tìm kết quả phù hợp 
                if (resultSet.next()) {
                    UUID idTaiKhoan = (UUID) resultSet.getObject("IdTaiKhoan");
                    UUID idNguoiDung = (UUID) resultSet.getObject("IdNguoiDung");
                    UUID idVaiTro = (UUID) resultSet.getObject("IdVaiTro");
                    Timestamp _CreateAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    taiKhoan = new TaiKhoan(idTaiKhoan, idNguoiDung, idVaiTro, TenDangNhap, MatKhau, _CreateAt, _UpdateAt, _DeleteAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }
        return taiKhoan;
    }
}