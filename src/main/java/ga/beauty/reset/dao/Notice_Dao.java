package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

public interface Notice_Dao<Notice_Vo> {
	
	 List<Notice_Vo> selectAll() throws SQLException;
	 void insertOne(Notice_Vo bean) throws SQLException;
	 Notice_Vo selectOne(int no_no) throws SQLException;
	 int updateOne(Notice_Vo bean) throws SQLException;
	 int deleteOne(int no_no) throws SQLException;
	
}
