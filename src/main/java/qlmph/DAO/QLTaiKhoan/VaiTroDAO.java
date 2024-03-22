package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.VaiTro;

public class VaiTroDAO {

    public static VaiTro getByIdVaiTro(short IdVaiTro) { 

        VaiTro vaiTro = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM VaiTro WHERE IdVaiTro = ?");) {

            statement.setShort(1, IdVaiTro);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    String tenvaiTro = resultSet.getString("VaiTro");
                    vaiTro = new VaiTro(IdVaiTro, tenvaiTro);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }

        return vaiTro;
    }
}
