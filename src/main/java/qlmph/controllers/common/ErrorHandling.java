package qlmph.controllers.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorHandling {

	@RequestMapping("/Error")
    public ModelAndView showErrorView(@RequestParam ("Message") String e) {
        ModelAndView mav = new ModelAndView("components/errorHandling/error-view-handling");
        mav.addObject("errorMessage", e);
        return mav;
    }

    @ExceptionHandler(Exception.class)
    @RequestMapping()
    public ModelAndView handleException(Exception e) {
        ModelAndView mav = new ModelAndView("components/errorHandling/error-controller-handling");
        mav.addObject("errorMessage", e.getMessage());
        return mav;
    }

}
