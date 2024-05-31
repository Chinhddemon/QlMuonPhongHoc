package qlmph.controller.manager;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.model.universityBase.LopSinhVien;
import qlmph.model.universityBase.MonHoc;
import qlmph.model.universityCourse.NhomHocPhan;
import qlmph.model.user.GiangVien;
import qlmph.model.user.QuanLy;
import qlmph.service.universityBase.LopSinhVienService;
import qlmph.service.universityBase.MonHocService;
import qlmph.service.universityCourse.NhomHocPhanService;
import qlmph.service.universityCourse.NhomToHocPhanService;
import qlmph.service.user.GiangVienService;
import qlmph.service.user.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/CTHocPhan")
public class CTNhomHocPhanController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    NhomHocPhanService nhomHocPhanService;

    @Autowired
    NhomToHocPhanService lopHocPhanSectionService;

    @Autowired
    MonHocService monHocService;

    @Autowired
    LopSinhVienService lopSVService;

    @Autowired
    GiangVienService giangVienService;

    @Autowired
    QuanLyService quanLyService;

    @RequestMapping("XemTTHocPhan") // MARK: - XemTTHocPhan
    public String showXemTTHocPhancreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdNhomHocPhan") String IdNhomHocPhan) {

        // Lấy dữ liệu hiển thị
        NhomHocPhan CTNhomHocPhan = nhomHocPhanService.layThongTin(Integer.parseInt(IdNhomHocPhan));

        // Kiểm tra dữ liệu lớp học phần
        if (ValidateObject.isNullOrEmpty(CTNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTNhomHocPhan", CTNhomHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/ct-lop-hoc-phan";
    }

    @RequestMapping("SuaTTHocPhan") // MARK: - SuaTTHocPhan
    public String showSuaTTHocPhanScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdNhomHocPhan") String IdNhomHocPhan) {

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService
                .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể lấy thông tin quản lý.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Lấy dữ liệu hiển thị
        NhomHocPhan CTNhomHocPhan = nhomHocPhanService.layThongTin(Integer.parseInt(IdNhomHocPhan));
        List<MonHoc> DsMonHoc = monHocService.layDanhSach();
        List<LopSinhVien> DsLopSinhVien = lopSVService.layDanhSach();
        List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(CTNhomHocPhan, DsMonHoc, DsLopSinhVien, DsGiangVien)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTNhomHocPhan", CTNhomHocPhan);
        model.addAttribute("DsMonHoc", DsMonHoc);
        model.addAttribute("DsLopSinhVien", DsLopSinhVien);
        model.addAttribute("DsGiangVien", DsGiangVien);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "CTHocPhan");
        model.addAttribute("NextUsecasePathSubmitOption2", "SuaTTHocPhan");

        return "components/boardContent/ct-lop-hoc-phan";
    }

    // @RequestMapping(value = "SuaTTHocPhan", method = RequestMethod.POST)
    // public String submitSuaTTHocPhan(Model model,
    //         RedirectAttributes redirectAttributes,
    //         @RequestParam("UID") String uid,
    //         @RequestParam("XacNhan") String XacNhan,
    //         @RequestParam("IdNhomHocPhan") String IdNhomHocPhan,
    //         @RequestParam("MaMonHoc") String MaMonHoc,
    //         @RequestParam("Nhom") String Nhom,
    //         @RequestParam("MaLopSinhVien") String MaLopSinhVien,
    //         @RequestParam("MaGiangVien-Root") String MaGiangVienRoot,
    //         @RequestParam("MucDich-Root") String MucDichRoot,
    //         @RequestParam("StartDate-Root") String StartDateRoot,
    //         @RequestParam("EndDate-Root") String EndDateRoot,
    //         @RequestParam(value = "MaGiangVien-Section", required = false) List<String> MaGiangVienSection,
    //         @RequestParam(value = "To", required = false) List<String> To,
    //         @RequestParam(value = "MucDich-Section", required = false) List<String> MucDichSection,
    //         @RequestParam(value = "StartDate-Section", required = false) List<String> StartDateSection,
    //         @RequestParam(value = "EndDate-Section", required = false) List<String> EndDateSection) {

    //     // Kiểm tra mã xác nhận
    //     if (!xacNhanToken(XacNhan)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không hợp lệ.");
    //         return "redirect:/CTHocPhan/SuaTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    //     }

    //     // Lấy và kiểm tra thông tin quản lý đang thực hiện
    //     QuanLy QuanLyKhoiTao = quanLyService
    //             .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
    //     if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Không thể lấy thông tin quản lý.");
    //         return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    //     }

    //     // Kiểm tra thông tin nhập vào
    //     if (!ValidateObject.allNullOrEmpty(MaGiangVienSection, MucDichSection, StartDateSection, EndDateSection)
    //             && !ValidateObject.allNotNullOrEmpty(MaGiangVienSection, MucDichSection, StartDateSection, EndDateSection)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Thông tin không hợp lệ, vui lòng kiểm tra lại.");
    //         return "redirect:/CTHocPhan/SuaTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    //     }

    //     // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
    //     NhomHocPhan CTNhomHocPhan = nhomHocPhanService.capNhatThongTinLopHocPhan(
    //             layThongTinNhomHocPhan(IdNhomHocPhan), layIdSecondSection(IdNhomHocPhan),
    //             MaMonHoc, MaLopSinhVien, QuanLyKhoiTao, Nhom, To.get(0),
    //             MaGiangVienRoot, MucDichRoot, StartDateRoot, EndDateRoot,
    //             MaGiangVienSection.get(0), MucDichSection.get(0), StartDateSection.get(0), EndDateSection.get(0));
    //     if (ValidateObject.isNullOrEmpty(CTNhomHocPhan)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin lớp học phần.");
    //         return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    //     }

    //     redirectAttributes.addFlashAttribute("messageStatus", "Lưu thông tin thành công");
    //     return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    // }

    // @RequestMapping("ThemTTHocPhan") // MARK: - ThemTTHocPhan
    // public String showThemTTHocPhanScreen(Model model,
    //         RedirectAttributes redirectAttributes,
    //         @RequestParam("UID") String uid) {

    //     // Lấy thông tin quản lý đang thực hiện
    //     QuanLy QuanLyKhoiTao = quanLyService
    //             .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
    //     if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Không thể lấy thông tin quản lý.");
    //         return "components/boardContent/ct-lich-muon-phong";
    //     }

    //     // Lấy dữ liệu hiển thị
    //     List<MonHoc> DsMonHoc = monHocService.layDanhSach();
    //     List<LopSinhVien> DsLopSinhVien = lopSVService.layDanhSach();
    //     List<GiangVien> DsGiangVien = giangVienService.layDanhSach();

    //     // Kiểm tra dữ liệu hiển thị
    //     if (ValidateObject.exsistNullOrEmpty(DsMonHoc, DsLopSinhVien, DsGiangVien)) {
    //         model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
    //     }

    //     // Thiết lập dữ liệu hiển thị
    //     model.addAttribute("DsMonHoc", DsMonHoc);
    //     model.addAttribute("DsLopSinhVien", DsLopSinhVien);
    //     model.addAttribute("DsGiangVien", DsGiangVien);
    //     model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);

    //     // Thiết lập chuyển hướng trang kế tiếp
    //     model.addAttribute("NextUsecaseSubmitOption2", "CTHocPhan");
    //     model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTHocPhan");

    //     return "components/boardContent/ct-lop-hoc-phan";
    // }

    // @RequestMapping(value = "/ThemTTHocPhan", method = RequestMethod.POST)
    // public String submitThemTTHocPhan(Model model,
    //         RedirectAttributes redirectAttributes,
    //         @RequestParam("UID") String uid,
    //         @RequestParam("XacNhan") String XacNhan,
    //         @RequestParam("MaMonHoc") String MaMonHoc,
    //         @RequestParam("Nhom") String Nhom,
    //         @RequestParam("MaLopSinhVien") String MaLopSinhVien,
    //         @RequestParam("MaGiangVien-Root") String MaGiangVienRoot,
    //         @RequestParam("MucDich-Root") String MucDichRoot,
    //         @RequestParam("StartDate-Root") String StartDateRoot,
    //         @RequestParam("EndDate-Root") String EndDateRoot,
    //         @RequestParam(value = "MaGiangVien-Section", required = false) List<String> MaGiangVienSection,
    //         @RequestParam(value = "To", required = false) List<String> To,
    //         @RequestParam(value = "MucDich-Section", required = false) List<String> MucDichSection,
    //         @RequestParam(value = "StartDate-Section", required = false) List<String> StartDateSection,
    //         @RequestParam(value = "EndDate-Section", required = false) List<String> EndDateSection) {

    //     // Kiểm tra mã xác nhận
    //     if (!xacNhanToken((String) servletContext.getAttribute("OTP"))) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
    //         return "redirect:/CTHocPhan/ThemTTHocPhan?UID=" + uid;
    //     }

    //     // Lấy và kiểm tra thông tin quản lý đang trực
    //     QuanLy QuanLyKhoiTao = quanLyService
    //             .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
    //     if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
    //         return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid;
    //     }

    //     // // Kiểm tra thông tin nhập vào
    //     // if (!ValidateObject.allNullOrEmpty(MaGiangVienSection, MucDichSection, StartDateSection, EndDateSection)
    //     //         && !ValidateObject.allNotNullOrEmpty(MaGiangVienSection, MucDichSection, StartDateSection, EndDateSection)
    //     //         || !ValidateObject.allNullOrEmpty(To, MaGiangVienSection2, To2, MucDichSection2, StartDateSection2,
    //     //                 EndDateSection2)
    //     //                 && !ValidateObject.allNotNullOrEmpty(To, MaGiangVienSection2, To2, MucDichSection2, StartDateSection2,
    //     //                         EndDateSection2)
    //     //         || !ValidateObject.allNullOrEmpty(MaGiangVienSection3, To3, MucDichSection3, StartDateSection3, EndDateSection3)
    //     //                 && !ValidateObject.allNotNullOrEmpty(MaGiangVienSection3, To3, MucDichSection3, StartDateSection3,
    //     //                         EndDateSection3)) {
    //     //     redirectAttributes.addFlashAttribute("messageStatus", "Thông tin không hợp lệ, vui lòng kiểm tra lại.");
    //     //     return "redirect:/CTHocPhan/ThemTTHocPhan?UID=" + uid;
    //     // }

    //     // Lưu thông tin và thông báo kết quả
    //     NhomHocPhan CTNhomHocPhan = nhomHocPhanService.luuThongTinNhomHocPhan(
    //         MaMonHoc, MaLopSinhVien, QuanLyKhoiTao, Nhom,
    //         MaGiangVienRoot, MucDichRoot, StartDateRoot, EndDateRoot,
    //         MaGiangVienSection, To, MucDichSection, StartDateSection, EndDateSection,
    //         MaGiangVienSection2, To2, MucDichSection2, StartDateSection2, EndDateSection2,
    //         MaGiangVienSection3, To3, MucDichSection3, StartDateSection3, EndDateSection3);
    //     if (ValidateObject.isNullOrEmpty(CTNhomHocPhan)) {
    //         redirectAttributes.addFlashAttribute("messageStatus", "Không thể lưu thông tin lớp học phần.");
    //         return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid;
    //     }

    //     redirectAttributes.addFlashAttribute("messageStatus", "Lưu thông tin thành công");
    //     return "redirect:../DsHocPhan/XemTTHocPhan?UID=" + uid + "IdNhomHocPhan=" + CTNhomHocPhan.getIdNHPAsString();
    // }

    @RequestMapping("XoaTTHocPhan") // MARK: - XoaTTHocPhan
    public String showXoaTTHocPhanScreen(
            @RequestParam("IdNhomHocPhan") int IdNhomHocPhan,
            Model model) {
        // Tạo khối dữ liệu hiển thị
        // TTLopHocBean tTLopHoc = TTLopHocService.getIdNhomHocPhan(IdNhomHocPhan);
        // // Thiết lập khối dữ liệu hiển thị
        // model.addAttribute("TTLopHoc", tTLopHoc);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View

        return "components/boardContent/ct-lop-hoc-phan";
    }

    private boolean xacNhanToken(String OTP) {
        if (ValidateObject.isNullOrEmpty(OTP) && !OTP.equals(servletContext.getAttribute("OTP"))) {
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("OTP", Token.createRandom());
        return true;
    }

}
