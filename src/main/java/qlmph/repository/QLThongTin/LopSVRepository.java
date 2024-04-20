package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.LopSV;

@Repository
@Transactional
public class LopSVRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopSV> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM LopSV").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LopSV getByMaLopSV(String MaLopSV) {
        try (Session session = sessionFactory.openSession()){
            return session.get(LopSV.class, MaLopSV);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
