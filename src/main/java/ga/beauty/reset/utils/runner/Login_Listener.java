package ga.beauty.reset.utils.runner;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.Future;

import javax.annotation.PreDestroy;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.entity.User_Vo;
import ga.beauty.reset.dao.entity.stat.Log_C_Vo;
import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.MySDF;

@Component("login_Listener")
public class Login_Listener implements Common_Listener {

	Logger logger = Logger.getLogger(Login_Listener.class);
	// login/yy/MM/dd.json
	// {"data":[{"name":"로그인","num":int},{"name":"접속자","num":int}]}

	private String defaultFP = "/reset/report/login/";
	// 했는데 시점이 애매함 다시 봐야됨 이놈은 인터셉터 - linter 봐야됨

	// addLog 할때 user 넣으면 로그인숫자 올리기
	// 접속자는 null
	// 일마다 로그인 한 사람들 총수
	// session lsn가 잘 작동하니까 이걸 이용해서 전체 접속숫자는 저장한다.

	private List<Log_C_Vo> list;
	private ObjectMapper objectMapper;
	private JsonNode node;

	static Login_Listener self;

	public Login_Listener() {
		try {
			init();
			self = this; // TODO 임시용
			logger.info(LogEnum.INIT + "(" + getClass() + ") 생성완료");
		} catch (Exception e) {
			String msg = e.getMessage();
			msg=msg.replace("\n", " ").replace("\r", "");
			logger.error(LogEnum.ERROR+msg);
		}
	}

	public static Login_Listener getThis() {
		return self; // TODO 임시용
	}

	private void init() throws JsonProcessingException, IOException {
		list = new ArrayList<Log_C_Vo>();
		objectMapper = new ObjectMapper();
		Date date = new Date();
		String filename = defaultFP + MySDF.SDF_Y.format(date) + "/" + MySDF.SDF_M.format(date) + "/"
				+ MySDF.SDF_D.format(date) + ".json";
		File file = new File(filename);
		if (!file.exists()) {
			new File(file.getParent()).mkdirs();
		} else {
			node = objectMapper.readTree(file);
			list = objectMapper.convertValue(node.findValue("data"), new TypeReference<List<Log_C_Vo>>() {
			});
		}
	}// init()

	@Async("threadPoolTaskExecutor")
	@Override
	public <T> Future<String> addLog(T bean, String type, int chNum) throws Exception {
		if (bean == null) {
			changeValue(null, type, chNum);
		} else if (bean instanceof User_Vo) {
			User_Vo target = (User_Vo) bean;
			changeValue(target, type, chNum);
		}
		return new AsyncResult<String>("Success");
	}// addLog()

	private void changeValue(User_Vo target, String type, int chNum) {
		Log_C_Vo checkVo = null;
		if (target != null)
			checkVo = new Log_C_Vo("로그인", 0);
		else
			checkVo = new Log_C_Vo("접속자", 0);
		// 기존에 있는건지 확인
		int maybeIdx = list.indexOf(checkVo);
		if (maybeIdx >= 0)
			checkVo = list.get(maybeIdx);
		else
			list.add(checkVo);
		// 어떤거 값 변화
		if (type.equals("num")) { // 사실 안써도 됨.
			checkVo.setNum(checkVo.getNum() + chNum);
		}
	}// changeValue()

	@Override
	public List getList() throws Exception {
		return list;
	}// getList()

	@Override
	@Async("threadPoolTaskExecutor")
	@Scheduled(cron = " 0 1 0 * * *\r\n")
	public void saveLogOneday() throws Exception {
		synchronized (this) {
			Calendar cal = new GregorianCalendar();
			cal.add(Calendar.DATE, -1);
			Date date = cal.getTime();
			String filename = defaultFP + MySDF.SDF_Y.format(date) + "/" + MySDF.SDF_M.format(date) + "/"
					+ MySDF.SDF_D.format(date) + ".json";
			File file = new File(filename);
			if (!file.exists()) {
				new File(file.getParent()).mkdirs();
			}
			StringBuilder sbr = createJsonString();
			try (BufferedWriter buffOut = new BufferedWriter(new FileWriter(file))) {
				buffOut.write(sbr.toString());
				buffOut.flush();
				logger.info(LogEnum.SAVA_LOG + " [" + MySDF.SDF_ALL.format(date) + "]일의 로그인/접속자 수치가 저장되었습니다.");
			}
			init();
		}
	}// saveLogOneday()

	@Override
	@PreDestroy
	public void saveTmp() throws Exception {
		if (list.size() == 0) {
			return;
		}
		synchronized (this) {
			Date date = new Date();
			String filename = defaultFP + MySDF.SDF_Y.format(date) + "/" + MySDF.SDF_M.format(date) + "/"
					+ MySDF.SDF_D.format(date) + ".json";
			File file = new File(filename);
			if (!file.exists()) {
				new File(file.getParent()).mkdirs();
			}
			StringBuilder sbr = createJsonString();
			try (BufferedWriter buffOut = new BufferedWriter(new FileWriter(file))) {
				buffOut.write(sbr.toString());
				buffOut.flush();
				logger.warn(LogEnum.SAVA_LOG + " [" + MySDF.SDF_ALL.format(date) + "]일의 로그인 로그가 임시저장 되었습니다.");
			}
		}
	}

	@Override
	protected void finalize() throws Throwable {
		saveTmp();
	}// finalize()

	private StringBuilder createJsonString() {
		StringBuilder sbr = new StringBuilder("{\"data\":[");
		Iterator<Log_C_Vo> ite = list.iterator();
		int i = 0;
		while (ite.hasNext()) {
			if (i != 0)
				sbr.append(",");
			sbr.append(ite.next());
			i++;
		}
		sbr.append("]}");
		return sbr;
	}// createJsonString()

}// Login_Listener
