package ga.beauty.reset.services.mypage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;

import ga.beauty.reset.Session_Listener;
import ga.beauty.reset.dao.Companys_Dao;
import ga.beauty.reset.dao.Event_DaoImpl;
import ga.beauty.reset.dao.Items_DaoImp;
import ga.beauty.reset.dao.Magazine_DaoImpl;
import ga.beauty.reset.dao.Members_Dao;
import ga.beauty.reset.dao.Reviews_DaoImp;
import ga.beauty.reset.dao.entity.Companys_Vo;
import ga.beauty.reset.dao.entity.Event_Vo;
import ga.beauty.reset.dao.entity.Magazine_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;
import ga.beauty.reset.dao.entity.stat.Log_Chart;
import ga.beauty.reset.dao.entity.stat.Log_File;
import ga.beauty.reset.dao.entity.stat.Simple_Vo;
import ga.beauty.reset.utils.ChartFile;
import ga.beauty.reset.utils.RegexLogFile;

@Service
public class Mypage_Admin_Service {
	
	String logFile = "C:/reset/applogs/weblog.log";
	String errFile = "C:/reset/applogs/errlog.log";
	
	Logger logger = Logger.getLogger(getClass());
	
// 권한으로 CEO, 직원 구별한다

	@Autowired
	RegexLogFile regexLogFile;
	@Autowired
	ChartFile chartFile;
	private String[] colorFile = {
			"rgba(255,145,48,"
			,"rgba(132,176,157,"
			,"rgba(18,140,135,"
			,"rgba(59,0,48,"
	};
	public Mypage_Admin_Service() {
	}
	
	@Autowired
	Members_Dao members_Dao;
	
	@Autowired
	Companys_Dao companys_Dao;
	
	@Autowired
	Magazine_DaoImpl magazine_Dao;
	
	@Autowired
	Reviews_DaoImp reviews_Dao;
	
	@Autowired
	Event_DaoImpl event_Dao;
	
	@Autowired
	Items_DaoImp items_DaoImp;
	
	// 접속자수 / 로그인 수 / 숫자 등등
	// rev-cnt/ mag-cnt/ eve-cnt / itm-cnt
	public int getInfoAsInt(String command, HttpSession session, HttpServletRequest req) throws SQLException {
		int data =0;
		if(command.equals("login-cnt")) {
			data = Session_Listener.getLoginSessionNumber();
		}else if(command.equals("session-cnt")) {
			data = Session_Listener.getActiveSessionNumber();
		}else if(command.equals("rev-cnt")) {
			data = reviews_Dao.getCount();
		}else if(command.equals("mag-cnt")) {
			data = magazine_Dao.getCount();
		}else if(command.equals("eve-cnt")) {
			data = event_Dao.getCount();
		}else if(command.equals("itm-cnt")) {
			data = items_DaoImp.getCount();
		}
		return data;
	}

	//
	public List getInfoAslist(String command, HttpSession session,
			HttpServletRequest req) throws SQLException {
		if(command.equals("member")) {
			String type= req.getParameter("type");
			HashMap<String, Object> map = new HashMap<String,Object>();
			String start = req.getParameter("start");
			String cnt = req.getParameter("cnt");
			String searchType = req.getParameter("searchType");
			String txt = req.getParameter("txt");
			
			if(start!=null && !start.equals("") && !start.equals("undefined"))map.put("start", Integer.parseInt(start));
			if(cnt!=null && !cnt.equals("")&& !cnt.equals("undefined"))map.put("cnt", Integer.parseInt(cnt));
			if(searchType!=null && !searchType.equals("")&& !searchType.equals("undefined"))map.put("searchType", searchType);
			if(txt!=null && !txt.equals("")&& !txt.equals("undefined"))map.put("txt", txt);
			if(searchType.equals("pointUp"))map.put("pointUp","pointUp");
			if(searchType.equals("#pointDown"))map.put("#pointDown","#pointDown");
			if(type.equals("emp"))map.put("company","reset");
			
			
			if(type.equals("normal")) {
				int tot = members_Dao.totCount(map);
				List<Members_Vo> list = members_Dao.selectAllLimit(map);
				req.setAttribute("totNum", tot);
				req.setAttribute("listSize", list.size());
				req.setAttribute("result_data", list);
				req.setAttribute("go", "1");
				return list;
			}else if(type.equals("company")) {
				int tot = companys_Dao.totCount(map);
				List<Companys_Vo> list = companys_Dao.selectAllLimit(map);
				req.setAttribute("totNum", tot);
				req.setAttribute("listSize", list.size());
				req.setAttribute("result_data", list);
				req.setAttribute("go", "2");
				return list;
			}else if(type.equals("emp")) {
				int tot = companys_Dao.totCount(map);
				List<Companys_Vo> list = companys_Dao.selectAllLimit(map);
				req.setAttribute("totNum", tot);
				req.setAttribute("listSize", list.size());
				req.setAttribute("result_data", list);
				req.setAttribute("go", "2");
				return list;
			}
		}else if(command.equals("event")){
			String where = (String) req.getParameter("where");
			List<Event_Vo> lists  = null;
			
			if(where !=null && !where.equals("") && !where.equals("undefined")){
				Event_Vo bean = new Event_Vo();
				bean.setCom_email(where);
				lists = event_Dao.selectAll(bean );
			}
			else lists = event_Dao.selectAll();

			List<Simple_Vo> listitem = new ArrayList<Simple_Vo>();
			Iterator<Event_Vo> ite = lists.iterator();
			while(ite.hasNext()) {
				Event_Vo bean = ite.next();
				listitem.add(new Simple_Vo(bean.getEve_no(),bean.getTitle()));
			}
			return listitem;
		}else if(command.equals("magzine")){
			String where = (String) req.getParameter("where");
			List<Magazine_Vo> lists  = null;
			if(where !=null && !where.equals("") && !where.equals("undefined")) {
				Magazine_Vo bean = new Magazine_Vo();
				bean.setCom_email(where);
				lists = magazine_Dao.selectAll(bean );
			}
			else lists = magazine_Dao.selectAll();
			List<Simple_Vo> listitem = new ArrayList<Simple_Vo>();
			Iterator<Magazine_Vo> ite = lists.iterator();
			while(ite.hasNext()) {
				Magazine_Vo bean = ite.next();
				listitem.add(new Simple_Vo(bean.getMag_no(),bean.getTitle()));
			}
			return listitem;
		}else if(command.equals("review")){
			String where = (String) req.getParameter("where");
			List<Reviews_Vo> lists  = null;
			if(where !=null && !where.equals("") && !where.equals("undefined")) {
				Magazine_Vo bean = new Magazine_Vo();
				bean.setCom_email(where);
				lists = reviews_Dao.reviewToTAll();
			}
			else lists = reviews_Dao.reviewToTAll();
			List<Simple_Vo> listitem = new ArrayList<Simple_Vo>();
			Iterator<Reviews_Vo> ite = lists.iterator();
			while(ite.hasNext()) {
				Reviews_Vo bean = ite.next();
				listitem.add(new Simple_Vo(bean.getRev_no(),"[item:"+bean.getItem()+"/Writer:"+bean.getWriter()+"]"));
			}
			return listitem;
		}
		return null;
	}	

	
	
