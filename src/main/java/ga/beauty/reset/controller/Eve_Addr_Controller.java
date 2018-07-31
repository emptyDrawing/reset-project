package ga.beauty.reset.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.entity.Eve_addr_Vo;
import ga.beauty.reset.dao.entity.Event_Vo;
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

	String goRoot = "../";
	
	//TODO: admin 이벤트 목록 출력 / eve_addr_list.jsp / 김형준
	@RequestMapping(value = "/admin/eveaddr", method = RequestMethod.GET)
	public String list(Model model, HttpServletRequest req) throws SQLException {
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10; // 페이지당 표시될 게시물 최대 갯수

		if (req.getParameter("pages") != null) // 게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면
			currentPageNo = Integer.parseInt(req.getParameter("pages")); // pages에있는 string 타입 변수를 int형으로 바꾸어서
																			// currentPageNo에 담는다.

		Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); // Paging.java에있는 currentPAgeNo, maxPost를 paging변수에
																	// 담는다.

		int offset = (paging.getCurrentPageNo() - 1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의
																			// 선언.
		// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다.

		paging.setNumberOfRecords(eventService.getCount()); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것

		paging.makePaging(); //

		model.addAttribute("paging", paging);
		model.addAttribute("goRoot", goRoot);
		eventService.listPage(model, offset, paging.getmaxPost());

		// 접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();

		logger.info(CrudEnum.LIST + "이벤트참가에서 {ip:" + ip + "}가 이벤트 목록을 불러옵니다.");

		return "eve_addr/eve_addr_list";
	}

	//TODO: admin 이벤트 참가자 목록 출력 / eve_addr_detail.jsp / 김형준
	@RequestMapping(value = "/admin/eveaddr/{eve_no}", method = RequestMethod.GET)
	public String detail(@PathVariable int eve_no, Model model, HttpServletRequest req) throws SQLException {
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10; // 페이지당 표시될 게시물 최대 갯수

		if (req.getParameter("pages") != null) // 게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면
			currentPageNo = Integer.parseInt(req.getParameter("pages")); // pages에있는 string 타입 변수를 int형으로 바꾸어서
																			// currentPageNo에 담는다.

		Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); // Paging.java에있는 currentPAgeNo, maxPost를 paging변수에
																	// 담는다.

		int offset = (paging.getCurrentPageNo() - 1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의
																			// 선언.
		// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다.

		paging.setNumberOfRecords(service.getCount(eve_no)); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것

		paging.makePaging(); //

		String goRoot = "../../";
		Eve_addr_Vo bean = new Eve_addr_Vo();
		bean.setEve_no(eve_no);

		Event_Vo event = new Event_Vo();
		event.setEve_no(eve_no);

		model.addAttribute("tot", service.getCount(eve_no));
		model.addAttribute("eve_no", eve_no);
		model.addAttribute("paging", paging);
		model.addAttribute("goRoot", goRoot);
		eventService.detailPage(model, event);
		service.listPage(model, eve_no, offset, paging.getmaxPost());

		// 접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();

		logger.info(CrudEnum.DETAIL + "이벤트참가에서 {ip:" + ip + "}가 참가자 목록을 불러옵니다.");

		return "eve_addr/eve_addr_detail";
	}
	
	//TODO: admin 이벤트 참가자 랜덤 추출 / eve_addr_eventNum.jsp / 김형준
	@RequestMapping(value = "/admin/eveaddr/{eve_no}", method = RequestMethod.POST)
	public String eventNum(@PathVariable("eve_no") int eve_no, Model model, HttpServletRequest req)
			throws SQLException {

		String goRoot = "../../";

		// 총인원
		int tot = service.getCount(eve_no);

		// 당첨자를 뽑을 인원수
		int eventNum = Integer.parseInt(req.getParameter("eventNum"));

		int lucky[] = new int[eventNum];
		
		if(tot>eventNum) {
		// 중복 숫자 제거
		for (int i = 0; i < lucky.length; i++) {
			lucky[i] = (int) (Math.random() * tot) + 1;

			for (int j = 0; j < i; j++) {
				if (lucky[i] == lucky[j]) {
					i--;
					break;
				}
			}
		}

		// 오름차순 정렬
		for (int i = 0; i < lucky.length - 1; i++) {
			for (int j = 0; j < lucky.length - 1 - i; j++) {
				if (lucky[j] > lucky[j + 1]) {
					int temp;
					temp = lucky[j];
					lucky[j] = lucky[j + 1];
					lucky[j + 1] = temp;
				}
			}
		}
		List<Eve_addr_Vo> allList = service.listPage(eve_no);
		List<Eve_addr_Vo> result = new ArrayList<Eve_addr_Vo>();
		for (int i = 0; i < lucky.length; i++) {
			result.add(allList.get(lucky[i]));
		}
		
		model.addAttribute("detail", result);
		} else {
			List<Eve_addr_Vo> allList = service.listPage(eve_no);
	
			model.addAttribute("detail", allList);
			
		}
		model.addAttribute("goRoot", goRoot);
		model.addAttribute("eve_no", eve_no);
		// 접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();

		logger.info(CrudEnum.DETAIL + "이벤트참가에서 {ip:" + ip + "}가 당첨자 목록을 불러옵니다.");
		Event_Vo bean = new Event_Vo();
		bean.setEve_no(eve_no);
		eventService.detailPage(model, bean);
		return "eve_addr/eve_addr_eventNum";
	}
	
	//TODO: 이벤트 참가신청 폼으로 이동 / event_addr.jsp / 김형준
	@RequestMapping(value = "/event/{eve_no}/addr", method = RequestMethod.GET)
	public String addForm(@PathVariable("eve_no") int eve_no, Model model) throws SQLException {
		String goRoot = "../../";
		model.addAttribute("goRoot", goRoot);
		model.addAttribute("event", eve_no);
		return "event/event_addr";
	}

	//TODO: 이벤트 참가신청 / / 김형준
	@RequestMapping(value = "/event/{eve_no}/addr", method = RequestMethod.POST)
	public String add(@PathVariable("eve_no") int eve_no, HttpServletRequest req) throws Exception {
		Eve_addr_Vo bean = new Eve_addr_Vo();
		bean.setEve_no(eve_no);
		bean.setEmail(req.getParameter("email"));
		bean.setName(req.getParameter("name"));
		// 주소
		String address = req.getParameter("roadAddrPart1") + req.getParameter("addrDetail");
		bean.setAddress(address);

		bean.setPhone(req.getParameter("phone"));

		bean.setPostcode(Integer.parseInt(req.getParameter("zipNo")));

		service.addPage(bean);
		return "redirect:/event/" + eve_no;
	}

	//TODO: admin 이벤트 랜덤 추출 후 txt로 저장 / / 김형준
	@RequestMapping(value = "/admin/eveaddr/{eve_no}/print", method = RequestMethod.POST)
	public void print(@PathVariable("eve_no") int eve_no, HttpServletRequest req, @RequestBody String paramData,
			 HttpServletResponse resp) throws IOException {

		// TODO : 이벤트 참가 파일 저장 장소 변경필요
		String filePath = "/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/lucky/";
		String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date()); // 현재시간

		ObjectMapper mapper = new ObjectMapper();
		JsonNode arr = mapper.readTree(paramData);
		StringBuffer content = new StringBuffer();
		String eveName = null;
		if (arr.isArray()) {
			int cnt = 0;
			for (JsonNode node : arr) {
				String rn = System.getProperty("line.separator");
				System.out.println("찍히냐?"+rn);
				if (cnt == 0) {
					eveName = node.get("title").asText();
					content.append("이벤트명 :" + node.get("title").asText() + rn + rn);
				}
				content.append("이름 :" + node.get("name").asText() + rn);
				content.append("이메일 :" + node.get("email").asText() + rn);
				content.append("전화번호 :" + node.get("phone").asText() + rn);
				content.append("우편번호 :" + node.get("postcode").asText() + rn);
				content.append("주소 :" + node.get("address").asText() + rn + rn);
				cnt++;
			}
		}
		System.out.println(content.toString());
		String fileName = now + eveName + "당첨자발표.txt";
		BufferedWriter bw = new BufferedWriter(new FileWriter(filePath + fileName));

		bw.write(content.toString());
		bw.flush();

		resp.setCharacterEncoding("UTF-8");
		PrintWriter wrt = resp.getWriter();
		wrt.write(fileName);
		wrt.close();
		resp.flushBuffer();
	}
	
	//TODO: admin 이벤트 랜덤 추출 후 txt 다운로드 / / 김형준
	@RequestMapping(value = "/admin/eveaddr/download", method = RequestMethod.GET)
	public void download(String text, HttpServletResponse resp) throws IOException {
		String filePath = "/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/lucky/";
		File source = new File(filePath+text);
		
		byte[] buff=new byte[2048];
		
		resp.setContentType("application/octet-stream; charset=UTF-8"); 
		resp.setHeader("Content-Disposition"
				, "attachment; filename=\""+text+"\"");
		
		FileInputStream fis=null;
		ServletOutputStream os=null;
		BufferedInputStream bis =null;
		BufferedOutputStream bos=null;
		
		fis=new FileInputStream(source);
		os = resp.getOutputStream();
		bis=new BufferedInputStream(fis);
		bos=new BufferedOutputStream(os);
		int su =0;
		while((su=bis.read(buff))>0) {
			bos.write(buff,0,su);
		}
		if(bos!=null)bos.flush();
		if(bis!=null)bis.close();
		if(os!=null)os.close();
		if(fis!=null)fis.close();
		
	}
	
}
