package ga.beauty.reset.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ga.beauty.reset.dao.entity.Eve_addr_Vo;
import ga.beauty.reset.dao.entity.Paging_Vo;
import ga.beauty.reset.services.Eve_addr_Service;
import ga.beauty.reset.services.Event_Service;
import ga.beauty.reset.utils.CrudEnum;

@Controller
public class Eve_Addr_Controller {
	private static final Logger logger = LoggerFactory.getLogger(Eve_Addr_Controller.class);
	
	@Autowired
	Eve_addr_Service service;
	
	@Autowired
	Event_Service eventService;
	
	String goRoot="../";
	
	@RequestMapping(value = "/admin/eveaddr", method = RequestMethod.GET)
	public String list(Model model,HttpServletRequest req) throws SQLException {
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10;	// 페이지당 표시될 게시물  최대 갯수
		
		if(req.getParameter("pages") != null)								//게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면							 
			currentPageNo = Integer.parseInt(req.getParameter("pages")); 	//pages에있는 string 타입 변수를 int형으로 바꾸어서 currentPageNo에 담는다.
		
		Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); //Paging.java에있는 currentPAgeNo, maxPost를 paging변수에 담는다.
		
		int offset = (paging.getCurrentPageNo() -1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의 선언. 
		// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다. 
		
		paging.setNumberOfRecords(eventService.getCount()); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것
		
		paging.makePaging(); //
		
		model.addAttribute("paging",paging);
		model.addAttribute("goRoot",goRoot);
		eventService.listPage(model, offset, paging.getmaxPost());
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.LIST + "이벤트참가에서 {ip:"+ip+"}가 이벤트 목록을 불러옵니다.");
		
		return "eve_addr/eve_addr_list";
	}
	
	@RequestMapping(value = "/admin/eveaddr/{eve_no}", method = RequestMethod.GET)
	public String detail(@PathVariable int eve_no ,Model model,HttpServletRequest req) throws SQLException {
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10;	// 페이지당 표시될 게시물  최대 갯수
		
		if(req.getParameter("pages") != null)								//게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면							 
			currentPageNo = Integer.parseInt(req.getParameter("pages")); 	//pages에있는 string 타입 변수를 int형으로 바꾸어서 currentPageNo에 담는다.
		
		Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); //Paging.java에있는 currentPAgeNo, maxPost를 paging변수에 담는다.
		
		int offset = (paging.getCurrentPageNo() -1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의 선언. 
		// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다. 
		
		paging.setNumberOfRecords(service.getCount(eve_no)); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것
		
		paging.makePaging(); //
		
		String goRoot="../../";
		Eve_addr_Vo bean=new Eve_addr_Vo();
		bean.setEve_no(eve_no);
		
		model.addAttribute("tot",service.getCount(eve_no));
		model.addAttribute("eve_no",eve_no);
		model.addAttribute("paging",paging);
		model.addAttribute("goRoot",goRoot);
		service.listPage(model, eve_no, offset, paging.getmaxPost());
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DETAIL + "이벤트참가에서 {ip:"+ip+"}가 참가자 목록을 불러옵니다.");
		
		return "eve_addr/eve_addr_detail";
	}
	
	@RequestMapping(value = "/admin/eveaddr/{eve_no}", method = RequestMethod.POST)
	public String eventNum(@PathVariable int eve_no ,Model model,HttpServletRequest req) throws SQLException {
		
		String goRoot="../../";
		
		//총인원
		int tot = service.getCount(eve_no);
		
		//당첨자를 뽑을 인원수
		int eventNum=Integer.parseInt(req.getParameter("eventNum"));
		
		int lucky[] = new int[eventNum];
		
		for(int i=0; i<lucky.length; i++) {
			lucky[i] = (int)(Math.random()*tot);
			
			for(int j=0; j<i; j++) {
				if(lucky[i] == lucky[j]) {
					i--;
					break;
				}
			}
		};
		List allList = service.listPage(eve_no);
		List result = new ArrayList();
		for(int i=0; i<lucky.length; i++) {
			result.add(allList.get(lucky[i]));
		}
		model.addAttribute("detail",result);
		model.addAttribute("goRoot",goRoot);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DETAIL + "이벤트참가에서 {ip:"+ip+"}가 당첨자 목록을 불러옵니다.");
		
		return "eve_addr/eve_addr_eventNum";
	}
	
	
	@RequestMapping(value="/event/{eve_no}/addr", method=RequestMethod.GET)
	public String addForm(@PathVariable("eve_no") int eve_no,Model model) throws SQLException{
		String goRoot="../../";
		model.addAttribute("goRoot",goRoot);
		model.addAttribute("event",eve_no);
		return "event/event_addr";
	}
	
	
	@RequestMapping(value="/event/{eve_no}/addr", method=RequestMethod.POST)
	public String add(@PathVariable("eve_no") int eve_no,HttpServletRequest req) throws SQLException{
		Eve_addr_Vo bean = new Eve_addr_Vo();
		bean.setEve_no(eve_no);
		bean.setEmail(req.getParameter("email"));
		bean.setName(req.getParameter("name"));
		//주소 
		String address =req.getParameter("roadAddrPart1") + req.getParameter("addrDetail");
		bean.setAddress(address);
		
		bean.setPhone(req.getParameter("phone"));
		
		bean.setPostcode(Integer.parseInt(req.getParameter("zipNo")));
		
		service.addPage(bean);
		return "redirect:/event/"+eve_no;
	}
}
