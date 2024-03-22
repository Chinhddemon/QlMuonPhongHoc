package qlmph.DAO.QLTaiKhoan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLTaiKhoan.VaiTro;

public class VaiTroDAO {
    public static VaiTro getByIdVaiTro(UUID IdVaiTro) { 
        // Tạo đối tượng TaiKhoan để lưu trữ thông tin
        VaiTro vaiTro = null;

        // Tìm kiếm UUID đồng bộ với mã UID
        try {
            // Kết nối SQL 
            Connection connection = DBUtil.getConnection();
            if (connection == null || connection.isClosed()) {
                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Truy vấn để tìm IdUserOneTime và IdQL trong bảng UserOneTime
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM VaiTro WHERE IdVaiTro = ?");
            statement.setObject(1, IdVaiTro);
            // Thực hiện truy vấn và nhận kết quả
            ResultSet resultSet = statement.executeQuery();
            
            // Duyệt qua kết quả để tìm UUID phù hợp
            if (resultSet.next()) {
                String tenvaiTro = resultSet.getString("VaiTro");
                vaiTro = new VaiTro(IdVaiTro, tenvaiTro);
            }

            // Đóng kết nối, các tài nguyên
            resultSet.close();
            statement.close();
            connection.close(); 
        } catch (SQLException e) {
            e.printStackTrace(); // In ra thông tin lỗi nếu có
        }
        return vaiTro;
    }
}
