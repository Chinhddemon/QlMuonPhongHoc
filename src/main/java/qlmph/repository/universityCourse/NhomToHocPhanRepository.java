package qlmph.repository.universityCourse;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityCourse.NhomToHocPhan;

@Repository
@Transactional
public class NhomToHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<NhomToHocPhan> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM NhomToHocPhan WHERE _DeleteAt IS NULL", NhomToHocPhan.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomToHocPhan getById(int idLHPSection) {
        try (Session session = sessionFactory.openSession()){
            return session.get(NhomToHocPhan.class, idLHPSection);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean save(NhomToHocPhan lopHocPhanSection) {
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

    public boolean update(NhomToHocPhan lopHocPhanSection) {
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
