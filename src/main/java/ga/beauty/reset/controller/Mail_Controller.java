package ga.beauty.reset.controller;

import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Qna_Vo;
import ga.beauty.reset.services.Qna_Service;
import ga.beauty.reset.utils.CrudEnum;

@Controller
public class Mail_Controller {

	Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	Qna_Service service;
	
	@Autowired
	VelocityEngine velocityEngine;
	
	//TODO
	
	@RequestMapping(value="/mail/qna/{qa_no}" , method = RequestMethod.POST)
	@ResponseBody
	public String qnaSender(@PathVariable int qa_no, HttpServletRequest req) throws MessagingException, SQLException{
		
		Qna_Vo bean = service.selectOnePage(qa_no);
		String setfrom ="resetbeauty@gmail.com";
		String toemail = bean.getEmail();
		String title = "Re : " + bean.getCon();
		String contents = "<html><body><h3>안녕하세요 리셋입니다</h3>"+"문의에 대한 답변입니다"+ "<p> ======================================<br>문의주신 내용 : <br>"+ bean.getCon() + "<br>"+ "<br><br><br>" +  bean.getAnswer() + "<br>====================================== "+ "<br>" +"<br><br><br><br>본 메일은 발신 전용임을 알려드리며 추가적인 문의사항이 있으시면 고객상담으로 재문의 주시면 감사하겠습니다."+"</body></html>";
		
		
		
		MimeMessage msg = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
	
		messageHelper.setFrom(setfrom);
		messageHelper.setTo(toemail);
		messageHelper.setSubject(title);
		msg.setContent(contents, "text/html; charset=utf-8");
	
		mailSender.send(msg);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.UPDATE + "관리자 페이지에서 {ip:"+ip+"}가 Q&A[No."+ qa_no+"] 응답메일을 보냈습니다.");
		return "456";
	}
}
