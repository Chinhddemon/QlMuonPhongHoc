package qlmph.DAO.QLThongTin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLThongTin.MonHoc;

public class MonHocDAO {

    public static List<MonHoc> getAll() {
        List<MonHoc> dsMonHoc = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    String maMH = resultSet.getString("MaMH");
                    String tenMonHoc = resultSet.getString("TenMonHoc");
                    Timestamp _ActiveAt = resultSet.getTimestamp("_ActiveAt");
                    Timestamp _DeactiveAt = resultSet.getTimestamp("_DeactiveAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    MonHoc monHoc = new MonHoc(maMH, tenMonHoc, _ActiveAt, _DeactiveAt);
                    dsMonHoc.add(monHoc);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsMonHoc;
    }
    
    public static MonHoc getByMaMH(String MaMH) {

        MonHoc monHoc = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM MonHoc WHERE MaMH = ?");) {

            statement.setString(1, MaMH);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    String tenMonHoc = resultSet.getString("TenMonHoc");
                    Timestamp _ActiveAt = resultSet.getTimestamp("_ActiveAt");
                    Timestamp _DeactiveAt = resultSet.getTimestamp("_DeactiveAt");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    monHoc = new MonHoc(MaMH, tenMonHoc, _ActiveAt, _DeactiveAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
            System.out.println("Không tìm thấy môn học với MaMH = " + MaMH);
        }

        return monHoc;
    }

}

