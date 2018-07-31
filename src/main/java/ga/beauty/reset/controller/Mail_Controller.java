package ga.beauty.reset.controller;

import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Qna_Vo;
import ga.beauty.reset.services.Qna_Service;

@Controller
public class Mail_Controller {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	Qna_Service service;
	
	@Autowired
	VelocityEngine velocityEngine;
	
	//TODO
	
	@RequestMapping(value="/mail/qna/{qa_no}" , method = RequestMethod.POST)
	@ResponseBody
	public String qnaSender(@PathVariable int qa_no) throws MessagingException, SQLException{
		
		Qna_Vo bean = service.selectOnePage(qa_no);
		String setfrom ="resetbeauty@gmail.com";
		String toemail = bean.getEmail();
		String title = "Re : " + bean.getCon();
		String contents = "<html><body><h1>안녕하세요 리셋입니다</h1>"+"<p>문의주신 내용</p>"+"<blockquote>"+bean.getCon()+"</blockquote>"+"에 대한 답변입니다"+"<hr>"+ "<p>"+bean.getAnswer()+"</p></body></html>";
		
		
		
		MimeMessage msg = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
	
		messageHelper.setFrom(setfrom);
		messageHelper.setTo(toemail);
		messageHelper.setSubject(title);
		msg.setContent(contents, "text/html; charset=utf-8");
	
		mailSender.send(msg);
	
		return "456";
	}
}
