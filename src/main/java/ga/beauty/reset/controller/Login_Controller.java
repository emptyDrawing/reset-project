package ga.beauty.reset.controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.Companys_Dao;
import ga.beauty.reset.dao.Members_Dao;
import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.services.Login_Service;
import ga.beauty.reset.services.Sign_Service;

@Controller
public class Login_Controller {
	
	private static final Logger logger = Logger.getLogger(Login_Controller.class);

	// 서비스 분기용
	
	@Autowired
	private Login_Service login_kakao;
	@Autowired
	private Login_Service login_Naver;
	@Autowired
	private Login_Service login_Google;
	@Autowired
	private Login_Service login_Normal;
	@Autowired
	private Sign_Service sign_Service;
	
	@Autowired
	private Members_Dao members_Dao;
	
	@Autowired
	private Companys_Dao companys_Dao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	public Login_Controller() {
	}
	
	@RequestMapping(value="/logout/", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		if((boolean) session.getAttribute("login_on")){
				session.invalidate(); // TODO 세션초기화
				//session.setAttribute("login_on", false);
			}
		return "redirect:/";
	}
	
	@RequestMapping(value ="/login/", method=RequestMethod.GET)
	public String showLoginMain(HttpServletRequest req, Model model, HttpSession session) {
		model.addAttribute("goRoot", "../");
		if(session.getAttribute("old_url")==null) session.setAttribute("old_url", req.getHeader("referer"));
		System.out.println((String)session.getAttribute("old_url"));
		return "login/login_main";
	}
	
	// 로그인 방식-결과 에따라 sign으로 이동할지 기존페이지로 rediect 할지 정해야됨.
	@RequestMapping(value ="/login/{loginPath}/", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectLoginService(@PathVariable String loginPath, Model model
			, HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException, SQLException {
		// 서비스 분기용
		Login_Service login_Service = null;
		if("naver".equals(loginPath)) {
			login_Service = login_Naver;
		}else if("kakao".equals(loginPath)){
			login_Service = login_kakao;
		}else if("google".equals(loginPath)) {
			login_Service = login_Google;
		}else {
			login_Service = login_Normal;
		}
		try {
			logger.debug("["+req.getContextPath()+"] {"+loginPath+"} : login-click ");
			model = login_Service.login(model,req);
		} catch (Exception e) {
			logger.debug("["+req.getContextPath()+"] {"+loginPath+"} : login_Service.login().. err..");
			e.printStackTrace();
			// TODO 에러페이지
		}// try-catch end
		
		// 닉네임정보는 컨트롤러에서 넣어줍니다.
		HttpSession session = req.getSession();
		if(session.getAttribute("login_on")!=null && (boolean)session.getAttribute("login_on")) {
			String login_email = (String) session.getAttribute("login_email");
			String login_user_type = (String) session.getAttribute("login_user_type");
				if(login_user_type.equals("일반")) {
					Members_Vo bean = new Members_Vo();
					bean.setEmail((String)session.getAttribute("login_email"));
					session.setAttribute("login_nick" ,members_Dao.selectOne(bean).getNick());
					logger.debug("로그인성공:"+bean);
				}else {
					Companys_Vo bean = new Companys_Vo();
					bean.setEmail((String)session.getAttribute("login_email"));
					session.setAttribute("login_nick" ,companys_Dao.selectOne(bean).getManager());
					session.setAttribute("login_comName" ,companys_Dao.selectOne(bean).getCompany());

					logger.debug("로그인성공:"+bean);
				}
		}
		if(req.getAttribute("login_err")==null) return (String) req.getAttribute("login_result");
		else return "errPage";
	}//selectLoginService()
	
	
	@RequestMapping(value="/login/adds/", method=RequestMethod.GET)
	public String showAdds(Model model) {
		model.addAttribute("goRoot", "../../");
		return "login/login_adds";
	}

	@RequestMapping(value="/login/adds/", method=RequestMethod.POST) // ajax
	@ResponseBody
	public Map<String, Object> showAdds(Model model, String command, HttpSession session) throws NoSuchAlgorithmException, SQLException {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		int result = 0;
		if(command.equals("adds_yes")) {
			User_Vo target = new User_Vo();
			Members_Vo memGetNick = new Members_Vo();
			String email = (String)session.getAttribute("login_email");
			result= sign_Service.updateProfile(command,session);
			if(result==1) {
				// 로그인처리도 해야됨
				session.setAttribute("login_on", true);
				resultMap.put("result", 200);
				resultMap.put("redirect", (String)session.getAttribute("old_url"));
				logger.debug("로그인성공:"+memGetNick);
				return resultMap;
			}else {
				resultMap.put("result", 9999);
				return resultMap;
			}
		}else if(command.equals("adds_no")){
			String swap = (String)session.getAttribute("old_url");
			session.invalidate(); // TODO [kss]세션초기화
			session.setAttribute("old_url",swap);
			resultMap.put("result", 300);
			resultMap.put("redirect", "/reset/login/"); // TODO [kss]reset 지워야됨.
			return resultMap;
		}else {
			// adds_back
			String swap = (String)session.getAttribute("old_url");
			session.invalidate(); // TODO [kss]세션초기화
			resultMap.put("result", 300);
			resultMap.put("redirect", swap);
			return resultMap;
		}
	}
	
	@RequestMapping(value ="/login/find/", method=RequestMethod.POST) // ajax
	@ResponseBody
	public Map<String, Object> showFind(HttpServletRequest req, Model model) throws SQLException, NoSuchAlgorithmException, MessagingException {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		int result = 0;
		result = sign_Service.findPw(req);
		if(result==1) {
			// TODO 이메일보내기 서비스 해야됨
			String setfrom ="resetbeauty@gmail.com";
			String toemail = req.getParameter("emailFind");
			String title = "Reset : 비밀번호 메일";
			String contents = req.getParameter("tmp1")+"\n\n\n 입니다.";
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
		
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(toemail);
			messageHelper.setSubject(title);
			messageHelper.setText(contents);
			mailSender.send(msg);

			resultMap.put("result",200);
			resultMap.put("msg","가입시 입력한 이메일로 임시비밀번호를 보냈습니다.");
			return resultMap;
		}else if(result==0){
			resultMap.put("result",501);
			resultMap.put("msg","알수 없는 오류가 발생했습니다. 잠시후 이용해주세요...");
			return resultMap;
		}
		resultMap.put("result",400);
		resultMap.put("msg","잘못된 정보를 입력하셨습니다.");
		return resultMap;
	}

	
}
