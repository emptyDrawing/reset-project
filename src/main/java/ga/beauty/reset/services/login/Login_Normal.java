package ga.beauty.reset.services.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Companys_Dao;
import ga.beauty.reset.dao.Members_Dao;
import ga.beauty.reset.dao.User_Dao;
import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.services.Login_Service;
import ga.beauty.reset.utils.PasswordUtil;

@Service("login_Normal")
public class Login_Normal implements Login_Service {

	private static Logger logger = Logger.getLogger(Login_Normal.class);


	@Autowired
	User_Dao user_Dao;

	@Autowired
	Members_Dao members_Dao;

	@Autowired
	Companys_Dao companys_Dao;

	@Autowired
	PasswordUtil passwordUtil;
	
	
	public Login_Normal() {
	}
	
	@Override
	public String logout(Model model, HttpServletRequest req, HttpServletResponse resp) {
		req.getSession().invalidate();
		return "index";
	}

	@Override
	@Transactional
	public Model login(Model model, HttpServletRequest req) throws Exception {
		HttpServletRequest request = req;
		HttpSession userSession = req.getSession();
		String method = req.getMethod();
		if(method.equals("GET")) {
			req.setAttribute("login_result", "login/login_view");
		}else if(method.equals("POST")) { // ajax로 들어올꺼이
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			logger.debug("들어온 비밀번호:"+password);

			if(email==null || password == null) {
				// 잘못된 값 들어온 상황
				req.setAttribute("result", 400);
				req.setAttribute("msg", "잘못된 값을 입력하셨습니다.");
				req.setAttribute("login_result", "login/login_normal");
				return model;
			}
			User_Vo testBean = new User_Vo();
			testBean.setEmail(email);
			int result =user_Dao.checkInfo(testBean);
			logger.debug("email 있는지 체크"+result);
			if(result!=1) {
				req.setAttribute("result", 401);
				req.setAttribute("msg", "등록된 이메일이 없습니다.");
				req.setAttribute("login_result", "login/login_normal");
				return model;
			}
			
			User_Vo userBean = new User_Vo();
			userBean.setEmail(email);
			User_Vo checkBean = user_Dao.selectOne(userBean);
			if(!checkBean.getJoin_route().contains("normal")){
				// TODO 연동할건지 물어봐야됨 일반을
				Members_Vo tmpM = new Members_Vo();
				tmpM.setEmail(email);
				Members_Vo compare = members_Dao.selectOne(tmpM);
				userSession.setAttribute("join_route", checkBean.getJoin_route());
				userSession.setAttribute("login_user_type", checkBean.getUser_type());
				userSession.setAttribute("login_email", email);
				userSession.setAttribute("tmp", passwordUtil.getEncryptSHA256(password+compare.getNick()));
				userSession.setAttribute("login_route","normal");
				req.setAttribute("result", 300);
				req.setAttribute("msg", "다른 경로로 연결되어 있습니다.");
				req.setAttribute("redirect", "/reset/login/adds/");//TODO 나중에 reset 지워야됨.
				req.setAttribute("login_result", "login/login_normal");
				return model;
			}	
			// normal 있을때 - 비번 가지고오기
			String orginPW = checkBean.getPassword();
			String comparePw = "";
			Companys_Vo tmpC = new Companys_Vo();
			Members_Vo tmpM = new Members_Vo();
			if(!checkBean.getUser_type().equals("일반")) {
				Companys_Vo compare = companys_Dao.selectOne(tmpC);
				comparePw = passwordUtil.getEncryptSHA256(password+compare.getBisnum());
			}else {
				tmpM.setEmail(email);
				System.out.println("일반체크"+password);
				Members_Vo compare = members_Dao.selectOne(tmpM);
				comparePw = passwordUtil.getEncryptSHA256(password+compare.getNick());
			}
			if(orginPW.equals(comparePw)) {
				// 로그인완료
				userSession.setAttribute("login_user_type", checkBean.getUser_type());
				userSession.setAttribute("login_email", checkBean.getEmail());
				userSession.setAttribute("login_on", true);
				req.setAttribute("result", 200);
				req.setAttribute("msg", "로그인 성공");
				req.setAttribute("redirect", userSession.getAttribute("old_url"));//이전로그
				req.setAttribute("login_result", "login/login_normal");
				return model;
			}else {
				req.setAttribute("result", 402);
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
				req.setAttribute("login_result", "login/login_normal");
				return model;
			}
		}// end post()
		return model;
	}// end login()
}// end Login_Normal
