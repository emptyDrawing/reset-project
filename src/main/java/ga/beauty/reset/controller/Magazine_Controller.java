package ga.beauty.reset.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Magazine_Vo;
import ga.beauty.reset.dao.entity.Paging_Vo;
import ga.beauty.reset.services.Magazine_Service;
import ga.beauty.reset.utils.CrudEnum;
import ga.beauty.reset.utils.UpdateViewUtils;
import ga.beauty.reset.utils.UploadFileUtils;

@Controller
public class Magazine_Controller {
	private static final Logger logger = LoggerFactory.getLogger(Magazine_Controller.class);
	
	@Autowired
	Magazine_Service service;
	
	@Autowired
	UpdateViewUtils viewUtils;
	
	String goRoot="../";
	
	/*@RequestMapping(value="/magazine", method=RequestMethod.GET)
	public String list(Model model) throws SQLException{
		model.addAttribute("goRoot",goRoot);
		service.listPage(model);
		return "magazine/magazine_list";
	}
	
	@RequestMapping(value="/magazine/ajax",method=RequestMethod.GET)
	public String listAjax(Model model, Magazine_Vo bean) throws SQLException {
		if(bean.getCate()==99) {
				service.listPage(model);
			}else{
				service.listPage(model,bean);
			}
		return "magazine/magazine_list_ajax";
	}*/
	
	@RequestMapping(value="/magazine", method=RequestMethod.GET)
	public String list(Model model,HttpServletRequest req) throws SQLException{
		
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10;	// 페이지당 표시될 게시물  최대 갯수
		
		if(req.getParameter("pages") != null)								//게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면							 
			currentPageNo = Integer.parseInt(req.getParameter("pages")); 	//pages에있는 string 타입 변수를 int형으로 바꾸어서 currentPageNo에 담는다.
		
		Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); //Paging.java에있는 currentPAgeNo, maxPost를 paging변수에 담는다.
		
		int offset = (paging.getCurrentPageNo() -1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의 선언. 
		// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다. 
		
		paging.setNumberOfRecords(service.getCount()); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것
		
		paging.makePaging(); //
		
		model.addAttribute("paging",paging);
		model.addAttribute("goRoot",goRoot);
		service.listPage(model, offset, paging.getmaxPost());
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.LIST + "매거진에서 {ip:"+ip+"}가 매거진 목록을 불러옵니다.");
		
