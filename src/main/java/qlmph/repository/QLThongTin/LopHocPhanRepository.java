package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopHocPhan;

@Repository
@Transactional
public class LopHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopHocPhan> getAll() {
        List<LopHocPhan> lopHocPhans = null;
        Session session = null;
        try {
            
            session = sessionFactory.openSession();
            lopHocPhans = (List<LopHocPhan>) session.createQuery("FROM LopHocPhan")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhans;
    }

    public LopHocPhan getByIdLHP(int IdLHP) {

        LopHocPhan lopHocPhans = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            lopHocPhans = (LopHocPhan) session.createQuery("FROM LopHocPhan WHERE IdLHP = :IdLHP")
                            .setParameter("IdLHP", IdLHP)
                            .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhans;
    }

    public LopHocPhan getByMaGVAndMaLopSVAndMaMH(String MaGV, String MaLopSV, String MaMH) {

        LopHocPhan lopHocPhans = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            lopHocPhans = (LopHocPhan) session.createQuery("FROM LopHocPhan WHERE MaGV = :MaGV AND MaLopSV = :MaLopSV AND MaMH = :MaMH")
                            .setParameter("MaGV", MaGV)
                            .setParameter("MaLopSV", MaLopSV)
                            .setParameter("MaMH", MaMH)
                            .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhans;
    }
}
