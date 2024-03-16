package qlmph.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorHandling {

//	@RequestMapping()
//	public String showErrorController() {
//		return "components/errorHandling/error-controller-handling";
//	}
	
	@RequestMapping("/Error")
	public String showErrorView() {
		return "components/errorHandling/error-view-handling";
	}
	
}