		return "magazine/magazine_list";
	}
	
	@RequestMapping(value="/magazine/ajax",method=RequestMethod.GET)
	public String listAjax(Model model, Magazine_Vo bean, HttpServletRequest req) throws SQLException {
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
				
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10;	// 페이지당 표시될 게시물  최대 갯수
		
		if(bean.getCate()==99) {
			if(req.getParameter("pages") != null)								//게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면							 
				currentPageNo = Integer.parseInt(req.getParameter("pages")); 	//pages에있는 string 타입 변수를 int형으로 바꾸어서 currentPageNo에 담는다.
			
			Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); //Paging.java에있는 currentPAgeNo, maxPost를 paging변수에 담는다.
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의 선언. 
			// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다. 
			
				paging.setNumberOfRecords(service.getCount()); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것
				
				paging.makePaging(); //
				
				model.addAttribute("paging",paging);
				
				service.listPage(model, offset, paging.getmaxPost());
				logger.info(CrudEnum.LIST + "매거진에서 {ip:"+ip+"}가 ajax로 매거진 목록을 불러옵니다.");
			}else{
				if(req.getParameter("pages") != null)								//게시물이 1개도없으면(=페이지가 생성이 안되었으면)이 아니라면 == 페이징이 생성되었다면							 
					currentPageNo = Integer.parseInt(req.getParameter("pages")); 	//pages에있는 string 타입 변수를 int형으로 바꾸어서 currentPageNo에 담는다.
				
				Paging_Vo paging = new Paging_Vo(currentPageNo, maxPost); //Paging.java에있는 currentPAgeNo, maxPost를 paging변수에 담는다.
				
				int offset = (paging.getCurrentPageNo() -1) * paging.getmaxPost(); // query.xml에서 select를 할때 사용하기위한 offset 변수의 선언. 
				// 현재 3페이지 이고, 그 페이지에 게시물이 10개가 있다면 offset값은 (3-1) * 10 = 20이 된다. 
				
				paging.setNumberOfRecords(service.getCount(bean.getCate())); // 페이지를 표시하기 위해 전체 게시물 수를 파악하기 위한것
				
				paging.makePaging(); //
				
				model.addAttribute("paging",paging);
				
				service.listPage(model, bean.getCate(), offset, paging.getmaxPost());
				logger.info(CrudEnum.LIST + "매거진에서 {ip:"+ip+"}가 ajax로 매거진 목록을 불러옵니다.");
			}
		return "magazine/magazine_list_ajax";
	}
	
	@RequestMapping(value="/magazine/{mag_no}", method=RequestMethod.GET)
	public String detail(@PathVariable("mag_no") int mag_no,Model model,HttpServletRequest req,HttpServletResponse resp) throws SQLException{
		model.addAttribute("goRoot",goRoot);
		Magazine_Vo bean =new Magazine_Vo();
		bean.setMag_no(mag_no);
		
		Comment_Vo comment=new Comment_Vo();
		comment.setCo_type("매거진");
		comment.setP_no(mag_no);
		
		//쿠기를 사용한 조회수 증가 입니다(3번째 인자로 review,magazine,event 중에 골라서 넣어주세요)
		viewUtils.UpdateView(resp, req, "magazine", mag_no, model);
		
		model.addAttribute("no",mag_no);
		model.addAttribute("type","magazine");
		
		service.detailPage(model, bean, comment);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DETAIL + "매거진에서 {ip:"+ip+"}가 매거진 상세페이지로 이동합니다.");
		
		return "magazine/magazine_detail";
	}
	
	@RequestMapping(value="/admin/magazine/{mag_no}", method = RequestMethod.POST)
	public String updateForm(@PathVariable("mag_no") int mag_no, Model model,HttpServletRequest req) throws SQLException{
		String goRoot="../../";
		model.addAttribute("goRoot",goRoot);
		Magazine_Vo bean=new Magazine_Vo();
		bean.setMag_no(mag_no);
		
		Comment_Vo comment=new Comment_Vo();
		comment.setCo_type("매거진");
		comment.setP_no(mag_no);
		
		service.detailPage(model, bean, comment);
		
		return "magazine/magazine_update";
	}
	
	@RequestMapping(value="/admin/magazine/{mag_no}/update",method=RequestMethod.POST)
	public String update(@PathVariable("mag_no") int mag_no, @RequestParam("img") MultipartFile file, HttpServletRequest req) throws IOException, Exception{
		//TODO : 썸네일 사진 저장 장소 입니다.
		String filePath="/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/imgs/mag_imgs";
		Magazine_Vo bean=new Magazine_Vo();
		bean.setMag_no(mag_no);
		bean.setTitle(req.getParameter("title"));
		bean.setCon(req.getParameter("con"));
		bean.setCate(Integer.parseInt(req.getParameter("cate")));
		//TODO : 썸네일 사진을 불러오는 곳입니다.
		if(!(file.getOriginalFilename().equals(""))) {
			bean.setImg("/imgs/mag_imgs"+UploadFileUtils.uploadFile(filePath, file.getOriginalFilename(), file.getBytes(),300));
			Thread.sleep(5000);
		};
		bean.setTags(req.getParameter("tags"));
		service.updatePage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.UPDATE + "매거진에서 {ip:"+ip+"}가 글을 수정합니다.");
		
		return "redirect:/magazine";
	}
	
	
	
	@RequestMapping("/admin/magazine/add")
	public String addForm(Model model) throws SQLException{
		String goRoot="../../";
		model.addAttribute("goRoot",goRoot);
		return "magazine/magazine_add";
	}
	
	@RequestMapping(value="/admin/magazine", method=RequestMethod.POST)
	public String add(@RequestParam("img") MultipartFile file,HttpServletRequest req) throws IOException, Exception{
		//TODO : 썸네일 사진 저장 장소 입니다.
		String filePath="/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/imgs/mag_imgs";
		Magazine_Vo bean =new Magazine_Vo();
		bean.setTitle(req.getParameter("title"));
		bean.setCon(req.getParameter("con"));
		bean.setCate(Integer.parseInt((req.getParameter("cate"))));
		bean.setTags(req.getParameter("tags"));
		bean.setWriter(req.getParameter("writer"));
		//TODO : 썸네일 사진을 불러오는 곳입니다.
		bean.setImg("/imgs/mag_imgs"+UploadFileUtils.uploadFile(filePath, file.getOriginalFilename(), file.getBytes(),300));
		Thread.sleep(3000);
		service.addPage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.ADD + "매거진에서 {ip:"+ip+"}가 글을 작성하였습니다.");
		
		return "redirect:/magazine";
	}
	
	@RequestMapping(value="/admin/magazine/{mag_no}", method=RequestMethod.DELETE)
	public String delete(@PathVariable("mag_no") int mag_no,HttpServletRequest req) throws SQLException{
		/*
		Magazine_Vo bean =new Magazine_Vo();
		bean.setMag_no(mag_no);
		
		Comment_Vo com =new Comment_Vo();
		com.setCo_type("매거진");
		com.setP_no(mag_no);
		
		String img = req.getParameter("img");
		String Largeimg=img.replaceAll("#$#", "");
		String filepath ="/Users/hb/Desktop/3차 프로젝트/코딩/reset_pro/src/main/webapp/resources";
		File file = new File(filepath+img);
		File file2 = new File(filepath+Largeimg);
		file.delete();
		file2.delete();
		
		service.deletePage(bean);
		*/
		Magazine_Vo bean =new Magazine_Vo();
		bean.setMag_no(mag_no);
		service.deletePage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DELETE + "매거진에서 {ip:"+ip+"}가 글을 삭제하였습니다.");
		
		return "redirect:/magazine";
	}
	
	
}//class end
