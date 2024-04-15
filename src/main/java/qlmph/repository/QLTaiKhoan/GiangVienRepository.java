package qlmph.repository.QLTaiKhoan;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLTaiKhoan.GiangVien;

@Repository
@Transactional
public class GiangVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<GiangVien> getAll() {
        List<GiangVien> GiangViens = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            GiangViens = (List<GiangVien>) session.createQuery("FROM GiangVien")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return GiangViens;
    }

    public GiangVien getByMaGV(String MaGV) {
        GiangVien giangvien = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            giangvien = (GiangVien) session.get(GiangVien.class, MaGV);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return giangvien;
    }

}
