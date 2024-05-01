package qlmph.controller.manager;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import qlmph.model.NhomHocPhan;
import qlmph.model.QuanLy;
import qlmph.service.NhomHocPhanService;
import qlmph.service.QuanLyService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DsNHP")
public class DsNhomHocPhanController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private NhomHocPhanService nhomHocPhanService;

    @Autowired
    private QuanLyService quanLyService;

    @RequestMapping("/XemDsNHP") // MARK: - XemDsNHP
    public String showDsNHP(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTLHP");

        model.addAttribute("NextUsecaseTableOption2", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption2", "SuaTTLHP");

        model.addAttribute("NextUsecaseTableOption3", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption3", "XoaTTLHP");

        model.addAttribute("NextUsecaseTableOption4", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption4", "XemDsMPH");

        return "components/boardContent/ds-nhom-hoc-phan";
    }

    @RequestMapping("/XemDsLHP") // MARK: - XemDsLHP
    public String showDsLHP(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTLHP");

        model.addAttribute("NextUsecaseTableOption2", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption2", "SuaTTLHP");

        model.addAttribute("NextUsecaseTableOption3", "CTLHP");
        model.addAttribute("NextUsecasePathTableOption3", "XoaTTLHP");

        model.addAttribute("NextUsecaseTableOption4", "DsMPH");
        model.addAttribute("NextUsecasePathTableOption4", "XemDsMPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }

    @RequestMapping("/ThemTTMPH") // MARK: - ThemTTMPH
    public String showThemTTMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "CTMPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "ThemTTMPH");

        return "components/boardContent/ds-nhom-hoc-phan";
    }
}
