package qlmph.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LichMuonPhong;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.QuanLy;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;
import qlmph.utils.Converter;
import qlmph.utils.ValidateObject;

@Service
public class LichMuonPhongService {

    @Autowired
    private LichMuonPhongRepository lichMuonPhongRepository;

    @Autowired
    private PhongHocService phongHocService;

    @Autowired
    private LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    private MuonPhongHocService muonPhongHocService;

    // MARK: MultiBasicTasks

    public List<LichMuonPhong> layDanhSach() {
        List<LichMuonPhong> lichMuonPhongs = lichMuonPhongRepository.getAll();
        if (lichMuonPhongs == null) {
            new Exception("Không tìm thấy danh sách lịch mượn phòng.").printStackTrace();
        }
        return lichMuonPhongs;
    }

    // MARK: MultiDynamicTasks

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

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands) {

        LocalDateTime ThoiGian_BD = null;
        LocalDateTime ThoiGian_KT = null;
        String MaHocKy = null;

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(GetCommand.MacDinh_TheoNgay)) {
            ThoiGian_BD = LocalDateTime.of(LocalDate.now(), LocalTime.MIDNIGHT);
            ThoiGian_KT = ThoiGian_BD.plusDays(3).with(LocalTime.MAX);
        }
        if (Commands.contains(GetCommand.MacDinh_TheoHocKy) && ValidateObject.isNullOrEmpty(MaHocKy)) {
            new Exception("Mã học kỳ không được để trống.").printStackTrace();
            return null;
        }

        return lichMuonPhongRepository.getListByCondition(Commands,
                ThoiGian_BD,
                ThoiGian_KT,
                0,
                null,
                null,
                null,
                MaHocKy);
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands,
            String ThoiGian_BD, String ThoiGian_KT,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH,
            String MaPhongHoc,
            String MaHocKy) {

        LocalDateTime thoiGian_BD = Converter.stringToLocalDateTime(ThoiGian_BD);
        LocalDateTime thoiGian_KT = Converter.stringToLocalDateTime(ThoiGian_KT);

        return lichMuonPhongRepository.getListByCondition(Commands,
                thoiGian_BD,
                thoiGian_KT,
                IdLHP,
                MaGVGiangDay,
                MaNgMPH,
                MaPhongHoc,
                MaHocKy);
    }

    public LichMuonPhong luuThongTinDoiPhongHoc(String IdLHPSection, int IdPH, QuanLy QuanLyDuyet, String ThoiGian_KT,
            String LyDo, NguoiMuonPhong NguoiMuonPhong, String YeuCau) {
        LichMuonPhong lichMuonPhong = taoThongTin(IdLHPSection, IdPH, QuanLyDuyet, ThoiGian_KT);
        lichMuonPhong.setMuonPhongHoc(muonPhongHocService.taoThongTin(NguoiMuonPhong, QuanLyDuyet, YeuCau));
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return lichMuonPhongRepository.saveDoiPhongHoc(lichMuonPhong);
    }

    // MARK: SingleBasicTasks

    public LichMuonPhong layThongTin(int IdLichMPH) {
        if (IdLichMPH == 0) {
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
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
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
        if (ValidateObject.exsistNullOrEmpty(IdLHPSection, IdPH, QuanLyKhoiTao, ThoiGian_BD, ThoiGian_KT)) {
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

    protected LichMuonPhong taoThongTin(String IdLHPSection, int IdPH, QuanLy QuanLyKhoiTao, String ThoiGian_KT) {
        if (ValidateObject.exsistNullOrEmpty(IdLHPSection, IdPH, QuanLyKhoiTao, ThoiGian_KT)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                lopHocPhanSectionService.layThongTin(Integer.parseInt(IdLHPSection)),
                phongHocService.layThongTin(IdPH),
                QuanLyKhoiTao,
                new Date(),
                Converter.stringToDatetime(ThoiGian_KT));
        return lichMuonPhong;
    }

    // MARK: ENUM

    public enum GetCommand {
        MacDinh_TheoNgay,
        MacDinh_TheoHocKy,
        TheoHocKy,
        TheoTrangThai_ChuaMuonPhong,
        TheoTrangThai_QuaHan,
        TheoTrangThai_DaMuonPhong,
        TheoTrangThai_ChuaTraPhong,
        TheoTrangThai_DaHuy,
        TheoLopHocPhan,
        TheoGiangVienGiangDay,
        TheoMonHoc,
        TheoLopGiangDay,
        TheoPhongHoc,
        TheoNguoiMuonPhong,
        TheoQuanLyDuyetMuonPhong,
        TheoQuanLyTaoLichMuonPhong
    }
}
