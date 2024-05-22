package qlmph.repository.user;

import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.QuanLy;
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

    public QuanLy getByIdTaiKhoan(UUID idTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM QuanLy WHERE idTaiKhoan = :idTaiKhoan", QuanLy.class)
                    .setParameter("idTaiKhoan", idTaiKhoan.toString())
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}