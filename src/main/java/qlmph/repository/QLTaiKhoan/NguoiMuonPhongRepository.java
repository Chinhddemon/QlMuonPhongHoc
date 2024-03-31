package qlmph.repository.QLTaiKhoan;

import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;

@Repository
@Transactional
public class NguoiMuonPhongRepository {
    
    @Autowired
    private SessionFactory sessionFactory;

    public NguoiMuonPhong getByMaNgMPH(String MaNgMPH) {
        NguoiMuonPhong nguoiMuonPhong = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();	
            nguoiMuonPhong = (NguoiMuonPhong) session.createQuery("FROM NguoiMuonPhong WHERE MaNgMPH = :MaNgMPH")
                            .setParameter("MaNgMPH", MaNgMPH)
                            .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nguoiMuonPhong;
    }

    public NguoiMuonPhong getByIdTaiKhoan(UUID IdTaiKhoan) {
        NguoiMuonPhong nguoiMuonPhong = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();	
            nguoiMuonPhong = (NguoiMuonPhong) session.createQuery("FROM NguoiMuonPhong WHERE IdTaiKhoan = :IdTaiKhoan")
                            .setParameter("IdTaiKhoan", IdTaiKhoan)
                            .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return nguoiMuonPhong;
    }

}
