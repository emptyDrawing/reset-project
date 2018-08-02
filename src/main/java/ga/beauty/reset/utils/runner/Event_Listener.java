package ga.beauty.reset.utils.runner;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
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

import ga.beauty.reset.dao.entity.Event_Vo;
import ga.beauty.reset.dao.entity.stat.Log_EM_Vo;
import ga.beauty.reset.utils.LogEnum;
import ga.beauty.reset.utils.MySDF;

@Component("event_Listener")
public class Event_Listener implements Common_Listener{

	Logger logger = Logger.getLogger(Event_Listener.class);
	
	// event/yyyy/MM/dd.json
	//{"data":[{"no":eveno,"like":,"view":,"num":},....]}
	private String defaultFP = "/reset/report/event/";

	// 좋아요 총량-은 기록안함 		/ 일별 증가량 // DONE
	// 조회수 총량-은 기록안함 		/ 일별 증가량 // DONE
	// 신청자수 총량-은 기록안함 	/ 일별 증가량 // DONE
	private List<Log_EM_Vo> list;
	private ObjectMapper objectMapper;
	private JsonNode node;
	
	public Event_Listener() {
		try {
			init();
			logger.info(LogEnum.INIT+"("+getClass()+") 생성완료");
		} catch (Exception e) {
			String msg = e.getMessage();
			msg=msg.replace("\n", " ").replace("\r", "");
			logger.error(LogEnum.ERROR+msg);
		}
	}
	
	private void init()  throws JsonProcessingException, IOException {
		list = new ArrayList<Log_EM_Vo>();
		objectMapper = new ObjectMapper();
		Date date = new Date();
		String filename =  
				defaultFP + MySDF.SDF_Y.format(date)
				+"/"+MySDF.SDF_M.format(date)
				+"/"+MySDF.SDF_D.format(date)
				+".json";
		File file = new File(filename);
		if(!file.exists()) {
			new File(file.getParent()).mkdirs();
		}else {
			node = objectMapper.readTree(file);
			list = objectMapper.convertValue(node.findValue("data"), new TypeReference<List<Log_EM_Vo>>(){});
		}
	};
	
	@Async("threadPoolTaskExecutor")
	@Override
	public <T> Future<String> addLog(T bean, String type, int chNum ) throws Exception {
		if(bean instanceof Event_Vo) {
			Event_Vo target = (Event_Vo)bean;
			changeValue(target,type,chNum);
		}
        return new AsyncResult<String>("Success");
	}
	
	private void changeValue(Event_Vo target, String type,int chNum) {
		int checkNo = target.getEve_no();
		Log_EM_Vo checkVo = new Log_EM_Vo(checkNo,0,0,0);
		synchronized(this){
			// 기존에 있는건지 확인
			int maybeIdx = list.indexOf(checkVo);
			if(maybeIdx>=0) checkVo = list.get(maybeIdx);
			else list.add(checkVo);
			// 어떤거 값 변화 
			if(type.equals("like")) {
				logger.info(LogEnum.EVE+"[No."+checkNo+"] 이벤트의 좋아요가 ["+chNum+"] 만큼 변했습니다.");
				checkVo.setLike(checkVo.getLike()+chNum);
			}else if(type.equals("view")) {
				logger.info(LogEnum.EVE+"[No."+checkNo+"] 이벤트의 조회수가 ["+chNum+"] 만큼 변했습니다.");
				checkVo.setView(checkVo.getView()+chNum);
			}else if(type.equals("num")) {
				logger.info(LogEnum.EVE+"[No."+checkNo+"] 이벤트의 참여자수가 ["+chNum+"] 만큼 변했습니다.");
				checkVo.setNum(checkVo.getNum()+chNum);
			}
			logger.debug("값변화체크:"+checkVo);
		}
	}//changeValue()
	

	@Override
	public List getList() throws Exception {
		return list;
	}

	@Override
	@Async("threadPoolTaskExecutor")
	@Scheduled(cron=" 0 5 0 * * *\r\n" )
	public void saveLogOneday() throws Exception {
		synchronized (this) {
			Calendar cal = new GregorianCalendar();
			cal.add(Calendar.DATE, -1);
			Date date = cal.getTime();
			String filename =  
					defaultFP + MySDF.SDF_Y.format(date)
					+"/"+MySDF.SDF_M.format(date)
					+"/"+MySDF.SDF_D.format(date)
					+".json";
			File file = new File(filename);
			if(!file.exists()) {
				new File(file.getParent()).mkdirs();
			}
			StringBuilder sbr = createJsonString();
			try(BufferedWriter buffOut =  new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, true), StandardCharsets.UTF_8))){
				buffOut.write(sbr.toString());
				buffOut.flush();
				logger.info(LogEnum.SAVA_LOG+" ["+MySDF.SDF_ALL.format(date)+"]일의 이벤트로그가 저장되었습니다.");
				buffOut.close();
			}
			init();
		}
	}//

	@Override
	@PreDestroy
	public void saveTmp() throws Exception {
		if(list.size()==0) {return ;}
		synchronized (this) {
			Date date = new Date();
			String filename =  
					defaultFP + MySDF.SDF_Y.format(date)
					+"/"+MySDF.SDF_M.format(date)
					+"/"+MySDF.SDF_D.format(date)
					+".json";
			File file = new File(filename);
			if(!file.exists()) {
				new File(file.getParent()).mkdirs();
			}
			StringBuilder sbr = createJsonString();
			try(BufferedWriter buffOut =  new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, true), StandardCharsets.UTF_8))){
				buffOut.write(sbr.toString());
				buffOut.flush();
				logger.warn(LogEnum.SAVA_LOG+" ["+MySDF.SDF_ALL.format(date)+"]일의 이벤트 로그가 임시저장 되었습니다.");
				buffOut.close();
			}
		}
	}
	
	@Override
	protected void finalize() throws Throwable {
		saveTmp();
	}// finalize()
	
	private StringBuilder createJsonString(){
		StringBuilder sbr = new StringBuilder("{\"data\":[");
		Collections.sort(list, new Comparator<Log_EM_Vo>() {
			@Override
			public int compare(Log_EM_Vo o1, Log_EM_Vo o2) {
				if(o1.getNo()>o2.getNo()) return 1;
				else if (o1.getNo()<o2.getNo()) return -1;
				return 0;
			}
		});
		Iterator<Log_EM_Vo> ite = list.iterator();
		int i=0;
		while(ite.hasNext()) {
			if(i!=0)sbr.append(",");
			sbr.append(ite.next());
			i++;
		}
		sbr.append("]}");
		return sbr;
	}// createJsonString()
 	
	
}//
