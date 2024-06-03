package qlmph.repository.universityCourse;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.service.universityCourse.NhomHocPhanService.GetCommand;
import qlmph.model.universityCourse.NhomHocPhan;

@Repository
@Transactional
public class NhomHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<NhomHocPhan> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM NhomHocPhan", NhomHocPhan.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<NhomHocPhan> getListByCondition(Set<GetCommand> Commands,
            String idTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT nhp FROM NhomHocPhan nhp ";
            if(Commands.contains(GetCommand.TheoNguoiDung)) {
                hql += "INNER JOIN nhp.sinhViens sv ";
            }
            if(Commands.contains(GetCommand.TheoNguoiDung)) {
                hql += " WHERE sv.idTaiKhoan = :idTaiKhoan AND  ";
            }
            hql = hql.substring(0, hql.length() - 6);

            @SuppressWarnings("rawtypes")
            Query query = (Query) session.createQuery(hql, NhomHocPhan.class);
            if(Commands.contains(GetCommand.TheoNguoiDung)) {
                query.setParameter("idTaiKhoan", idTaiKhoan);
            }
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomHocPhan getByIdNhomHocPhan(int IdNhomHocPhan) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(NhomHocPhan.class, IdNhomHocPhan);
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
            for (NhomToHocPhan nhomToHocPhan : nhomHocPhan.getNhomToHocPhans()) {
                nhomToHocPhan.setNhomHocPhan(nhomHocPhan);
                session.save(nhomToHocPhan);
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
            for (NhomToHocPhan nhomToHocPhan : nhomHocPhan.getNhomToHocPhans()) {
                session.update(nhomToHocPhan);
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
            for (NhomToHocPhan nhomToHocPhan : nhomHocPhan.getNhomToHocPhans()) {
                session.saveOrUpdate(nhomToHocPhan);
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
            for (NhomToHocPhan nhomToHocPhan : nhomHocPhan.getNhomToHocPhans()) {
                session.update(nhomToHocPhan);
            }
            NhomToHocPhan nhomToHocPhan = (NhomToHocPhan) session.get(NhomToHocPhan.class, IdLHPSection);
            session.delete(nhomToHocPhan);
            session.getTransaction().commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NhomHocPhan update(NhomHocPhan nhomHocPhan, List<NhomToHocPhan> nhomToHocPhansDelete) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(nhomHocPhan);
            for (NhomToHocPhan nhomToHocPhan : nhomHocPhan.getNhomToHocPhans()) {
                session.saveOrUpdate(nhomToHocPhan);
            }
            for (NhomToHocPhan nhomToHocPhan : nhomToHocPhansDelete) {
                session.delete(nhomToHocPhan);
            }
            session.getTransaction().commit();
            return nhomHocPhan;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
