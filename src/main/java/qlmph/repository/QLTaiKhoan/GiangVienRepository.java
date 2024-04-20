package qlmph.repository.QLTaiKhoan;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.GiangVien;

@Repository
@Transactional
public class GiangVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<GiangVien> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM GiangVien").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public GiangVien getByMaGV(String MaGV) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(GiangVien.class, MaGV);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
