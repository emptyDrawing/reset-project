package ga.beauty.reset.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;
import ga.beauty.reset.dao.entity.stat.Log_File;
import ga.beauty.reset.services.Items_Reviews_Service;
import ga.beauty.reset.services.mypage.Mypage_Admin_Service;
import ga.beauty.reset.utils.LogEnum;

@Controller
public class Admin_Controller {

	String filePath="/Tomcat/webapps/ROOT/resources/imgs/review_imgs";

	Logger logger = Logger.getLogger(Admin_Controller.class);
	
	
	
	@Autowired
	Mypage_Admin_Service mypage_Admin_Service;
	
	@Autowired
	Items_Reviews_Service items_Reviews_service;
	
	public Admin_Controller() {
	}

	@RequestMapping("/admin/")
	public String showDashBoard(Model model, HttpSession session) {
		model.addAttribute("goRoot", "../");
		String email =(String) session.getAttribute("login_email");
		String nick =(String) session.getAttribute("login_nick");
		logger.info(LogEnum.INTER+"["+email+"/"+nick+"] 유저가 /admin/페이지에 접속함.");
		return "admin/admin_main";
	}
	
	@RequestMapping(value = "/admin/review", method = RequestMethod.GET)
	public String showReview(Model model, HttpSession session, HttpServletRequest req) throws SQLException {
		model.addAttribute("goRoot", "../");
		List<Reviews_Vo> list = mypage_Admin_Service.getInfoAslist("review", session, req);
		model.addAttribute("rev_list", list);
		return "admin/admin_review";
	}
	
	
	// 리뷰 상세
		@RequestMapping(value="/admin/{item}/review/{rev_no}",method=RequestMethod.GET)
		@Transactional
		public String review_detail(@PathVariable int item,@PathVariable int rev_no,Model model) throws SQLException {
			logger.debug("review_detail-param: "+item+" "+rev_no);
			
			String goRoot = "../../../";
				
			Comment_Vo comment=new Comment_Vo();
			comment.setCo_type("리뷰");
			comment.setP_no(rev_no);
			
			model.addAttribute("goRoot", goRoot);
			items_Reviews_service.review_detailPage(model,item,rev_no);
			return "admin/admin_review_detail";
		}
			
		// 리뷰 삭제
		@RequestMapping(value="/admin/{item}/review/{rev_no}", method=RequestMethod.DELETE)
		public void review_delete(@PathVariable("item") int item,@PathVariable("rev_no") int rev_no,HttpServletResponse resp,HttpServletRequest req) throws Exception{
			logger.debug("admin_review_delete: "+item+"/"+rev_no);
			
			// 공통
			Reviews_Vo bean=new Reviews_Vo();
			bean.setItem(item);
			bean.setRev_no(rev_no);
			bean.setWriter(req.getParameter("writer"));
			
			resp.setCharacterEncoding("utf-8");
			resp.getWriter().print(items_Reviews_service.review_deletePage(filePath,bean));
		}
	
	
	
	@RequestMapping(value="/admin/{path}/{command}/",method=RequestMethod.GET)
	public String showPage(Model model, @PathVariable("path") String path, @PathVariable("command") String command) {
		model.addAttribute("goRoot", "../../../");
		model.addAttribute("command",command);
		return "admin/admin_"+path;
	}
	
	
	@RequestMapping(value="/admin/ajax/{command}", method=RequestMethod.POST) // AJAX
	public String ajaxCalling(Model model,@PathVariable("command") String command
			,HttpSession session ,HttpServletRequest req) throws SQLException {
		model.addAttribute("goRoot", "../../../");
		if(req.getParameter("resultType")==null) {
			return "admin/admin_ajax";
		}
		if(req.getParameter("resultType").equals("int")) {
			int result = mypage_Admin_Service.getInfoAsInt(command, session, req);
			if(result!=0) {
				model.addAttribute("result",200);
				model.addAttribute("result_data",result);
			}
		}else if(req.getParameter("resultType").equals("list")) {
			List<? super Object> result = mypage_Admin_Service.getInfoAslist(command, session, req);
			if(result!=null && result.size()>0) {
				if(command.equals("member") && req.getAttribute("go").equals("1")) {
					return "admin/admin_userlist";
				}else if(command.equals("member") && req.getAttribute("go").equals("2")){// company 있는 사람들 용
					return "admin/admin_userlist2";
				}else if(req.getParameter("itemList")!=null) {
					req.setAttribute("itemList",result);
					return "admin/admin_listItem_ajax";
				}else if(command.equals("review")) {
					req.setAttribute("rev_list", result);
					return "admin/admin_review_ajax";
				}
			}else {
				return "admin/admin_empty";
			}
		}
		return "admin/admin_ajax";
	}
	
	@RequestMapping(value="/admin/log/{command}", method=RequestMethod.POST) // ajax
	public String logCalling(Model model,@PathVariable("command") String command
			,HttpSession session ,HttpServletRequest req) throws NumberFormatException, IOException, InterruptedException {
		List<Log_File> result = mypage_Admin_Service.getLog(command, session, req);
		int logLine = 0;
		if(result!=null && result.size()>0) {
			// log_start_num="+start+"&nextNum="+cnt+"&more_Log=true"+"&mode=detail
			model.addAttribute("result",200);
			req.setAttribute("log_list", result);
			logLine = result.size();
		}
		String moreLog = req.getParameter("more_Log");
		String mode = req.getParameter("mode");
		if(moreLog!=null)req.setAttribute("more_Log", moreLog);
		if(mode!=null)req.setAttribute("mode", mode);
		req.setAttribute("logLine", logLine);
		return "admin/admin_log_ajax";
	}
	
	@RequestMapping(value="/admin/chart/{command}", method=RequestMethod.POST) // ajax
	public String chartCalling(Model model,@PathVariable("command") String command
			,HttpSession session ,HttpServletRequest req) throws NumberFormatException, IOException, InterruptedException {

		Map<String,Object> result = mypage_Admin_Service.getChart(command, session, req);
		if(result!=null && result.size()>0) {
			req.setAttribute("chartSort", command);
		}
		return "admin/admin_chart_ajax";
	}
}// Admin_Controller end
