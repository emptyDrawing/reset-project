package ga.beauty.reset.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import com.google.common.io.Files;

import ga.beauty.reset.dao.Companys_Dao;
import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Event_Vo;
import ga.beauty.reset.dao.entity.Paging_Vo;
import ga.beauty.reset.services.Event_Service;
import ga.beauty.reset.utils.CrudEnum;
import ga.beauty.reset.utils.UpdateViewUtils;
import ga.beauty.reset.utils.UploadFileUtils;

@Controller
public class Event_Controller {

	private static final Logger logger = LoggerFactory.getLogger(Event_Controller.class);
	
	@Autowired
	Event_Service service;
	
	@Autowired
	UpdateViewUtils viewUtils;
	
	@Autowired
	Companys_Dao companys_Dao;
	
	String goRoot="../";

	
	
	/*@RequestMapping(value = "/event", method = RequestMethod.GET)
	public String list(Model model) throws SQLException {
		model.addAttribute("goRoot",goRoot);
		service.listPage(model);
		return "event/event_list";
	}*/
	
	//TODO: event 리스트를 출력합니다. / event_list.jsp / 김형준
	//리스트를 보여줍니다.
	@RequestMapping(value = "/event", method = RequestMethod.GET)
	public String list(Model model,HttpServletRequest req) throws SQLException {
		String goRoot="./";
		//페이징관련 입니다.
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
		
		logger.info(CrudEnum.LIST + "이벤트에서 {ip:"+ip+"}가 이벤트 목록을 불러옵니다.");
		
		return "event/event_list";
	}
	
	
	
	//TODO: event 상세페이지를 출력합니다. / event_detail.jsp / 김형준
	@RequestMapping(value = "/event/{eve_no}", method = RequestMethod.GET)
	public String detail(@PathVariable int eve_no ,Model model,HttpServletRequest req,HttpServletResponse resp) throws Exception {
		model.addAttribute("goRoot",goRoot);
		Event_Vo bean=new Event_Vo();
		bean.setEve_no(eve_no);
		
		Comment_Vo comment=new Comment_Vo();
		comment.setCo_type("이벤트");
		comment.setP_no(eve_no);
		
		//쿠키를 사용한 조회수 증가 입니다(3번째 인자로 review,magazine,event 중에 골라서 넣어주세요)
		viewUtils.UpdateView(resp, req, "event", eve_no, model);
		
		model.addAttribute("no",eve_no);
		model.addAttribute("type","event");
		service.detailPage(model, bean, comment);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        
		logger.info(CrudEnum.DETAIL + "이벤트에서 {ip:"+ip+"}가 상세페이지를 불러옵니다.");
		
		return "event/event_detail";
	}

	//TODO: ckeditor 서버로 이미지 업로드하고 다시 보여주는 메소드 입니다.
	@RequestMapping(value = "/add/img", method=RequestMethod.POST)
    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
 
        OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
 
