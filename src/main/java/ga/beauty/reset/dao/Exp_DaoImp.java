package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Exp_DaoImp implements Exp_Dao {
	Logger log=Logger.getLogger(getClass());
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int up(Map map) throws SQLException {
		return sqlSession.update("exp.expUp",map);
	}

	@Override
	public int down(Map map) throws SQLException {
		return sqlSession.update("exp.expDown",map);
	}

}
