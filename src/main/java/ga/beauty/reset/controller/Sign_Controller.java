package ga.beauty.reset.controller;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.services.Sign_Service;

@Controller
public class Sign_Controller {

	Logger logger = Logger.getLogger(Sign_Controller.class);

	@Autowired
	private Sign_Service sign_Service;

	
	public Sign_Controller() {
	}

	// 메인페이지나 회원가입 버튼 눌렀을때 처리
	@RequestMapping(value = "/sign/", method = RequestMethod.GET)
	public String showSignpage(HttpServletRequest req, Model model, HttpSession session) {
		model.addAttribute("goRoot", "../");
		if (session.getAttribute("old_url") == null)
			session.setAttribute("old_url", req.getHeader("referer"));
		if (session.getAttribute("login_route") == null)
			session.setAttribute("login_route", "normal");
		return "sign/sign_normal";
	}

	// 유저등록 : 일반일경우 url에 리턴넣음
	@RequestMapping(value = "/sign/", method = RequestMethod.POST) // Ajax
	@ResponseBody
	public Map<String, Object> sign(User_Vo userBean, Members_Vo memberBean, Companys_Vo componyBean,
			HttpSession session) throws NoSuchAlgorithmException, SQLException {
		int result = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		if (userBean.getUser_type().equals("일반")) {
			logger.debug("일반유저 일반들어옴");
			map.put("url", session.getAttribute("old_url"));
			result = sign_Service.signUp(userBean, memberBean);
		} else {
			result = sign_Service.signUp(userBean, componyBean);
		}
		map.put("result", result);
		return map;
	}

	// 유저 등록시 중복체크 검사
	@RequestMapping(value = "/sign/{command}", method = RequestMethod.POST) // ajax
	@ResponseBody
	public Map<String, Object> checkSomething(@PathVariable String command,
			@RequestParam(value = "target") String target) throws SQLException {
		int result = 0; // 연결실패 0 성공 200 연결됬는데 이상한 실패 9999
		result = sign_Service.checkSomething(command, target);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

}
