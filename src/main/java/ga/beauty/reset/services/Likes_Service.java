package ga.beauty.reset.services;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ga.beauty.reset.dao.Likes_Dao;
import ga.beauty.reset.dao.entity.Event_Vo;
import ga.beauty.reset.dao.entity.Likes_Vo;
import ga.beauty.reset.dao.entity.Magazine_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;
import ga.beauty.reset.utils.runner.Common_Listener;


@Service
public class Likes_Service {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	Likes_Dao<Likes_Vo> Likes_Dao;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired	@Qualifier("like_Listener")
	Common_Listener like_Listener;

	@Autowired	@Qualifier("magzine_Listener")
	Common_Listener magzine_Listener;
	
	@Autowired @Qualifier("event_Listener")
	Common_Listener event_Listener;

	@Autowired @Qualifier("review_Listener")
	Common_Listener review_Listener;
	
	
	public Likes_Vo check(Likes_Vo bean) throws SQLException {
		logger.debug("likes_dao param: "+bean);
		bean.setType(convert_Type(bean.getType()));
		return Likes_Dao.check(bean);
	}
	
	@Transactional
	public Map up(Likes_Vo bean) throws Exception {
		logger.debug("bean"+bean);
		bean.setType(convert_Type(bean.getType()));
		Likes_Dao.likesAdd(bean);//insert하고

		String type_no=null;
		if(bean.getType().equals("리뷰")) {
			bean.setType("review");
			type_no="rev_no";
		}else if(bean.getType().equals("매거진")) {
			bean.setType("magazine");
			type_no="mag_no";
		}else if(bean.getType().equals("이벤트")) {
			bean.setType("event");
			type_no="eve_no";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("type", bean.getType());
		map.put("type_no", type_no);
		map.put("p_no", bean.getP_no());
		int result=Likes_Dao.up(map);//1을 추가시킴
		int like=Likes_Dao.likesCheck(map);//좋아요 수를 확인
		// XXX:[kss] 좋아요 로그쌓기 
			addLogToListener(bean, 1);
		//
		map2.put("result", result);
		map2.put("like",like);
		return map2;
	}
	
	@Transactional
	public Map down(Likes_Vo bean) throws Exception {
		logger.debug("bean"+bean);
		bean.setType(convert_Type(bean.getType()));
		Likes_Dao.likesDel(bean);//Del하고
		
		String type_no=null;
		if(bean.getType().equals("리뷰")) {
			bean.setType("review");
			type_no="rev_no";
		}else if(bean.getType().equals("매거진")) {
			bean.setType("magazine");
			type_no="mag_no";
		}else if(bean.getType().equals("이벤트")) {
			bean.setType("event");
			type_no="eve_no";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("type", bean.getType());
		map.put("type_no", type_no);
		map.put("p_no", bean.getP_no());
		int result=Likes_Dao.down(map);//1을 내림
		int like=Likes_Dao.likesCheck(map);//좋아요 수를 확인
		// XXX:[kss] 좋아요 로그쌓기 
			addLogToListener(bean, -1);
		//
		map2.put("result", result);
		map2.put("like",like);
		return map2;
	}
	
	
	private String convert_Type(String type) {
		// co_type를 영어에서 한글로 바꾸는 메소드 입니다.
		if(type.equals("event")){
			return type="이벤트";
		}else if(type.equals("magazine")) {
			return type="매거진";
		}else if(type.equals("review")) {
			return type="리뷰";
		}else {
			return type="에러";
		}
	}
	
	private <T> void addLogToListener(Likes_Vo bean, int chValue) throws Exception {
		like_Listener.addLog(bean, "num", chValue);
		String type = bean.getType();
		if(type.equals("이벤트")){
			Event_Vo target = new Event_Vo();
			target.setEve_no(bean.getP_no());
			event_Listener.addLog(target, "like", chValue);
		} else if(type.equals("매거진")){
			Magazine_Vo target = new Magazine_Vo();
			target.setMag_no(bean.getP_no());
			magzine_Listener.addLog(target, "like", chValue);
		} else if(type.equals("리뷰")){
			Reviews_Vo target = new Reviews_Vo();
			target.setRev_no(bean.getP_no());
			review_Listener.addLog(target, "like", chValue);
		}
	};
}//Like_Service
