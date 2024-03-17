package qlmph.controllers.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorHandling {

	@RequestMapping("/Error")
	public String showErrorView() {
		return "components/errorHandling/error-view-handling";
	}

    @ExceptionHandler(Exception.class)
    @RequestMapping()
    public ModelAndView handleException(Exception e) {
        ModelAndView mav = new ModelAndView("components/errorHandling/error-controller-handling");
        mav.addObject("errorMessage", e.getMessage());
        return mav;
    }

}
