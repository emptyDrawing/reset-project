package ga.beauty.reset.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ga.beauty.reset.dao.entity.Likes_Vo;
import ga.beauty.reset.services.Likes_Service;

@Controller
public class Likes_Controller {
	Logger log=Logger.getLogger(getClass());
	
	@Autowired
	Likes_Service likes_Service;
	
	@RequestMapping("/likes")
	public String likes() {
		return "ranking_review/likesTest";
	}
	
	@RequestMapping(value="/like/{type}/{p_no}", method=RequestMethod.POST)
	public void check(@RequestBody Likes_Vo bean,HttpServletResponse resp) throws SQLException, IOException {
		
		String result=null;
		if(likes_Service.check(bean)==null) {
			result="unlike";
		}else {
			result="like";
		}
		resp.getWriter().print(result);
	}
	
	@RequestMapping(value="/likes/{type}/{p_no}", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String,Object> likesAddUp(@RequestBody Likes_Vo bean,HttpServletResponse resp) throws Exception {
		return likes_Service.up(bean);
	}
	
	@RequestMapping(value="/likes/{co_type}/{p_no}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String,Object> likesDeldown(@RequestBody Likes_Vo bean,HttpServletResponse resp) throws Exception {
		return likes_Service.down(bean);
	}
}
