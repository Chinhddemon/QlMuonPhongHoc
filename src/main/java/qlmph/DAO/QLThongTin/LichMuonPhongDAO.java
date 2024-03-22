package qlmph.DAO.QLThongTin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLThongTin.LichMuonPhong;

public class LichMuonPhongDAO {
    
    public static List<LichMuonPhong> getAll() {

        List<LichMuonPhong> dsLichMuonPhong = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM LichMuonPhong");) {

            try (ResultSet resultSet = statement.executeQuery();) {
                while (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    int idLMPH = resultSet.getInt("IdLMPH");
                    String maPH = resultSet.getString("MaPH");
                    int idLH = resultSet.getInt("IdLH");
                    int idMPH = resultSet.getInt("IdMPH");
                    Timestamp thoiGian_BD = resultSet.getTimestamp("ThoiGian_BD");
                    Timestamp thoiGian_KT = resultSet.getTimestamp("ThoiGian_KT");
                    String mucDich = resultSet.getString("MucDich");
                    String lyDo = resultSet.getString("LyDo");
                    Timestamp _CreateAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                    LichMuonPhong lichMuonPhong = new LichMuonPhong(idLMPH, maPH, idLH, idMPH, thoiGian_BD, thoiGian_KT, mucDich, lyDo, _CreateAt, _DeleteAt);
                    dsLichMuonPhong.add(lichMuonPhong);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
        }

        return dsLichMuonPhong;
    }

    public static LichMuonPhong getByIdLMPH(int IdLMPH) {

        LichMuonPhong lichMuonPhong = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM LichMuonPhong WHERE IdLMPH = ?");) {

            statement.setInt(1, IdLMPH);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                    // Lấy thông tin từ kết quả
                    String maPH = resultSet.getString("MaPH");
                    int idLH = resultSet.getInt("IdLH");
                    int idMPH = resultSet.getInt("IdMPH");
                    Timestamp thoiGian_BD = resultSet.getTimestamp("ThoiGian_BD");
                    Timestamp thoiGian_KT = resultSet.getTimestamp("ThoiGian_KT");
                    String mucDich = resultSet.getString("MucDich");
                    String lyDo = resultSet.getString("LyDo");
                    Timestamp _CreateAt = resultSet.getTimestamp("_CreateAt");
                    Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
                    // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
                    lichMuonPhong = new LichMuonPhong(IdLMPH, maPH, idLH, idMPH, thoiGian_BD, thoiGian_KT, mucDich, lyDo, _CreateAt, _DeleteAt);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
            System.out.println("Không tìm thấy lịch mượn phòng với IdLMPH = " + IdLMPH);
        }

        return lichMuonPhong;
    }

}
