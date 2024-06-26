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
        model.addAttribute("NextUsecaseNavigate1", "DsND");
        model.addAttribute("NextUsecasePathNavigate1", "XemDsSinhVien");

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
        model.addAttribute("NextUsecaseSubmitOption1", "CTHocPhan");
        model.addAttribute("NextUsecasePathSubmitOption1", "SuaTTHocPhan");

        return "components/boardContent/ct-lop-hoc-phan";
    }

    @RequestMapping(value = "SuaTTHocPhan", method = RequestMethod.POST)
    public String submitSuaTTHocPhan(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdNhomHocPhan") String IdNhomHocPhan,
            @RequestParam("MaMonHoc") String MaMonHoc,
            @RequestParam("MaLopSinhVien") String MaLopSinhVien,
            @RequestParam("Nhom") String Nhom,
            @RequestParam("IdNhomToHocPhan") List<Integer> IdNhomToHocPhans,
            @RequestParam("MaGiangVien") List<String> MaGiangViens,
            @RequestParam("MucDich") List<String> MucDichs,
            @RequestParam("StartDate") List<String> StartDates,
            @RequestParam("EndDate") List<String> EndDates) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không hợp lệ.");
            return "redirect:/CTHocPhan/SuaTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Lấy và kiểm tra thông tin quản lý đang thực hiện
        QuanLy QuanLyKhoiTao = quanLyService
                .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể lấy thông tin quản lý.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Kiểm tra thông tin nhập vào
        if (ValidateObject.exsistNotSameSize(IdNhomToHocPhans, MaGiangViens, MucDichs, StartDates, EndDates)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Thông tin không hợp lệ, vui lòng kiểm tra lại.");
            return "redirect:/CTHocPhan/SuaTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        NhomHocPhan CTNhomHocPhan = nhomHocPhanService.capNhatThongTinNhomHocPhan(
            Integer.parseInt(IdNhomHocPhan), MaMonHoc, MaLopSinhVien, QuanLyKhoiTao, Nhom,
            IdNhomToHocPhans, MaGiangViens, MucDichs, StartDates, EndDates);
        if (ValidateObject.isNullOrEmpty(CTNhomHocPhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin lớp học phần.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Lưu thông tin thành công");
        return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
    }

    // @RequestMapping("ThemTTHocPhan") // MARK: - ThemTTHocPhan

    @RequestMapping(value = "/XoaTTHocPhan", method = RequestMethod.POST) // MARK: - XoaTTHocPhan POST
    public String submitXoaTTHocPhan(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdNhomHocPhan") int IdNhomHocPhan) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyKhoiTao = quanLyService
                .layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể xác định thông tin quản lý.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // Lấy dữ liệu
        NhomHocPhan CTNhomHocPhan = nhomHocPhanService.layThongTin(IdNhomHocPhan);

        // Kiểm tra dữ liệu
        if (ValidateObject.exsistNullOrEmpty(CTNhomHocPhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        // if(CTNhomHocPhan.getHocKy_LopSinhVien().getStartDate().before(new Date())) {
        //     redirectAttributes.addFlashAttribute("messageStatus", "Không thể xóa thông tin khi học kỳ đã bắt đầu.");
        //     return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        // }

        // Xóa thông tin và thông báo kết quả
        if (!nhomHocPhanService.xoaThongTin(IdNhomHocPhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể xóa thông tin lớp học phần.");
            return "redirect:/CTHocPhan/XemTTHocPhan?UID=" + uid + "&IdNhomHocPhan=" + IdNhomHocPhan;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Xóa thông tin thành công");
        return "redirect:/DsHocPhan/XemDsHocPhan?UID=" + uid;
    }

    private boolean xacNhanToken(String OTP) {
        if (ValidateObject.isNullOrEmpty(OTP) || !OTP.equals(servletContext.getAttribute("OTP"))) {
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("OTP", Token.createRandom());
        return true;
    }

}
