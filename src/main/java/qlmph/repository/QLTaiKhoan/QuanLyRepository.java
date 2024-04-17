package qlmph.repository.QLTaiKhoan;

import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QuanLy;

@Repository
@Transactional
public class QuanLyRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public QuanLy getByMaQL(String MaQL) {

        QuanLy quanLy = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            quanLy = (QuanLy) session.get(QuanLy.class, MaQL);
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
