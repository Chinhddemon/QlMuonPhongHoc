package qlmph.controller.manager;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.LichMuonPhong;
import qlmph.model.LopHocPhanSection;
import qlmph.model.MuonPhongHoc;
import qlmph.model.PhongHoc;
import qlmph.model.QuanLy;
import qlmph.service.LichMuonPhongService;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.MuonPhongHocService;
import qlmph.service.PhongHocService;
import qlmph.service.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTMPH")
public class CTLichMuonPhongController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private LichMuonPhongService lichMuonPhongService;

    @Autowired
    private MuonPhongHocService muonPhongHocService;

    @Autowired
    private LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    private QuanLyService quanLyService;

    @Autowired
    private PhongHocService phongHocService;

    @RequestMapping("/XemTTMPH") // MARK: - XemTTMPH
    public String showTTMPHScreen(Model model,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMPH") String IdLichMPH) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(Integer.parseInt(IdLichMPH));

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(CTLichMPH)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTLichMPH", CTLichMPH);
        model.addAttribute("CurrentDateTime", new Date());

        model.addAttribute("NextUsecaseNavigate1", "DsND");
        model.addAttribute("NextUsecasePathNavigate1", "XemDsNgMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping("/SuaTTMPH") // MARK: - SuaTTMPH
    public String showSuaTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMPH") int IdLichMPH) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if(ValidateObject.exsistNullOrEmpty(CTLichMPH, DsPhongHoc)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLichMPH", CTLichMPH);
        model.addAttribute("DsPhongHoc", DsPhongHoc);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption1", "SuaTTMPH");

        model.addAttribute("NextUsecaseNavigate1", "DsND");
        model.addAttribute("NextUsecasePathNavigate1", "ChinhDsNgMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/SuaTTMPH", method = RequestMethod.POST)
    public String submitSuaTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLichMPH") String IdLichMPH,
            @RequestParam("IdPH") int IdPH,
            @RequestParam("ThoiGian_BD") String ThoiGian_BD,
            @RequestParam("ThoiGian_KT") String ThoiGian_KT,
            @RequestParam("LyDo") String LyDo) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        LichMuonPhong CTLichMPH = lichMuonPhongService.capNhatThongTin(IdLichMPH, IdPH, QuanLyKhoiTao, ThoiGian_BD, ThoiGian_KT, LyDo);
        if(ValidateObject.isNullOrEmpty(CTLichMPH)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin lịch mượn phòng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Cập nhật thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + CTLichMPH.getIdLMPH();
    }

    @RequestMapping("/TraTTMPH") //MARK: - TraTTMPH
    public String showTraTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMPH") int IdLichMPH) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMPH = lichMuonPhongService.layThongTin(IdLichMPH);

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(CTLichMPH)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTLichMPH", CTLichMPH);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption1", "TraTTMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/TraTTMPH", method = RequestMethod.POST)
    public String submitTraTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLichMPH") String IdLichMPH) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        MuonPhongHoc CTMuonPhongHoc = muonPhongHocService.capNhatThongTinTraPhong(IdLichMPH);
        if (ValidateObject.isNullOrEmpty(CTMuonPhongHoc)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin trả phòng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + IdLichMPH;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Cập nhật thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + CTMuonPhongHoc.getIdLMPH();
    }

    @RequestMapping("/ThemTTMPH") //MARK: - ThemTTMPH
    public String showThemTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLHPSection") int IdLHPSection) {

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/DsMPH/XemDsMPH?UID=" + uid;
        }

        // Lấy dữ liệu hiển thị
        LopHocPhanSection CTLopHocPhanSection = lopHocPhanSectionService.layThongTin(IdLHPSection);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if(ValidateObject.exsistNullOrEmpty(CTLopHocPhanSection, DsPhongHoc)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLopHocPhanSection", CTLopHocPhanSection);
        model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);
        model.addAttribute("DsPhongHoc", DsPhongHoc);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/ThemTTMPH", method = RequestMethod.POST)
    public String submitThemTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLHPSection") String IdLHPSection,
            @RequestParam("IdPH") int IdPH,
            @RequestParam("ThoiGian_BD") String ThoiGian_BD,
            @RequestParam("ThoiGian_KT") String ThoiGian_KT) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        // Lưu thông tin và thông báo kết quả
        LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTin(IdLHPSection, IdPH, QuanLyKhoiTao, ThoiGian_BD, ThoiGian_KT);
        if (ValidateObject.isNullOrEmpty(CTLichMPH)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tạo thông tin lịch mượn phòng.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Lưu thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMPH=" + CTLichMPH.getIdLMPHAsString();
    }

    private boolean xacNhanToken(String token) {
        if (ValidateObject.isNullOrEmpty(token) && !token.equals(servletContext.getAttribute("token"))) {
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("token", Token.createRandom());
        return true;
    }
}
