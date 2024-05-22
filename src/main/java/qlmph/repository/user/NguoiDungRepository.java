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

    public NguoiDung getByIdTaiKhoan(UUID idTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM NguoiDung WHERE idTaiKhoan = :idTaiKhoan", NguoiDung.class)
                    .setParameter("idTaiKhoan", idTaiKhoan.toString())
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
