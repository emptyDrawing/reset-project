package ga.beauty.reset.services;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Qna_Dao;
import ga.beauty.reset.dao.entity.Qna_Vo;

@Service
public class Qna_Service {
	
	@Autowired
	Qna_Dao<Qna_Vo> Qna_Dao;
	
	public void listPage(Model model) throws SQLException {
		model.addAttribute("alist", Qna_Dao.selectAll());
		
	}
	
	public Qna_Vo selectOnePage(int qa_no) throws SQLException {
		return Qna_Dao.selectOne(qa_no);
		
	}
	
	public void addPage(Qna_Vo bean) throws SQLException {
		Qna_Dao.insertOne(bean);
	}
	
	public void deletePage(int qa_no) throws SQLException {
		Qna_Dao.deleteOne(qa_no);
	}

	
	public int updatePage(Qna_Vo bean) throws SQLException {
		return Qna_Dao.updateOne(bean);
	}
	
}
