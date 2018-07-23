package ga.beauty.reset.services;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Comment_Dao;
import ga.beauty.reset.dao.Common_Dao;
import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.dao.entity.Magazine_Vo;

@Service
public class Magazine_Service {
	@Autowired
	Common_Dao<Magazine_Vo> commonDao;
	
	@Autowired
	Comment_Dao<Comment_Vo> commentDao;
	
	public Magazine_Service() {
	}
	
	public void listPage(Model model) throws SQLException{
		model.addAttribute("alist",commonDao.selectAll());
	}

	public void listPage(Model model, Magazine_Vo bean) throws SQLException{
		model.addAttribute("alist",commonDao.selectAll(bean));
	}
	
	public void listPage(Model model, int offset, int noOfRecords) throws SQLException{
		model.addAttribute("alist",commonDao.selectAll(offset, noOfRecords));
	}
	
	public void listPage(Model model, int cate, int offset, int noOfRecords) throws SQLException{
		model.addAttribute("alist",commonDao.selectAll(cate, offset, noOfRecords));
	}
	
	public int getCount() throws SQLException{
		return commonDao.getCount();
	}
	
	public int getCount(int cate) throws SQLException{
		return commonDao.getCount(cate);
	}
	
	public void detailPage(Model model,Magazine_Vo bean,Comment_Vo comment) throws SQLException{
		model.addAttribute("detail",commonDao.selectOne(bean));
		model.addAttribute("comment",commentDao.list(comment));
	}
	
	public void addPage(Magazine_Vo bean) throws SQLException{
		commonDao.insertOne(bean);
	}
	
	public void updateView(Magazine_Vo bean) throws SQLException{
		commonDao.updateView(bean);
	}
	
	public void updatePage(Magazine_Vo bean) throws SQLException{
		commonDao.updateOne(bean);
	}
	
	public void deletePage(Magazine_Vo bean) throws SQLException{
		commonDao.deleteOne(bean);
	}
}
