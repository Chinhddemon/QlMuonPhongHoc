package QlMuonPhongHoc.controller.manager;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {

	@RequestMapping("/DsMPH")
	public String showLoginForm() {
		// Yêu cầu: 
            // setAttribute UIDManager để truy cập trang
            // thay đổi nội dung phần javascript trong đường dẫn
		return "/components/boardContent/DsMuonPhongHoc";
	}

}