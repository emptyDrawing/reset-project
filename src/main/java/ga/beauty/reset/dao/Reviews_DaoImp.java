package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.dao.entity.Ranks_Vo;
import ga.beauty.reset.dao.entity.Reviews_Vo;
import ga.beauty.reset.utils.LogEnum;

@Repository
public class Reviews_DaoImp implements Reviews_Dao<Reviews_Vo> {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Ranks_Vo totAll(int item) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-totAll-param: "+item);
		return sqlSession.selectOne("items.totAll", item);
	}

	@Override
	public List<Reviews_Vo> reviewToTAll() throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-reviewToTAll-noParam");
		return sqlSession.selectList("reviews.reviewToTAll");
	}

	public List<Reviews_Vo> reviewToTAll(String where) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-reviewToTAll-noParam");
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("where", where);
		return sqlSession.selectList("reviews.reviewToTAll", params);
	}
	
	@Override
	public List<Reviews_Vo> reviewAll(int item) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-reviewAll-param: "+item);
		return sqlSession.selectList("reviews.reviewAll", item);
	}
	
	//TODO:[sch] 3.크롤링 dao 부분
	@Override
	public List<Reviews_Vo> reviewListAdd(int item,int review_num) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-reviewAdd-param: "+item+" "+review_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("item", item);
		map.put("review_num", review_num);
		return sqlSession.selectList("reviews.reviewListAdd", map);
	}

	@Override
	public int reviewAdd(Reviews_Vo bean) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp-reviewAdd:"+bean);
		int result=sqlSession.insert("reviews.reviewAdd", bean);
		if(result==1){rankUpdate(bean);}
		return result;
	}

	@Override
	public Reviews_Vo reviewOne(int item,int rev_no) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+item+" "+rev_no);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("item", item);
		map.put("rev_no", rev_no);
		return sqlSession.selectOne("reviews.reviewOne", map);
	}
	
	@Override
	public int reviewUpdate(Reviews_Vo bean) throws SQLException {
		int result=sqlSession.update("reviews.reviewUpdate",bean);
		if(result==1){rankUpdate(bean);}
		return result;
	}
	

	@Override
	public int reviewDelete(String filePath,Reviews_Vo bean) throws SQLException {
		
		bean=sqlSession.selectOne("reviews.reviewOne", bean);
		//open=0으로 인한 생략
//		filePath=filePath.replaceFirst("imgs/upload_imgs", "");
//		if(!bean.getImg().equals("")) {
//			log.debug(filePath+bean.getImg());
//			String temp=filePath+bean.getImg();
//			log.debug(temp);
//			temp.replace("/", "\\");
//			log.debug(temp);
//			File file1 = new File(temp);
//			file1.delete();
//			
//			String[] temp2=temp.split("s_");
//			temp=temp2[0]+temp2[1];
//			log.debug(temp);
//			File file2 = new File(temp);
//			file2.delete();
//		}
		int result=sqlSession.delete("reviews.reviewDelete", bean);
		if(result==1){rankUpdate(bean);}
		return result;
	}

	@Override
	public int cartAdd(int item, String email) throws SQLException {
		logger.debug(LogEnum.DEBUG+"DaoImp param: "+item+" "+email);
		
		Members_Vo member=sqlSession.selectOne("items.cartAll", email);
		logger.debug(LogEnum.DEBUG+member.getCart());
		String cart=member.getCart();
		
		String temp=";"+item;
		logger.debug(LogEnum.DEBUG+cart.contains(temp));
		
		if(!cart.contains(temp)) {
		cart+=";"+item;
		logger.debug(LogEnum.DEBUG+"변경"+cart);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cart", cart);
		map.put("email", email);
		
		return sqlSession.insert("items.cartAdd",map);
		} else {
			return 3;
		}
		
	}

	@Override
	public int reviewTot(int item) throws SQLException {
		return sqlSession.selectOne("reviews.reviewTot", item);
	}

	// XXX:[kss] 추가 전체카운트용
	public int getCount() {
		return sqlSession.selectOne("reviewCountTotAll");
	}
	public int getCount(String where) {
		HashMap<String, Object> params =new HashMap<String, Object>();
		params.put("where", where);
		return sqlSession.selectOne("reviewCountTotAll", params);
	}

	@Override
	public List<Reviews_Vo> mypage_review(String nick) throws SQLException {
		return sqlSession.selectList("reviews.mypage_review", nick);
	}
	
	private void rankUpdate(Reviews_Vo bean) {
		logger.debug(LogEnum.DEBUG+"check"+bean);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int one=0;
		int two=0;
		int three=0;
		int four=0;
		int five=0;
		map.put("item", bean.getItem());
		map.put("star", 1);
		one=sqlSession.selectOne("reviews.rankUpdate",map);
		map.put("star", 2);
		two=sqlSession.selectOne("reviews.rankUpdate",map);
		map.put("star", 3);
		three=sqlSession.selectOne("reviews.rankUpdate",map);
		map.put("star", 4);
		four=sqlSession.selectOne("reviews.rankUpdate",map);
		map.put("star", 5);
		five=sqlSession.selectOne("reviews.rankUpdate",map);
		Ranks_Vo rank=new Ranks_Vo();
		rank.setItem(bean.getItem());
		rank.setOne(one);
		rank.setTwo(two);
		rank.setThree(three);
		rank.setFour(four);
		rank.setFive(five);
		sqlSession.update("ranks.rankUpdate",rank);
	}
}
