package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.MonHoc;

@Repository
@Transactional
public class MonHocRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<MonHoc> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM MonHoc").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public MonHoc getByMaMH(String MaMH) {
        try (Session session = sessionFactory.openSession()){
            return session.get(MonHoc.class, MaMH);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
