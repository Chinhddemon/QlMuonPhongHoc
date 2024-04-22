package qlmph.controller.manager;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.LichMuonPhong;
import qlmph.model.QuanLy;
import qlmph.service.LichMuonPhongService;
import qlmph.service.LichMuonPhongService.GetCommand;
import qlmph.service.QuanLyService;
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
            @RequestParam(value = "ThoiGian_BD", required = false) String ThoiGian_BD,
            @RequestParam(value = "ThoiGian_KT", required = false) String ThoiGian_KT,
            @RequestParam(value = "IdLHP", required = false) String IdLHP,
            @RequestParam(value = "MaGVGiangDay", required = false) String MaGVGiangDay,
            @RequestParam(value = "MaNgMPH", required = false) String MaNgMPH,
            @RequestParam(value = "MaPhongHoc", required = false) String MaPhongHoc,
            @RequestParam(value = "MaHocKy", required = false) String MaHocKy) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMPH = null;
        if(Command == null) Command = "TheoNgay";
        switch (Command) {
            case "TheoNgay":
                
                DsLichMPH = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoNgay));
                break;
            case "ChuaTraPhong":
                DsLichMPH = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.TheoTrangThai_ChuaTraPhong));
                break;
            case "TheoHocKy":
                DsLichMPH = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoHocKy));
                break;
            case "LichSu":
                DsLichMPH = lichMuonPhongService.layDanhSach();
                break;
            case "Sort":
                break;
            default:
                break;
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMPH)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", DsLichMPH);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }
}