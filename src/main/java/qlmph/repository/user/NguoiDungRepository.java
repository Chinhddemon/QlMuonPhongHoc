package qlmph.repository.user;

import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.NguoiDung;

@Repository
@Transactional
public class NguoiDungRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public NguoiDung getByIdNguoiDung(int idNguoiDung) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(NguoiDung.class, idNguoiDung);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NguoiDung getByIdTaiKhoan(UUID idTaiKhoan, String role) {
        try (Session session = sessionFactory.openSession()) {
            NguoiDung nguoiDung = null;
            String hql = null;
            switch (role) {
                case "Regular":
                    hql = "SELECT nd " +
                            "FROM SinhVien sv " +
                            "INNER JOIN sv.nguoiDung nd " +
                            "WHERE sv.idTaiKhoan = :idTaiKhoan ";
                    nguoiDung = session.createQuery(hql, NguoiDung.class)
                            .setParameter("idTaiKhoan", idTaiKhoan.toString())
                            .uniqueResult();
                    if (nguoiDung != null) {
                        return nguoiDung;
                    }
                    hql = "SELECT nd " +
                            "FROM GiangVien gv " +
                            "INNER JOIN gv.nguoiDung nd " +
                            "WHERE gv.idTaiKhoan = :idTaiKhoan ";
                    return session.createQuery(hql, NguoiDung.class)
                            .setParameter("idTaiKhoan", idTaiKhoan.toString())
                            .uniqueResult();
                case "Manager":
                    hql = "SELECT nd " +
                            "FROM QuanLy ql " +
                            "INNER JOIN ql.nguoiDung nd " +
                            "WHERE ql.idTaiKhoan = :idTaiKhoan ";
                    return session.createQuery(hql, NguoiDung.class)
                            .setParameter("idTaiKhoan", idTaiKhoan.toString())
                            .uniqueResult();
                default:
                    throw new Exception("Invalid role");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
