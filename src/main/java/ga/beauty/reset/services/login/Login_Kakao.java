package ga.beauty.reset.services.login;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.User_Dao;
import ga.beauty.reset.dao.entity.Login_Vo;
import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.services.Login_Service;
import ga.beauty.reset.utils.ErrorEnum;


@Service("login_kakao")
public class Login_Kakao implements Login_Service{

	private static final Logger logger = Logger.getLogger(Login_Kakao.class);
	
	private final String clientId = "1b9f25b372bcd6828070cc433502aa22";//애플리케이션 클라이언트 아이디값";
	private String redirectURI ="http://reset-beauty.ga/login/kakao/"; // TODO [kss] 주소바꿀거
	// private String access_token = "";
	// private String refresh_token = "";

	// private HttpSession userSession;
	// private HttpServletRequest request;
	
	ObjectMapper mapper = new ObjectMapper();

	@Autowired
	User_Dao user_Dao;

	public Login_Kakao() {
	}
	
	@Override
	public String logout(Model model, HttpServletRequest req, HttpServletResponse resp) {
		req.getSession().invalidate();
		return "index";
	}


	@Override
	public Model login(Model model, HttpServletRequest req) throws Exception {
		// 요청(코드) >>  토큰얻기(코드) >> ( 앱연결(토큰) ) >> 프로필(토큰) 

		HttpServletRequest request = req;
		HttpSession userSession = req.getSession();
		String code = req.getParameter("code");
		
		Login_Vo bean = new Login_Vo();
		bean.setRequest(request);
		bean.setUserSession(userSession);
		
		int resultCode = 0;
		
		if( (resultCode = getToken(code, bean))!=200  ) {
			model.addAttribute("login_err",ErrorEnum.TOKENERR);
			return model;
		} 
		// 한번만 실행되면 됨
		this.setkakaoId(bean);
		
		// checkEmail : 가능한 에러 > profile / email 
		// 소셜로 로그인인지, 회원가입인지를 파악하기 위해서 다오에게서 데이터를 받아옴.
		// 로그인일 경우 리다이렉트, 회원가입일땐 model에 이메일,
		
		String result= this.getInfofromProfile(bean); // 정상적이면 이메일
		if(result.equals(ErrorEnum.PROFILEERR)) {
			req.setAttribute("login_err",ErrorEnum.PROFILEERR);
			return model;
		}
		result = this.checkEmail(result);
		if(result.equals(ErrorEnum.EMAILERR)) {
			req.setAttribute("login_err",ErrorEnum.EMAILERR);
			return model;		
		}
		
		User_Vo checkEmailVo = new User_Vo();
		checkEmailVo.setEmail(result);
		userSession.setAttribute("login_email", checkEmailVo.getEmail());
		userSession.setAttribute("login_route", "kakao");
		User_Vo resultUser = user_Dao.selectOne(checkEmailVo);
		if( resultUser != null) {
			if(resultUser.getJoin_route().contains("kakao")) {
			// 로그인 완료
			userSession.setAttribute("access_token", bean.getAccess_token());
			userSession.setAttribute("refresh_token", bean.getRefresh_token());
			userSession.setAttribute("login_user_type", resultUser.getUser_type());
			userSession.setAttribute("login_on", true);
			req.setAttribute("login_result", "redirect:"+userSession.getAttribute("old_url"));
			}else {
				// 연동할건지 물어보기
				userSession.setAttribute("login_user_type", resultUser.getUser_type());
				userSession.setAttribute("join_route", resultUser.getJoin_route());
				req.setAttribute("login_result", "redirect:/login/adds/");
			}
		}else {
			// 회원가입
			req.setAttribute("login_result", "redirect:/sign/");
		}
		return model;
	}
	
	private int getToken(String code, Login_Vo bean) throws ClientProtocolException, IOException {
		logger.debug(code);
		// 시작
		String apiURL = "https://kauth.kakao.com/oauth/token";
		
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("client_id", clientId)); // REST API KEY
		postParams.add(new BasicNameValuePair("redirect_uri", redirectURI)); // 리다이렉트 URI
		postParams.add(new BasicNameValuePair("code", code)); // 로그인 과정중 얻은 code 값

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(apiURL);
		post.setEntity(new UrlEncodedFormEntity(postParams));
		final HttpResponse response = client.execute(post); // 연결시작
		
