package ga.beauty.reset.services;

import java.sql.SQLException;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ga.beauty.reset.dao.Exp_Dao;

@Service
public class Exp_Service {
	Logger log=Logger.getLogger(getClass());
	
	@Autowired
	Exp_Dao Exp_Dao;
	
	public int up(String email,String type) throws SQLException {
		int exp=0;
		if(type.equals("review")) {
			exp=10;
		}else if(type.equals("comment")) {
			exp=5;
		}else if(type.equals("like")) {
			exp=1;
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("exp", exp);
		return Exp_Dao.up(map); 
	}
	
	public int down(String email,String type) throws SQLException {
		int exp=0;
		if(type.equals("review")) {
			exp=10;
		}else if(type.equals("comment")) {
			exp=5;
		}else if(type.equals("like")) {
			exp=1;
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("exp", exp);
		return Exp_Dao.down(map); 
	}	
}