	public List<Log_File> getLog(String command, HttpSession session, HttpServletRequest req) throws NumberFormatException, IOException, InterruptedException {
		// log_start_num="+start+"&nextNum="+cnt+"&more_Log=true"+"&mode=detail
		String startNum = req.getParameter("log_start_num");
		String cnt = req.getParameter("nextNum");
		
		List<Log_File> list = null;
		if(command.equals("normal")) {
			if(startNum!=null && !startNum.equals("") && cnt!=null && !cnt.equals("")) {
				list = regexLogFile.getListFromLog(logFile,Integer.parseInt(startNum),Integer.parseInt(cnt));
				req.setAttribute("endPoint", Integer.parseInt(startNum)+list.size());
			}else {
				list = regexLogFile.getListFromLog(logFile);
			}
		}else if(command.equals("error")) {
			if(startNum!=null && !startNum.equals("") && cnt!=null && !cnt.equals("")) {
				list = regexLogFile.getListFromLog(errFile,Integer.parseInt(startNum),Integer.parseInt(cnt));
			}else {
				list = regexLogFile.getListFromLog(errFile);
			}		
		}
		return list;
	}

	public <T> Map<String, Object> getChart(String command, HttpSession session, HttpServletRequest req) throws JsonProcessingException, IOException {
		Map<String,Object> listS = null;

		String days = req.getParameter("log_day");
		int daysInt = 1;
		if(days!=null && !days.equals("")) daysInt = Integer.parseInt(days);		
		String beanType = req.getParameter("no");
		
		
		int no = -1;
		if(beanType!=null && !beanType.equals(""))no = Integer.parseInt(beanType);		
		if(no==-1){
			listS = chartFile.getDataForC(command,daysInt);
		}else{
			listS = chartFile.getDataForEM(command,daysInt,no);
		}
		
		if(listS.size()>0) {
			StringBuffer sbr = new StringBuffer();
			StringBuffer sbr2 = new StringBuffer(); // 라벨용
			sbr.append("[");
			Set<String> keySet = listS.keySet();
			Iterator<String> ite = keySet.iterator();
			int cnt = 0;
			while(ite.hasNext()) {
				String listName = ite.next();
				if( listName.equals("라벨")) {
					List<String> list = (List<String>) listS.get(listName);	
					sbr2.append("[");
					for(int i=0; i<list.size(); i++){
						if(i!=0)sbr2.append(",");
						sbr2.append("\""+list.get(list.size()-i-1)+"\"");
					}
					sbr2.append("]");
				}else {
					List<Log_Chart> list = (List<Log_Chart>) listS.get(listName);	
					sbr.append("{label:'"+list.get(0).getLabel()+"',");
		            sbr.append("borderColor: '"+getColor(cnt,"0.8")+"',");
		            sbr.append("backgroundColor: '"+getColor(cnt++,"0.4")+"',");
					sbr.append("data:[");
					for(int i=0; i<list.size(); i++){
						if(i!=0)sbr.append(",");
						sbr.append(list.get(list.size()-i-1).getValueY());
					}
					sbr.append("]},");
				}
			}
			sbr.append("]");
			req.setAttribute("dataSet", sbr.toString());
			req.setAttribute("labels", sbr2.toString());
		}
		return listS;
	}

	private String getColor(int i,String str) {
		return colorFile [i]+str+")";
	}

}// Mypage_Admin_service
