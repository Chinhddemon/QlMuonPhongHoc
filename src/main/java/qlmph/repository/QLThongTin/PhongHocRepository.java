package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.PhongHoc;

@Repository
@Transactional
public class PhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<PhongHoc> getAll() {
        List<PhongHoc> phongHocs = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            phongHocs = (List<PhongHoc>) session.createQuery("FROM PhongHoc")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return phongHocs;
    }

    public PhongHoc getByMaPH(int IdPH) {

        PhongHoc phongHoc = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            phongHoc = (PhongHoc) session.createQuery("FROM PhongHoc WHERE IdPH = :IdPH")
                    .setParameter("IdPH", IdPH)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return phongHoc;
    }
}
