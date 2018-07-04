package ga.beauty.reset.services.login;

import org.springframework.stereotype.Service;

import ga.beauty.reset.services.LoginService;

@Service
public class LoginNaver implements LoginService {

	
	
	private String token;
		
	public void setToken(String token) {
		this.token = token;
	}
	
	public String getToken() {
		return token;
	}
	
	@Override
	public void login() {
		// 토큰 가져오기
		// TODO Auto-generated method stub
		
	}

	@Override
	public void logout() {
		//	토큰키 반납
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getProfile() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getEmail() {
		// TODO Auto-generated method stub
		
	}

}
