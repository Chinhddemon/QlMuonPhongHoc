package qlmph.controllers.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Introduce")
public class Introduce {
    
    @RequestMapping()
	public String showScreen() {
		return "introduce";
	}
}