        try{
        	String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
            String fileName = now+upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            //TODO: CKeditor 이미지 저장 장소
            String uploadPath = "/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/imgs/ckeditor_imgs/" + fileName;
            out = new FileOutputStream(new File(uploadPath));
            out.write(bytes);
            out.flush();
            String callback = request.getParameter("CKEditorFuncNum");
            
            printWriter = response.getWriter();
            
            //url경로
            //TODO: ckeditor 이미지 가져오는 주소(uploadPath의 resources의 뒤부터 추가해주세요 )
            String fileUrl = "http://localhost:8080/reset/imgs/ckeditor_imgs/"+ fileName;
            
            printWriter.println("<script type='text/javascript'>"
            		+"setTimeout(function(){"
            		+ "window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")},4000"
                    + ")</script>");
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
 
        return;
    }
	
	
	/*===========================================================================================
	 *  Admin 전용
	 *===========================================================================================
	 */
	
	//TODO: admin event 수정 페이지로 이동 / event_update.jsp / 김형준
	@RequestMapping(value="/admin/event/{eve_no}", method = RequestMethod.POST)
	public String updateForm(@PathVariable int eve_no ,Model model,HttpServletRequest req) throws SQLException {
		String goRoot="../../";
		model.addAttribute("goRoot",goRoot);
		Event_Vo bean=new Event_Vo();
		bean.setEve_no(eve_no);
		
		
		Comment_Vo comment=new Comment_Vo();
		comment.setCo_type("이벤트");
		comment.setP_no(eve_no);
		
		List<Companys_Vo> companyList = companys_Dao.selectAll();
		model.addAttribute("companyList",companyList);
		service.detailPage(model, bean, comment);
		System.out.println(bean.getCom_email());
		return "event/event_update";
	}
	
	//TODO: admin event 수정합니다. / / 김형준
	@RequestMapping(value="/admin/event/{eve_no}/update", method = RequestMethod.POST)
	public String update(@PathVariable("eve_no") int eve_no , @RequestParam("img") MultipartFile file, HttpServletRequest req) throws IOException, Exception {
		//TODO : 썸네일 주소
		String filePath="/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/imgs/event_imgs";
		Event_Vo bean= new Event_Vo();
		bean.setEve_no(eve_no);
		//TODO : 썸네일 사진을 불러오는 곳입니다.
		if(!(file.getOriginalFilename().equals(""))) {
			bean.setImg("/imgs/event_imgs"+UploadFileUtils.uploadFile(filePath, file.getOriginalFilename(), file.getBytes(),300));
			Thread.sleep(3000);
		};
		bean.setTitle(req.getParameter("title"));
		bean.setCon(req.getParameter("con"));
		bean.setCom_email(req.getParameter("com_email"));
		service.updatePage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        
		logger.info(CrudEnum.UPDATE + "이벤트에서  {ip:"+ip+"}가 글을 수정 합니다.");
		
		return "redirect:/admin/event";
	}
	
	//TODO: admin event 입력 페이지로 이동 / event_add.jsp / 김형준
	@RequestMapping("/admin/event/add")
	public String addForm(Model model,HttpServletRequest req) throws SQLException {
		String goRoot="../../";
		
		List<Companys_Vo> companyList = companys_Dao.selectAll();
		
		model.addAttribute("companyList",companyList);
		model.addAttribute("goRoot",goRoot);
		
		return "event/event_add";
	}
	
	@RequestMapping(value = "/admin/event", method = RequestMethod.GET)
	public String adminlist(Model model,HttpServletRequest req) throws SQLException {
		//페이징관련 입니다.
		int currentPageNo = 1; // /(localhost:8080)페이지로 오면 처음에 표시할 페이지 (1 = 첫번째 페이지)
		int maxPost = 10;	// 페이지당 표시될 게시물  최대 갯수
		String goRoot="../";
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
		
		logger.info(CrudEnum.LIST + "이벤트에서 {ip:"+ip+"}가 이벤트 목록을 불러옵니다.");
		
		return "admin/admin_event";
	}
	
	//TODO: admin 전용 / event_detail.jsp / 김형준 
	@RequestMapping(value = "/admin/event/{eve_no}", method = RequestMethod.GET)
	public String adminDetail(@PathVariable int eve_no ,Model model,HttpServletRequest req,HttpServletResponse resp) throws Exception {
		String goRoot = "../../";
		
		model.addAttribute("goRoot",goRoot);
		Event_Vo bean=new Event_Vo();
		bean.setEve_no(eve_no);
		
		Comment_Vo comment=new Comment_Vo();
		comment.setCo_type("이벤트");
		comment.setP_no(eve_no);
		
		//쿠키를 사용한 조회수 증가 입니다(3번째 인자로 review,magazine,event 중에 골라서 넣어주세요)
		//viewUtils.UpdateView(resp, req, "event", eve_no, model);
		
		model.addAttribute("no",eve_no);
		model.addAttribute("type","event");
		service.detailPage(model, bean, comment);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        
		logger.info(CrudEnum.DETAIL + "이벤트에서 {ip:"+ip+"}가 상세페이지를 불러옵니다.");
		
		return "event/event_detail";
	}
	
	
	//TODO: admin event 입력합니다. / / 김형준
	@RequestMapping(value = "/admin/event", method = RequestMethod.POST)
	public String add(@RequestParam("img") MultipartFile file,HttpServletRequest req) throws IOException, Exception {
		//TODO : 썸네일 주소
		String filePath="/Users/hb/Desktop/3차 프로젝트/코딩/reset_new/src/main/webapp/resources/imgs/event_imgs";
		Event_Vo bean= new Event_Vo();
		bean.setTitle(req.getParameter("title"));
		bean.setCon(req.getParameter("con"));
		bean.setCom_email(req.getParameter("com_email"));
		System.out.println(req.getParameter("com_email"));
		// 파일업로드 start
		//TODO : 썸네일 사진을 불러오는 곳입니다.
	    bean.setImg("/imgs/event_imgs"+UploadFileUtils.uploadFile(filePath, file.getOriginalFilename(), file.getBytes(),300));
	    Thread.sleep(3000);
	    // 파일업로드 end
		service.addPage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        
		logger.info(CrudEnum.ADD + "이벤트에서  {ip:"+ip+"}가 글을 작성하였습니다.");
		
		return "redirect:/admin/event";
	}
	
	//TODO: admin event 삭제합니다.(open을 0으로 전환) / / 김형준
	@RequestMapping(value = "/admin/event/{eve_no}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("eve_no") int eve_no,HttpServletRequest req) throws SQLException {
		Event_Vo bean=new Event_Vo();
		bean.setEve_no(eve_no);
		service.deletePage(bean);
		
		//접속대상의 IP를 받아옵니다.
		HttpSession session = req.getSession();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        
		logger.info(CrudEnum.DELETE + "이벤트에서  {ip:"+ip+"}가 글을 삭제하였습니다.");
		
		return "redirect:/admin/event";
	}
	

	
}
