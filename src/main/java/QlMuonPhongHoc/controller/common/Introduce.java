package QlMuonPhongHoc.controller.common;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.Controller;

@Controller
@RequestMapping("/Introduce")
public class Introduce {
    
    @RequestMapping("")
	public String showLoginForm() {
		return "/Introduce";
	}
}
