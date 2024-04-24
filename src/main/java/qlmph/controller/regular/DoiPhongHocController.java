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

import qlmph.model.LichMuonPhong;
import qlmph.model.LopHocPhanSection;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.NhomHocPhan;
import qlmph.model.PhongHoc;
import qlmph.model.QuanLy;
import qlmph.service.LichMuonPhongService;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.NhomHocPhanService;
import qlmph.service.PhongHocService;
import qlmph.service.QuanLyService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;
import qlmph.service.NguoiMuonPhongService;

@Controller
@RequestMapping("/DPH")
public class DoiPhongHocController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private NhomHocPhanService nhomHocPhanService;

    @Autowired
    private LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    private PhongHocService phongHocService;

    @Autowired
    private LichMuonPhongService lichMuonPhongService;

    @Autowired
    private NguoiMuonPhongService nguoiMuonPhongService;

    @Autowired
    private QuanLyService quanLyService;

    @RequestMapping("/ChonLHP")
    public String showChonLhScreen(Model model) {

        // Lấy dữ liệu hiển thị
        List<NhomHocPhan> DsLopHocPhan = nhomHocPhanService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (DsLopHocPhan == null) {
            model.addAttribute("Message", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLopHocPhan", DsLopHocPhan);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableRowChoose", "DPH");
        model.addAttribute("NextUsecasePathTableRowChoose", "DPH");

        return "components/boardContent/ds-lop-hoc-phan";
    }

    @RequestMapping("/DPH")
    public String showDPHScreen(Model model,
            @RequestParam("UID") String uid,
            @RequestParam("IdLHP") int IdLHP) {

        // Lấy dữ liệu hiển thị
        LopHocPhanSection CTLopHocPhanSection = lopHocPhanSectionService.layThongTin(IdLHP);
        List<PhongHoc> DsPhongHoc = phongHocService.layDanhSach();
        NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

        // Kiểm tra dữ liệu hiển thị
        if (CTLopHocPhanSection == null || NgMuonPhong == null) {
            model.addAttribute("Message", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLopHocPhanSection", CTLopHocPhanSection);
        model.addAttribute("DsPhongHoc", DsPhongHoc);
        model.addAttribute("NgMuonPhong", NgMuonPhong);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseSubmitOption2", "DPH");
        model.addAttribute("NextUsecasePathSubmitOption2", "DPH");

        return "components/boardContent/ct-muon-phong-hoc";
    }

    @RequestMapping(value = "/DPH", method = RequestMethod.POST)
    public String submit(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid,
            @RequestParam("IdLHPSection") String IdLHPSection,
            @RequestParam("IdPH") int IdPH,
            @RequestParam("ThoiGian_KT") String ThoiGian_KT,
            @RequestParam("LyDo") String LyDo,
            @RequestParam("XacNhan") String XacNhan,
            @RequestParam("YeuCau") String YeuCau) {

        // Kiểm tra mã xác nhận
        if (!xacNhanToken(XacNhan)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Mã xác nhận không đúng.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdLHPSection=" + IdLHPSection;
        }

        // Lấy thông tin quản lý đang trực
        QuanLy QuanLyDuyet = quanLyService.layThongTin((String) servletContext.getAttribute("UIDManager"));
        if (ValidateObject.isNullOrEmpty(QuanLyDuyet)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin quản lý, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdLHPSection=" + IdLHPSection;
        }

        // Lấy thông tin người mượn phòng
        NguoiMuonPhong NguoiMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);
        if (ValidateObject.isNullOrEmpty(NguoiMuonPhong)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người mượn phòng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdLHPSection=" + IdLHPSection;
        }

        // Kiểm tra thông tin nhập vào
        if (ValidateObject.exsistNullOrEmpty(NguoiMuonPhong, QuanLyDuyet, IdLHPSection, IdPH, ThoiGian_KT, LyDo,
                YeuCau)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Dữ liệu không hợp lệ.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdLHPSection=" + IdLHPSection;
        }

        // Lưu thông tin và thông báo kết quả
        LichMuonPhong CTLichMPH = lichMuonPhongService.luuThongTinDoiPhongHoc(IdLHPSection, IdPH, QuanLyDuyet,
                ThoiGian_KT, LyDo, NguoiMuonPhong, YeuCau);
        if (ValidateObject.isNullOrEmpty(CTLichMPH)) {
            redirectAttributes.addFlashAttribute("messageStatus", "Không thể tạo thông tin lịch mượn phòng.");
            return "redirect:/DPH/DPH?UID=" + uid + "&IdLHPSection=" + IdLHPSection;
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
