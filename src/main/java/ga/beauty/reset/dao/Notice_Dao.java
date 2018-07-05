package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

import ga.beauty.reset.dao.entity.Qna_Vo;

public interface Notice_Dao<Notice_Vo> {
	
	 List<Notice_Vo> selectAll() throws SQLException;
	 void insertOne(Notice_Vo bean) throws SQLException;
	 Notice_Vo selectOne(Notice_Vo bean) throws SQLException;
	 int updateOne(Notice_Vo bean) throws SQLException;
	 int deleteOne(Notice_Vo bean) throws SQLException;
	
}
