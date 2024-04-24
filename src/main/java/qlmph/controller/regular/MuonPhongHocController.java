package qlmph.controller.regular;

import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.LichMuonPhong;
import qlmph.model.MuonPhongHoc;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.QuanLy;
import qlmph.service.LichMuonPhongService;
import qlmph.service.MuonPhongHocService;
import qlmph.service.NguoiMuonPhongService;
import qlmph.service.QuanLyService;
import qlmph.service.LichMuonPhongService.GetCommand;
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

    @RequestMapping("/ChonLMPH") // MARK: - ChonLMPH
    public String showDsMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyDangTruc = quanLyService.layThongTin((String) servletContext.getAttribute("UIDManager"));
        if (ValidateObject.isNullOrEmpty(QuanLyDangTruc)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMPH = lichMuonPhongService.layDanhSachTheoDieuKien(
                Set.of(GetCommand.MacDinh_TheoNgay, GetCommand.TheoTrangThai_ChuaMuonPhong));

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMPH)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", DsLichMPH);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "MPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "MPH");

        return "components/boardContent/ds-lich-muon-phong";
    }

    @RequestMapping("/MPH") // MARK: - MPH
    public String showLoginForm(Model model,
            @RequestParam("IdLichMPH") int IdLichMPH,
            @RequestParam("UID") String uid) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
        NguoiMuonPhong NguoiMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(CTLichMPH, NguoiMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLichMPH", CTLichMPH);
        model.addAttribute("NgMuonPhong", NguoiMuonPhong);

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
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/MPH/MPH?UID=" + uid;
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyDuyet = quanLyService.layThongTin((String) servletContext.getAttribute("UIDManager"));
        if (ValidateObject.isNullOrEmpty(QuanLyDuyet)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin quản lý, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        NguoiMuonPhong NguoiMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
        if(ValidateObject.isNullOrEmpty(NguoiMuonPhong)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người mượn phòng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        // Tạo thông tin và thông báo kết quả
        MuonPhongHoc CTMuonPhongHoc = muonPhongHocService.luuThongTin(IdLichMPH, NguoiMuonPhong, QuanLyDuyet, YeuCau);
        if (ValidateObject.isNullOrEmpty(CTMuonPhongHoc)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể tạo thông tin mượn phòng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Tạo thông tin thành công");
        return "redirect:../Introduce";
    }

    private boolean xacNhanToken(String token) {
        if (ValidateObject.isNullOrEmpty(token) && !token.equals(servletContext.getAttribute("token"))) {
            new Exception("Mã xác nhận không đúng.").printStackTrace();
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("token", Token.createRandom());
        return true;
    }
}