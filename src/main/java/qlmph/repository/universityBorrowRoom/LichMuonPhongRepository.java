package qlmph.repository.universityBorrowRoom;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.type.LocalDateTimeType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityBorrowRoom.MuonPhongHoc;
import qlmph.service.universityBorrowRoom.LichMuonPhongService.GetCommand;
import qlmph.utils.ValidateObject;

@Repository
@Transactional
public class LichMuonPhongRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getAll() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM LichMuonPhong WHERE _DeleteAt IS NULL").list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<LichMuonPhong> getInCurrentDateTime() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery(
                    "FROM LichMuonPhong WHERE startDatetime <= :currentDateTime AND endDatetime >= :currentDateTime AND _DeleteAt IS NULL",
                    LichMuonPhong.class)
                    .setParameter("currentDateTime", LocalDateTime.now())
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<LichMuonPhong> getListByCondition(Set<GetCommand> Commands,
            LocalDateTime startDatetime, LocalDateTime endDatetime,
            int idHocKy_LopSinhVien,
            String maGiangVienGiangDay,
            String idTaiKhoan,
            String maPhongHoc,
            String maHocKy) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT lmp FROM LichMuonPhong lmp ";
            if (Commands.contains(GetCommand.TheoNguoiDung)) {
                List<LichMuonPhong> list = new ArrayList<>();
                hql += "LEFT JOIN lmp.muonPhongHoc mph " +
                        "INNER JOIN lmp.nhomToHocPhan nthp " +
                        "INNER JOIN nthp.giangVienGiangDay gv " +
                        "WHERE lmp._DeleteAt IS NULL AND " +
                        "mph IS NOT NULL AND mph._ReturnAt IS NULL AND " +
                        "nthp._DeleteAt IS NULL AND " +
                        "lmp.endDatetime >= :startDatetime AND lmp.startDatetime <= :endDatetime AND " +
                        "gv.idTaiKhoan = :idTaiKhoan ";
                list.addAll(session.createQuery(hql, LichMuonPhong.class)
                        .setParameter("idTaiKhoan", idTaiKhoan)
                        .setParameter("startDatetime", startDatetime, LocalDateTimeType.INSTANCE)
                        .setParameter("endDatetime", endDatetime, LocalDateTimeType.INSTANCE)
                        .list());
                hql = "SELECT lmp FROM LichMuonPhong lmp " +
                        "LEFT JOIN lmp.muonPhongHoc mph " +
                        "INNER JOIN lmp.nhomToHocPhan nthp " +
                        "INNER JOIN nthp.nhomHocPhan nhp " +
                        "INNER JOIN nhp.sinhViens sv " +
                        "WHERE lmp._DeleteAt IS NULL AND " +
                        "mph IS NOT NULL AND mph._ReturnAt IS NULL AND " +
                        "nthp._DeleteAt IS NULL AND " +
                        "nhp._DeleteAt IS NULL AND " +
                        "lmp.endDatetime >= :startDatetime AND lmp.startDatetime <= :endDatetime AND " +
                        "sv.idTaiKhoan = :idTaiKhoan ";
                list.addAll(session.createQuery(hql, LichMuonPhong.class)
                        .setParameter("idTaiKhoan", idTaiKhoan)
                        .setParameter("startDatetime", startDatetime, LocalDateTimeType.INSTANCE)
                        .setParameter("endDatetime", endDatetime, LocalDateTimeType.INSTANCE)
                        .list());
                return list;
            }
            if (Commands.contains(GetCommand.TheoTrangThai_ChuaTraPhong)
                    || Commands.contains(GetCommand.TheoTrangThai_ChuaMuonPhong)
                    || ValidateObject.isNotNullOrEmpty(idTaiKhoan)) {
                hql += "LEFT JOIN lmp.muonPhongHoc mph ";
            }
            if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
                hql += "INNER JOIN lmp.nhomToHocPhan nthp ";
                if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
                    hql += "INNER JOIN nthp.nhomHocPhan nhp ";
                    if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
                        hql += "INNER JOIN nhp.hocKy_LopSinhVien hklsv ";
                    }
                }
            }

            hql += "WHERE lmp._DeleteAt IS NULL AND  ";
            if (ValidateObject.allNotNullOrEmpty(startDatetime, endDatetime)) {
                hql += "lmp.endDatetime >= :startDatetime AND lmp.startDatetime <= :endDatetime AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(maPhongHoc)) {
                hql += "lmp.maPhongHoc = :maPhongHoc AND  ";
            }
            if (Commands.contains(GetCommand.TheoTrangThai_ChuaTraPhong)) {
                hql += "mph IS NOT NULL AND mph._ReturnAt IS NULL AND  ";
            } else if (Commands.contains(GetCommand.TheoTrangThai_ChuaMuonPhong)) {
                hql += "mph IS NULL AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(idTaiKhoan)) {
                hql += "mph.nguoiMuonPhong.idTaiKhoan = :idTaiKhoan AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(maGiangVienGiangDay)) {
                hql += "nthp.maGiangVienGiangDay = :maGiangVienGiangDay AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(idHocKy_LopSinhVien)) {
                hql += "hklsv.idHocKy_LopSinhVien = :idHocKy_LopSinhVien AND  ";
            }
            if (ValidateObject.isNotNullOrEmpty(maHocKy)) {
                hql += "hklsv.maHocKy = :maHocKy AND  ";
            }
            hql = hql.substring(0, hql.length() - 6);

            @SuppressWarnings("rawtypes")
            Query query = (Query) session.createQuery(hql, LichMuonPhong.class);
            if (ValidateObject.allNotNullOrEmpty(startDatetime, endDatetime)) {
                query.setParameter("startDatetime", startDatetime, LocalDateTimeType.INSTANCE);
                query.setParameter("endDatetime", endDatetime, LocalDateTimeType.INSTANCE);
            }
            if (ValidateObject.isNotNullOrEmpty(idHocKy_LopSinhVien)) {
                query.setParameter("idHocKy_LopSinhVien", idHocKy_LopSinhVien);
            }
            if (ValidateObject.isNotNullOrEmpty(maGiangVienGiangDay)) {
                query.setParameter("maGiangVienGiangDay", maGiangVienGiangDay);
            }
            if (ValidateObject.isNotNullOrEmpty(maPhongHoc)) {
                query.setParameter("maPhongHoc", maPhongHoc);
            }
            if (ValidateObject.isNotNullOrEmpty(maHocKy)) {
                query.setParameter("maHocKy", maHocKy);
            }
            if (query.list().size() == 0 || query.list().get(0) instanceof LichMuonPhong) {
                return query.list();
            }
            throw new Exception("Không thể lấy danh sách.");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LichMuonPhong getByIdLichMuonPhong(int IdLichMuonPhong) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM LichMuonPhong WHERE idLichMuonPhong = :IdLichMuonPhong AND _DeleteAt IS NULL";
            return session.createQuery(hql, LichMuonPhong.class)
                    .setParameter("IdLichMuonPhong", IdLichMuonPhong)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public LichMuonPhong save(LichMuonPhong lichMuonPhong) {
        try (Session session = sessionFactory.openSession()) {
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
            muonPhongHoc.setIdLichMuonPhong(lichMuonPhong.getIdLichMuonPhong());
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
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.update(lichMuonPhong);
            session.getTransaction().commit();
            return lichMuonPhong;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean delete(LichMuonPhong lichMuonPhong) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.delete(lichMuonPhong);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
