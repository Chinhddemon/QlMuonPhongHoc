package qlmph.repository.user;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.SinhVien;

@Repository
@Transactional
public class SinhVienRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<SinhVien> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM SinhVien").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public SinhVien getByMaSinhVien(String maSinhVien) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(SinhVien.class, maSinhVien);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public SinhVien getByIdTaiKhoan(UUID idTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM SinhVien WHERE idTaiKhoan = :idTaiKhoan", SinhVien.class)
                    .setParameter("idTaiKhoan", idTaiKhoan.toString())
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<SinhVien> getListByIdNhomHocPhan(int idNhomHocPhan) {
        try (Session session = sessionFactory.openSession()) {System.out.println("Hello");
            String hql = "SELECT sv FROM NhomHocPhan nhp INNER JOIN nhp.sinhViens sv WHERE nhp.idNhomHocPhan = :idNhomHocPhan";
            return session.createQuery(hql, SinhVien.class)
                    .setParameter("idNhomHocPhan", idNhomHocPhan)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}