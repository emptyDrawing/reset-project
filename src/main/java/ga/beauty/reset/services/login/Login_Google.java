package ga.beauty.reset.services.login;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import ga.beauty.reset.dao.User_Dao;
import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.services.Login_Service;
import ga.beauty.reset.utils.ErrorEnum;


@Service("login_Google")
public class Login_Google implements Login_Service{

	private static final Logger logger = Logger.getLogger(Login_Google.class);

	String access_token;
	private HttpSession userSession;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	@Autowired
	User_Dao user_Dao;
	
	public Login_Google() {
	}
	
	@Override
	public String logout(Model model, HttpServletRequest req, HttpServletResponse resp) {
		req.getSession().invalidate();
		return "index";
	}// logout()

	// 이메일 체크할때 토큰 오류 / 이메일 오류 있을수 있음
	@Override
	public Model login(Model model, HttpServletRequest req) throws Exception {
		request = req;
		userSession= req.getSession();
		access_token = req.getParameter("idtoken");
		
		String result = getEmail(access_token);
		if(result.equals(ErrorEnum.TOKENERR)) {
			userSession.setAttribute("login_err",ErrorEnum.TOKENERR);
			userSession.setAttribute("nextUrl", "/errPage");
			return model;
		}else if(result.equals(ErrorEnum.EMAILERR)) {
			userSession.setAttribute("login_err",ErrorEnum.EMAILERR);
			userSession.setAttribute("nextUrl", "/errPage");
			return model;
		}
		
		User_Vo checkEmailVo = new User_Vo();
		checkEmailVo.setEmail(result);
		userSession.setAttribute("login_email", checkEmailVo.getEmail());
		userSession.setAttribute("login_route", "google");
		User_Vo resultUser = user_Dao.selectOne(checkEmailVo);
		String nextUrl ="";
		if(resultUser != null) {
			if(resultUser.getJoin_route().contains("google")) {
			// 로그인 완료
				userSession.setAttribute("access_token", access_token);
				userSession.setAttribute("login_user_type", resultUser.getUser_type());
				userSession.setAttribute("login_email", resultUser.getEmail());
				userSession.setAttribute("login_on", true);
				result = "200";
				nextUrl = (String)userSession.getAttribute("old_url");//이전로그
			}else {
				// TODO [kss]Reset 나중에 지워야됨
				// 연동할건지 물어보기
				result = "300";
				userSession.setAttribute("login_user_type", resultUser.getUser_type());
				userSession.setAttribute("join_route", resultUser.getJoin_route());
				nextUrl = "/reset/login/adds";
			}
		}else {
			// TODO [kss] Reset 나중에 지워야됨
			result = "201"; // 회원가입
			nextUrl = "/reset/sign/";// 
			// 회원가입
		}
		req.setAttribute("result", result);
		req.setAttribute("nextUrl", nextUrl);
		req.setAttribute("login_result","login/google");
		return model;
	}// login()

	private String getEmail(String id_token) throws GeneralSecurityException, IOException {

		JsonFactory jsonFactory = new JacksonFactory();
		HttpTransport transport = new NetHttpTransport();

		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
				.setAudience(Collections.singletonList("1051220480905-p8890ral8a45q8c1q6201a57oqg75k7f.apps.googleusercontent.com"))
				.build();

		GoogleIdToken idToken = verifier.verify(id_token);
		String email = "";
		if (idToken != null) {
			Payload payload = idToken.getPayload();
			String userId = payload.getSubject();
			email = payload.getEmail();
			boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			if(emailVerified) {
				return email;
			}else {
				return ErrorEnum.EMAILERR;
			}
		} else {
			return ErrorEnum.TOKENERR;
		}

	}//getEmail()


}// Login_Google()


