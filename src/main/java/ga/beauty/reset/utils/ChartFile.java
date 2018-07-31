package ga.beauty.reset.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import ga.beauty.reset.dao.entity.stat.Log_Chart;

@Component
public class ChartFile {

	private String defaultFP = "/reset/report/";
	Logger logger = Logger.getLogger(getClass());
	
	public ChartFile() {
	}

	private String getFileName(Date date, String command) {
		String filename = defaultFP + command + "/" + MySDF.SDF_Y.format(date) + "/" + MySDF.SDF_M.format(date) + "/"
				+ MySDF.SDF_D.format(date) + ".json";
		return filename;
	}

	private Map<String, File> getFileList(String command, int days) {
		Map<String, File> files = new HashMap<String, File>();
		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			String filename = getFileName(todayC.getTime(), command);
			File file = new File(filename);
			if (file.exists())
				files.put(MySDF.SDF_ALL.format(todayC.getTime()), file);
			else
				files.put(MySDF.SDF_ALL.format(todayC.getTime()), null);
		}
		return files;
	}

	public Map<String, Object> getDataForC(String command, int days) throws JsonProcessingException, IOException {
		Map<String, File> files = getFileList(command, days);
		Map<String, Object> listS = null;
		if (command.equals("login")) {
			listS = getLoginData(files, command, days);
		} else if (command.equals("like")) {
			listS = getLikeData(files, command, days);
		}
		logger.debug("요청한 차트 데이터 :"+listS);
		return listS;
	}

	public Map<String, Object> getDataForEM(String command, int days, int no)
			throws JsonProcessingException, IOException {
		Map<String, File> files = getFileList(command, days);
		Map<String, Object> listS = null;
		if (command.equals("magzine")) {
			listS = getMagData(files, command, days, no);
		} else if (command.equals("event")) {
			listS = getEveData(files, command, days, no);
		} else if (command.equals("review")) {
			listS = getReviewData(files, command, days,no);
		}
		logger.debug("요청한 차트 데이터 :"+listS);
		return listS;
	}

	// TODO [kss] 이거 해야됨
	private Map<String, Object> getEveData(Map<String, File> files, String command, int days, int no) throws JsonProcessingException, IOException {
		Map<String, Object> listS = new HashMap<String, Object>();
		List<String> listLabels = new ArrayList<String>();
		List<Log_Chart> listlikes = new ArrayList<Log_Chart>();
		List<Log_Chart> listviews = new ArrayList<Log_Chart>();
		List<Log_Chart> listaddrs = new ArrayList<Log_Chart>();

		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			// 라벨 추가
			String day = MySDF.SDF_ALL.format(todayC.getTime());
			listLabels.add(day);
			// 파일 있는지 없는지 검사후 값 넣음
			File file = files.get(day);
			if (file != null) {
				final String daysName = file.getAbsolutePath().replace("\\", "/").replace(defaultFP + command + "/", "").replace(".json", "");
				ObjectMapper mapper = new ObjectMapper();
				final JsonNode arrNode = mapper.readTree(file).get("data");
				if (arrNode.isArray()) {
					boolean checkno = true;
					for (final JsonNode objNode : arrNode) {
						// 여기서도 혹시나 값이 없을땐 초기값 넣음
						if (objNode.get("no").asInt() == no) {
							listlikes.add(new Log_Chart("좋아요", daysName, objNode.get("like").asInt()));
							listviews.add(new Log_Chart("조회수", daysName, objNode.get("view").asInt()));
							listaddrs.add(new Log_Chart("신청자수", daysName, objNode.get("num").asInt()));
							checkno = false;
						}
					} // nodesForEach
					if (checkno) {
						listlikes.add(new Log_Chart("좋아요", daysName, 0));
						listviews.add(new Log_Chart("조회수", daysName, 0));
						listaddrs.add(new Log_Chart("신청자수", daysName, 0));
					}
				} // isArray
			} else {
				listlikes.add(new Log_Chart("좋아요", day, 0));
				listviews.add(new Log_Chart("조회수", day, 0));
				listaddrs.add(new Log_Chart("신청자수", day, 0));
			}
		} // filesForEach
		if (listlikes.size() > 0)
			listS.put("좋아요", listlikes);
		if (listviews.size() > 0)
			listS.put("조회수", listviews);
		if (listaddrs.size() > 0)
			listS.put("신청자수", listaddrs);
		if (listLabels.size() > 0)
			listS.put("라벨", listLabels);

		return listS;
	}

	// TODO [kss] 이거 해야됨
	private Map<String, Object> getMagData(Map<String, File> files, String command, int days, int no)
			throws JsonProcessingException, IOException {
		Map<String, Object> listS = new HashMap<String, Object>();
		List<String> listLabels = new ArrayList<String>();
		List<Log_Chart> listlikes = new ArrayList<Log_Chart>();
		List<Log_Chart> listviews = new ArrayList<Log_Chart>();
		List<Log_Chart> listcomms = new ArrayList<Log_Chart>();

		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			// 라벨 추가
			String day = MySDF.SDF_ALL.format(todayC.getTime());
			listLabels.add(day);
			// 파일 있는지 없는지 검사후 값 넣음
			File file = files.get(day);
			if (file != null) {
				final String daysName = file.getAbsolutePath().replace("\\", "/").replace(defaultFP + command + "/", "")
						.replace(".json", "");
				ObjectMapper mapper = new ObjectMapper();
				final JsonNode arrNode = mapper.readTree(file).get("data");
				if (arrNode.isArray()) {
					boolean checkno = true;
					for (final JsonNode objNode : arrNode) {
						// 여기서도 혹시나 값이 없을땐 초기값 넣음
						if (objNode.get("no").asInt() == no) {
							listlikes.add(new Log_Chart("좋아요", daysName, objNode.get("like").asInt()));
							listviews.add(new Log_Chart("조회수", daysName, objNode.get("view").asInt()));
							listcomms.add(new Log_Chart("댓글수", daysName, objNode.get("num").asInt()));
							checkno = false;
						}
					} // nodesForEach
					if (checkno)
						listlikes.add(new Log_Chart("좋아요", daysName, 0));
				} // isArray
			} else {
				listlikes.add(new Log_Chart("좋아요", day, 0));
				listviews.add(new Log_Chart("조회수", day, 0));
				listcomms.add(new Log_Chart("댓글수", day, 0));
			}
		} // filesForEach
		if (listlikes.size() > 0)
			listS.put("좋아요", listlikes);
		if (listviews.size() > 0)
			listS.put("조회수", listviews);
		if (listcomms.size() > 0)
			listS.put("댓글수", listcomms);
		if (listLabels.size() > 0)
			listS.put("라벨", listLabels);

		return listS;
	}

	private Map<String, Object> getReviewData(Map<String, File> files, String command, int days, int no)
			throws JsonProcessingException, IOException {
		Map<String, Object> listS = new HashMap<String, Object>();
		List<String> listLabels = new ArrayList<String>();
		List<Log_Chart> listlikes = new ArrayList<Log_Chart>();
		List<Log_Chart> listcomms = new ArrayList<Log_Chart>();

		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			// 라벨 추가
			String day = MySDF.SDF_ALL.format(todayC.getTime());
			listLabels.add(day);
			// 파일 있는지 없는지 검사후 값 넣음
			File file = files.get(day);
			if (file != null) {
				final String daysName = file.getAbsolutePath().replace("\\", "/").replace(defaultFP + command + "/", "")
						.replace(".json", "");
				ObjectMapper mapper = new ObjectMapper();
				final JsonNode arrNode = mapper.readTree(file).get("data");
				if (arrNode.isArray()) {
					boolean checkno = true;
					for (final JsonNode objNode : arrNode) {
						// 여기서도 혹시나 값이 없을땐 초기값 넣음
						if (objNode.get("no").asInt() == no) {
							listlikes.add(new Log_Chart("좋아요", daysName, objNode.get("like").asInt()));
							listcomms.add(new Log_Chart("댓글수", daysName, objNode.get("num").asInt()));
							checkno = false;
						}
					} // nodesForEach
					if (checkno)
						listlikes.add(new Log_Chart("좋아요", daysName, 0));
				} // isArray
			} else {
				listlikes.add(new Log_Chart("좋아요", day, 0));
				listcomms.add(new Log_Chart("댓글수", day, 0));
			}
		} // filesForEach
		if (listlikes.size() > 0)
			listS.put("좋아요", listlikes);
		if (listcomms.size() > 0)
			listS.put("댓글수", listcomms);
		if (listLabels.size() > 0)
			listS.put("라벨", listLabels);

		return listS;
	}

	private Map<String, Object> getLikeData(Map<String, File> files, String command, int days)
			throws JsonProcessingException, IOException {
		Map<String, Object> listS = new HashMap<String, Object>();
		List<String> listLabels = new ArrayList<String>();
		List<Log_Chart> listlikes = new ArrayList<Log_Chart>();

		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			// 라벨 추가
			String day = MySDF.SDF_ALL.format(todayC.getTime());
			listLabels.add(day);
			// 파일 있는지 없는지 검사후 값 넣음
			File file = files.get(day);
			if (file != null) {
				final String daysName = file.getAbsolutePath().replace("\\", "/").replace(defaultFP + command + "/", "")
						.replace(".json", "");
				ObjectMapper mapper = new ObjectMapper();
				final JsonNode arrNode = mapper.readTree(file).get("data");
				if (arrNode.isArray()) {
					boolean checklike = true;
					for (final JsonNode objNode : arrNode) {
						// 여기서도 혹시나 값이 없을땐 초기값 넣음
						if (objNode.get("name").asText().equals("좋아요")) {
							listlikes.add(new Log_Chart("좋아요", daysName, objNode.get("num").asInt()));
							checklike = false;
						}
					} // nodesForEach
					if (checklike)
						listlikes.add(new Log_Chart("좋아요", daysName, 0));
				} // isArray
			} else {
				listlikes.add(new Log_Chart("좋아요", day, 0));
			}
		} // filesForEach
		if (listlikes.size() > 0)
			listS.put("좋아요", listlikes);
		if (listLabels.size() > 0)
			listS.put("라벨", listLabels);

		return listS;
	}

	private Map<String, Object> getLoginData(Map<String, File> files, String command, int days)
			throws JsonProcessingException, IOException {
		Map<String, Object> listS = new HashMap<String, Object>();
		List<String> listLabels = new ArrayList<String>();
		List<Log_Chart> listSession = new ArrayList<Log_Chart>();
		List<Log_Chart> listLogin = new ArrayList<Log_Chart>();
		for (int i = 0; i < days; i++) {
			Calendar todayC = new GregorianCalendar();
			todayC.add(Calendar.DATE, -i); // 오늘날짜로부터 -1
			// 라벨 추가
			String day = MySDF.SDF_ALL.format(todayC.getTime());
			listLabels.add(day);
			// 파일 있는지 없는지 검사후 값 넣음
			File file = files.get(day);
			if (file != null) {
				final String daysName = file.getAbsolutePath().replace("\\", "/").replace(defaultFP + command + "/", "")
						.replace(".json", "");
				ObjectMapper mapper = new ObjectMapper();
				final JsonNode arrNode = mapper.readTree(file).get("data");
				if (arrNode.isArray()) {
					boolean checkSession = true;
					boolean checklogin = true;
					for (final JsonNode objNode : arrNode) {
						// 여기서도 혹시나 값이 없을땐 초기값 넣음
						if (objNode.get("name").asText().equals("접속자")) {
							listSession.add(new Log_Chart("접속자", daysName, objNode.get("num").asInt()));
							checkSession = false;
						} else if (objNode.get("name").asText().equals("로그인")) {
							listLogin.add(new Log_Chart("로그인", daysName, objNode.get("num").asInt()));
							checklogin = false;
						}
					} // nodesForEach
					if (checkSession)
						listSession.add(new Log_Chart("접속자", daysName, 0));
					if (checklogin)
						listLogin.add(new Log_Chart("로그인", daysName, 0));
				} // isArray
			} else {
				listSession.add(new Log_Chart("접속자", day, 0));
				listLogin.add(new Log_Chart("로그인", day, 0));
			}
		} // filesForEach
		if (listSession.size() > 0)
			listS.put("접속자", listSession);
		if (listLogin.size() > 0)
			listS.put("로그인", listLogin);
		if (listLabels.size() > 0)
			listS.put("라벨", listLabels);

		return listS;
	}

}
