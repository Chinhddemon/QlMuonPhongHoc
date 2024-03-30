package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LichMuonPhong;

@Repository
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getAll() {
        List<LichMuonPhong> lichMuonPhongs = null;
        Session session = null;
        try {
            
            session = sessionFactory.openSession();
            // @SuppressWarnings("unchecked")
            lichMuonPhongs = (List<LichMuonPhong>) session.createQuery("FROM LichMuonPhong")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lichMuonPhongs;
    }

    public static LichMuonPhong getByIdLMPH(int IdLMPH) {

        LichMuonPhong lichMuonPhong = null;

        // try (Connection connection = DBUtil.getConnection();
        // PreparedStatement statement = connection.prepareStatement("SELECT * FROM LichMuonPhong WHERE IdLMPH = ?");) {

        //     statement.setInt(1, IdLMPH);

        //     try (ResultSet resultSet = statement.executeQuery();) {
        //         if (resultSet.next()) {
        //             // Lấy thông tin từ kết quả
        //             String maPH = resultSet.getString("MaPH");
        //             int idLH = resultSet.getInt("IdLH");
        //             int idMPH = resultSet.getInt("IdMPH");
        //             Timestamp thoiGian_BD = resultSet.getTimestamp("ThoiGian_BD");
        //             Timestamp thoiGian_KT = resultSet.getTimestamp("ThoiGian_KT");
        //             String mucDich = resultSet.getString("MucDich");
        //             String lyDo = resultSet.getString("LyDo");
        //             Timestamp _CreateAt = resultSet.getTimestamp("_CreateAt");
        //             Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
        //             // Tạo đối tượng  với thông tin lấy được và thêm vào danh sách
        //             lichMuonPhong = new LichMuonPhong(IdLMPH, maPH, idLH, idMPH, thoiGian_BD, thoiGian_KT, mucDich, lyDo, _CreateAt, _DeleteAt);
        //         }
        //     }
        // } catch (SQLException e) {
        //     // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
        //     e.printStackTrace();
        //     System.out.println("Không tìm thấy lịch mượn phòng với IdLMPH = " + IdLMPH);
        // }

        return lichMuonPhong;
    }

}
