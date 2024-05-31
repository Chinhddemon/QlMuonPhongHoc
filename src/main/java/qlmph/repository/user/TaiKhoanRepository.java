package qlmph.repository.user;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.TaiKhoan;

@Repository
@Transactional
public class TaiKhoanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<TaiKhoan> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM TaiKhoan", TaiKhoan.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByTenDangNhapAndMatKhau(String TenDangNhap, String MatKhau) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM TaiKhoan WHERE TenDangNhap = :TenDangNhap AND MatKhau = :MatKhau", TaiKhoan.class)
                    .setParameter("TenDangNhap", TenDangNhap)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByTenDangNhapAndMatKhauAndRolesOfRegular(String TenDangNhap, String MatKhau) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.tenDangNhap = :TenDangNhap " +
                    "AND tk.matKhau = :MatKhau " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.tenDangNhap = :TenDangNhap " +
                    "    AND tk2.matKhau = :MatKhau " +
                    "    AND (vt2.maVaiTro = 'S' OR vt2.maVaiTro = 'L')" +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("TenDangNhap", TenDangNhap)
                    .setParameter("MatKhau", MatKhau)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByTenDangNhapAndMatKhauAndRolesOfManager(String TenDangNhap, String MatKhau) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.tenDangNhap = :TenDangNhap " +
                    "AND tk.matKhau = :MatKhau " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.tenDangNhap = :TenDangNhap " +
                    "    AND tk2.matKhau = :MatKhau " +
                    "    AND (vt2.maVaiTro = 'MM' OR vt2.maVaiTro = 'MB' OR vt2.maVaiTro = 'MDB' OR vt2.maVaiTro = 'A')" +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("TenDangNhap", TenDangNhap)
                    .setParameter("MatKhau", MatKhau)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByTenDangNhapAndMatKhauAndRolesOfAdmin(String TenDangNhap, String MatKhau) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.tenDangNhap = :TenDangNhap " +
                    "AND tk.matKhau = :MatKhau " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.tenDangNhap = :TenDangNhap " +
                    "    AND tk2.matKhau = :MatKhau " +
                    "    AND (vt2.maVaiTro = 'A')" +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("TenDangNhap", TenDangNhap)
                    .setParameter("MatKhau", MatKhau)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByIdTaiKhoanAndRolesOfRegular(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.idTaiKhoan = :IdTaiKhoan " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.idTaiKhoan = :IdTaiKhoan " +
                    "    AND (vt2.maVaiTro = 'S' OR vt2.maVaiTro = 'L')" +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByIdTaiKhoanAndRolesOfManager(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.idTaiKhoan = :IdTaiKhoan " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.idTaiKhoan = :IdTaiKhoan " +
                    "    AND (vt2.maVaiTro = 'MM' OR vt2.maVaiTro = 'MB' OR vt2.maVaiTro = 'MDB' OR vt2.maVaiTro = 'A')"
                    +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan getByIdTaiKhoanAndRolesOfAdmin(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT tk " +
                    "FROM TaiKhoan tk " +
                    "INNER JOIN tk.vaiTros vt " +
                    "WHERE tk.idTaiKhoan = :IdTaiKhoan " +
                    "AND tk._DeleteAt IS NULL " +
                    "AND tk._IsInactive = 0 " +
                    "AND vt.maVaiTro = 'U' " +
                    "AND EXISTS (" +
                    "    SELECT 1 FROM TaiKhoan tk2 " +
                    "    INNER JOIN tk.vaiTros vt2 " +
                    "    WHERE tk2.idTaiKhoan = :IdTaiKhoan " +
                    "    AND (vt2.maVaiTro = 'A')" +
                    ")";

            return session.createQuery(hql, TaiKhoan.class)
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
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