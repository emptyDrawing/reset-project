package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Items_Vo;

@Repository
public class Items_DaoImp implements Items_Dao<Items_Vo> {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Items_Vo> itemAll() throws SQLException {
		return sqlSession.selectList("items.itemAll");
	}
	
	@Override
	public List<Items_Vo> rankAll(int cate) throws SQLException {
		// type { 1: 스킨 ,2: 로션 ,3: 에센스 }
		logger.debug("DaoImp-rankAll-param: "+cate);
		return sqlSession.selectList("items.rankAll",cate);
	}
	
	@Override
	public List<Items_Vo> rankListAdd(int cate) throws SQLException {
		// type { 1: 스킨 ,2: 로션 ,3: 에센스 }
		logger.debug("DaoImp-rankAdd-param: "+cate);
		return sqlSession.selectList("items.rankListAdd", cate);
	} 
	
	@Override
	public Items_Vo selectOne(int item) throws SQLException {
		logger.debug("DaoImp-selectOne-param: "+item);
		return sqlSession.selectOne("items.selectOne", item);
	}

	@Override
	public List<Items_Vo> itemSearch(String condition,String type) throws SQLException {
		logger.debug("DaoImp-itemSearch-param: "+condition+"/"+type);
		if(type.equals("brand")) {
			logger.debug("브랜드 검색");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("brand", condition);
			return sqlSession.selectList("items.itemBrand", map);
		}else if(type.equals("name")) {
			logger.debug("이름 검색");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("name", condition);
			return sqlSession.selectList("items.itemName", map);
		}else {
			return null;
		}
	}
	
	@Override
	public int itemAdd(Items_Vo bean) throws SQLException {
		logger.debug("DaoImp-itemAdd:"+bean);
		return sqlSession.insert("items.itemAdd", bean);
	}
	
	@Override
	public int rankAdd(Items_Vo bean) throws SQLException {
		return sqlSession.insert("items.rankAdd", bean);
	}


	@Override
	public int itemUpdate(Items_Vo bean) throws SQLException {
		return sqlSession.update("items.itemUpdate",bean);
	}
	
	@Override
	public int itemDelete(int item) throws SQLException {
		logger.debug("DaoImp-itemDel: "+item);
		return sqlSession.delete("items.itemDel",item);
	}
	
	// XXX:[kss] 추가 전체카운트용
	public int getCount() {
		return sqlSession.selectOne("items.itemCont");
	}

}
