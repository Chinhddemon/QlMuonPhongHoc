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

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityBorrowRoom.MuonPhongHoc;
import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.model.universityBase.PhongHoc;
import qlmph.model.user.QuanLy;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;
import qlmph.service.universityBorrowRoom.MuonPhongHocService;
import qlmph.service.universityCourse.NhomToHocPhanService;
import qlmph.service.universityBase.PhongHocService;
import qlmph.service.user.QuanLyService;
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
    private NhomToHocPhanService lopHocPhanSectionService;

    @Autowired
    private QuanLyService quanLyService;

    @Autowired
    private PhongHocService phongHocService;

    @RequestMapping("/XemTTMPH") // MARK: - XemTTMPH GET
    public String showTTMPHScreen(Model model,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.layThongTin(IdLichMuonPhong);

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(CTLichMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTLichMuonPhong", CTLichMuonPhong);
        model.addAttribute("CurrentDateTime", new Date());

        model.addAttribute("NextUsecaseNavigate1", "DsND");
        model.addAttribute("NextUsecasePathNavigate1", "XemDsSinhVien");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping("/SuaTTMPH") // MARK: - SuaTTMPH GET
    public String showSuaTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.layThongTin(IdLichMuonPhong);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSachPhongKhaDung();

        // Kiểm tra dữ liệu hiển thị
        if(ValidateObject.exsistNullOrEmpty(CTLichMuonPhong, DsPhongHoc)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLichMuonPhong", CTLichMuonPhong);
        model.addAttribute("DsPhongHoc", DsPhongHoc);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption1", "SuaTTMPH");

        model.addAttribute("NextUsecaseNavigate1", "DsND");
        model.addAttribute("NextUsecasePathNavigate1", "ChinhDsNgMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/SuaTTMPH", method = RequestMethod.POST) // MARK: - SuaTTMPH POST
    public String submitSuaTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong,
            @RequestParam("IdPhongHoc") int IdPhongHoc,
            @RequestParam("StartDatetime") String StartDatetime,
            @RequestParam("EndDatetime") String EndDatetime,
            @RequestParam(value = "LyDo", required = false) String LyDo) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.capNhatThongTin(IdLichMuonPhong, IdPhongHoc, QuanLyKhoiTao, StartDatetime, EndDatetime, LyDo);
        if(ValidateObject.isNullOrEmpty(CTLichMuonPhong)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin lịch mượn phòng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Cập nhật thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + CTLichMuonPhong.getIdLichMuonPhongAsString();
    }

    @RequestMapping("/TraTTMPH") //MARK: - TraTTMPH GET
    public String showTraTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.layThongTin(IdLichMuonPhong);

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(CTLichMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập khối dữ liệu hiển thị
        model.addAttribute("CTLichMuonPhong", CTLichMuonPhong);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption1", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption1", "TraTTMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/TraTTMPH", method = RequestMethod.POST) //MARK: - TraTTMPH POST
    public String submitTraTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        // Cập nhật dữ liệu vào hệ thống và thông báo kết quả
        MuonPhongHoc CTMuonPhongHoc = muonPhongHocService.capNhatThongTinTraPhong(IdLichMuonPhong);
        if (ValidateObject.isNullOrEmpty(CTMuonPhongHoc)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể cập nhật thông tin trả phòng.");
            return "redirect:/CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Cập nhật thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + CTMuonPhongHoc.getIdLichMuonPhongAsString();
    }

    @RequestMapping("/ThemTTMPH") //MARK: - ThemTTMPH GET
    public String showThemTTMPHScreen(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdNhomToHocPhan") int IdNhomToHocPhan) {

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:/DsMPH/XemDsMPH?UID=" + uid;
        }

        // Lấy dữ liệu hiển thị
        NhomToHocPhan CTNhomToHocPhan = lopHocPhanSectionService.layThongTin(IdNhomToHocPhan);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSachPhongKhaDung();

        // Kiểm tra dữ liệu hiển thị
        if(ValidateObject.exsistNullOrEmpty(CTNhomToHocPhan, DsPhongHoc)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTNhomToHocPhan", CTNhomToHocPhan);
        model.addAttribute("QuanLyKhoiTao", QuanLyKhoiTao);
        model.addAttribute("DsPhongHoc", DsPhongHoc);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "CTMPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "ThemTTMPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/ThemTTMPH", method = RequestMethod.POST) //MARK: - ThemTTMPH POST
    public String submitThemTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdNhomToHocPhan") int IdNhomToHocPhan,
            @RequestParam("IdPhongHoc") int IdPhongHoc,
            @RequestParam("MucDich") String MucDich,
            @RequestParam("StartDatetime") String StartDatetime,
            @RequestParam("EndDatetime") String EndDatetime) {

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
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.luuThongTin(IdNhomToHocPhan, IdPhongHoc, QuanLyKhoiTao, StartDatetime, EndDatetime, MucDich);
        if (ValidateObject.isNullOrEmpty(CTLichMuonPhong)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tạo thông tin lịch mượn phòng.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Lưu thông tin thành công");
        return "redirect:../CTMPH/XemTTMPH?UID=" + uid + "&IdLichMuonPhong=" + CTLichMuonPhong.getIdLichMuonPhongAsString();
    }

    @RequestMapping(value = "/XoaTTMPH", method = RequestMethod.POST) //MARK: - XoaTTMPH POST
    public String submitXoaTTMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        // Lấy thông tin quản lý đang trực và kiểm tra kết quả
        QuanLy QuanLyKhoiTao = quanLyService.layThongTinQuanLyDangTruc((String) servletContext.getAttribute("UIDManager"), uid);
        if (ValidateObject.isNullOrEmpty(QuanLyKhoiTao)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        // Xóa thông tin và thông báo kết quả
        if (!lichMuonPhongService.xoaThongTin(IdLichMuonPhong)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể xóa thông tin lịch mượn phòng.");
            return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Xóa thông tin thành công.");
        return "redirect:../DsMPH/XemDsMPH?UID=" + uid;
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
