package qlmph.controller.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.service.LichMuonPhongService;

@Controller
@RequestMapping("/DsMPH")
public class DsLichMuonPhongController {

    @Autowired
    LichMuonPhongService lichMuonPhongService;

    @RequestMapping("/XemDsMPH")
    public String showDsMPH(Model model) {

        // Lấy dữ liệu hiển thị
        List<LichMuonPhong> dsLichMPH = lichMuonPhongService.layDanhSach();

        // Kiểm tra dữ liệu hiển thị
        if (dsLichMPH == null) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải dữ liệu.");
        }

        // Thiết lập dữ liệu hiển thị
        model.addAttribute("DsLichMPH", dsLichMPH);

        // Thiết lập chuyển hướng trang kế tiếp
        model.addAttribute("NextUsecaseTableOption1", "CTMPH");
        model.addAttribute("NextUsecasePathTableOption1", "XemTTMPH");

        return "components/boardContent/ds-lich-muon-phong";
    }

}