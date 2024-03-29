package qlmph.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/DsNgMPH")
public class DsNgMuonPhong {
    
    @RequestMapping("/DsNgMPH")
    public String showLoginForm(
            @RequestParam ("Message") String Message,
            Model model) {
        // Mẫu xử lý service
		// List<TTNgMPH> dsNgMPH = TTNgMPHService.getByIdLMPH();
		
		// Tạo khối dữ liệu hiển thị
		// Mẫu dữ liệu
		// List<TTNgMPH> dsNgMPH = new ArrayList<TTNgMPH>();
		
		// Thiết lập khối dữ liệu hiển thị
        // Mẫu hiển thị
		// model.addAttribute("DsNgMPH", dsNgMPH);

        // Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "");
		model.addAttribute("NextUsecasePathTable", "");
        return "components/boardContent/ds-ng-muon-phong-hoc";
    }

}