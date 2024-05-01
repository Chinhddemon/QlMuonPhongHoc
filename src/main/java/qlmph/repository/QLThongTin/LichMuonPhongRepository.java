package qlmph.repository.QLThongTin;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.LichMuonPhong;
import qlmph.model.MuonPhongHoc;
import qlmph.service.LichMuonPhongService.GetCommand;
import qlmph.utils.ValidateObject;

@Repository
@Transactional
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getAll() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM LichMuonPhong").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getInCurrentDateTime() {
        try (Session session = sessionFactory.openSession()){
            return session.createQuery("FROM LichMuonPhong WHERE ThoiGian_BD <= :currentDateTime AND ThoiGian_KT >= :currentDateTime")
                    .setParameter("currentDateTime", LocalDateTime.now())
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getListByCondition(Set<GetCommand> Commands,
            LocalDateTime ThoiGian_BD, LocalDateTime ThoiGian_KT,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH,
            String MaPhongHoc,
            String MaHocKy) {
        try (Session session = sessionFactory.openSession()){
            String hql = "SELECT lmp FROM LichMuonPhong lmp ";
            if (Commands.contains(GetCommand.TheoTrangThai_ChuaTraPhong)
                || Commands.contains(GetCommand.TheoTrangThai_ChuaMuonPhong)
                || ValidateObject.isNotNullOrEmpty(MaNgMPH)) {
                hql += "LEFT JOIN MuonPhongHoc mph ON lmp.idLMPH = mph.idLMPH ";
            }

            hql += "WHERE ";
            
            if (Commands.contains(GetCommand.TheoTrangThai_ChuaTraPhong)) {
                hql += "mph.thoiGian_MPH IS NOT NULL AND mph.thoiGian_TPH IS NULL AND  ";
            }
            else if (Commands.contains(GetCommand.TheoTrangThai_ChuaMuonPhong)) {
                hql += "mph IS NULL AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(MaNgMPH)) {
                hql += "mph.nguoiMuonPhong.maNgMPH = :MaNgMPH AND  ";
            }

            if (ValidateObject.allNotNullOrEmpty(ThoiGian_BD, ThoiGian_KT)) {
                hql += "ThoiGian_BD >= :ThoiGian_BD AND ThoiGian_KT <= :ThoiGian_KT AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(IdLHP)) {
                hql += "IdLHP = :IdLHP AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(MaGVGiangDay)) {
                hql += "MaGVGiangDay = :MaGVGiangDay AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(MaPhongHoc)) {
                hql += "MaPhongHoc = :MaPhongHoc AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(MaHocKy)) {
                hql += "MaHocKy = :MaHocKy AND  ";
            }
            hql = hql.substring(0, hql.length() - 6);

            @SuppressWarnings("rawtypes")
            Query query = (Query) session.createQuery(hql);
            if (ValidateObject.allNotNullOrEmpty(ThoiGian_BD, ThoiGian_KT)) {
                query.setParameter("ThoiGian_BD", ThoiGian_BD);
                query.setParameter("ThoiGian_KT", ThoiGian_KT);
            }
            if (ValidateObject.isNotNullOrEmpty(IdLHP)) {
                query.setParameter("IdLHP", IdLHP);
            }
            if (ValidateObject.isNotNullOrEmpty(MaGVGiangDay)) {
                query.setParameter("MaGVGiangDay", MaGVGiangDay);
            }
            if (ValidateObject.isNotNullOrEmpty(MaNgMPH)) {
                query.setParameter("MaNgMPH", MaNgMPH);
            }
            if (ValidateObject.isNotNullOrEmpty(MaPhongHoc)) {
                query.setParameter("MaPhongHoc", MaPhongHoc);
            }
            if (ValidateObject.isNotNullOrEmpty(MaHocKy)) {
                query.setParameter("MaHocKy", MaHocKy);
            }
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LichMuonPhong getByIdLMPH(int IdLMPH) {
        try (Session session = sessionFactory.openSession()){
            return session.get(LichMuonPhong.class, IdLMPH);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LichMuonPhong save(LichMuonPhong lichMuonPhong) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.save(lichMuonPhong);
            session.getTransaction().commit();
            return lichMuonPhong;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LichMuonPhong saveDoiPhongHoc(LichMuonPhong lichMuonPhong) {
        Session session = sessionFactory.openSession();
        Transaction transaction1 = null;
        Transaction transaction2 = null;
        try {
            transaction1 = session.beginTransaction();
            session.save(lichMuonPhong);
            transaction1.commit();

            transaction2 = session.beginTransaction();
            MuonPhongHoc muonPhongHoc = lichMuonPhong.getMuonPhongHoc();
            muonPhongHoc.setIdLMPH(lichMuonPhong.getIdLMPH());
            session.save(muonPhongHoc);
            transaction2.commit();
            
            return lichMuonPhong;
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction2 != null) {
                transaction2.rollback(); // Rollback giao dịch thứ 2 nếu có ngoại lệ
            }
            if (transaction1 != null) {
                transaction1.rollback(); // Rollback giao dịch thứ 1 nếu có ngoại lệ
            }
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public LichMuonPhong update(LichMuonPhong lichMuonPhong) {
        try (Session session = sessionFactory.openSession()){
            session.beginTransaction();
            session.update(lichMuonPhong);
            session.getTransaction().commit();
            return lichMuonPhong;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
