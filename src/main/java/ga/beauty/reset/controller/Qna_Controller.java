package ga.beauty.reset.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Qna_Vo;
import ga.beauty.reset.services.Qna_Service;
import ga.beauty.reset.utils.CrudEnum;
import ga.beauty.reset.utils.LogEnum;

@Controller
public class Qna_Controller {
	private static final Logger logger = Logger.getLogger(Qna_Controller.class);

	@Autowired
	Qna_Service service;

	String view = "redirect:/qna";
	String view2 = "redirect:/admin/admin_qna_list";

	//고객의 문의사항
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String show(Model model , HttpServletRequest req) {
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		logger.info(CrudEnum.LIST + " {ip:"+ip+"}가 Q&A 입력폼에 접근했습니다.");
		model.addAttribute("goRoot", "./");
		return "qna/qna";
	}
	
	//고객이 문의 내용을 입력하고 전송
	@RequestMapping(value = "/qna", method = RequestMethod.POST)
	public String add(Qna_Vo bean,HttpServletRequest req) throws SQLException {
		service.addPage(bean);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		logger.info(CrudEnum.ADD + " {ip:"+ip+"}가 Q&A{"+bean.getQa_type()+"/"+bean.getCon()+"} 을 요청했습니다.");
		return view;
	}
	
	//TODO admin qna list / "admin/admin_qna_list" / 이지현
	@RequestMapping(value = "/admin/qna")
	public String showList(Model model, HttpServletRequest req) throws SQLException {
		service.listPage(model);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		logger.info(CrudEnum.LIST + "관리자 페이지에서 {ip:"+ip+"}가 Q&A 리스트를 요청했습니다.");
		model.addAttribute("goRoot", "../");
		return "admin/admin_qna_list";
	}

	//TODO admin qna detail / "admin/admin_qna_detail" / 이지현
	@RequestMapping(value = "/admin/qna/{qa_no}", method=RequestMethod.GET)
	public String detail(@PathVariable int qa_no, Model model,  HttpServletRequest req) throws SQLException {
		
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		logger.info(CrudEnum.DETAIL + "관리자 페이지에서 {ip:"+ip+"}가 Q&A[No."+ qa_no+"] 을 열람했습니다.");
		model.addAttribute("bean", service.selectOnePage(qa_no));
		model.addAttribute("goRoot", "../../");
	return "admin/admin_qna_detail";
	}

	//TODO admin qna answer ajax / "admin/admin_qna_detail" / 이지현
	@RequestMapping(value="/admin/qna/{qa_no}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> json(@PathVariable int qa_no, Model model,Qna_Vo bean,  HttpServletRequest req) throws SQLException {
		int resultNum = service.updatePage(bean);
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		
		if(resultNum==1) {
			result.put("result", resultNum);
			result.put("new_answer",bean.getAnswer());
			logger.info(CrudEnum.UPDATE + "관리자 페이지에서 {ip:"+ip+"}가 Q&A[No."+ qa_no+"]에 대한 응답을 했습니다.");
		}
		logger.debug(LogEnum.DEBUG+bean);
		return result;
	}

}// class end
