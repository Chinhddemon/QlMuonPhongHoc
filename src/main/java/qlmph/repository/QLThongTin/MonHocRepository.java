package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.MonHoc;

@Repository
@Transactional
public class MonHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<MonHoc> getAll() {
        List<MonHoc> monHocs = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            monHocs = (List<MonHoc>) session.createQuery("FROM MonHoc")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return monHocs;
    }
    
    public static MonHoc getByMaMH(String MaMH) {

        MonHoc monHoc = null;

        // try (Connection connection = DBUtil.getConnection();
        // PreparedStatement statement = connection.prepareStatement("SELECT * FROM MonHoc WHERE MaMH = ?");) {

        //     statement.setString(1, MaMH);

        //     try (ResultSet resultSet = statement.executeQuery();) {
        //         if (resultSet.next()) {
        //             String tenMonHoc = resultSet.getString("TenMonHoc");
        //             Timestamp _ActiveAt = resultSet.getTimestamp("_ActiveAt");
        //             Timestamp _DeactiveAt = resultSet.getTimestamp("_DeactiveAt");
        //             // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
        //             monHoc = new MonHoc(MaMH, tenMonHoc, _ActiveAt, _DeactiveAt);
        //         }
        //     }
        // } catch (SQLException e) {
        //     // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý tùy thuộc vào ngữ cảnh
        //     e.printStackTrace();
        //     System.out.println("Không tìm thấy môn học với MaMH = " + MaMH);
        // }

        return monHoc;
    }

}

