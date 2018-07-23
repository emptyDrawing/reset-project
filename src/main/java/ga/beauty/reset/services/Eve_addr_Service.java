package ga.beauty.reset.services;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Common_Dao;
import ga.beauty.reset.dao.entity.Eve_addr_Vo;
import ga.beauty.reset.utils.runner.Common_Listener;
import ga.beauty.reset.utils.runner.Event_Listener;

@Service
public class Eve_addr_Service {

	@Autowired
	@Qualifier("event_Listener")
	Common_Listener event_Listener;
	
	@Autowired
	Common_Dao<Eve_addr_Vo> commonDao;
	
	public void listPage(Model model,Eve_addr_Vo bean) throws SQLException{
		model.addAttribute("detail",commonDao.selectAll(bean));
	}
	
	public void listPage(Model model,int eve_no,int offset, int noOfRecords) throws SQLException{
		model.addAttribute("detail",commonDao.selectAll(eve_no,offset,noOfRecords));
	}
	
	public List listPage(int eve_no) throws SQLException{
		return commonDao.selectAll(eve_no);
	}
	
	public void addPage(Eve_addr_Vo bean) throws SQLException{
		commonDao.insertOne(bean); // XXX 이벤트주소 추가시점
	}

	public int getCount(int eve_no) throws SQLException{
		return commonDao.getCount(eve_no);
	}
}
