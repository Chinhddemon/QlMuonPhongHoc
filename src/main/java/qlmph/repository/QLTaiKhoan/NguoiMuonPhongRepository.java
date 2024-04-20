package qlmph.repository.QLTaiKhoan;

import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.NguoiMuonPhong;

@Repository
@Transactional
public class NguoiMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public NguoiMuonPhong getByMaNgMPH(String MaNgMPH) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(NguoiMuonPhong.class, MaNgMPH);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public NguoiMuonPhong getByIdTaiKhoan(UUID IdTaiKhoan) {
        try (Session session = sessionFactory.openSession()) {
            return (NguoiMuonPhong) session
                    .createQuery("FROM NguoiMuonPhong WHERE IdTaiKhoan = :IdTaiKhoan")
                    .setParameter("IdTaiKhoan", IdTaiKhoan)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
