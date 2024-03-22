package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import qlmph.DBUtil.DBUtil;

public class VaiTroDAO {
	public String kiemTraVaiTro(int idVaiTro) {
        String vaiTro = null;
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT vaiTro FROM VaiTro WHERE idVaiTro = ?")) {
            preparedStatement.setInt(1, idVaiTro);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    vaiTro = resultSet.getString("vaiTro");
                    return vaiTro;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vaiTro;
    }
}
