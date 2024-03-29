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
public class TaiKhoanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();	
            taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE tenDangNhap = :tenDangNhap AND matKhau = :matKhau")
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

    @Transactional
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

    @Transactional
    public List<TaiKhoan> getByListIdTaiKhoan(List<UUID> DsIdTaiKhoan) {
        List<TaiKhoan> dstaiKhoan = new ArrayList<>();;
        // Session session = null;
        // try {
        //     session = sessionFactory.openSession();	
        //     taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE tenDangNhap = :tenDangNhap AND matKhau = :matKhau")
        //                     .setParameter("tenDangNhap", tenDangNhap)
        //                     .setParameter("matKhau", matKhau)
        //                     .uniqueResult();
        // } catch (Exception e) {
        //     e.printStackTrace();
        // } finally {
        //     if (session != null) {
        //         session.close();
        //     }
        // }
        return dstaiKhoan;
    }

    @Transactional
    public List<TaiKhoan> getAll() {
        List<TaiKhoan> dsTaiKhoan = new ArrayList<>();;
        // Session session = null;
        // try {
        //     session = sessionFactory.openSession();	
        //     taiKhoan = (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE tenDangNhap = :tenDangNhap AND matKhau = :matKhau")
        //                     .setParameter("tenDangNhap", tenDangNhap)
        //                     .setParameter("matKhau", matKhau)
        //                     .uniqueResult();
        // } catch (Exception e) {
        //     e.printStackTrace();
        // } finally {
        //     if (session != null) {
        //         session.close();
        //     }
        // }
        return dsTaiKhoan;
    }

    @Transactional
    public void post(TaiKhoan taiKhoan) {

    }

    @Transactional
    public void postAll(List<TaiKhoan> dsTaiKhoan) {

    }

    @Transactional
    public void put(TaiKhoan taiKhoan) {

    }

    @Transactional
    public void putList(List<TaiKhoan> dsTaiKhoan) {

    }

    @Transactional
    public void delete(UUID IdTaiKhoan) {

    }

    @Transactional
    public void deleteList(List<UUID> dsIdTaiKhoan) {

    }

}