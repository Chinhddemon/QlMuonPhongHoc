package qlmph.repository.universityBase;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityBase.LopSinhVien;

@Repository
@Transactional
public class LopSinhVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<LopSinhVien> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM LopSinhVien", LopSinhVien.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LopSinhVien getByMaLopSinhVien(String MaLopSinhVien) {
        try (Session session = sessionFactory.openSession()){
            return session.get(LopSinhVien.class, MaLopSinhVien);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
