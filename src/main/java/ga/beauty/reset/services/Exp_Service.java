package ga.beauty.reset.services;

import java.sql.SQLException;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ga.beauty.reset.dao.Exp_Dao;
import ga.beauty.reset.utils.LogEnum;

@Service
public class Exp_Service {
	Logger logger=Logger.getLogger(getClass());
	
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
		logger.info(LogEnum.EXP+"계정["+email+"]의 포인트가 ["+exp+"]만큼 증가하였습니다.");
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
		logger.info(LogEnum.EXP+"계정["+email+"]의 포인트가 ["+exp+"]만큼 하락하였습니다.");
		return Exp_Dao.down(map); 
	}	
}
