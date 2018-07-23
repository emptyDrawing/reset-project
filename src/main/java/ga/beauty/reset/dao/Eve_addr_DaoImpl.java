package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Eve_addr_Vo;

@Repository
public class Eve_addr_DaoImpl implements Common_Dao<Eve_addr_Vo>{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Eve_addr_Vo> selectAll() throws SQLException {
		return null;
	}

	@Override
	public void insertOne(Eve_addr_Vo bean) throws SQLException {
		sqlSession.insert("eveAddr.insertOne", bean);
	}

	@Override
	public Eve_addr_Vo selectOne(Eve_addr_Vo bean) throws SQLException {
		return null;
	}

	@Override
	public int updateOne(Eve_addr_Vo bean) throws SQLException {
		return 0;
	}

	@Override
	public int deleteOne(Eve_addr_Vo bean) throws SQLException {
		return 0;
	}

	@Override
	public int updateView(Eve_addr_Vo bean) throws SQLException {
		return 0;
	}

	@Override
	public List<Eve_addr_Vo> selectAll(Eve_addr_Vo bean) throws SQLException {
		return sqlSession.selectList("eveAddr.selectAll",bean);
	}

	@Override
	public List<Eve_addr_Vo> selectAll(int offset, int noOfRecords) throws SQLException {
		return null;
	}

	@Override
	public int getCount() throws SQLException {
		return 0;
	}

	@Override
	public List<Eve_addr_Vo> selectAll(int eve_no, int offset, int noOfRecords) throws SQLException {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("eve_no", eve_no);
		params.put("offset",offset);
		params.put("noOfRecords",noOfRecords);
		return sqlSession.selectList("eveAddr.pagingList",params);
	}

	@Override
	public int getCount(int eve_no) throws SQLException {
		return sqlSession.selectOne("eveAddr.listCount",eve_no);
	}

	@Override
	public List<Eve_addr_Vo> selectAll(int eve_no) throws SQLException {
		return sqlSession.selectList("eveAddr.selectAll",eve_no);
	}

}
