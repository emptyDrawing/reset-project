package ga.beauty.reset;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.runner.Login_Listener;

public class Session_Listener implements HttpSessionListener{

	Logger logger = Logger.getLogger(Session_Listener.class);
	
	private static final Map<String, HttpSession> SESSIONS = new HashMap<>();
	
	// 현재 접속자수 / 로그인수 만 보여주는 놈
	// see
	// TODO 임시용
	Login_Listener login_Lsn;
	
	public Session_Listener() {
		logger.info(LogEnum.INIT+"("+getClass()+") 생성완료");
	}
    
    public void sessionCreated(HttpSessionEvent event) {
    	logger.debug("세션만들어짐");
        login_Lsn = Login_Listener.getThis();
    	HttpSession session = event.getSession();
        synchronized(this){
        	try {
				login_Lsn.addLog(null, "num", 1);
			} catch (Exception e) {
				logger.error(LogEnum.ERROR+e);
				e.printStackTrace();
			}
        	SESSIONS.put(session.getId(),session);
        }
    }

    public void sessionDestroyed(HttpSessionEvent event) {
        HttpSession session = event.getSession();
        synchronized(this){
        	SESSIONS.remove(session.getId());
        }
    }

    public static int getActiveSessionNumber() {
        return SESSIONS.size();
    }
    
    public static int getLoginSessionNumber() {
    	Set<String> keySet = SESSIONS.keySet();
    	Iterator<String> iteS = keySet.iterator();
    	int count = 0;
	    	while(iteS.hasNext()) {
	    		HttpSession session = SESSIONS.get(iteS.next());
	    		if(session.getAttribute("login_on")!=null) {
		    		boolean loginChk = (boolean)session.getAttribute("login_on");
		    		if(loginChk== true)count++;
		    		else if(loginChk== false)count--;
	    		}
	    	}
    	return count;
    }
}// Session_Linstener
