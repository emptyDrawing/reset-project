package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import ga.beauty.reset.dao.entity.Likes_Vo;

public interface Likes_Dao<C> {
	
	Likes_Vo check(C bean) throws SQLException;
	
	int likesAdd(C bean) throws SQLException;
	
	int likesDel(C bean) throws SQLException;
	
	int likesCheck(HashMap map) throws SQLException;
	
	int up(HashMap map) throws SQLException;
	
	int down(HashMap map) throws SQLException;
	
}
