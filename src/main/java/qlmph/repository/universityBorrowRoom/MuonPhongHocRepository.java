package qlmph.repository.universityBorrowRoom;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityBorrowRoom.MuonPhongHoc;

@Repository
@Transactional
public class MuonPhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public MuonPhongHoc getByIdLichMuonPhong(int IdLichMuonPhong) {
        try (Session session = sessionFactory.openSession()){
            String hql = "FROM MuonPhongHoc mph INNER JOIN mph.lichMuonPhong lmp WHERE lmp.IdLichMuonPhong = :IdLichMuonPhong AND lmp._DeleteAt IS NULL";
            return session.createQuery(hql, MuonPhongHoc.class)
                    .setParameter("IdLichMuonPhong", IdLichMuonPhong)
                    .uniqueResult();
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
