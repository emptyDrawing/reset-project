package ga.beauty.reset.services;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface Login_Service {
	
	public String logout(Model model, HttpServletRequest req, HttpServletResponse resp);
	public Model login(Model model, HttpServletRequest req) throws Exception;
	
}
