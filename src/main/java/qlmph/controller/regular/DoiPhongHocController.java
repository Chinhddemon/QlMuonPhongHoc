package qlmph.controller.regular;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import qlmph.model.LopHocPhanSection;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.NhomHocPhan;
import qlmph.service.LopHocPhanSectionService;
import qlmph.service.NhomHocPhanService;
import qlmph.utils.Token;
import qlmph.utils.ValidateObject;
import qlmph.service.NguoiMuonPhongService;

@Controller
@RequestMapping("/DPH")
public class DoiPhongHocController {

    @Autowired
    private ServletContext servletContext;

    @Autowired
    NhomHocPhanService nhomHocPhanService;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    NguoiMuonPhongService nguoiMuonPhongService;

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
            @RequestParam("IdLHP") int IdLHP,
            @RequestParam("UID") String uid) {

        // Lấy dữ liệu hiển thị
        LopHocPhanSection CTLopHocPhanSection = lopHocPhanSectionService.layThongTin(IdLHP);
        NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

        // Kiểm tra dữ liệu hiển thị
        if (CTLopHocPhanSection == null || NgMuonPhong == null) {
            model.addAttribute("Message", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("CTLopHocPhanSection", CTLopHocPhanSection);
        model.addAttribute("NgMuonPhong", NgMuonPhong);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTable", null);
        model.addAttribute("NextUsecasePathTable", null);

        return "components/boardContent/ct-muon-phong-hoc";
    }

    @RequestMapping(value = "/DPH", method = RequestMethod.POST)
    public String submit(Model model,
            @RequestParam("IdLHP") int IdLHP,
            @RequestParam("UID") String uid) {
                
        // Lấy dữ liệu hiển thị
        NhomHocPhan CtLopHocPhan = nhomHocPhanService.layThongTin(IdLHP);
        NguoiMuonPhong NgMuonPhong = nguoiMuonPhongService.layThongTinTaiKhoan(uid);

        String token = (String) servletContext.getAttribute("token");

        // Tạo mã xác nhận mới khi xác nhận thành công
        servletContext.setAttribute("token", Token.createRandom());

        // Thiết lập khối dữ liệu hiển thị

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
        model.addAttribute("NextUsecaseTable", null);
        model.addAttribute("NextUsecasePathTable", null);
        // Yêu cầu:
        // setAttribute UIDRegular để truy cập trang
        // thay đổi nội dung phần javascript trong đường dẫn
        return "components/boardContent/ct-muon-phong-hoc";
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
