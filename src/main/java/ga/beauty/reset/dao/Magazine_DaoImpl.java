package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Magazine_Vo;

@Repository
public class Magazine_DaoImpl implements Common_Dao<Magazine_Vo>{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Magazine_Vo> selectAll() throws SQLException {
		return sqlSession.selectList("magazine.selectAll");
	}

	@Override
	public void insertOne(Magazine_Vo bean) throws SQLException {
		sqlSession.insert("magazine.insertOne",bean);
	}

	@Override
	public Magazine_Vo selectOne(Magazine_Vo bean) throws SQLException {
		return sqlSession.selectOne("magazine.selectOne", bean);
	}

	@Override
	public int updateOne(Magazine_Vo bean) throws SQLException {
		return sqlSession.update("magazine.updateOne", bean);
	}

	@Override
	public int deleteOne(Magazine_Vo bean) throws SQLException {
		/*return sqlSession.delete("magazine.deleteOne", bean);*/
		return sqlSession.update("magazine.deleteOne", bean);
	}

	@Override
	public int updateView(Magazine_Vo bean) throws SQLException {
		return sqlSession.update("magazine.updateView", bean);
	}

	@Override
	public List<Magazine_Vo> selectAll(Magazine_Vo bean) throws SQLException {
		return sqlSession.selectList("magazine.selectAll",bean);
	}

	@Override
	public List<Magazine_Vo> selectAll(int offset, int noOfRecords) throws SQLException {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("offset",offset);
		params.put("noOfRecords",noOfRecords);
		return sqlSession.selectList("magazine.pagingList",params);
	}

	@Override
	public int getCount() throws SQLException {
		return sqlSession.selectOne("magazine.listCount");
	}

	@Override
	public List<Magazine_Vo> selectAll(int cate, int offset, int noOfRecords) throws SQLException {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("cate", cate);
		params.put("offset",offset);
		params.put("noOfRecords",noOfRecords);
		return sqlSession.selectList("magazine.pagingList",params);
	}

	@Override
	public int getCount(int cate) throws SQLException {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("cate", cate);
		return sqlSession.selectOne("magazine.listCount",params);
	}

	@Override
	public List<Magazine_Vo> selectAll(int num) throws SQLException {
		return null;
	}


}
