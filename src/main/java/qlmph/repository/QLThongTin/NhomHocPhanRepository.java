package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.NhomHocPhan;

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
            nhomHocPhans = (NhomHocPhan) session.createQuery("FROM NhomHocPhan WHERE IdNHP = :IdNHP")
                    .setParameter("IdNHP", IdNHP)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nhomHocPhans;
    }

    // public NhomHocPhan getByMaGVAndMaLopSVAndMaMH(String MaGV, String MaLopSV, String MaMH) {

    //     NhomHocPhan nhomHocPhans = null;
    //     Session session = null;

    //     try {
    //         session = sessionFactory.openSession();
    //         nhomHocPhans = (NhomHocPhan) session
    //                 .createQuery("FROM NhomHocPhan WHERE MaGV = :MaGV AND MaLopSV = :MaLopSV AND MaMH = :MaMH")
    //                 .setParameter("MaGV", MaGV)
    //                 .setParameter("MaLopSV", MaLopSV)
    //                 .setParameter("MaMH", MaMH)
    //                 .uniqueResult();
    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     } finally {
    //         if (session != null) {
    //             session.close();
    //         }
    //     }
    //     return nhomHocPhans;
    // }
}
