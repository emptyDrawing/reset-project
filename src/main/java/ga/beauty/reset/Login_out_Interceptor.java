package ga.beauty.reset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.runner.Common_Listener;
import ga.beauty.reset.utils.runner.Login_Listener;

public class Login_out_Interceptor extends HandlerInterceptorAdapter{

	Logger logger = Logger.getLogger(Login_out_Interceptor.class);

	Common_Listener login_Listener;
	
	public Login_out_Interceptor() {
		logger.info(LogEnum.INIT+"("+getClass()+") 생성완료");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		HttpSession session = request.getSession();
		if(login_Listener==null) login_Listener = Login_Listener.getThis();
		if(session.getAttribute("login_on")==null) {
			
		}else if((boolean)session.getAttribute("login_on") == true){
			login_Listener.addLog(new User_Vo(), "num", 1);
		}else if((boolean)session.getAttribute("login_on") ==false){
			//login_Listener.addLog(new User_Vo(), "num", -1);
		}
		super.afterCompletion(request, response, handler, ex);
	}
	
	/*@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(login_Listener==null) login_Listener = Login_Listener.getThis();
		if(session.getAttribute("login_on")==null) {
			
		}else if((boolean)session.getAttribute("login_on") == true){
			login_Listener.addLog(new User_Vo(), "num", 1);
		}else if((boolean)session.getAttribute("login_on") ==false){
			//login_Listener.addLog(new User_Vo(), "num", -1);
		}
		super.afterConcurrentHandlingStarted(request, response, handler);
	}
	 */
	
}
