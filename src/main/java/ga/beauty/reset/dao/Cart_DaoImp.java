package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;

@Repository
public class Cart_DaoImp implements Cart_Dao{
		Logger logger=Logger.getLogger(getClass());

		@Autowired
		SqlSession sqlSession;
		
		// 찜조회-회원
		@Override
		public Members_Vo cartList(String email) throws SQLException {
			return sqlSession.selectOne("items.cartAll", email);
		}
		
		// 찜조회-제품
		@Override
		public Items_Vo selectOne(int item) throws SQLException {
			logger.debug("DaoImp-selectOne-param: "+item);
			return sqlSession.selectOne("items.selectOne", item);
		}
		
		// 찜추가/삭제
		@Override
		public int cartUpdate(HashMap map) throws SQLException {
			return sqlSession.update("items.cartUpdate",map);
		}
	}

