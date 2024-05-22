package qlmph.service.universityBorrowRoom;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.user.NguoiDung;
import qlmph.model.user.QuanLy;
import qlmph.repository.universityBorrowRoom.LichMuonPhongRepository;
import qlmph.service.universityBase.HocKyService;
import qlmph.service.universityBase.PhongHocService;
import qlmph.service.universityCourse.NhomToHocPhanService;
import qlmph.utils.Converter;
import qlmph.utils.ValidateObject;

@Service
public class LichMuonPhongService {

    @Autowired
    private LichMuonPhongRepository lichMuonPhongRepository;

    @Autowired
    private PhongHocService phongHocService;

    @Autowired
    private HocKyService hocKyService;

    @Autowired
    private NhomToHocPhanService nhomToHocPhanService;

    @Autowired
    private MuonPhongHocService muonPhongHocService;

    // MARK: BasicTasks

    public List<LichMuonPhong> layDanhSach() {
        List<LichMuonPhong> lichMuonPhongs = lichMuonPhongRepository.getAll();
        if (lichMuonPhongs == null) {
            new Exception("Không tìm thấy danh sách lịch mượn phòng.").printStackTrace();
            return null;
        }
        return lichMuonPhongs;
    }

    public LichMuonPhong layThongTin(String IdLichMuonPhong) {
        LichMuonPhong lichMuonPhong = lichMuonPhongRepository.getByIdLichMuonPhong(Integer.parseInt(IdLichMuonPhong));
        if (lichMuonPhong == null) {
            new Exception("Không tìm thấy thông tin: " + IdLichMuonPhong).printStackTrace();
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

    // MARK: DynamicTasks

    public List<LichMuonPhong> layDanhSachHienTai() {
        List<LichMuonPhong> lichMuonPhongs = lichMuonPhongRepository.getInCurrentDateTime();
        if (lichMuonPhongs == null) {
            new Exception("Không tìm thấy danh sách lịch mượn phòng.").printStackTrace();
            return null;
        }
        return lichMuonPhongs;
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands) {
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

        LocalDateTime StartAt = null;
        LocalDateTime EndAt = null;
        String MaHocKy = null;

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(GetCommand.MacDinh_TheoNgay)) {
            StartAt = LocalDateTime.of(LocalDate.now(), LocalTime.MIDNIGHT); // 00:00:00 hôm nay
            EndAt = StartAt.plusDays(3).with(LocalTime.MAX);// 23:59:59 3 ngày sau
        }
        if(Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
            MaHocKy = hocKyService.layHocKyHienTai();
            if(ValidateObject.isNullOrEmpty(MaHocKy)) {
                new Exception("Không tìm thấy học kỳ được thiết lập.").printStackTrace();
                return null;
            }
        }

        return lichMuonPhongRepository.getListByCondition(Commands,
                StartAt,
                EndAt,
                0,
                null,
                null,
                null,
                MaHocKy);
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands,
            String StartAt, String EndAt,
            int IdLHP,
            String MaGVGiangDay,
            String MaNgMPH,
            String MaPhongHoc,
            String MaHocKy) {

        LocalDateTime startAt = Converter.stringToLocalDateTime(StartAt);
        LocalDateTime endAt = Converter.stringToLocalDateTime(EndAt);

        return lichMuonPhongRepository.getListByCondition(Commands,
                startAt,
                endAt,
                IdLHP,
                MaGVGiangDay,
                MaNgMPH,
                MaPhongHoc,
                MaHocKy);
    }

    public LichMuonPhong luuThongTinDoiPhongHoc(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyDuyet, String EndAt,
            String LyDo, NguoiDung NguoiDung, String YeuCau) {
        LichMuonPhong lichMuonPhong = taoThongTin(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyDuyet, EndAt);
        lichMuonPhong.setMuonPhongHoc(muonPhongHocService.taoThongTin(NguoiDung, QuanLyDuyet, YeuCau));
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return lichMuonPhongRepository.saveDoiPhongHoc(lichMuonPhong);
    }

    public LichMuonPhong luuThongTin(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyKhoiTao, String StartAt,
            String EndAt) {
        LichMuonPhong lichMuonPhong = taoThongTin(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyKhoiTao, StartAt, EndAt);
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return luuThongTin(lichMuonPhong);
    }

    public LichMuonPhong capNhatThongTin(String IdLichMuonPhong, int IdPhongHoc, QuanLy QuanLyKhoiTao, String StartAt,
            String EndAt, String LyDo) {
        LichMuonPhong lichMuonPhong = layThongTin(IdLichMuonPhong);
        lichMuonPhong.setPhongHoc(phongHocService.layThongTin(IdPhongHoc));
        lichMuonPhong.setQuanLyKhoiTao(QuanLyKhoiTao);
        lichMuonPhong.setStartAt(Converter.stringToDatetime(StartAt));
        lichMuonPhong.setEndAt(Converter.stringToDatetime(EndAt));
        return capNhatThongTin(lichMuonPhong);
    }

    // MARK: UtilTasks

    protected LichMuonPhong taoThongTin(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyKhoiTao, String StartAt,
            String EndAt) {
        if (ValidateObject.exsistNullOrEmpty(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyKhoiTao, StartAt, EndAt)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                nhomToHocPhanService.layThongTin(Integer.parseInt(IdHocPhanThuocNhomTo)),
                phongHocService.layThongTin(IdPhongHoc),
                QuanLyKhoiTao,
                Converter.stringToDatetime(StartAt),
                Converter.stringToDatetime(EndAt));
        return lichMuonPhong;
    }

    protected LichMuonPhong taoThongTin(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyKhoiTao, String EndAt) {
        if (ValidateObject.exsistNullOrEmpty(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyKhoiTao, EndAt)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                nhomToHocPhanService.layThongTin(Integer.parseInt(IdHocPhanThuocNhomTo)),
                phongHocService.layThongTin(IdPhongHoc),
                QuanLyKhoiTao,
                new Date(),
                Converter.stringToDatetime(EndAt));
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
        TheoNguoiDung,
        TheoQuanLyDuyetMuonPhong,
        TheoQuanLyTaoLichMuonPhong
    }
}
