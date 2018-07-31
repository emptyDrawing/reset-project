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

@Repository
public class Reviews_DaoImp implements Reviews_Dao<Reviews_Vo> {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Ranks_Vo totAll(int item) throws SQLException {
		logger.debug("DaoImp-totAll-param: "+item);
		return sqlSession.selectOne("items.totAll", item);
	}

	@Override
	public List<Reviews_Vo> reviewToTAll() throws SQLException {
		logger.debug("DaoImp-reviewToTAll-noParam");
		return sqlSession.selectList("reviews.reviewToTAll");
	}
	
	@Override
	public List<Reviews_Vo> reviewAll(int item) throws SQLException {
		logger.debug("DaoImp-reviewAll-param: "+item);
		return sqlSession.selectList("reviews.reviewAll", item);
	}
	
	//TODO:[sch] 3.크롤링 dao 부분
	@Override
	public List<Reviews_Vo> reviewListAdd(int item,int review_num) throws SQLException {
		logger.debug("DaoImp-reviewAdd-param: "+item+" "+review_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("item", item);
		map.put("review_num", review_num);
		return sqlSession.selectList("reviews.reviewListAdd", map);
	}

	@Override
	public int reviewAdd(Reviews_Vo bean) throws SQLException {
		logger.debug("DaoImp-reviewAdd:"+bean);
		return sqlSession.insert("reviews.reviewAdd", bean);
	}

	@Override
	public Reviews_Vo reviewOne(int item,int rev_no) throws SQLException {
		logger.debug("param: "+item+" "+rev_no);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("item", item);
		map.put("rev_no", rev_no);
		return sqlSession.selectOne("reviews.reviewOne", map);
	}
	
	@Override
	public int reviewUpdate(Reviews_Vo bean) throws SQLException {
		return sqlSession.update("reviews.reviewUpdate",bean);
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
		return sqlSession.delete("reviews.reviewDelete", bean);
	}

	@Override
	public int cartAdd(int item, String email) throws SQLException {
		logger.debug("DaoImp param: "+item+" "+email);
		
		Members_Vo member=sqlSession.selectOne("items.cartAll", email);
		logger.debug(member.getCart());
		String cart=member.getCart();
		
		String temp=";"+item;
		logger.debug(cart.contains(temp));
		
		if(!cart.contains(temp)) {
		cart+=";"+item;
		logger.debug("변경"+cart);
		
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
		return sqlSession.selectOne("reviewTotAll");
	}

	@Override
	public List<Reviews_Vo> mypage_review(String nick) throws SQLException {
		return sqlSession.selectList("reviews.mypage_review", nick);
	}
}
