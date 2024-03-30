package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLTaiKhoan.TaiKhoan;
import qlmph.model.QLThongTin.LichMuonPhong;

@Repository
@Transactional
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getAll() {
        List<LichMuonPhong> lichMuonPhongs = null;
        Session session = null;
        try {
            
            session = sessionFactory.openSession();
            // @SuppressWarnings("unchecked")
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

    public LichMuonPhong getByIdLMPH(int IdLMPH) {
        LichMuonPhong lichMuonPhong = null;
        Session session = null;
        try {
            
            session = sessionFactory.openSession();
            // @SuppressWarnings("unchecked")
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

}
