package qlmph.controller.manager;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.GiangVien;
import qlmph.model.LopSV;
import qlmph.model.MonHoc;
import qlmph.model.NhomHocPhan;
import qlmph.model.QuanLy;
import qlmph.service.GiangVienService;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.LopSVService;
import qlmph.service.MonHocService;
import qlmph.service.NhomHocPhanService;
import qlmph.service.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTLHP")
public class CTLopHocPhan {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    NhomHocPhanService nhomHocPhanService;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    MonHocService monHocService;

    @Autowired
    LopSVService lopSVService;

    @Autowired
    GiangVienService giangVienService;

    @Autowired
    QuanLyService quanLyService;

    @RequestMapping("XemTTLHP") // MARK: - XemTTLHP
    public String showXemTTLHPcreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLHP") String IdLHP) {

        // Lấy dữ liệu hiển thị
        NhomHocPhan CTLopHocPhan = layThongTinNhomHocPhan(IdLHP);
        String IdSection = layIdSecondSection(IdLHP);

        // Kiểm tra dữ liệu lớp học phần
        if (ValidateObject.isNullOrEmpty(CTLopHocPhan)) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTLopHocPhan", CTLopHocPhan);
        model.addAttribute("IdSection", IdSection);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/ct-lop-hoc-phan";
    }

    @RequestMapping("SuaTTLHP") // MARK: - SuaTTLHP
    public String showSuaTTLHPScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLHP") String IdLHP) {

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
            return "redirect:/CTLHP/XemTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
        }

        // Lấy dữ liệu hiển thị
        NhomHocPhan CTLopHocPhan = layThongTinNhomHocPhan(IdLHP);
        String IdSection = layIdSecondSection(IdLHP);
        List<MonHoc> DsMonHoc = monHocService.layDanhSach();
        List<LopSV> DsLopSV = lopSVService.layDanhSach();
        List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(CTLopHocPhan, DsMonHoc, DsLopSV, DsGiangVien)) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLopHocPhan", CTLopHocPhan);
        model.addAttribute("IdSection", IdSection);
        model.addAttribute("DsMonHoc", DsMonHoc);
        model.addAttribute("DsLopSV", DsLopSV);
        model.addAttribute("DsGiangVien", DsGiangVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "CTLHP");
        model.addAttribute("NextUsecasePathSubmitOption2", "SuaTTLHP");

        return "components/boardContent/ct-lop-hoc-phan";
    }

    @RequestMapping(value = "SuaTTLHP", method = RequestMethod.POST)
    public String submitSuaTTLHP(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLHP") String IdLHP,
            @RequestParam("MaMH") String MaMH,
            @RequestParam("Nhom") String Nhom,
            @RequestParam("To") String To,
            @RequestParam("MaLopSV") String MaLopSV,
            @RequestParam("MaGV-Root") String MaGVRoot,
            @RequestParam("MucDich-Root") String MucDichRoot,
            @RequestParam("Ngay_BD-Root") String Ngay_BDRoot,
            @RequestParam("Ngay_KT-Root") String Ngay_KTRoot,
            @RequestParam(value = "MaGV-Section", required = false) String MaGVSection,
            @RequestParam(value = "MucDich-Section", required = false) String MucDichSection,
            @RequestParam(value = "Ngay_BD-Section", required = false) String Ngay_BDSection,
            @RequestParam(value = "Ngay_KT-Section", required = false) String Ngay_KTSection) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không hợp lệ.");
            return "redirect:/CTLHP/XemTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
        }

        // Lấy và kiểm tra thông tin quản lý đang thực hiện
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
            return "redirect:/CTLHP/XemTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
        }

        // Kiểm tra thông tin nhập vào
        if(!ValidateObject.allNullOrEmpty(MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)
            && !ValidateObject.allNotNullOrEmpty(MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thông tin không hợp lệ, vui lòng kiểm tra lại.");
            return "redirect:/CTLHP/SuaTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        if(!nhomHocPhanService.capNhatThongTinLopHocPhan(
            layThongTinNhomHocPhan(IdLHP), layIdSecondSection(IdLHP), 
            MaMH, MaLopSV, QuanLyKhoiTao, Nhom, To,
            MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot, 
            MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật thông tin lớp học phần.");
            return "redirect:/CTLHP/XemTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
        }

        redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:/CTLHP/XemTTLHP?UID=" + uid + "&IdLHP=" + IdLHP;
    }

    @RequestMapping("ThemTTLHP") // MARK: - ThemTTLHP
    public String showThemTTLHPScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        // Lấy thông tin quản lý đang thực hiện
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể lấy thông tin quản lý.");
            return "components/boardContent/ct-muon-phong-hoc";
        }

        // Lấy dữ liệu hiển thị
        List<MonHoc> DsMonHoc = monHocService.layDanhSach();
        List<LopSV> DsLopSV = lopSVService.layDanhSach();
        List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(DsMonHoc, DsLopSV, DsGiangVien)) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsMonHoc", DsMonHoc);
        model.addAttribute("DsLopSV", DsLopSV);
        model.addAttribute("DsGiangVien", DsGiangVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "CTLHP");
        model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTLHP");

        return "components/boardContent/ct-lop-hoc-phan";
    }

    @RequestMapping(value = "/ThemTTLHP", method = RequestMethod.POST)
    public String submitThemTTLHP(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("MaMH") String MaMH,
            @RequestParam("Nhom") String Nhom,
            @RequestParam("To") String To,
            @RequestParam("MaLopSV") String MaLopSV,
            @RequestParam("MaGV-Root") String MaGVRoot,
            @RequestParam("MucDich-Root") String MucDichRoot,
            @RequestParam("Ngay_BD-Root") String Ngay_BDRoot,
            @RequestParam("Ngay_KT-Root") String Ngay_KTRoot,
            @RequestParam(value = "MaGV-Section", required = false) String MaGVSection,
            @RequestParam(value = "MucDich-Section", required = false) String MucDichSection,
            @RequestParam(value = "Ngay_BD-Section", required = false) String Ngay_BDSection,
            @RequestParam(value = "Ngay_KT-Section", required = false) String Ngay_KTSection) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken((String) servletContext.getAttribute("token"))) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã xác nhận không đúng.");
            return "redirect:/CTLHP/ThemTTLHP?UID=" + uid;
        }

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/CTLHP/ThemTTLHP?UID=" + uid;
        }

        // Tạo thông tin và thông báo kết quả
        if(!nhomHocPhanService.luuThongTinLopHocPhan(
            MaMH, MaLopSV, QuanLyKhoiTao, Nhom, To,
            MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot, 
            MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật thông tin lớp học phần.");
            return "redirect:/CTLHP/ThemTTLHP?UID=" + uid;
        }

        redirectAttributes.addFlashAttribute("errorMessage", "Tạo thông tin thành công");
        return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
    }

    @RequestMapping("XoaTTLHP") // MARK: - XoaTTLHP
    public String showXoaTTLHPScreen(
            @RequestParam("IdLHP") int IdLHP,
            Model model) {
        // Tạo khối dữ liệu hiển thị
        // TTLopHocBean tTLopHoc = TTLopHocService.getIdLHP(IdLHP);
        // // Thiết lập khối dữ liệu hiển thị
        // model.addAttribute("TTLopHoc", tTLopHoc);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/ct-lop-hoc-phan";
    }

    private String layIdSecondSection(String IdLHP) {
        if (IdLHP.length() == 12) {
            return IdLHP.substring(6, 12);
        } else {
            return "000000";
        }
    }

    private NhomHocPhan layThongTinNhomHocPhan(String IdLHP) {
        if (IdLHP.length() == 12) {
            return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP.substring(0, 6)));
        } else if (IdLHP.length() == 6) {
            return nhomHocPhanService.layThongTin(Integer.parseInt(IdLHP));
        } else {
            return null;
        }
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
