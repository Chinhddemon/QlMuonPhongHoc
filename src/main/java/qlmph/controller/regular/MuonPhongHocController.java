package qlmph.controller.regular;

import java.util.Date;
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

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityBorrowRoom.MuonPhongHoc;
import qlmph.model.user.NguoiDung;
import qlmph.model.user.QuanLy;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;
import qlmph.service.universityBorrowRoom.MuonPhongHocService;
import qlmph.service.universityBorrowRoom.LichMuonPhongService.GetCommand;
import qlmph.service.user.NguoiDungService;
import qlmph.service.user.QuanLyService;
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
    NguoiDungService nguoiDungService;

    @Autowired
    QuanLyService quanLyService;

    @RequestMapping("/ChonLMPH") // MARK: - ChonLMPH GET
    public String showDsMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam(value = "Command", required = false) String Command) {

        // Lấy và kiểm tra thông tin quản lý đang trực
        QuanLy QuanLyDangTruc = quanLyService.layThongTinTaiKhoan((String) servletContext.getAttribute("UIDManager"));
        NguoiDung NguoiDung = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");
        if (ValidateObject.isNullOrEmpty(QuanLyDangTruc)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tìm thấy thông tin quản lý.");
            return "redirect:../Introduce";
        }
        if(ValidateObject.isNullOrEmpty(NguoiDung)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người sử dụng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/Introduce";
        }

        List<LichMuonPhong> DsLichMuonPhong = null;
        if(ValidateObject.isNullOrEmpty(Command)) {
            if(Command == null) Command = "MacDinh";
            if(Command.equals("")) new Exception("Command rỗng.").printStackTrace();
        }

        // Lấy dữ liệu hiển thị
        switch (Command) {
            case "XemTatCa":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                        Set.of(GetCommand.MacDinh_TheoNgay, GetCommand.TheoTrangThai_ChuaQuaHan, GetCommand.TheoTrangThai_ChuaMuonPhong),
                        null, null, 0, null, null, null, null);

                model.addAttribute("NextUsecaseNavOption1", "MPH");
                model.addAttribute("NextUsecasePathNavOption1", "ChonLMPH");
                break;
            case "MacDinh":
                DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKien(
                    Set.of(GetCommand.MacDinh_TheoNgay, GetCommand.TheoNguoiDung, GetCommand.TheoTrangThai_ChuaQuaHan),
                    null, null, 0, null, uid, null, null);

                model.addAttribute("NextUsecaseNavOption1", "MPH");
                model.addAttribute("NextUsecasePathNavOption1", "ChonLMPH");
                model.addAttribute("NextUsecaseNavParams", "XemTatCa");
                break;
            default:
                new Exception("Command không hợp lệ.").printStackTrace();
                break;
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMuonPhong", DsLichMuonPhong);
        model.addAttribute("NguoiDung", NguoiDung);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "MPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "MPH");

        return "components/boardContent/ds-lich-muon-phong";
    }

    @RequestMapping("/MPH") // MARK: - MPH GET
    public String showLoginForm(Model model,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong,
            @RequestParam("UID") String uid) {

        // Lấy dữ liệu hiển thị
        LichMuonPhong CTLichMuonPhong = lichMuonPhongService.layThongTin(IdLichMuonPhong);
        NguoiDung NguoiMuonPhong = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");
        QuanLy QuanLyDuyet = quanLyService.layThongTinTaiKhoan((String) servletContext.getAttribute("UIDManager"));

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.exsistNullOrEmpty(CTLichMuonPhong, NguoiMuonPhong, QuanLyDuyet)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLichMuonPhong", CTLichMuonPhong);
        model.addAttribute("NguoiMuonPhong", NguoiMuonPhong);
        model.addAttribute("QuanLyDuyet", QuanLyDuyet);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "MPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "MPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/MPH", method = RequestMethod.POST) // MARK: - MPH POST
    public String submit(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("IdLichMuonPhong") String IdLichMuonPhong,
            @RequestParam("UID") String uid,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("YeuCau") String YeuCau) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/MPH/MPH?UID=" + uid;
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyDuyet = quanLyService.layThongTinTaiKhoan((String) servletContext.getAttribute("UIDManager"));
        if (ValidateObject.isNullOrEmpty(QuanLyDuyet)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin quản lý, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        NguoiDung NguoiDung = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");
        if(ValidateObject.isNullOrEmpty(NguoiDung)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người sử dụng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        // Tạo thông tin và thông báo kết quả
        MuonPhongHoc CTMuonPhongHoc = muonPhongHocService.luuThongTin(IdLichMuonPhong, NguoiDung, QuanLyDuyet, YeuCau);
        if (ValidateObject.isNullOrEmpty(CTMuonPhongHoc)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể tạo thông tin sử dụng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/MPH/MPH?UID=" + uid + "&IdLichMuonPhong=" + IdLichMuonPhong;
        }

        redirectAttributes.addFlashAttribute("messageStatus", "Tạo thông tin thành công");
        return "redirect:../Introduce";
    }

    private boolean xacNhanToken(String OTP) {
        if (ValidateObject.isNullOrEmpty(OTP) && !OTP.equals(servletContext.getAttribute("OTP"))) {
            new Exception("Mã xác nhận không đúng.").printStackTrace();
            return false;
        }
        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("OTP", Token.createRandom());
        return true;
    }
}