package qlmph.repository.QLTaiKhoan;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.TaiKhoan;

@Repository
@Transactional
public class TaiKhoanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<TaiKhoan> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM TaiKhoan").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByTenDangNhapAndMatKhau(String TenDangNhap, String MatKhau) {
        try (Session session = sessionFactory.openSession()) {
            TaiKhoan TaiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE TenDangNhap = :TenDangNhap")
                    .setParameter("TenDangNhap", TenDangNhap)
                    .uniqueResult();
            if(TaiKhoan.getMatKhau().trim().equals(MatKhau)){
                return TaiKhoan;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByIdTaiKhoan(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(TaiKhoan.class, IdTaiKhoan);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<TaiKhoan> getListByIdTaiKhoan(List<UUID> DsIdTaiKhoan) {
        List<TaiKhoan> dstaiKhoan = new ArrayList<>();
        ;
        // Session session = null;
        // try {
        // session = sessionFactory.openSession();
        // taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE tenDangNhap =
        // :tenDangNhap AND matKhau = :matKhau")
        // .setParameter("tenDangNhap", tenDangNhap)
        // .setParameter("matKhau", matKhau)
        // .uniqueResult();
        // } catch (Exception e) {
        // e.printStackTrace();
        // } finally {
        // if (session != null) {
        // session.close();
        // }
        // }
        return dstaiKhoan;
    }

    public void save(TaiKhoan taiKhoan) {

    }

    public void saveAll(List<TaiKhoan> dsTaiKhoan) {

    }

    public void update(TaiKhoan taiKhoan) {

    }

    public void updateList(List<TaiKhoan> dsTaiKhoan) {

    }

    public void delete(UUID IdTaiKhoan) {

    }

    public void deleteList(List<UUID> dsIdTaiKhoan) {

    }

}