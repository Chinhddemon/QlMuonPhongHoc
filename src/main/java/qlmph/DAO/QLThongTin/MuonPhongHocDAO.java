package qlmph.DAO.QLThongTin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;

import qlmph.DBUtil.DBUtil;
import qlmph.models.QLThongTin.MuonPhongHoc;

public class MuonPhongHocDAO {
    
    public static MuonPhongHoc getByIdMPH(int IdMPH) {

        MuonPhongHoc muonPhongHoc = null;

        try (Connection connection = DBUtil.getConnection();
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM MuonPhongHoc WHERE IdMPH = ?");) {

            statement.setInt(1, IdMPH);

            try (ResultSet resultSet = statement.executeQuery();) {
                if (resultSet.next()) {
                	UUID idNgMPH = UUID.fromString(resultSet.getString("IdNgMPH")) ;
                	UUID idQLDuyet = UUID.fromString(resultSet.getString("IdQLDuyet")) ;
                    short idVaiTro = resultSet.getShort("idVaiTro");
                    Timestamp thoiGian_MPH = resultSet.getTimestamp("ThoiGian_MPH");
                    Timestamp thoiGian_TPH = resultSet.getTimestamp("tThoiGian_TPH");
                    String yeuCau = resultSet.getString("YeuCau");
                    // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
                    muonPhongHoc = new MuonPhongHoc(IdMPH, idNgMPH, idQLDuyet, idVaiTro, thoiGian_MPH, thoiGian_TPH, yeuCau);
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
            e.printStackTrace();
            System.out.println("Không tìm thấy thủ tục mượn phòng học với IdMPH = " + muonPhongHoc);
        }

        return muonPhongHoc;
    }
}
