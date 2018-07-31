package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Likes_Vo;

@Repository
public class Likes_DaoImp implements Likes_Dao<Likes_Vo> {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Likes_Vo check(Likes_Vo bean) throws SQLException {
		logger.debug("like_dao_param: "+bean);
		return sqlSession.selectOne("likes.likes", bean);
	}

	@Override
	public int likesAdd(Likes_Vo bean) throws SQLException {
		logger.debug("like_dao_param: "+bean);
		return sqlSession.insert("likes.likesAdd", bean);
	}
	
	@Override
	public int likesDel(Likes_Vo bean) throws SQLException {
		logger.debug("like_dao_param: "+bean);
		return sqlSession.delete("likes.likesDel", bean);
	}
	
	@Override
	public int likesCheck(HashMap map) throws SQLException {
		return sqlSession.selectOne("likes.likescheck", map);
	}
	
	@Override
	public int up(HashMap map) throws SQLException {
		return sqlSession.update("likes.likesUp", map);
	}

	@Override
	public int down(HashMap map) throws SQLException {
		return sqlSession.update("likes.likesDown", map);
	}

}
