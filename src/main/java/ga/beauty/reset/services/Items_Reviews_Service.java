package ga.beauty.reset.services;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import ga.beauty.reset.dao.Items_Dao;
import ga.beauty.reset.dao.Reviews_Dao;
import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.dao.entity.Ranks_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;

@Service
public class Items_Reviews_Service {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	Items_Dao<Items_Vo> Items_Dao;
	
	@Autowired
	Reviews_Dao<Reviews_Vo> Reviews_Dao;
	
	// 카테고리에 따른 랭킹 리스트페이지
	public void ranking_listPage(Model model,int type) throws SQLException {
		logger.debug("param: "+type);
		model.addAttribute("alist", Items_Dao.rankAll(type));
		model.addAttribute("cate", type);
	}
	
	// item 상세 페이지
	@Transactional
	public void item_detailPage(Model model,int item) throws SQLException{
		logger.debug("param: "+item);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//tag.start
		Items_Vo temp = Items_Dao.selectOne(item);
		logger.debug(temp.getTags());
		String tempStr="";
		tempStr=temp.getTags().toString();
		
		StringTokenizer tokens = new StringTokenizer( tempStr, "$" );
		List<String> list=new ArrayList<String>();
		while(tokens.hasMoreTokens()) {
			list.add(tokens.nextToken());
		}
		logger.debug(list.size());
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
		boolean result=false;
		for(int i=0;i<temp123.length;i++) {
			if(temp123[i]==0) {
				temp123[i]=0;
				result=true;
			}
		}
		if(result) {
			if(one!=0) {one=rank.getOne()*100/total;}
			if(two!=0) {two= rank.getTwo()*100/total;}
			if(three!=0) {three= rank.getThree()*100/total;}
			if(four!=0) {four= rank.getFour()*100/total;}
			if(five!=0) {five= rank.getFive()*100/total;}
			total=one+two+three+four+five;
		} else {
			total=rank.getOne()+rank.getTwo()+rank.getThree()+rank.getFour()+rank.getFive();
			one= rank.getOne()*100/total;
			two= rank.getTwo()*100/total;
			three= rank.getThree()*100/total;
			four= rank.getFour()*100/total;
			five= rank.getFive()*100/total;
		}
		logger.debug("avg: "+one+" "+two+" "+three+" "+four+" "+five);
		logger.debug("total: "+total);
		map.put("total", total);
		map.put("one", one);
		map.put("two", two);
		map.put("three", three);
		map.put("four", four);
		map.put("five", five);
		//tot end
		
		
		model.addAttribute("item_bean", Items_Dao.selectOne(item));
		model.addAttribute("tags", list);
		model.addAttribute("map", map);
		model.addAttribute("review_bean", Reviews_Dao.reviewAll(item));
		model.addAttribute("tot", Reviews_Dao.reviewTot(item));
	}
	
	// 리뷰 추가
	public int review_addPage(HttpServletResponse resp,Reviews_Vo bean) throws SQLException, IOException {
		return Reviews_Dao.reviewAdd(bean);
	}

	// 리뷰 상세페이지
	@Transactional
	public void review_detailPage(Model model, int item, int rev_no) throws SQLException {
		logger.debug("param: "+item+" "+rev_no);
		//tot start
		HashMap<String, Object> map = new HashMap<String, Object>();
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
		boolean result=false;
		for(int i=0;i<temp123.length;i++) {
			if(temp123[i]==0) {
				temp123[i]=0;
				result=true;
			}
		}
		if(result) {
			if(one!=0) {one=rank.getOne()*100/total;}
			if(two!=0) {two= rank.getTwo()*100/total;}
			if(three!=0) {three= rank.getThree()*100/total;}
			if(four!=0) {four= rank.getFour()*100/total;}
			if(five!=0) {five= rank.getFive()*100/total;}
			total=one+two+three+four+five;
		} else {
			total=rank.getOne()+rank.getTwo()+rank.getThree()+rank.getFour()+rank.getFive();
			one= rank.getOne()*100/total;
			two= rank.getTwo()*100/total;
			three= rank.getThree()*100/total;
			four= rank.getFour()*100/total;
			five= rank.getFive()*100/total;
		}
		logger.debug("avg: "+one+" "+two+" "+three+" "+four+" "+five);
		logger.debug("total: "+total);
		map.put("total", total);
		map.put("one", one);
		map.put("two", two);
		map.put("three", three);
		map.put("four", four);
		map.put("five", five);
		//tot end
		
		Reviews_Vo bean=Reviews_Dao.reviewOne(item,rev_no);
		logger.debug(bean);
		if(!bean.getImg().equals("")) {
			logger.debug("확인"+bean.getImg());
			String temp=bean.getImg();
			String[] temp2=temp.split("_s_");
			bean.setImg(temp2[0]+temp2[1]);
		}
		
		model.addAttribute("item_bean", Items_Dao.selectOne(item));
		model.addAttribute("map", map);
		model.addAttribute("review_bean", bean);
	}
	
	// 리뷰 수정페이지
	public int review_updatePage(int option,Reviews_Vo bean) throws SQLException, IOException {
		logger.debug("updatePage param: "+option+" "+bean);
		
		if(option==1) {
			logger.debug("확인"+bean.getImg());
			StringBuffer sb=new StringBuffer(bean.getImg());
			sb.insert(28,"_s_");
			String temp=sb.toString();
			bean.setImg(temp);
		}

		return Reviews_Dao.reviewUpdate(bean);
	}
	
	// 리뷰 삭제페이지
	public int review_deletePage(String filePath,Reviews_Vo bean) throws SQLException, IOException {
		logger.debug("deletePage param: "+bean);
		return Reviews_Dao.reviewDelete(filePath,bean);
	}
}

