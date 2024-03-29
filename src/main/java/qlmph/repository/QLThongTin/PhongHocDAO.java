package qlmph.repository.QLThongTin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import qlmph.DBUtil.DBUtil;
import qlmph.model.QLThongTin.PhongHoc;

public class PhongHocDAO {
    
    public static List<PhongHoc> getAll() {
        List<PhongHoc> dsPhongHoc = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM PhongHoc");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    String maPH = resultSet.getString("MaPH");
                    String tinhTrang = resultSet.getString("TinhTrang");
                    Timestamp _ActiveAt = resultSet.getTimestamp("_ActiveAt");
                    Timestamp _DeactiveAt = resultSet.getTimestamp("_DeactiveAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    PhongHoc phongHoc = new PhongHoc(maPH, tinhTrang, _ActiveAt, _DeactiveAt);
                    dsPhongHoc.add(phongHoc);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsPhongHoc;
    }
    
    public static PhongHoc getByMaPH(String MaPH) {

        PhongHoc phongHoc = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM PhongHoc WHERE MaPH = ?");) {

            statement.setString(1, MaPH);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    String tinhTrang = resultSet.getString("TinhTrang");
                    Timestamp _ActiveAt = resultSet.getTimestamp("_ActiveAt");
                    Timestamp _DeactiveAt = resultSet.getTimestamp("_DeactiveAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    phongHoc = new PhongHoc(MaPH, tinhTrang, _ActiveAt, _DeactiveAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
            System.out.println("Không tìm thấy phòng học với MaPH = " + MaPH);
        }

        return phongHoc;
    }
}
