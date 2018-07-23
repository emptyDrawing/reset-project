package ga.beauty.reset;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.runner.Common_Listener;

@Controller
public class Home_Controller {
	
	Logger logger = Logger.getLogger(Home_Controller.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();		
        logger.info(LogEnum.INTER+"메인페이지에 {ip:"+ip+", locale:"+locale+"} 가 들어왔습니다. ");
		return "index";
	}
	
	@RequestMapping(value="/error")
	public String test() throws IOException{
		{
			throw new IOException("에러 발생 잠시후 다시 이용해 주세요.");
		}
	}

}
