package qlmph.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;
import qlmph.utils.Converter;

@Service
public class LichMuonPhongService {

    @Autowired
    LichMuonPhongRepository lichMuonPhongRepository;

    @Autowired
    PhongHocService phongHocService;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    public List<LichMuonPhong> layDanhSach() {
        return lichMuonPhongRepository.getAll();
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(List<GetCommand> Commands,
            Date ThoiGian_BD, Date ThoiGian_KT,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH) {

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
        if (Commands.contains(GetCommand.TheoThoiGian_LichMuonPhong)) {
            if (ThoiGian_BD == null)
                return null; // Thời gian bắt đầu không được để trống
        }

        if (Commands.contains(GetCommand.TheoId_LopHocPhan)) {
            if (IdLHP == 0)
                return null; // Id lớp học phần không được để trống

        }
        if (Commands.contains(GetCommand.TheoMa_GiangVienGiangDay)) {
            if (MaGVGiangDay == null)
                return null; // Mã giảng viên giảng dạy không được để trống

        }
        if (Commands.contains(GetCommand.TheoMa_NguoiMuonPhong)) {
            if (MaNgMPH == null)
                return null; // Mã người mượn phòng không được để trống

        }
        return lichMuonPhongRepository.getListByCondition(Commands,
                ThoiGian_BD,
                ThoiGian_KT,
                IdLHP,
                MaGVGiangDay,
                MaNgMPH);
    }

    public LichMuonPhong layThongTin(int IdLichMPH) {
        LichMuonPhong lichMuonPhong = lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
        if (lichMuonPhong == null) {
            new Exception("Không tìm thấy thông tin lịch mượn phòng.").printStackTrace();
            return null;
        }
        return lichMuonPhong;
    }

    public enum GetCommand {
        TheoThoiGian_LichMuonPhong,
        TheoTrangThai_ChuaMuonPhong,
        TheoTrangThai_DaMuonPhong,
        TheoTrangThai_ChuaTraPhong,
        TheoTrangThai_DaHuy,
        TheoMucDich_LyThuyet,
        TheoMucDich_ThucHanh,
        TheoMucDich_Khac,
        TheoId_LopHocPhan,
        TheoMa_GiangVienGiangDay,
        TheoMa_NguoiMuonPhong
    }

    public LichMuonPhong taoThongTin(LichMuonPhong lichMuonPhong) {
        if (lichMuonPhongRepository.save(lichMuonPhong)) {
            return lichMuonPhong;
        }
        return null;
    }

    public boolean taoThongTin(String IdLHPSection, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_BD,
            String ThoiGian_KT) {
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                lopHocPhanSectionService.layThongTin(Integer.parseInt(IdLHPSection)),
                phongHocService.layThongTin(IdPH),
                QuanLyKhoiTao,
                Converter.stringToDatetime(ThoiGian_BD),
                Converter.stringToDatetime(ThoiGian_KT));
        if (!lichMuonPhongRepository.save(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin mượn phòng học");
            return false;
        }
        return true;
    }

    public boolean capNhatThongTin(String IdLMPH, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_BD,
            String ThoiGian_KT, String LyDo) {
        LichMuonPhong lichMuonPhong = layThongTin(Integer.parseInt(IdLMPH));
        lichMuonPhong.setPhongHoc(phongHocService.layThongTin(IdPH));
        lichMuonPhong.setQuanLyKhoiTao(QuanLyKhoiTao);
        lichMuonPhong.setThoiGian_BD(Converter.stringToDatetime(ThoiGian_BD));
        lichMuonPhong.setThoiGian_KT(Converter.stringToDatetime(ThoiGian_KT));
        lichMuonPhong.setLyDo(LyDo);
        if (!lichMuonPhongRepository.update(lichMuonPhong)) {
            new Exception("Không thể cập nhật thông tin lịch mượn phòng.").printStackTrace();
            return false;
        }
        return true;
    }

}
