package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.LopHocPhanSection;
import qlmph.model.NhomHocPhan;

@Repository
@Transactional
public class NhomHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<NhomHocPhan> getAll() {
        List<NhomHocPhan> nhomHocPhans = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            nhomHocPhans = (List<NhomHocPhan>) session.createQuery("FROM NhomHocPhan")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nhomHocPhans;
    }

    public NhomHocPhan getByIdLHP(int IdNHP) {

        NhomHocPhan nhomHocPhans = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            nhomHocPhans = (NhomHocPhan) session.get(NhomHocPhan.class, IdNHP);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nhomHocPhans;
    }

    public boolean update(NhomHocPhan nhomHocPhan) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(nhomHocPhan);
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

    public boolean updateLopHocPhan(NhomHocPhan nhomHocPhan) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(nhomHocPhan);
            for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
                session.update(lopHocPhanSection);
            }
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
