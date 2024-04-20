package qlmph.repository.QLThongTin;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.LichMuonPhong;
import qlmph.service.LichMuonPhongService.GetCommand;

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
    public List<LichMuonPhong> getListByCondition(Set<GetCommand> Commands,
            LocalDateTime ThoiGian_BD, LocalDateTime ThoiGian_KT,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH) {
        try (Session session = sessionFactory.openSession()){
            String query = "FROM LichMuonPhong WHERE ";
            if (Commands.contains(GetCommand.TheoThoiGian_LichMuonPhong)) {
                query += "ThoiGian_BD >= :ThoiGian_BD AND ThoiGian_KT <= :ThoiGian_KT AND ";
            }
            if (Commands.contains(GetCommand.TheoId_LopHocPhan)) {
                query += "IdLHP = :IdLHP AND ";
            }
            if (Commands.contains(GetCommand.TheoMa_GiangVienGiangDay)) {
                query += "MaGVGiangDay = :MaGVGiangDay AND ";
            }
            if (Commands.contains(GetCommand.TheoMa_NguoiMuonPhong)) {
                query += "MaNgMPH = :MaNgMPH AND ";
            }
            query = query.substring(0, query.length() - 5);
            return session.createQuery(query)
                    .setParameter("ThoiGian_BD", ThoiGian_BD)
                    .setParameter("ThoiGian_KT", ThoiGian_KT)
                    .setParameter("IdLHP", IdLHP)
                    .setParameter("MaGVGiangDay", MaGVGiangDay)
                    .setParameter("MaNgMPH", MaNgMPH)
                    .list();
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
