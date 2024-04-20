package qlmph.repository.QLThongTin;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.MuonPhongHoc;

@Repository
@Transactional
public class MuonPhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public MuonPhongHoc getByIdLMPH(int IdLMPH) {
        try (Session session = sessionFactory.openSession()){
            return session.get(MuonPhongHoc.class, IdLMPH);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public MuonPhongHoc save(MuonPhongHoc muonPhongHoc) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.save(muonPhongHoc);
            session.getTransaction().commit();
            return muonPhongHoc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public MuonPhongHoc update(MuonPhongHoc muonPhongHoc) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.update(muonPhongHoc);
            session.getTransaction().commit();
            return muonPhongHoc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
