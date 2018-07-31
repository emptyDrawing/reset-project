package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.Map;

public interface Exp_Dao {
	
	public int up(Map map) throws SQLException;
	
	public int down(Map map) throws SQLException;
}
