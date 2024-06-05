package qlmph.repository.user;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.GiangVien;

@Repository
@Transactional
public class GiangVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<GiangVien> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM GiangVien", GiangVien.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public GiangVien getByMaGiangVien(String maGiangVien) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(GiangVien.class, maGiangVien);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public GiangVien getByIdTaiKhoan(UUID idTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM GiangVien WHERE idTaiKhoan = :idTaiKhoan", GiangVien.class)
                    .setParameter("idTaiKhoan", idTaiKhoan.toString())
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
