package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.LopHocPhanSection;

@Repository
@Transactional
public class LopHocPhanSectionRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopHocPhanSection> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM LopHocPhanSection").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LopHocPhanSection getById(int idLHPSection) {
        try (Session session = sessionFactory.openSession()){
            return session.get(LopHocPhanSection.class, idLHPSection);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean save(LopHocPhanSection lopHocPhanSection) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.save(lopHocPhanSection);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(LopHocPhanSection lopHocPhanSection) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.update(lopHocPhanSection);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
