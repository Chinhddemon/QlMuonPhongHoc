package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopHocPhanSection;

@Repository
@Transactional
public class LopHocPhanSectionRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopHocPhanSection> getAll() {
        List<LopHocPhanSection> lopHocPhanSections = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            lopHocPhanSections = (List<LopHocPhanSection>) session.createQuery("FROM LopHocPhanSection")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhanSections;
    }

    public LopHocPhanSection getById(int idLHPSection) {
        LopHocPhanSection lopHocPhanSection = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            lopHocPhanSection = (LopHocPhanSection) session
                    .createQuery("FROM LopHocPhanSection WHERE IdLHPSection = :idLHPSection")
                    .setParameter("idLHPSection", idLHPSection)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhanSection;
    }

    public boolean update(LopHocPhanSection lopHocPhanSection) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(lopHocPhanSection);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
