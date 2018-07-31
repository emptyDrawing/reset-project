package ga.beauty.reset.utils;

public class LogEnum {
	
	public static final String INIT = "@INIT@-"; // 특정페이지 들어갈때 하는거
	public static final String INTER = "@접속@-"; // 특정페이지 들어갈때 하는거
	public static final String SAVA_LOG = "@저장@-"; // listenner 로그 저장
	
	public static final String LOGIN = "@로그인@-"; // 로그인 됬을때
	public static final String LOGOUT = "@로그아웃@-"; // 로그아웃 
	public static final String SIGNUP = "@회원가입@-"; // 로그아웃 
	public static final String PROFILE ="@회원정보@-"; // 회원정보 변경시
	
	public static final String ITM = "@아이템@-";
	public static final String REV = "@리뷰@-"; // 
	public static final String MAG = "@매거진@-"; // 
	public static final String LIKE = "@좋아요@-"; // 
	public static final String EVE = "@이벤트@-"; // 
	
	public static final String ERROR = "@에러@-"; // 에러상황일때
	public static final String ERROR_ASYNC = "@비동기-스케쥴러에러@-"; // 
	public static final String EEROR_CON= "@비정상접속@-";
}
