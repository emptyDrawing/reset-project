package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Notice_Vo;

@Repository
public class Notice_DaoImpl implements Notice_Dao<Notice_Vo> {
	
	@Autowired
	SqlSession sqlSession;

	
	public Notice_DaoImpl() {
	}
	
	
	@Override
	public List<Notice_Vo> selectAll() throws SQLException {
		System.out.println(sqlSession);
		return sqlSession.selectList("notice_mapper.selectAll");
	}

	@Override
	public void insertOne(Notice_Vo bean) throws SQLException {
		sqlSession.insert("notice_mapper.insertOne", bean);
	}

	@Override
	public Notice_Vo selectOne(int no_no) throws SQLException {
		return sqlSession.selectOne("notice_mapper.selectOne", no_no);
	}

	@Override
	public int updateOne(Notice_Vo bean) throws SQLException {
		return sqlSession.update("notice_mapper.updateOne", bean);
	}

	@Override
	public int deleteOne(int no_no) throws SQLException {
		return sqlSession.delete("notice_mapper.deleteOne", no_no);
	}

}
