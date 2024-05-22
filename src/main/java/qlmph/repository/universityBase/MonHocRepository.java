package qlmph.repository.universityBase;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityBase.MonHoc;

@Repository
@Transactional
public class MonHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<MonHoc> getAll() {
        try (Session session = sessionFactory.openSession()){
            String hql = "FROM MonHoc mh WHERE _Status = 'A'" +
            " AND _ActiveAt = (SELECT MAX(_ActiveAt) FROM MonHoc mh2 WHERE mh2.maMonHoc = mh.maMonHoc)";
            return session.createQuery(hql, MonHoc.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public MonHoc getByIdMonHoc(int idMonHoc) {
        try (Session session = sessionFactory.openSession()){
            String hql = "FROM MonHoc mh WHERE mh.idMonHoc = :idMonHoc AND _Status = 'A'";
            return session.createQuery(hql, MonHoc.class)
                    .setParameter("idMonHoc", idMonHoc)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public MonHoc getByMaMonHoc(String maMonHoc) {
        try (Session session = sessionFactory.openSession()){
            String hql = "FROM MonHoc mh WHERE mh.maMonHoc = :maMonHoc AND _Status = 'A'" +
            " AND _ActiveAt = (SELECT MAX(_ActiveAt) FROM MonHoc mh2 WHERE mh2.maMonHoc = mh.maMonHoc)";
            return session.createQuery(hql, MonHoc.class)
                    .setParameter("maMonHoc", maMonHoc)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
