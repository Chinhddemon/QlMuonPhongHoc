package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopHocPhan;

@Repository
@Transactional
public class LopHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopHocPhan> getAll() {
        List<LopHocPhan> lopHocPhans = null;
        Session session = null;
        try {
            
            session = sessionFactory.openSession();
            // @SuppressWarnings("unchecked")
            lopHocPhans = (List<LopHocPhan>) session.createQuery("FROM LopHocPhan")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhans;
    }

    public static LopHocPhan getByIdLHP(int IdLHP) {

        LopHocPhan lopHocPhans = null;

        // try (Connection connection = DBUtil.getConnection();
        // PreparedStatement statement = connection.prepareStatement("SELECT * FROM LopHoc WHERE IdLHP = ?");) {

        //     statement.setInt(1, IdLHP);

        //     try (ResultSet resultSet = statement.executeQuery();) {
        //         if (resultSet.next()) {
        //             UUID idGVGiangDay = UUID.fromString(resultSet.getString("IdGVGiangDay")) ;
        //             String maMH = resultSet.getString("MaMH");
        //             String maLopSV = resultSet.getString("MaLopSV");
        //             Date ngay_BD = resultSet.getDate("Ngay_BD");
        //             Date ngay_KT = resultSet.getDate("Ngay_KT");
        //             Timestamp _CreatedAt = resultSet.getTimestamp("_CreateAt");
        //             Timestamp _UpdateAt = resultSet.getTimestamp("_UpdateAt");
        //             Timestamp _DeleteAt = resultSet.getTimestamp("_DeleteAt");
        //             // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
        //             lopHoc = new LopHoc(IdLHP, idGVGiangDay, maMH, maLopSV, ngay_BD, ngay_KT, _CreatedAt, _UpdateAt, _DeleteAt);
        //         }
        //     }
        // } catch (SQLException e) {
        //     // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
        //     e.printStackTrace();
        //     System.out.println("Không tìm thấy lớp học với IdLHP = " + IdLHP);
        // }

        return lopHocPhans;
    }
}
