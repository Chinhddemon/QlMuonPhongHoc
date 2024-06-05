package qlmph.service.universityBorrowRoom;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBase.PhongHoc;
import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityCourse.NhomToHocPhan;
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

    public List<LichMuonPhong> layDanhSachKhaDung() {
        List<LichMuonPhong> lichMuonPhongs = lichMuonPhongRepository.getAllAvailable();
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
            new Exception("Không thể cập nhật thông tin: IdLichMuonPhong: " + lichMuonPhong.getIdLichMuonPhong())
                    .printStackTrace();
            return null;
        }
        return lichMuonPhong;
    }

    public boolean xoaThongTin(String IdLichMuonPhong) {
        LichMuonPhong lichMuonPhong = layThongTin(IdLichMuonPhong);
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không tìm thấy thông tin: IdLichMuonPhong: " + IdLichMuonPhong).printStackTrace();
            return false;
        }
        return lichMuonPhongRepository.delete(lichMuonPhong);
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

        LocalDateTime startDatetime = null;
        LocalDateTime endDatetime = null;
        String MaHocKy = null;

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(GetCommand.MacDinh_TheoNgay)) {
            if(Commands.contains(GetCommand.TheoTrangThai_ChuaQuaHan)) {
                startDatetime = LocalDateTime.now(); // thời gian hiện tại
            } else {
                startDatetime = LocalDateTime.of(LocalDate.now(), LocalTime.MIDNIGHT); // 00:00:00 hôm nay
            }
            endDatetime = startDatetime.with(LocalTime.MAX);// 23:59:59 ngày hôm nay
        }
        if (Commands.contains(GetCommand.MacDinh_TheoTuan)) {
            if(Commands.contains(GetCommand.TheoTrangThai_ChuaQuaHan)) {
                startDatetime = LocalDateTime.now(); // thời gian hiện tại
            } else {
                startDatetime = LocalDateTime.of(LocalDate.now().with(DayOfWeek.MONDAY), LocalTime.MIDNIGHT); // 00:00:00 thứ 2 tuần này
            }
            endDatetime = startDatetime.with(DayOfWeek.SUNDAY).with(LocalTime.MAX);// 23:59:59 chủ nhật tuần này
        }
        if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
            MaHocKy = hocKyService.layHocKyHienTai();
            if (ValidateObject.isNullOrEmpty(MaHocKy)) {
                new Exception("Không tìm thấy học kỳ được thiết lập.").printStackTrace();
                return null;
            }
        }


        return lichMuonPhongRepository.getListByCondition(Commands,
                startDatetime,
                endDatetime,
                0,
                null,
                null,
                null,
                MaHocKy);
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKien(Set<GetCommand> Commands,
            String StartDatetime, String EndDatetime,
            int IdNhomToHocPhan,
            String MaGVGiangDay,
            String idTaiKhoanNguoiMuonPhong,
            String MaPhongHoc,
            String MaHocKy) {

        LocalDateTime startDatetime = null;
        LocalDateTime endDatetime = null;

        // Các lệnh điều kiện được sử dụng trong truy vấn:
        if (Commands.contains(GetCommand.MacDinh_TheoNgay)) {
            if(Commands.contains(GetCommand.TheoTrangThai_ChuaQuaHan)) {
                startDatetime = LocalDateTime.now(); // thời gian hiện tại
            } else {
                startDatetime = LocalDateTime.of(LocalDate.now(), LocalTime.MIDNIGHT); // 00:00:00 hôm nay
            }
            endDatetime = startDatetime.with(LocalTime.MAX);// 23:59:59 ngày hôm nay
        } else if (Commands.contains(GetCommand.MacDinh_TheoTuan)) {
            if(Commands.contains(GetCommand.TheoTrangThai_ChuaQuaHan)) {
                startDatetime = LocalDateTime.now(); // thời gian hiện tại
            } else {
                startDatetime = LocalDateTime.of(LocalDate.now().with(DayOfWeek.MONDAY), LocalTime.MIDNIGHT); // 00:00:00 thứ 2 tuần này
            }
            endDatetime = startDatetime.with(DayOfWeek.SUNDAY).with(LocalTime.MAX);// 23:59:59 chủ nhật tuần này
        } else {
            if(StartDatetime != null){
                startDatetime = Converter.stringToLocalDateTime(StartDatetime);
            }
            if(EndDatetime != null){
                endDatetime = Converter.stringToLocalDateTime(EndDatetime);
            }
        }
        if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
            MaHocKy = hocKyService.layHocKyHienTai();
            if (ValidateObject.isNullOrEmpty(MaHocKy)) {
                new Exception("Không tìm thấy học kỳ được thiết lập.").printStackTrace();
                return null;
            }
        }

        return lichMuonPhongRepository.getListByCondition(Commands,
                startDatetime,
                endDatetime,
                IdNhomToHocPhan,
                MaGVGiangDay,
                idTaiKhoanNguoiMuonPhong,
                MaPhongHoc,
                MaHocKy);
    }

    public List<LichMuonPhong> layDanhSachTheoDieuKienLichSu(Set<GetCommand> Commands,
            int IdNhomToHocPhan,
            String MaGVGiangDay,
            String idTaiKhoanNguoiMuonPhong,
            String MaPhongHoc,
            String MaHocKy) {

        if (Commands.contains(GetCommand.MacDinh_TheoHocKy)) {
            MaHocKy = hocKyService.layHocKyHienTai();
            if (ValidateObject.isNullOrEmpty(MaHocKy)) {
                new Exception("Không tìm thấy học kỳ được thiết lập.").printStackTrace();
                return null;
            }
        }

        return lichMuonPhongRepository.getListByConditionIncludeDeleted(Commands,
                null,
                null,
                IdNhomToHocPhan,
                MaGVGiangDay,
                idTaiKhoanNguoiMuonPhong,
                MaPhongHoc,
                MaHocKy);
    }

    public LichMuonPhong luuThongTinDoiPhongHoc(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyDuyet,
            String EndDatetime,
            String LyDo, NguoiDung NguoiDung, String YeuCau, String MucDich) {
        LichMuonPhong lichMuonPhong = taoThongTin(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyDuyet, EndDatetime, MucDich);
        lichMuonPhong.setMuonPhongHoc(muonPhongHocService.taoThongTin(NguoiDung, QuanLyDuyet, YeuCau));
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return lichMuonPhongRepository.saveDoiPhongHoc(lichMuonPhong);
    }

    public LichMuonPhong luuThongTin(int IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyKhoiTao,
            String StartDatetime, String EndDatetime, String MucDich) {
        LichMuonPhong lichMuonPhong = taoThongTin(
                nhomToHocPhanService.layThongTin(IdHocPhanThuocNhomTo),
                phongHocService.layThongTin(IdPhongHoc),
                QuanLyKhoiTao,
                Converter.stringToDatetime(StartDatetime),
                Converter.stringToDatetime(EndDatetime),
                MucDich);
        if (ValidateObject.isNullOrEmpty(lichMuonPhong)) {
            new Exception("Không thể tạo thông tin.").printStackTrace();
            return null;
        }
        return luuThongTin(lichMuonPhong);
    }

    public LichMuonPhong capNhatThongTin(String IdLichMuonPhong, int IdPhongHoc, QuanLy QuanLyKhoiTao,
            String StartDatetime,
            String EndDatetime, String LyDo) {
        LichMuonPhong lichMuonPhong = layThongTin(IdLichMuonPhong);
        lichMuonPhong.setPhongHoc(phongHocService.layThongTin(IdPhongHoc));
        lichMuonPhong.setQuanLyKhoiTao(QuanLyKhoiTao);
        lichMuonPhong.setStartDatetime(Converter.stringToDatetime(StartDatetime));
        lichMuonPhong.setEndDatetime(Converter.stringToDatetime(EndDatetime));
        return capNhatThongTin(lichMuonPhong);
    }

    // MARK: UtilTasks

    protected LichMuonPhong taoThongTin(NhomToHocPhan HocPhanThuocNhomTo, PhongHoc PhongHoc, QuanLy QuanLyKhoiTao,
            Date StartDatetime, Date EndDatetime, String MucDich) {
        if (ValidateObject.exsistNullOrEmpty(HocPhanThuocNhomTo, PhongHoc, QuanLyKhoiTao, MucDich, StartDatetime,
                EndDatetime)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        if (MucDich.equals(HocPhanThuocNhomTo.getMucDich())) {
            MucDich = "C";
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                HocPhanThuocNhomTo,
                PhongHoc,
                QuanLyKhoiTao,
                StartDatetime,
                EndDatetime,
                MucDich);
        return lichMuonPhong;
    }

    protected LichMuonPhong taoThongTin(String IdHocPhanThuocNhomTo, int IdPhongHoc, QuanLy QuanLyKhoiTao,
            String EndDatetime, String MucDich) {
        if (ValidateObject.exsistNullOrEmpty(IdHocPhanThuocNhomTo, IdPhongHoc, QuanLyKhoiTao, EndDatetime)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        if (MucDich.equals("LT") || MucDich.equals("TH") || MucDich.equals("TN")) {
            MucDich = "C";
        }
        LichMuonPhong lichMuonPhong = new LichMuonPhong(
                nhomToHocPhanService.layThongTin(Integer.parseInt(IdHocPhanThuocNhomTo)),
                phongHocService.layThongTin(IdPhongHoc),
                QuanLyKhoiTao,
                new Date(),
                Converter.stringToDatetime(EndDatetime),
                MucDich);
        return lichMuonPhong;
    }

    // MARK: ENUM

    public enum GetCommand {
        MacDinh_TheoNgay,
        MacDinh_TheoTuan,
        MacDinh_TheoHocKy,
        TheoHocKy,
        TheoTrangThai_ChuaMuonPhong,
        TheoTrangThai_QuaHan,
        TheoTrangThai_ChuaQuaHan,
        TheoTrangThai_DaMuonPhong,
        TheoTrangThai_ChuaTraPhong,
        TheoGiangVienGiangDay,
        TheoNguoiDung,
        TheoNguoiMuonPhong_LichSuMuonPhong
    }
}
