package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopHocPhanSection;

@Repository
@Transactional
public class LopHocPhanSectionRepository {
    
    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LopHocPhanSection> getAll() {
        List<LopHocPhanSection> lopHocPhanSections = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            lopHocPhanSections = (List<LopHocPhanSection>) session.createQuery("FROM LopHocPhanSection")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return lopHocPhanSections;
    }
}