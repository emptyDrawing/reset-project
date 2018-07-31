package ga.beauty.reset.services;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Notice_Dao;
import ga.beauty.reset.dao.entity.Notice_Vo;

@Service
public class Notice_Service {

	@Autowired
	Notice_Dao<Notice_Vo> Notice_Dao;
	
	public void listPage(Model model) throws SQLException {
		model.addAttribute("alist", Notice_Dao.selectAll());
	}
	
	public Notice_Vo selectOnePage(int no_no) throws SQLException {
		return Notice_Dao.selectOne(no_no);
	}
	
	public void addPage(Notice_Vo bean) throws SQLException {
		Notice_Dao.insertOne(bean);
	}
	
	public void updatePage(Notice_Vo bean) throws SQLException {
		Notice_Dao.updateOne(bean);
	}

	public void deletePage(int no_no) throws SQLException {
		Notice_Dao.deleteOne(no_no);
	}
}
