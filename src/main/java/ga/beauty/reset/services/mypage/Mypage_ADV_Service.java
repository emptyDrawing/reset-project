package ga.beauty.reset.services.mypage;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.w3c.dom.events.EventTarget;

import ga.beauty.reset.dao.Common_Dao;
import ga.beauty.reset.dao.entity.Eve_addr_Vo;
import ga.beauty.reset.dao.entity.Event_Vo;
import ga.beauty.reset.dao.entity.Magazine_Vo;

@Service
public class Mypage_ADV_Service {
	@Autowired
	Common_Dao<Event_Vo> eveDao;
	
	@Autowired
	Common_Dao<Magazine_Vo> magDao;
	
	@Autowired
	Common_Dao<Eve_addr_Vo> eveaddrDao;
	
	
	// 이벤트의 관한 정보만 보여준다.
	public Map<String, Object> getInfo(String command, HttpSession session, HttpServletRequest req) throws SQLException {
		HashMap<String, Object> map =new HashMap<String, Object>();
		
		//session에 있는 이메일을 잡아서 대입해줘야함.
		String com_email=(String) session.getAttribute("login_email");

		//이벤트 리스트
		Event_Vo evebean = new Event_Vo();
		evebean.setCom_email(com_email);
		map.put("EventList", eveDao.selectAll(evebean));
		
		//매거진 리스트
		Magazine_Vo magbean = new Magazine_Vo();
		magbean.setCom_email(com_email);
		map.put("MagList", magDao.selectAll(magbean));
		
		//이벤트 참가자 리스트
		Eve_addr_Vo eveaddrbean = new Eve_addr_Vo();
		eveaddrbean.setEve_no(evebean.getEve_no());
		map.put("Eveaddr", eveaddrDao.selectAll(eveaddrbean));
		
		//이벤트 참가자 숫자
		map.put("EveaddrCount", eveaddrDao.getCount(evebean.getEve_no()));
		
		return map;
	}
	
}
