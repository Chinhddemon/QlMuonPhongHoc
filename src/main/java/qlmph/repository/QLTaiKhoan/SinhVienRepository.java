package qlmph.repository.QLTaiKhoan;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.SinhVien;

@Repository
@Transactional
public class SinhVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<SinhVien> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM SinhVien").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public SinhVien getByMaSV(String MaSV) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(SinhVien.class, MaSV);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}