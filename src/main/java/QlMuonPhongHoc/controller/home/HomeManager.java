package QlMuonPhongHoc.controller.home;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeManager {

	@RequestMapping("")
	public String showLoginForm() {
		return "/home/HomeManager";
	}
}
