package QlMuonPhongHoc.controller.manager;

@Controller
@RequestMapping("/DsLH")
public class DsLopHoc {
    
    @RequestMapping("/DsLH")
    public String showLoginForm() {
        // Yêu cầu: 
            // setAttribute UIDManager để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
        return "/home/HomeManager";
    }
}
