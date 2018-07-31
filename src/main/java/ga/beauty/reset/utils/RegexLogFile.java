package ga.beauty.reset.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import ga.beauty.reset.dao.entity.stat.Log_File;

public class RegexLogFile {
	
//	public final String regex ="^\\[(.*)\\]\\[(.*)\\]-@(.*)@(.*)";
	public final String regex ="^\\[(.*)\\]\\[(.*)\\]-@(.*)@-(.*)";
  	
	private Log_File getLogForString(String target){
		Log_File bean = new Log_File();
  		Pattern p = Pattern.compile(regex);
  		Matcher m = p.matcher(target);
  	    if (m.find())
  	    {
  	    	String[] tmp = new String[m.groupCount()];
  	        for (int i = 0; i < m.groupCount(); i++)
  	        {
  	        	tmp[i]= m.group(i+1);
  	        }
  	        bean.setNalja(tmp[0]);
  	        bean.setLogCate(tmp[1]);
  	        bean.setCate(tmp[2]);
  	        bean.setMsg(tmp[3]);
  	    }
  		return  bean;
 	}
  	
  	public List<Log_File> getListFromLog(String filename) throws IOException, InterruptedException{
  		return getListFromLog(filename,1,10);
  	} 
  	public List<Log_File> getListFromLog(String filename, int start) throws IOException, InterruptedException{
  		return getListFromLog(filename,start,10);
  	} 
  	public List<Log_File> getListFromLog(String filename, int start ,int cnt) throws IOException, InterruptedException{
  		ArrayList<Log_File> list = new ArrayList<Log_File>();  		
  		int result = getFile(filename, start,cnt, list);
  		if(result==0) return null;
  		else return list;
  	} 
  	
	private int getFile(String filename, int start,int cnt, ArrayList<Log_File> list) throws IOException, InterruptedException {
		File tmp = new File(filename);
		if(!tmp.exists()) {
			return 0;
		}
		int tmpCnt = start;
		try(BufferedReader in = new BufferedReader 
				(new InputStreamReader 
						(new ReverseLineInputStream(new File(filename))
								))){// try-resource
			
			int lineCnt = 1;
			while(true) {
				if(lineCnt<start+cnt) {
					String line = in.readLine();
					if (line == null) {
						break;
					}else if(line.equals( System.getProperty( "line.separator" )) || line.equals("\r") || line.equals("\n") ){	
					}else {
						if(tmpCnt==lineCnt) {
							list.add(getLogForString(line));
							tmpCnt++;
						}
					}
					lineCnt++;
				}else {
					break;
				}
			}
		}
		return tmpCnt;
	}
}//
