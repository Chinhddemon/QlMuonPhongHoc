package qlmph.controller.manager;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.service.LichMuonPhongService.GetCommand;
import qlmph.utils.ValidateObject;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/DsMPH")
public class DsLichMuonPhongController {

    @Autowired
    LichMuonPhongService lichMuonPhongService;

    @RequestMapping("/XemDsMPH") // MARK: - XemDsMPH
    public String XemDsMPH(Model model,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "ThoiGian_BD", required = false) String ThoiGian_BD,
            @RequestParam(value = "ThoiGian_KT", required = false) String ThoiGian_KT,
            @RequestParam(value = "IdLHP", required = false) String IdLHP,
            @RequestParam(value = "MaGVGiangDay", required = false) String MaGVGiangDay,
            @RequestParam(value = "MaNgMPH", required = false) String MaNgMPH) {

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMPH = null;

        if (ValidateObject.allNullOrEmpty(ThoiGian_BD, ThoiGian_KT, MaGVGiangDay, MaNgMPH) && ValidateObject.isNullOrEmpty(IdLHP)) {
            DsLichMPH = lichMuonPhongService.layDanhSach();
        } else {
            Set<GetCommand> Commands = new HashSet<>();
            if (ValidateObject.exsistNotNullOrEmpty(ThoiGian_BD, ThoiGian_KT)) {
                Commands.add(GetCommand.TheoThoiGian_LichMuonPhong);
            }
            if (ValidateObject.isNullOrEmpty(IdLHP)) {
                Commands.add(GetCommand.TheoId_LopHocPhan);
            }
            if (ValidateObject.exsistNotNullOrEmpty(MaGVGiangDay)) {
                Commands.add(GetCommand.TheoMa_GiangVienGiangDay);
            }
            if (ValidateObject.exsistNotNullOrEmpty(MaNgMPH)) {
                Commands.add(GetCommand.TheoMa_NguoiMuonPhong);
            }
            DsLichMPH = lichMuonPhongService.layDanhSachTheoDieuKien(Commands, ThoiGian_BD, ThoiGian_KT, IdLHP,
                    MaGVGiangDay, MaNgMPH);
        }

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMPH)) {
            model.addAttribute("messageStatus", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", DsLichMPH);
        model.addAttribute("CurrentDateTime", new Date());

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }
}