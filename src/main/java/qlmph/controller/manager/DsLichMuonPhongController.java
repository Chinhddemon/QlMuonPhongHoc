package qlmph.controller.manager;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.user.QuanLy;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;
import qlmph.service.universityBorrowRoom.LichMuonPhongService.GetCommand;
import qlmph.service.user.QuanLyService;
import qlmph.utils.ValidateObject;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/DsMPH")
public class DsLichMuonPhongController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private LichMuonPhongService lichMuonPhongService;

    @Autowired
    private QuanLyService quanLyService;

    @RequestMapping("/XemDsMPH") // MARK: - XemDsMPH
    public String XemDsMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam(value = "Command", required = false) String Command,
            @RequestParam(value = "StartAt", required = false) String StartAt,
            @RequestParam(value = "EndAt", required = false) String EndAt,
            @RequestParam(value = "IdNhomHocPhan", required = false) String IdNhomHocPhan,
            @RequestParam(value = "MaGiangVien", required = false) String MaGiangVienGiangDay,
            @RequestParam(value = "MaSinhVien", required = false) String MaSinhVien,
            @RequestParam(value = "MaGiangVien", required = false) String MaGiangVien,
            @RequestParam(value = "IdNguoiDung", required = false) String IdNguoiDung,
            @RequestParam(value = "MaPhongHoc", required = false) String MaPhongHoc,
            @RequestParam(value = "MaHocKy", required = false) String MaHocKy) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce?UId=" + uid;
        }

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMuonPhong = null;
        if(ValidateObject.isNullOrEmpty(Command)) {
            if(Command == null) Command = "TheoNgay";
            if(Command.equals("")) new Exception("Command rỗng.").printStackTrace();
        }
        switch (Command) {
            case "TheoNgay":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoNgay));
                break;
            case "TheoTuan":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoTuan));
                break;
            case "ChuaTraPhong":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.TheoTrangThai_ChuaTraPhong));
                break;
            case "TheoHocKy":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoHocKy));
                break;
            case "TatCa":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachKhaDung();
                break;
            case "LichSu":
                DsLichMuonPhong = lichMuonPhongService.layDanhSach();
                break;
            case "Sort":
                break;
            default:
                break;
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMuonPhong", DsLichMuonPhong);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }
}