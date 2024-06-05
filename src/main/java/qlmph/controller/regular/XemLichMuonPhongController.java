package qlmph.controller.regular;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.user.NguoiDung;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;
import qlmph.service.universityBorrowRoom.LichMuonPhongService.GetCommand;
import qlmph.service.user.NguoiDungService;
import qlmph.utils.ValidateObject;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/MPH")
public class XemLichMuonPhongController {

    @Autowired
    private LichMuonPhongService lichMuonPhongService;

    @Autowired
    NguoiDungService nguoiDungService;

    @RequestMapping("/LichSuMuonPhong") // MARK: - LichSuMuonPhong
    public String XemDsMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam("UID") String uid) {

        NguoiDung NguoiDung = nguoiDungService.layThongTinTaiKhoan(uid, "Regular");
        if (ValidateObject.isNullOrEmpty(NguoiDung)) {
            redirectAttributes.addFlashAttribute("messageStatus",
                    "Không thể xác định thông tin người sử dụng, liên hệ với quản lý để được hỗ trợ.");
            return "redirect:/Introduce";
        }

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMuonPhong = lichMuonPhongService.layDanhSachTheoDieuKienLichSu(
                Set.of(GetCommand.TheoNguoiMuonPhong_LichSuMuonPhong, GetCommand.TheoNguoiDung),
                0, null, uid, null, null);

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMuonPhong)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMuonPhong", DsLichMuonPhong);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }
}