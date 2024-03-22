package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.TaiKhoan;

public class TaiKhoanDAO {

    public TaiKhoan timTaiKhoanTheoTDN(String tenDangNhap) throws SQLException {
        TaiKhoan taiKhoan = null;
        String sql = "SELECT * FROM Account WHERE tenDangNhap = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, tenDangNhap);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    taiKhoan = new TaiKhoan();
                    taiKhoan.setIdTaiKhoan((resultSet.getInt("idTaiKhoan")));
                    taiKhoan.setIdNguoiDung(resultSet.getInt("idNgMPH"));
                    taiKhoan.setIdVaiTro(resultSet.getInt("idVaiTro"));
                    taiKhoan.setTenDangNhap(resultSet.getString("tenDangNhap"));
                    taiKhoan.setMatKhau(resultSet.getString("matKhau"));
                    taiKhoan.set_CreateAt(resultSet.getTimestamp("_CreateAt"));
                    taiKhoan.set_UpdateAt(resultSet.getTimestamp("_UpdateAt"));
                    taiKhoan.set_DeleteAt(resultSet.getTimestamp("_DeleteAt"));
                } else {
                    throw new SQLException("Không tìm thấy tài khoản với tên đăng nhập: " + tenDangNhap);
                }
            }
        }
        return taiKhoan;
    }    
}
