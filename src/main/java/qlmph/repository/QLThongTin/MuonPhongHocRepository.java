package qlmph.repository.QLThongTin;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.MuonPhongHoc;

@Repository
@Transactional
public class MuonPhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public boolean existsRecord(int IdLMPH) {
        Long count = 0L;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            count = (Long) session.createQuery("SELECT COUNT(*) FROM MuonPhongHoc WHERE IdLMPH = :IdLMPH")
                    .setParameter("IdLMPH", IdLMPH)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return count > 0;
    }

    public static MuonPhongHoc getByIdMPH(int IdMPH) {

        MuonPhongHoc muonPhongHoc = null;

        // try (Connection connection = DBUtil.getConnection();
        // PreparedStatement statement = connection.prepareStatement("SELECT * FROM
        // MuonPhongHoc WHERE IdMPH = ?");) {

        // statement.setInt(1, IdMPH);

        // try (ResultSet resultSet = statement.executeQuery();) {
        // if (resultSet.next()) {
        // UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan")) ;
        // UUID idQLDuyet = UUID.fromString(resultSet.getString("IdQLDuyet")) ;
        // Timestamp thoiGian_MPH = resultSet.getTimestamp("ThoiGian_MPH");
        // Timestamp thoiGian_TPH = resultSet.getTimestamp("tThoiGian_TPH");
        // String yeuCau = resultSet.getString("YeuCau");
        // // Tạo đối tượng lớp học với thông tin lấy được và thêm vào danh sách
        // muonPhongHoc = new MuonPhongHoc(IdMPH, idTaiKhoan, idQLDuyet, thoiGian_MPH,
        // thoiGian_TPH, yeuCau);
        // }
        // }
        // } catch (SQLException e) {
        // // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý
        // tùy thuộc vào ngữ cảnh
        // e.printStackTrace();
        // System.out.println("Không tìm thấy thủ tục mượn phòng học với IdMPH = " +
        // muonPhongHoc);
        // }

        return muonPhongHoc;
    }

    public boolean post(MuonPhongHoc muonPhongHoc) {

        Session session = null;
        Transaction transaction = null;
        boolean status = false;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(muonPhongHoc);
            transaction.commit();
            status = true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return status;
    }
}