		int responseCode=0;
		responseCode = response.getStatusLine().getStatusCode();
		String responseString ="";
		responseString = EntityUtils.toString(response.getEntity());

		JsonNode tokenJson = null;
		logger.debug("Response Code - getToken(kakao) : ("+bean.getRequest().getRemoteHost()+")/"+responseCode);
		if(responseCode==200) {
			tokenJson = mapper.readTree(responseString);
			bean.setAccess_token(tokenJson.get("access_token").asText());
			bean.setRefresh_token(tokenJson.get("refresh_token").asText());
//			access_token= tokenJson.get("access_token").asText();
//			refresh_token= tokenJson.get("refresh_token").asText();
		}else {
			logger.debug("Response Err - getToken(kakao) : ("+bean.getRequest()+")/"+responseString);
		}
		return responseCode;
	}
	
	
	// 앱연결을 위해서 필요한 ID를 등록합니다. 한번만 등록되며,
	// 추후에 카카오톡 연결 해제시 해제만 시키면됩니다.
	private void setkakaoId(Login_Vo bean) throws ClientProtocolException, IOException {
		
		String apiURL = "https://kapi.kakao.com/v1/user/signup";
		final String header1 = "Bearer "+bean.getAccess_token(); 
		
		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(apiURL);
		post.setHeader("Authorization", header1 );
		
		final HttpResponse response = client.execute(post);
		
		int responseCode = response.getStatusLine().getStatusCode();
		String responseString = EntityUtils.toString(response.getEntity(), "utf-8");

		if(responseCode==200) {
//			String app_id = idJson.get("id").asText();
//			logger.debug("app_id : " + app_id);
//			userSession.setAttribute("app_id", app_id);
		}
		logger.debug("Response Code -setkakaoId(kakao): ("+bean.getRequest().getRemoteHost()+")/"+responseCode);
		logger.debug("Response Body -setkakaoId(kakao) : ("+bean.getRequest().getRemoteHost()+")/"+responseString);
	}
	
	private String checkEmail(String resultString) throws IOException {

		JsonNode tokenJson = mapper.readTree(resultString);
		//JsonNode idJson = tokenJson.get("id"); 필요할때 쓰자
		JsonNode accountJson = tokenJson.get("kakao_account");
		boolean hasEmail = accountJson.get("has_email").asBoolean();
		boolean validEmail = accountJson.get("is_email_valid").asBoolean();
		boolean verifedEmail = accountJson.get("is_email_verified").asBoolean();
		String email = accountJson.get("email").asText();
		if( hasEmail &&  validEmail &&  verifedEmail ) {
			return email;
		}else {
			return ErrorEnum.EMAILERR;
		}
	
	}

	private String getInfofromProfile(Login_Vo bean) throws ClientProtocolException, IOException {

		String header1 = "Bearer " + bean.getAccess_token(); // Bearer 다음에 공백 추가
		String header2 = "application/x-www-form-urlencoded;charset=utf-8;";//Content-type
		String apiURL = "https://kapi.kakao.com/v2/user/me";

		List<NameValuePair> parameters = new ArrayList<NameValuePair>();
		parameters.add(new BasicNameValuePair("property_keys", "[\"kakao_account.email\"]"));

		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(apiURL);
		post.addHeader("Authorization",header1);
		post.setEntity(new UrlEncodedFormEntity(parameters));
		
		HttpResponse response = client.execute(post);
		int responseCode = response.getStatusLine().getStatusCode();
		String responseString = EntityUtils.toString(response.getEntity(), "utf-8");
		logger.debug("Response Code -getInfo(kakao): ("+bean.getRequest().getRemoteHost()+")/"+responseCode);
		if(responseCode != 200) {
			logger.debug("Response Err -getInfo(kakao): ("+bean.getRequest().getRemoteHost()+")/"+responseString);
			return ErrorEnum.PROFILEERR;
		}
		return responseString;
	}// getInfofromProfile()
	
}
