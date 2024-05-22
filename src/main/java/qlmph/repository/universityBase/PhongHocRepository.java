package qlmph.repository.universityBase;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityBase.PhongHoc;
@Repository
@Transactional
public class PhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<PhongHoc> getAll() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM PhongHoc ph WHERE _Status = 'A'" +
            " AND _ActiveAt = (SELECT MAX(_ActiveAt) FROM PhongHoc ph2 WHERE ph2.idPhongHoc = ph.idPhongHoc)";
            return session.createQuery(hql, PhongHoc.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public PhongHoc getByIdPhongHoc(int idPhongHoc) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM PhongHoc ph WHERE ph.idPhongHoc = :idPhongHoc AND _Status = 'A'";
            return session.createQuery(hql, PhongHoc.class)
                    .setParameter("idPhongHoc", idPhongHoc)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public PhongHoc getByMaPhongHoc(String maPhongHoc) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM PhongHoc ph WHERE ph.maPhongHoc = :maPhongHoc AND _Status = 'A'" +
            " AND _ActiveAt = (SELECT MAX(_ActiveAt) FROM PhongHoc ph2 WHERE ph2.maPhongHoc = ph.maPhongHoc)";
            return session.createQuery(hql, PhongHoc.class)
                    .setParameter("maPhongHoc", maPhongHoc)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
