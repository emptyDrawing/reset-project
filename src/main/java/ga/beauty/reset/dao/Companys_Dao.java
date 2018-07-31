package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;

public interface Companys_Dao{

	Companys_Vo selectOne(Companys_Vo bean) throws SQLException;
	List<Companys_Vo> selectAll() throws SQLException;
	List<Companys_Vo> selectAllLimit(Map<String,Object> map) throws SQLException;
	int totCount(Map<String,Object> map) throws SQLException;
	int insertOne(Companys_Vo otherBean) throws SQLException;
	int updateOne(Companys_Vo bean) throws SQLException;
	int deleteOne(Companys_Vo bean) throws SQLException;
	
}
