package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import ga.beauty.reset.dao.entity.Members_Vo;

public interface Members_Dao {
	Members_Vo selectOne(Members_Vo bean) throws SQLException;
	List<Members_Vo> selectAll() throws SQLException;
	List<Members_Vo> selectAllLimit(HashMap<String,Object> map) throws SQLException;
	int totCount(HashMap<String,Object> map) throws SQLException;
	int insertOne(Members_Vo otherBean) throws SQLException;
	int updateOne(Members_Vo bean) throws SQLException;
	int deleteOne(Members_Vo bean) throws SQLException;
	public <T> int checkInfo(T compare) throws SQLException;
}
