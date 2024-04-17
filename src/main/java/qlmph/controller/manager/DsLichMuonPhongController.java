package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.LichMuonPhong;
import qlmph.service.LichMuonPhongService;
import qlmph.utils.ValidateObject;

@Controller
@RequestMapping("/DsMPH")
public class DsLichMuonPhongController {

    @Autowired
    LichMuonPhongService lichMuonPhongService;

    @RequestMapping("/XemDsMPH") // MARK: - XemDsMPH
    public String showDsMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> DsLichMPH = lichMuonPhongService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (ValidateObject.isNullOrEmpty(DsLichMPH)) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", DsLichMPH);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }

}