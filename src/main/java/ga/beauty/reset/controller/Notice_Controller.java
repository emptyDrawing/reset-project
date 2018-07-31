package ga.beauty.reset.controller;

import java.sql.SQLException;

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

@Controller
public class Notice_Controller {
	private static final Logger log = Logger.getLogger(Notice_Controller.class);
	
	@Autowired
	Notice_Service service;
	
	String view = "redirect:/admin/notice";
	String goRoot = "../";
	public Notice_Controller() {
	}
	
	//고객 공지사항 리스트 보여주기
	//notice list / "notice/notice.jsp"  / 이지현	
	@RequestMapping(value="/notice", method = RequestMethod.GET)
	public String show(Model model) throws SQLException {
		String goRoot = "./";
		service.listPage(model);
		log.debug("notice - show List");
		model.addAttribute("goRoot", goRoot);
		return "notice/notice";
	}	

	
	//관리자 공지사항 리스트 보여주기
	//TODO admin notice list / "admin/admin_notice.jsp" / 이지현	
	@RequestMapping(value="/admin/notice")
	public String showList(Model model) throws SQLException {
		service.listPage(model);
		log.debug("Admin notice - show List");
		model.addAttribute("goRoot", "../");
		return "admin/admin_notice";
	}	
	
	//관리자 공지사항 입력
	//TODO admin notice add / "admin/admin_notice.jsp"  / 이지현	
	@RequestMapping(value="/admin/notice",method=RequestMethod.POST)
	public String add(@ModelAttribute Notice_Vo bean, Model model) throws SQLException {
		log.debug("Admin notice add - before");
		service.addPage(bean);
		log.debug("Admin notice add - after");
		model.addAttribute("goRoot", "../");
		return view;
	}
	
	//관리자 공지사항 수정
	//TODO admin notice edit / / "admin/admin_notice.jsp"  / 이지현
	@RequestMapping(value="/admin/notice/{no_no}", method=RequestMethod.PUT)
	public String edit(@PathVariable("no_no") int no_no, @ModelAttribute Notice_Vo bean, Model model) throws SQLException {
		service.updatePage(bean);
		return view;
	}
	
	//관리자 공지사항 삭제
	//TODO admin notice delete / "admin/admin_notice.jsp" / 이지현
	@RequestMapping(value="/admin/notice/{no_no}",method=RequestMethod.DELETE)
	public String delete(@PathVariable("no_no") int no_no) throws SQLException {
		log.debug("Admin notice delete");
		service.deletePage(no_no);
		log.debug("Admin notice delete - done");                                                                                                                                                                                                                                                                                                                                                                                       
		return view;
	}
}//class end
