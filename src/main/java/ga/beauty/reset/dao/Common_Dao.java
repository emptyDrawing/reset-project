package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

public interface Common_Dao<C> {

	List<C> selectAll() throws SQLException;
	List<C> selectAll(int num) throws SQLException;
	List<C> selectAll(C bean) throws SQLException;
	List<C> selectAll(int cate,int offset, int noOfRecords) throws SQLException;
	List<C> selectAll(int offset, int noOfRecords) throws SQLException;
	int getCount() throws SQLException;
	int getCount(int cate) throws SQLException;
	void insertOne(C bean) throws SQLException;
	C selectOne(C bean) throws SQLException;
	int updateOne(C bean) throws SQLException;
	int deleteOne(C bean) throws SQLException;
	int updateView(C bean) throws SQLException;
	
}
