package qlmph.repository.QLThongTin;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.MuonPhongHoc;

@Repository
@Transactional
public class MuonPhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public MuonPhongHoc getByIdLMPH(int IdLMPH) {
        MuonPhongHoc muonPhongHoc = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            muonPhongHoc = (MuonPhongHoc) session.get(MuonPhongHoc.class, IdLMPH);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return muonPhongHoc;
    }

    public boolean save(MuonPhongHoc muonPhongHoc) {

        Session session = null;
        Transaction transaction = null;
        boolean status = false;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(muonPhongHoc);
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

    public boolean update(MuonPhongHoc muonPhongHoc) {

        Session session = null;
        Transaction transaction = null;
        boolean status = false;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(muonPhongHoc);
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
