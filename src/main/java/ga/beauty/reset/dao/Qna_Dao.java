package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

public interface Qna_Dao<Qna_Vo> {
	
	 List<Qna_Vo> selectAll() throws SQLException;
	 void insertOne(Qna_Vo bean) throws SQLException;
	 void insertTwo(Qna_Vo bean) throws SQLException;
	 Qna_Vo selectOne(int qa_no) throws SQLException;
	 int updateOne(Qna_Vo bean) throws SQLException;
	 int deleteOne(int qa_no) throws SQLException;
	
}
