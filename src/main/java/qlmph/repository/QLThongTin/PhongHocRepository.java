package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.PhongHoc;

@Repository
@Transactional
public class PhongHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<PhongHoc> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM PhongHoc").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public PhongHoc getByMaPH(int IdPH) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(PhongHoc.class, IdPH);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
