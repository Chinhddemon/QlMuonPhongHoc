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
        try (Session session = sessionFactory.openSession()) {
            return session.get(QuanLy.class, MaQL);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public QuanLy getByIdTaiKhoan(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return (QuanLy) session.createQuery("FROM QuanLy WHERE IdTaiKhoan = :IdTaiKhoan")
                    .setParameter("IdTaiKhoan", IdTaiKhoan.toString())
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
