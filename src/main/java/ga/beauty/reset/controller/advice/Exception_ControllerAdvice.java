package ga.beauty.reset.controller.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class Exception_ControllerAdvice {

	@ExceptionHandler(Exception.class)
	@RequestMapping(value="/error")
	public String exception(Exception e) {
		return "error/error";
	}
}
