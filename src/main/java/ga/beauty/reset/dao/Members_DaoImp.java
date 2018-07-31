package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Members_Vo;

@Repository
public class Members_DaoImp implements Members_Dao{

	@Autowired
	SqlSession sqlSession;

	@Override
	public Members_Vo selectOne(Members_Vo bean) throws SQLException {
		return sqlSession.selectOne("members.selectOne",bean);
	}

	@Override
	public List<Members_Vo> selectAll() throws SQLException {
		return sqlSession.selectList("members.selectAll");
	}
	
	@Override
	public List<Members_Vo> selectAllLimit(HashMap<String,Object> map) throws SQLException {
		return sqlSession.selectList("members.selectAllLimit", map);
	}
	
	@Override
	public int totCount(HashMap<String,Object> map) throws SQLException {
		return sqlSession.selectOne("members.totCount",map);
	}

	@Override
	public int insertOne(Members_Vo bean) throws SQLException {
		return sqlSession.insert("members.insertOne", bean);
	}

	@Override
	public int updateOne(Members_Vo bean) throws SQLException {
		return sqlSession.update("members.insertOne", bean);
	}

	@Override
	public int deleteOne(Members_Vo bean) throws SQLException {
		return 0;
	}

	@Override
	public <T> int checkInfo(T compare) throws SQLException {
		return sqlSession.selectOne("members.checkInfo", compare);
	}
	
}
