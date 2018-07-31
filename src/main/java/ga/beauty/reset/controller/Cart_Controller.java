package ga.beauty.reset.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ga.beauty.reset.services.Cart_Service;

@Controller
public class Cart_Controller {
	Logger logger=Logger.getLogger(getClass());
	String goRoot="";
	
	@Autowired
	Cart_Service Cart_service;
	
	// 찜하기 확인
	@RequestMapping(value="/item/cart",method=RequestMethod.GET)
	public void cart_check(@RequestParam("item") int item,@RequestParam("email") String email,HttpServletResponse resp) throws IOException, SQLException {
		logger.debug("param: "+item+" "+email);
		resp.getWriter().print(Cart_service.Cart_check(item, email));
		
	}
	
	// 찜목록 조회
	@RequestMapping(value="/item/cart",method=RequestMethod.POST)
	public String cart_List(@RequestParam("email") String email,Model model) throws SQLException, IOException {
		logger.debug("param: "+email);
		model.addAttribute("alist", Cart_service.Cart_List(email));
		model.addAttribute(goRoot, "../../../");
		return "template/mypage_Cart_ajax";
	}
	
	// 찜목록에 추가
	@RequestMapping("/item/cartAdd")
	public void cart_Add(@RequestParam("item") int item,@RequestParam("email") String email,HttpServletResponse resp) throws SQLException, IOException {
		logger.debug("param: "+item+" "+email);
		resp.getWriter().print(Cart_service.Cart_Add(item, email));
	}
	
	// 찜목록에서 제거
	@RequestMapping("/item/cartDel")
	public void cart_Del(@RequestParam("item") int item,@RequestParam("email") String email,HttpServletResponse resp) throws SQLException, IOException {
		logger.debug("param: "+item+" "+email);
		resp.getWriter().print(Cart_service.Cart_Del(item, email));
	}

}
