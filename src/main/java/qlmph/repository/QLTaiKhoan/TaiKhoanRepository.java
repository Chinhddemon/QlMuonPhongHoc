package qlmph.repository.QLTaiKhoan;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLTaiKhoan.TaiKhoan;

@Repository
@Transactional
public class TaiKhoanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            taiKhoan = (TaiKhoan) session
                    .createQuery("FROM TaiKhoan WHERE tenDangNhap = :tenDangNhap AND matKhau = :matKhau")
                    .setParameter("tenDangNhap", tenDangNhap)
                    .setParameter("matKhau", matKhau)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return taiKhoan;
    }

    public TaiKhoan getByIdTaiKhoan(UUID IdTaiKhoan) {
        TaiKhoan taiKhoan = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE IdTaiKhoan = :IdTaiKhoan")
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return taiKhoan;
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

    @SuppressWarnings("unchecked")
    public List<TaiKhoan> getAll() {
        List<TaiKhoan> taiKhoans = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            // @SuppressWarnings("unchecked")
            taiKhoans = (List<TaiKhoan>) session.createQuery("FROM TaiKhoan")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return taiKhoans;
    }

    public void post(TaiKhoan taiKhoan) {

    }

    public void postAll(List<TaiKhoan> dsTaiKhoan) {

    }

    public void put(TaiKhoan taiKhoan) {

    }

    public void putList(List<TaiKhoan> dsTaiKhoan) {

    }

    public void delete(UUID IdTaiKhoan) {

    }

    public void deleteList(List<UUID> dsIdTaiKhoan) {

    }

}