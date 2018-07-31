package ga.beauty.reset.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.Comment_Dao;
import ga.beauty.reset.dao.Members_Dao;
import ga.beauty.reset.dao.Reviews_Dao;
import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;

@Controller
public class Mypage_Controller {

	private static final Logger logger = Logger.getLogger(Mypage_Controller.class);
	
	@Autowired
	Members_Dao members_Dao;
	@Autowired
	Reviews_Dao<Reviews_Vo> Reviews_Dao;
	@Autowired
	Comment_Dao<Comment_Vo> Comment_Dao;

	public Mypage_Controller() {
	}
	ObjectMapper mapper = new ObjectMapper();
	
/*	@RequestMapping(value = "/mypage/", method = RequestMethod.GET)
	public String showMain(@SessionAttribute(name="user_type") String user_type, Model model) {
		model.addAttribute("goRoot","../");
		/*if("CEO".equals(user_type) || "직원".equals(user_type)) {
			return "redirect:/admin/";
		}else if("광고주".equals(user_type)) {
			return "mypage/mypage_Adv_main";
		}else if("일반".equals(user_type)) {
			return "mypage/mypage_nor_main";
		}else {
			// TODO 에러
			model.addAttribute("goRoot","./");
			return "errPage";
		}
		model.addAttribute("alist",mapper.writeValueAsString(mypage_ADV_Service.getInfo("", session, req)));
		return ""; 
	}// showMain()
*/	
	//TODO: [sch] mypage sesstion 받아야함.
	@RequestMapping(value = "/mypage/", method = RequestMethod.GET)
	public String showMain(Model model, HttpSession session, HttpServletRequest req) throws SQLException, JsonProcessingException {
		model.addAttribute("goRoot","../");
		/*if("CEO".equals(user_type) || "직원".equals(user_type)) {
			return "redirect:/admin/";
		}else if("광고주".equals(user_type)) {
			return "mypage/mypage_Adv_main";
		}else if("일반".equals(user_type)) {
			return "mypage/mypage_nor_main";
		}else {
			// TODO 에러
			model.addAttribute("goRoot","./");
			return "errPage";
		}*/
		String email=(String) session.getAttribute("login_email");
//		String email=req.getParameter("email");
//		email="cus1@naver.com";
		Members_Vo bean=new Members_Vo();
		bean.setEmail(email);
		bean=members_Dao.selectOne(bean);
		Comment_Vo bean2=new Comment_Vo();
		bean2.setWriter("닉넴1");
		
		model.addAttribute("goRoot","../");
		model.addAttribute("bean", bean);
		model.addAttribute("review_alist",Reviews_Dao.mypage_review("닉넴1"));
		model.addAttribute("comment_alist",Comment_Dao.mypage_list(bean2));
		return "mypage/mypage_nor_main";
	}// showMain()

	
}// 순수 마이페이지 --> 정보조회용
