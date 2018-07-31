package ga.beauty.reset.services.mypage;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ga.beauty.reset.dao.Comment_Dao;
import ga.beauty.reset.dao.Members_Dao;
import ga.beauty.reset.dao.Reviews_Dao;
import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;

@Service
public class Mypage_NOR_Service {
	
	@Autowired
	Members_Dao members_Dao;
	@Autowired
	Reviews_Dao<Reviews_Vo> Reviews_Dao;
	@Autowired
	Comment_Dao<Comment_Vo> Comment_Dao;

	public Map<String, Object> getInfo(String command, HttpSession session, HttpServletRequest req) throws SQLException {
		String email=(String) session.getAttribute("eamil");
//		String email=req.getParameter("email");
		email="cus1@naver.com";
		Members_Vo bean=new Members_Vo();
		bean.setEmail(email);
		bean=members_Dao.selectOne(bean);
		
		Comment_Vo bean2=new Comment_Vo();
		bean2.setWriter("닉넴1");
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bean", bean);
//		map.put("review_alist",Reviews_Dao.mypage_review(bean.getNick()));
//		map.put("comment_alist",Comment_Dao.mypage_list(bean.getNick()));
		map.put("review_alist",Reviews_Dao.mypage_review("닉넴1"));
		map.put("comment_alist",Comment_Dao.mypage_list(bean2));
		
		return map;
	}// getInfo() end
}// Mypage_NOR_Service
