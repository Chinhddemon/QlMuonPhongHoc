package qlmph.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/DsMPH")
public class DsMuonPhongHoc {

	@RequestMapping("/XemDsMPH")
	public String showDsMPH() {

		return "/components/boardContent/ds-muon-phong-hoc";
	}

}