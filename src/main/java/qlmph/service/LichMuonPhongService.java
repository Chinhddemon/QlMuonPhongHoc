package qlmph.service;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LichMuonPhong;
import qlmph.model.QuanLy;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;
import qlmph.utils.Converter;
import qlmph.utils.ValidateObject;

@Service
public class LichMuonPhongService {

    @Autowired
    LichMuonPhongRepository lichMuonPhongRepository;

    @Autowired
    PhongHocService phongHocService;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    // MARK: MultiBasicTasks

    public List<LichMuonPhong> layDanhSach() {
        List<LichMuonPhong> lichMuonPhongs = lichMuonPhongRepository.getAll();
        if(lichMuonPhongs == null) {
            new Exception("Không tìm thấy danh sách lịch mượn phòng.").printStackTrace();
        }
        return lichMuonPhongs;
    }

    // MARK: MultiDynamicTasks

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands,
            String ThoiGian_BD, String ThoiGian_KT,
            String IdLHP,
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
        // Theo hình thức mượn phòng - trang 1
        // Theo thời gian mượn phòng - trang 2
        // Theo quản lý duyệt cho mượn phòng - trang 2
        // Theo người mượn phòng - trang 2
        // Theo quản lý tạo lịch mượn phòng - trang 2

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(GetCommand.TheoThoiGian_LichMuonPhong) && ValidateObject.exsistNullOrEmpty(ThoiGian_BD, ThoiGian_KT)) {
            new Exception("Thời gian không được để trống.").printStackTrace();
            return null;
        }

        if (Commands.contains(GetCommand.TheoId_LopHocPhan) && ValidateObject.isNullOrEmpty(IdLHP)) {
            new Exception("Id lớp học phần không được để trống.").printStackTrace();
            return null;
        }
        if (Commands.contains(GetCommand.TheoMa_GiangVienGiangDay) && ValidateObject.isNullOrEmpty(MaGVGiangDay)) {
            new Exception("Mã giảng viên giảng dạy không được để trống.").printStackTrace();
            return null;
        }
        if (Commands.contains(GetCommand.TheoMa_NguoiMuonPhong) && ValidateObject.isNullOrEmpty(MaNgMPH)) {
            new Exception("Mã người mượn phòng không được để trống.").printStackTrace();
            return null;
        }

        return lichMuonPhongRepository.getListByCondition(Commands,
                Converter.stringToLocalDateTime(ThoiGian_BD),
                Converter.stringToLocalDateTime(ThoiGian_KT),
                Integer.parseInt(IdLHP),
                MaGVGiangDay,
                MaNgMPH);
    }

    // MARK: SingleBasicTasks

    public LichMuonPhong layThongTin(int IdLichMPH) {
        if(IdLichMPH == 0) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
        }
        LichMuonPhong lichMuonPhong = lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
        if (lichMuonPhong == null) {
            new Exception("Không tìm thấy thông tin.").printStackTrace();
            return null;
        }
        return lichMuonPhong;
    }

    public LichMuonPhong luuThongTin(LichMuonPhong lichMuonPhong) {
        lichMuonPhong = lichMuonPhongRepository.save(lichMuonPhong);
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin").printStackTrace();
            return null;
        }
        return lichMuonPhong;
    }

    public LichMuonPhong capNhatThongTin(LichMuonPhong lichMuonPhong) {
        lichMuonPhong = lichMuonPhongRepository.update(lichMuonPhong);
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể cập nhật thông tin.").printStackTrace();
            return null;
        }
        return lichMuonPhong;
    }

    // MARK: SingleDynamicTasks

    public LichMuonPhong luuThongTin(String IdLHPSection, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_BD,
            String ThoiGian_KT) {
        LichMuonPhong lichMuonPhong = taoThongTin(IdLHPSection, IdPH, QuanLyKhoiTao, ThoiGian_BD, ThoiGian_KT);
        if(ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return luuThongTin(lichMuonPhong);
    }

    
    public LichMuonPhong capNhatThongTin(String IdLMPH, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_BD,
            String ThoiGian_KT, String LyDo) {
        LichMuonPhong lichMuonPhong = layThongTin(Integer.parseInt(IdLMPH));
        lichMuonPhong.setPhongHoc(phongHocService.layThongTin(IdPH));
        lichMuonPhong.setQuanLyKhoiTao(QuanLyKhoiTao);
        lichMuonPhong.setThoiGian_BD(Converter.stringToDatetime(ThoiGian_BD));
        lichMuonPhong.setThoiGian_KT(Converter.stringToDatetime(ThoiGian_KT));
        lichMuonPhong.setLyDo(LyDo);
        return capNhatThongTin(lichMuonPhong);
    }

    // MARK: SingleUtilTasks

    protected LichMuonPhong taoThongTin(String IdLHPSection, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_BD,
            String ThoiGian_KT) {
        if(ValidateObject.allNotNullOrEmpty(IdLHPSection, IdPH, QuanLyKhoiTao, ThoiGian_BD, ThoiGian_KT) == false) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                lopHocPhanSectionService.layThongTin(Integer.parseInt(IdLHPSection)),
                phongHocService.layThongTin(IdPH),
                QuanLyKhoiTao,
                Converter.stringToDatetime(ThoiGian_BD),
                Converter.stringToDatetime(ThoiGian_KT));
        return lichMuonPhong;
    }

    // MARK: ENUM

    public enum GetCommand {
        TheoThoiGian_LichMuonPhong,
        TheoTrangThai_ChuaMuonPhong,
        TheoTrangThai_QuaHan,
        TheoTrangThai_DaMuonPhong,
        TheoTrangThai_ChuaTraPhong,
        TheoTrangThai_DaHuy,
        TheoId_LopHocPhan,
        TheoMa_GiangVienGiangDay,
        TheoMa_MonHoc,
        TheoMa_LopGiangDay,
        TheoMa_PhongHoc,
        TheoMa_NguoiMuonPhong,
        TheoMa_QuanLyDuyetMuonPhong,
        TheoMa_QuanLyTaoLichMuonPhong
    }
}
