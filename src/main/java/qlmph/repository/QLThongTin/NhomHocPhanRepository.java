package qlmph.repository.QLThongTin;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.NhomHocPhan;

@Repository
@Transactional
public class NhomHocPhanRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<NhomHocPhan> getAll() {
        List<NhomHocPhan> nhomHocPhans = null;
        Session session = null;
        try {

            session = sessionFactory.openSession();
            nhomHocPhans = (List<NhomHocPhan>) session.createQuery("FROM NhomHocPhan")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nhomHocPhans;
    }

    public NhomHocPhan getByIdLHP(int IdNHP) {

        NhomHocPhan nhomHocPhans = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            nhomHocPhans = (NhomHocPhan) session.get(NhomHocPhan.class, IdNHP);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nhomHocPhans;
    }

    public boolean update(NhomHocPhan nhomHocPhan) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(nhomHocPhan);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

//     CREATE PROCEDURE InsertNhomHocPhanAndLopHocPhanSections
//     @MaMH VARCHAR(15),
//     @MaLopSV VARCHAR(15),
//     @MaQLKhoiTao VARCHAR(15),
//     @Nhom TINYINT,
//     @LopHocPhanSections dbo.LopHocPhanSectionParameter READONLY
// AS
// BEGIN
//     SET NOCOUNT ON;

//     -- Insert into NhomHocPhan
//     INSERT INTO NhomHocPhan (MaMH, MaLopSV, MaQLKhoiTao, Nhom)
//     VALUES (@MaMH, @MaLopSV, @MaQLKhoiTao, @Nhom);

//     -- Get the inserted IdNHP
//     DECLARE @IdNHP INT;
//     SET @IdNHP = SCOPE_IDENTITY();

//     -- Insert into LopHocPhanSection for each row in the table parameter
//     INSERT INTO LopHocPhanSection (IdNHP, MaGVGiangDay, NhomTo, Ngay_BD, Ngay_KT, MucDich)
//     SELECT @IdNHP, MaGVGiangDay, NhomTo, Ngay_BD, Ngay_KT, MucDich
//     FROM @LopHocPhanSections;
// END
    // public boolean updateLopHocPhan(NhomHocPhan nhomHocPhan) {
    //     Session session = null;
    //     try {
    //         StoredProcedureQuery spQuery = entityManager.createNamedStoredProcedureQuery("UpdateNhomHocPhanAndLopHocPhanSections");
    //         spQuery.setParameter("MaMH", nhomHocPhan.getMonHoc().getMaMH());
    //         spQuery.setParameter("MaLopSV", nhomHocPhan.getLopSV().getMaLopSV());
    //         spQuery.setParameter("MaQLKhoiTao", nhomHocPhan.getQuanLyKhoiTao().getMaQL());
    //         spQuery.setParameter("Nhom", nhomHocPhan.getNhom());
    //         spQuery.setParameter("LopHocPhanSections", nhomHocPhan.getLopHocPhanSections());
    //         session = sessionFactory.openSession();
    //         session.beginTransaction();
    //         spQuery.execute();
    //         session.getTransaction().commit();
    //         return true;
    //     } catch (Exception e) {
    //         e.printStackTrace();
    //         session.getTransaction().rollback();
    //         return false;
    //     } finally {
    //         if (session != null) {
    //             session.close();
    //         }
    //     }
    // }
}
