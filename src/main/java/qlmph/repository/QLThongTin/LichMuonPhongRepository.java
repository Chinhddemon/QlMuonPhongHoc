package qlmph.repository.QLThongTin;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LichMuonPhong;

@Repository
@Transactional
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public boolean existsRecord(int IdLMPH) {
        Integer count = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            count = session.createQuery("SELECT COUNT(*) FROM LichMuonPhong WHERE IdLMPH = :IdLMPH")
                    .setParameter("IdLMPH", IdLMPH)
                    .getFirstResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return !(count == null || count == 0);
    }

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getAll() {
        List<LichMuonPhong> lichMuonPhongs = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            lichMuonPhongs = (List<LichMuonPhong>) session.createQuery("FROM LichMuonPhong")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lichMuonPhongs;
    }

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getListByCondition(
            Date ThoiGian_BD, Date ThoiGian_KT,
            String TrangThai,
            String MucDich,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH) {

        List<LichMuonPhong> lichMuonPhongs = null;
        Session session = null;
        try {
            String hql = "CALL Stored Proceduce"; // HQL query - Add conditions here
            session = sessionFactory.openSession();
            lichMuonPhongs = (List<LichMuonPhong>) session.createQuery(hql)
                    // Add parameters here
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lichMuonPhongs;
    }

    public LichMuonPhong getByIdLMPH(int IdLMPH) {
        LichMuonPhong lichMuonPhong = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            lichMuonPhong = (LichMuonPhong) session.createQuery("FROM LichMuonPhong WHERE IdLMPH = :IdLMPH")
                    .setParameter("IdLMPH", IdLMPH)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lichMuonPhong;
    }

    public boolean post(LichMuonPhong lichMuonPhong) {

        Session session = null;
        Transaction transaction = null;
        boolean status = false;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(lichMuonPhong);
            transaction.commit();
            status = true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return status;
    }

}
