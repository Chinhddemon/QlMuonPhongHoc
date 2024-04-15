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
import qlmph.service.LichMuonPhongService.GetCommand;

@Repository
@Transactional
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public boolean existsRecord(int IdLMPH) {
        Long count = 0L;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            count = (Long) session.createQuery("SELECT COUNT(*) FROM LichMuonPhong WHERE IdLMPH = :IdLMPH")
                    .setParameter("IdLMPH", IdLMPH)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return count > 0;
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
    public List<LichMuonPhong> getListByCondition(List<GetCommand> Commands,
            Date ThoiGian_BD, Date ThoiGian_KT,
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
            lichMuonPhong = (LichMuonPhong) session.get(LichMuonPhong.class, IdLMPH);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lichMuonPhong;
    }

    public boolean save(LichMuonPhong lichMuonPhong) {

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

    public boolean update(LichMuonPhong lichMuonPhong) {

        Session session = null;
        Transaction transaction = null;
        boolean status = false;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(lichMuonPhong);
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
