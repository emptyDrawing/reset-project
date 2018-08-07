package ga.beauty.reset.services;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Items_Dao;
import ga.beauty.reset.dao.Reviews_Dao;
import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.dao.entity.Ranks_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;
import ga.beauty.reset.utils.CrudEnum;
import ga.beauty.reset.utils.LogEnum;

@Service
public class Items_Service {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	Items_Dao<Items_Vo> Items_Dao;
	
	@Autowired
	Reviews_Dao<Reviews_Vo> Reviews_Dao;

	// 아이템 검색
	public 	List<Items_Vo> item_search(String condition, String type) throws SQLException {
		logger.debug(LogEnum.DEBUG+"items_servic param: "+condition+"/"+type);
		return Items_Dao.itemSearch(condition,type);
	}
	
	// 아이템 상세
	public void item_detailPage(Model model, int item, HttpServletRequest req) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+item);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//tag.start
		Items_Vo bean = Items_Dao.selectOne(item);
		logger.debug(LogEnum.DEBUG+bean.getTags());
		String tempStr="";
		tempStr=bean.getTags().toString();
		
		StringTokenizer tokens = new StringTokenizer( tempStr, "$" );
		List<String> list=new ArrayList<String>();
		while(tokens.hasMoreTokens()) {
			list.add(tokens.nextToken());
		}
		logger.debug(LogEnum.DEBUG+list.size());
		//tag.end
		
		//tot start
		Ranks_Vo rank=Reviews_Dao.totAll(item);
		int[] temp123 = new int[5];
		temp123[0]=rank.getOne();
		temp123[1]=rank.getTwo();
		temp123[2]=rank.getThree();
		temp123[3]=rank.getFour();
		temp123[4]=rank.getFive();
		
		int total = 0;
		int one = 0;
		int two=0;
		int three=0;
		int four=0;
		int five=0;
		double avg=0;
		boolean result=false;
		for(int i=0;i<temp123.length;i++) {
			if(temp123[i]==0) {
				result=true;
			}else {
				if(i==0) {
					one=temp123[i];
				}else if(i==1) {
					two=temp123[i];
				}else if(i==2) {
					three=temp123[i];
				}else if(i==3) {
					four=temp123[i];
				}else if(i==4) {
					five=temp123[i];
				}
			}
		}
		if(result) {
			total=one+two+three+four+five;
			if(one!=0) {one=rank.getOne()*100/total;}
			if(two!=0) {two= rank.getTwo()*100/total;}
			if(three!=0) {three= rank.getThree()*100/total;}
			if(four!=0) {four= rank.getFour()*100/total;}
			if(five!=0) {five= rank.getFive()*100/total;}
		} else {
			total=rank.getOne()+rank.getTwo()+rank.getThree()+rank.getFour()+rank.getFive();
			one= rank.getOne()*100/total;
			two= rank.getTwo()*100/total;
			three= rank.getThree()*100/total;
			four= rank.getFour()*100/total;
			five= rank.getFive()*100/total;
		}
		logger.debug(LogEnum.DEBUG+"avg: "+one+" "+two+" "+three+" "+four+" "+five);
		logger.debug(LogEnum.DEBUG+"total: "+total);
		map.put("total", total);
		map.put("one", one);
		map.put("two", two);
		map.put("three", three);
		map.put("four", four);
		map.put("five", five);
		//tot end
		
		logger.debug(LogEnum.DEBUG+bean);
		if(!bean.getImg().equals("")) {
			logger.debug(LogEnum.DEBUG+"확인"+bean.getImg());
			String temp=bean.getImg();
			logger.debug(LogEnum.DEBUG+temp);
			if(temp.contains("_s_")) {
				String[] temp2=temp.split("_s_");
				bean.setImg(temp2[0]+temp2[1]);
			}else {
				bean.setImg(temp);
			}
		}
		
		
		model.addAttribute("item_bean", bean);
		model.addAttribute("tags", list);
		model.addAttribute("map", map);
		
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DETAIL + " {ip:"+ip+"}가 상품["+item+"]을 조회 하였습니다.");
		
		
	}
	
	// 아이템 추가
		public int item_add(Items_Vo bean, HttpServletRequest req) throws SQLException, IOException {
			
			if(Items_Dao.itemAdd(bean)==1) {
				HttpSession session = req.getSession();
				String ip = req.getHeader("X-FORWARDED-FOR");
				if (ip == null) ip = req.getRemoteAddr();
				
				logger.info(CrudEnum.ADD + " {ip:"+ip+"}가 상품["+bean.getName()+"]을 추가 하였습니다.");
				return Items_Dao.rankAdd(bean);
			}else {
				return 0;
			}
		}
	
	// 아이템 수정
	public int item_update(int option,Items_Vo bean, HttpServletRequest req) throws SQLException, IOException {
		logger.debug(LogEnum.DEBUG+"updatePage param: "+option+" "+bean);
		if(option==1) {
			logger.debug(LogEnum.DEBUG+"확인"+bean.getImg());
			StringBuffer sb=new StringBuffer(bean.getImg());
			sb.insert(26,"_s_");
			logger.debug(LogEnum.DEBUG+"재확인: "+sb);
			String temp=sb.toString();
			bean.setImg(temp);
			HttpSession session = req.getSession();
			String ip = req.getHeader("X-FORWARDED-FOR");
			if (ip == null) ip = req.getRemoteAddr();
			
			logger.info(CrudEnum.UPDATE + " {ip:"+ip+"}가 상품["+bean.getName()+"]을 수정 하였습니다.");
		}
		return Items_Dao.itemUpdate(bean);
	}
		
	// 아이템 삭제
	public int item_delete(int item, HttpServletRequest req) throws SQLException, IOException {
		logger.debug(LogEnum.DEBUG+"deletePage param: "+item);
		HttpSession session = req.getSession();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = req.getRemoteAddr();
		
		logger.info(CrudEnum.DELETE + " {ip:"+ip+"}가 상품[No."+item+"]을 삭제 하였습니다.");
		return Items_Dao.itemDelete(item);
	}
}

