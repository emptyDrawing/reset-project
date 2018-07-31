package ga.beauty.reset.dao;

import java.sql.SQLException;

import ga.beauty.reset.dao.entity.User_Vo;

public interface User_Dao {

	public User_Vo selectOne(User_Vo bean) throws SQLException;
	public int insertOne(User_Vo bean) throws SQLException;
	public int updateOne(User_Vo bean) throws SQLException;
	public <T> int checkInfo(T compare);
}
