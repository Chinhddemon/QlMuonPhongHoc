package qlmph.repository.QLTaiKhoan;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLTaiKhoan.QuanLy;

@Repository
@Transactional
public class QuanLyRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public static List<QuanLy> getAll() {

        List<QuanLy> dsQuanLy = new ArrayList<>();

        // try (Connection connection = DBUtil.getConnection();
        // PreparedStatement statement = connection.prepareStatement("SELECT * FROM
        // SinhVien");) {

        // try (ResultSet resultSet = statement.executeQuery();) {
        // while (resultSet.next()) {
        // // Lấy thông tin từ kết quả
        // UUID idQL = UUID.fromString(resultSet.getString("IdQL"));
        // UUID idTaiKhoan = UUID.fromString(resultSet.getString("IdTaiKhoan"));
        // String maQL = resultSet.getString("MaQL");
        // String hoTen = resultSet.getString("HoTen");
        // String email = resultSet.getString("Email");
        // String sDT = resultSet.getString("SDT");
        // Date ngaySinh = resultSet.getDate("NgaySinh");
        // byte gioiTinh = resultSet.getByte("GioiTinh");
        // // Tạo đối tượng với thông tin lấy được và thêm vào danh sách
        // QuanLy quanLy = new QuanLy(idQL, idTaiKhoan, maQL, hoTen, email, sDT,
        // ngaySinh, gioiTinh);
        // dsQuanLy.add(quanLy);
        // }
        // }
        // } catch (SQLException e) {
        // // Xử lý ngoại lệ, ví dụ: ghi log lỗi, thông báo cho người dùng, hoặc xử lý
        // tùy thuộc vào ngữ cảnh
        // e.printStackTrace();
        // }

        return dsQuanLy;
    }

    public QuanLy getByMaQL(String MaQL) {

        QuanLy quanLy = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            quanLy = (QuanLy) session.createQuery("FROM QuanLy WHERE MaQL = :MaQL")
                    .setParameter("MaQL", MaQL)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return quanLy;
    }

    public QuanLy getByIdTaiKhoan(UUID IdTaiKhoan) {
        QuanLy quanLy = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            quanLy = (QuanLy) session.createQuery("FROM QuanLy WHERE IdTaiKhoan = :IdTaiKhoan")
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return quanLy;
    }

}
