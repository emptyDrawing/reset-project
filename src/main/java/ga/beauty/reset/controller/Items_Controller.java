package ga.beauty.reset.controller;


import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.Items_DaoImp;
import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.services.Items_Service;

@Controller
public class Items_Controller {
	Logger log=Logger.getLogger(getClass());
	Items_Vo items_Vo=new Items_Vo();
	Items_DaoImp items_DaoImp=new Items_DaoImp();
	ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	Items_Service service;
	
	String view="redirect:/ranking/";
	
	@RequestMapping(value="/ranking", method = RequestMethod.GET)
	public String ranking_list(@RequestParam("id") int cate,Model model) throws SQLException {
		log.debug("list-param: "+cate);
		service.listPage(model, cate);
		return "ranking/ranking_list";
	}
	
	@RequestMapping(value="/ranking?id={id}&add", method = RequestMethod.GET)
	public String ranking_list_add(@RequestParam("id") int cate,HttpServletResponse resp) throws SQLException, JsonProcessingException {
		log.debug("list-param: "+cate);
		return mapper.writeValueAsString(items_DaoImp.rankAdd(cate));
//		return "ranking/ranking_list";
	}
	
	@RequestMapping(value="/item/{item}")
	public String ranking_detail(@PathVariable int item,Model model) throws SQLException {
		log.debug("detail-param: "+item);
		service.detailPage(model,item);
		return "ranking/ranking_detail";
	}

}
