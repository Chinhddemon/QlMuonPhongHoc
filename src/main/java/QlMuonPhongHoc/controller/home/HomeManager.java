package QlMuonPhongHoc.controller.home;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.Controller;

@Controller
@RequestMapping("/Home")
public class HomeManager {

	@RequestMapping("")
	public String showLoginForm() {
		return "/home/HomeManager";
	}
}
