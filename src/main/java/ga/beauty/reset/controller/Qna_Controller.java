package ga.beauty.reset.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Qna_Vo;
import ga.beauty.reset.services.Qna_Service;

@Controller
public class Qna_Controller {
	private static final Logger log = Logger.getLogger(Qna_Controller.class);

	@Autowired
	Qna_Service service;

	String view = "redirect:/qna";
	String view2 = "redirect:/admin/admin_qna_list";

	//고객의 문의사항
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String show(Model model) {
		log.debug("show form" );
		model.addAttribute("goRoot", "../");
		return "qna/qna";
	}
	
	//고객이 문의 내용을 입력하고 전송
	@RequestMapping(value = "/qna", method = RequestMethod.POST)
	public String add(Qna_Vo bean,HttpServletRequest req) throws SQLException {
		service.addPage(bean);
		log.debug("고객 - qna send : " + bean);
		return view;	
	}
	
	//TODO admin qna list / "admin/admin_qna_list" / 이지현
	@RequestMapping(value = "/admin/qna")
	public String showList(Model model) throws SQLException {
		service.listPage(model);
		log.debug("Admin qna - show List");
		System.out.println("리스트 보여주기");
		model.addAttribute("goRoot", "../");
		return "admin/admin_qna_list";
	}

	//TODO admin qna detail / "admin/admin_qna_detail" / 이지현
	@RequestMapping(value = "/admin/qna/{qa_no}", method=RequestMethod.GET)
	public String detail(@PathVariable int qa_no, Model model) throws SQLException {
	log.debug("qna detail : "+ qa_no);
	model.addAttribute("bean", service.selectOnePage(qa_no));
	model.addAttribute("goRoot", "../../");
	return "admin/admin_qna_detail";
	}

	//TODO admin qna answer ajax / "admin/admin_qna_detail" / 이지현
	@RequestMapping(value="/admin/qna/{qa_no}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> json(@PathVariable int qa_no, Model model,Qna_Vo bean) throws SQLException {
		System.out.println(bean.getAnswer());
		System.out.println("키값:"+bean.getQa_no());
		int resultNum = service.updatePage(bean);
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(resultNum==1) {
			result.put("result", resultNum);
			result.put("new_answer",bean.getAnswer());
		}
		log.debug(bean);
		return result;
	}

}// class end
