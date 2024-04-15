package qlmph.controller.regular;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.service.MuonPhongHocService;
import qlmph.service.NguoiMuonPhongService;
import qlmph.service.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/MPH")
public class MuonPhongHocController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    LichMuonPhongService lichMuonPhongService;

    @Autowired
    MuonPhongHocService muonPhongHocService;

    @Autowired
    NguoiMuonPhongService nguoiMuonPhongService;

    @Autowired
    QuanLyService quanLyService;

    @RequestMapping("/ChonLMPH")
    public String showDsMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> dsLichMPH = lichMuonPhongService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (dsLichMPH == null) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", dsLichMPH);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "MPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "MPH");

        return "components/boardContent/ds-lich-muon-phong";
    }

    @RequestMapping("/MPH")
    public String showLoginForm(Model model,
            @RequestParam("IdLichMPH") int IdLichMPH,
            @RequestParam("UID") String uid) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
        NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

        // Kiểm tra dữ liệu hiển thị
        if (CTLichMPH == null || NgMuonPhong == null) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLichMPH", CTLichMPH);
        model.addAttribute("NgMuonPhong", NgMuonPhong);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "MPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "MPH");

        return "components/boardContent/ct-muon-phong-hoc";
    }

    @RequestMapping(value = "/MPH", method = RequestMethod.POST)
    public String submit(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("IdLichMPH") String IdLichMPH,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("YeuCau") String YeuCau) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không đúng.");
            return "redirect:/MPH/MPH.htm";
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyDuyet = quanLyService.layThongTin((String) servletContext.getAttribute("UIDManager"));
        if (QuanLyDuyet == null) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Không thể xác định thông tin quản lý, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH.htm?IdLichMPH=" + IdLichMPH + "&UID=" + uid;
        }

        // Tạo thông tin và thông báo kết quả
        if (muonPhongHocService.taoThongTin(uid, QuanLyDuyet, IdLichMPH, YeuCau)) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Không thể tạo thông tin mượn phòng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH.htm?IdLichMPH=" + IdLichMPH + "&UID=" + uid;
        }

        redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:../Introduce.htm";
    }

    private boolean xacNhanToken(String token) {
        if (ValidateObject.isNullOrEmpty(token)) {
            new Exception("Mã xác nhận không đúng.").printStackTrace();
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("token", Token.createRandom());
        return true;
    }

}