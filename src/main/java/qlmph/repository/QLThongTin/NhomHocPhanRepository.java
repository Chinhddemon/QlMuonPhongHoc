package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
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
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM NhomHocPhan").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomHocPhan getByIdLHP(int IdNHP) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(NhomHocPhan.class, IdNHP);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean update(NhomHocPhan nhomHocPhan) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(nhomHocPhan);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public NhomHocPhan saveNhomHocPhan(NhomHocPhan nhomHocPhan) {
        Session session = sessionFactory.openSession();
        Transaction transaction1 = null;
        Transaction transaction2 = null;
        try {
            transaction1 = session.beginTransaction();
            session.save(nhomHocPhan);
            transaction1.commit();
            transaction2 = session.beginTransaction();
            for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
                lopHocPhanSection.setNhomHocPhan(nhomHocPhan);
                session.save(lopHocPhanSection);
            }
            transaction2.commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction2 != null) {
                transaction2.rollback(); // Rollback giao dịch thứ 2 nếu có ngoại lệ
            }
            if (transaction1 != null) {
                transaction1.rollback(); // Rollback giao dịch thứ 1 nếu có ngoại lệ
            }
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public NhomHocPhan updateLopHocPhan(NhomHocPhan nhomHocPhan) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(nhomHocPhan);
            for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
                session.update(lopHocPhanSection);
            }
            session.getTransaction().commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomHocPhan saveAndUpdateLopHocPhan(NhomHocPhan nhomHocPhan) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(nhomHocPhan);
            for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
                session.saveOrUpdate(lopHocPhanSection);
            }
            session.getTransaction().commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomHocPhan updateAndDeleteLopHocPhan(NhomHocPhan nhomHocPhan, String IdLHPSection) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(nhomHocPhan);
            for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
                session.update(lopHocPhanSection);
            }
            LopHocPhanSection lopHocPhanSection = (LopHocPhanSection) session.get(LopHocPhanSection.class, IdLHPSection);
            session.delete(lopHocPhanSection);
            session.getTransaction().commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
