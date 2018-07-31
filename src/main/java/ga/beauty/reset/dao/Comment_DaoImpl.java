package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Comment_Vo;

@Repository
public class Comment_DaoImpl implements Comment_Dao<Comment_Vo> {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int count(Comment_Vo bean) throws SQLException {
	
		sqlSession.selectList("",bean);
		return sqlSession.selectOne("comment.count", bean);
	}
	
	@Override
	public List<Comment_Vo> list(Comment_Vo bean) throws SQLException {
		return sqlSession.selectList("comment.list",bean);
	}

	
	@Override
	public void create(Comment_Vo bean) throws SQLException {
		sqlSession.insert("comment.create",bean);
	}

	@Override
	public void update(Comment_Vo bean) throws SQLException {
		sqlSession.update("comment.update",bean);
	}

	@Override
	public void delete(Comment_Vo bean) throws SQLException {
		sqlSession.delete("comment.delete",bean);
	}

	@Override
	public void deleteAll(Comment_Vo bean) throws SQLException {
		sqlSession.delete("comment.deleteAll", bean);
		
	}

	@Override
	public List<Comment_Vo> mypage_list(Comment_Vo bean) throws SQLException {
		return sqlSession.selectList("comment.mypage_list",bean);
	}

}
