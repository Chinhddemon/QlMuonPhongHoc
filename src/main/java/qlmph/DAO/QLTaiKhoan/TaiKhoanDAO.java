package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.utils.UUIDEncoderDecoder;

public class TaiKhoanDAO {
    public static TaiKhoan getByTenDangNhapAndMatKhau(String TenDangNhap, String MatKhau) {

        // Tạo đối tượng TaiKhoan để lưu trữ thông tin
        TaiKhoan taiKhoan = null;

        // Tìm kiếm UUID đồng bộ với mã UID
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Truy vấn để tìm IdUserOneTime và IdQL trong bảng UserOneTime
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM TaiKhoan WHERE TenDangNhap = ? AND MatKhau = ?");
            statement.setString(1, TenDangNhap);
            statement.setString(2, MatKhau);
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
            
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

            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
        return taiKhoan;
    }
}