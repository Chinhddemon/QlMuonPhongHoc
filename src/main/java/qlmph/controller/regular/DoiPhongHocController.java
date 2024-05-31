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

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.model.user.NguoiDung;
import qlmph.model.universityCourse.NhomHocPhan;
import qlmph.model.universityBase.PhongHoc;
import qlmph.model.user.QuanLy;
import qlmph.service.universityBase.PhongHocService;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;
import qlmph.service.universityCourse.NhomHocPhanService;
import qlmph.service.universityCourse.NhomToHocPhanService;
import qlmph.service.user.NguoiDungService;
import qlmph.service.user.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DPH")
public class DoiPhongHocController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private NhomHocPhanService nhomHocPhanService;

    @Autowired
    private NhomToHocPhanService lopHocPhanSectionService;

    @Autowired
    private PhongHocService phongHocService;

    @Autowired
    private LichMuonPhongService lichMuonPhongService;

    @Autowired
    private NguoiDungService nguoiDungService;

    @Autowired
    private QuanLyService quanLyService;

    @RequestMapping("/ChonHocPhan")
    public String showChonLhScreen(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsNhomHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsNhomHocPhan)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsNhomHocPhan", DsNhomHocPhan);
        // model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "DPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "DPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }

    @RequestMapping("/DPH")
    public String showDPHScreen(Model model,
            @RequestParam("UID") String uid,
            @RequestParam("IdNhomToHocPhan") int IdNhomToHocPhan) {

        // Lấy dữ liệu hiển thị
        NhomToHocPhan CTNhomToHocPhan = lopHocPhanSectionService.layThongTin(IdNhomToHocPhan);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();
        NguoiDung NgMuonPhong = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");

        // Kiểm tra dữ liệu hiển thị
        if (CTNhomToHocPhan == null || NgMuonPhong == null) {
            model.addAttribute("Message", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTNhomToHocPhan", CTNhomToHocPhan);
        model.addAttribute("DsPhongHoc", DsPhongHoc);
        model.addAttribute("NgMuonPhong", NgMuonPhong);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "DPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "DPH");

        return "components/boardContent/ct-lich-muon-phong";
    }

    @RequestMapping(value = "/DPH", method = RequestMethod.POST)
    public String submit(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdNhomToHocPhan") String IdNhomToHocPhan,
            @RequestParam("IdPhongHoc") int IdPhongHoc,
            @RequestParam("MucDich") String MucDich,
            @RequestParam("EndDatetime") String EndDatetime,
            @RequestParam(value = "LyDo", required = false) String LyDo,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("YeuCau") String YeuCau) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdNhomToHocPhan=" + IdNhomToHocPhan;
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyDuyet = quanLyService.layThongTinTaiKhoan((String) servletContext.getAttribute("UIDManager"));
        if (ValidateObject.isNullOrEmpty(QuanLyDuyet)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin quản lý, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdNhomToHocPhan=" + IdNhomToHocPhan;
        }

        // Lấy thông tin người mượn phòng
        NguoiDung NguoiDung = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");
        if (ValidateObject.isNullOrEmpty(NguoiDung)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người mượn phòng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdNhomToHocPhan=" + IdNhomToHocPhan;
        }

        // Lưu thông tin và thông báo kết quả
        LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTinDoiPhongHoc(IdNhomToHocPhan, IdPhongHoc, QuanLyDuyet,
                EndDatetime, LyDo, NguoiDung, YeuCau, MucDich);
        if (ValidateObject.isNullOrEmpty(CTLichMPH)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tạo thông tin lịch mượn phòng.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdNhomToHocPhan=" + IdNhomToHocPhan;
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
