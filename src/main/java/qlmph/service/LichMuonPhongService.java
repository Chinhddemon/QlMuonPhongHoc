package qlmph.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;
import qlmph.utils.Converter;

@Service
public class LichMuonPhongService {

    @Autowired
    LichMuonPhongRepository lichMuonPhongRepository;

    public List<LichMuonPhong> layDanhSach() {
        return lichMuonPhongRepository.getAll();
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(List<Command> Commands,
            String ThoiGian_BD, String ThoiGian_KT,
            String TrangThai, String MucDich,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH) {

        Date thoiGian_BD = null;
        Date thoiGian_KT = null;
        String trangThai = null;
        String mucDich = null;
        int idLHP = 0;
        String maGVGiangDay = null;
        String maNgMPH = null;

        // Các lệnh sắp xếp được sử dụng trên view:
        // Cho người mượn phòng:
        // Theo giảng viên giảng dạy - trang 1
        // Theo môn học - trang 1
        // Theo lớp giảng dạy - trang 1
        // Theo phòng học - trang 1
        // Theo thời gian lịch mượn phòng - trang 1
        // Cho quản lý:
        // Theo mục đích mượn phòng - trang 1
        // Theo trạng thái mượn phòng - trang 1
        // Theo thời gian mượn phòng - trang 2
        // Theo quản lý duyệt cho mượn phòng - trang 2
        // Theo người mượn phòng - trang 2
        // Theo quản lý tạo lịch mượn phòng - trang 2

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(Command.TheoThoiGianLichMuonPhong)) {
            thoiGian_BD = Converter.StringToDateTime(ThoiGian_BD); // Theo thời gian bắt đầu lịch mượn phòng
            thoiGian_KT = Converter.StringToDateTime(ThoiGian_KT); // Theo thời gian kết thúc lịch mượn phòng

        }
        if (Commands.contains(Command.TheoTrangThai)) {
            trangThai = TrangThai; // Theo trạng thái mượn phòng

        }
        if (Commands.contains(Command.TheoMucDich)) {
            mucDich = MucDich; // Theo mục đích mượn phòng

        }
        if (Commands.contains(Command.TheoIdLHP)) {
            idLHP = IdLHP; // Theo id lớp học phần

        }
        if (Commands.contains(Command.TheoGiangVienGiangDay)) {
            maGVGiangDay = MaGVGiangDay; // Theo mã giảng viên giảng dạy

        }
        if (Commands.contains(Command.TheoNguoiMuonPhong)) {
            maNgMPH = MaNgMPH; // Theo mã người mượn phòng

        }
        return lichMuonPhongRepository.getListByCondition(thoiGian_BD, thoiGian_KT, trangThai, mucDich, idLHP,
                maGVGiangDay, maNgMPH);

    }

    public LichMuonPhong layThongTin(int IdLichMPH) {
        return lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
    }

    public LichMuonPhong luuThongTin(LichMuonPhong lichMuonPhong) {
        if (!lichMuonPhongRepository.existsRecord(lichMuonPhong.getIdLMPH())
                && lichMuonPhongRepository.post(lichMuonPhong)) {
            return lichMuonPhong;
        }
        return null;
    }

    public enum Command {
        TheoThoiGianLichMuonPhong,
        TheoTrangThai,
        TheoMucDich,
        TheoIdLHP,
        TheoGiangVienGiangDay,
        TheoNguoiMuonPhong
    }
}
