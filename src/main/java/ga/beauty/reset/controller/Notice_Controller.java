package ga.beauty.reset.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ga.beauty.reset.dao.entity.Notice_Vo;
import ga.beauty.reset.services.Notice_Service;
import ga.beauty.reset.utils.CrudEnum;
import ga.beauty.reset.utils.LogEnum;

@Controller
public class Notice_Controller {
	private static final Logger logger = Logger.getLogger(Notice_Controller.class);
	
	@Autowired
	Notice_Service service;
	
	String view = "redirect:/admin/notice";
	String goRoot = "../";
	public Notice_Controller() {
	}
	
	//고객 공지사항 리스트 보여주기
	//notice list / "notice/notice.jsp"  / 이지현	
	@RequestMapping(value="/notice", method = RequestMethod.GET)
	public String show(Model model, HttpServletRequest req) throws SQLException {
		String goRoot = "./";
		service.listPage(model);
		
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.LIST + "{ip:"+ip+"}가 공지사항 리스트를 요청했습니다.");
		
		model.addAttribute("goRoot", goRoot);
		return "notice/notice";
	}	

	
	//관리자 공지사항 리스트 보여주기
	//TODO admin notice list / "admin/admin_notice.jsp" / 이지현	
	@RequestMapping(value="/admin/notice")
	public String showList(Model model, HttpServletRequest req) throws SQLException {
		service.listPage(model);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.LIST + "관리자 페이지에서 {ip:"+ip+"}가 공지사항 리스트를 요청했습니다.");
		model.addAttribute("goRoot", "../");
		return "admin/admin_notice";
	}	
	
	//관리자 공지사항 입력
	//TODO admin notice add / "admin/admin_notice.jsp"  / 이지현	
	@RequestMapping(value="/admin/notice",method=RequestMethod.POST)
	public String add(@ModelAttribute Notice_Vo bean, Model model, HttpServletRequest req) throws SQLException {
		logger.debug(LogEnum.DEBUG+"Admin notice add - before");
		service.addPage(bean);
		logger.debug(LogEnum.DEBUG+"Admin notice add - after");
		
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.ADD + "관리자 페이지에서 {ip:"+ip+"}가 공지글 [No."+bean.getNo_no()+"]을 입력하였습니다.");
		
		model.addAttribute("goRoot", "../");
		return view;
	}
	
	//관리자 공지사항 수정
	//TODO admin notice edit / / "admin/admin_notice.jsp"  / 이지현
	@RequestMapping(value="/admin/notice/{no_no}", method=RequestMethod.PUT)
	public String edit(@PathVariable("no_no") int no_no, @ModelAttribute Notice_Vo bean, Model model, HttpServletRequest req) throws SQLException {
		service.updatePage(bean);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.UPDATE + "관리자 페이지에서 {ip:"+ip+"}가 공지글 [No."+bean.getNo_no()+"]을 수정하였습니다.");
		
		return view;
	}
	
	//관리자 공지사항 삭제
	//TODO admin notice delete / "admin/admin_notice.jsp" / 이지현
	@RequestMapping(value="/admin/notice/{no_no}",method=RequestMethod.DELETE)
	public String delete(@PathVariable("no_no") int no_no, HttpServletRequest req) throws SQLException {
		logger.debug(LogEnum.DEBUG+"Admin notice delete");
		service.deletePage(no_no);
		logger.debug(LogEnum.DEBUG+"Admin notice delete - done");
		
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DELETE + "관리자 페이지에서 {ip:"+ip+"}가 공지글 [No."+no_no+"]을 삭제하였습니다.");
		
		return view;
	}
}//class end
