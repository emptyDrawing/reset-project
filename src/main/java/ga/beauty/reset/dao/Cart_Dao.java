package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;

import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;

public interface Cart_Dao {

	// 찜조회
	Members_Vo cartList(String email) throws SQLException;
	
	// 찜조회
	Items_Vo selectOne(int item) throws SQLException;
	
	// 찜추가/삭제
	int cartUpdate(HashMap map) throws SQLException;
	
}
