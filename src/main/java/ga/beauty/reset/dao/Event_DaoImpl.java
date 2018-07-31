package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Event_Vo;

@Repository
public class Event_DaoImpl implements Common_Dao<Event_Vo>{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Event_Vo> selectAll() throws SQLException {
		return sqlSession.selectList("event.selectAll");
	}

	@Override
	public Event_Vo selectOne(Event_Vo bean) throws SQLException {
		return sqlSession.selectOne("event.selectOne", bean);
	}
	
	@Override
	public void insertOne(Event_Vo bean) throws SQLException {
		sqlSession.insert("event.insertOne", bean);
	}
	
	@Override
	public int updateOne(Event_Vo bean) throws SQLException {
		return sqlSession.update("event.updateOne", bean);
	}

	@Override
	public int deleteOne(Event_Vo bean) throws SQLException {
		return sqlSession.delete("event.deleteOne", bean);
	}

	@Override
	public int updateView(Event_Vo bean) throws SQLException {
		return sqlSession.update("event.updateView", bean);
	}

	@Override
	public List<Event_Vo> selectAll(Event_Vo bean) throws SQLException {
		return sqlSession.selectList("event.selectAll",bean);
	}

	@Override
	public List<Event_Vo> selectAll(int offset, int noOfRecords) throws SQLException {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("offset",offset);
		params.put("noOfRecords",noOfRecords);
		return sqlSession.selectList("event.pagingList",params);
	}

	@Override
	public int getCount() throws SQLException {
		return sqlSession.selectOne("event.listCount");
	}

	@Override
	public List<Event_Vo> selectAll(int cate, int offset, int noOfRecords) throws SQLException {
		return null;
	}

	@Override
	public int getCount(int cate) throws SQLException {
		return 0;
	}

	@Override
	public List<Event_Vo> selectAll(int num) throws SQLException {
		return null;
	}



}
