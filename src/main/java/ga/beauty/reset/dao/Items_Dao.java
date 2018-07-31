package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;
import ga.beauty.reset.dao.entity.Items_Vo;

public interface Items_Dao<C> {
	
	//item search 페이지에서만 사용
	List<C> itemAll() throws SQLException;
	//ranking 페이지에서만 사용
	List<C> rankAll(int type) throws SQLException;
	//rank 추가
	List<Items_Vo> rankListAdd(int cate) throws SQLException;
	//ranking 상세페이지
	C selectOne(int c) throws SQLException;
	//item 검색
	List<C> itemSearch(String c,String v) throws SQLException;
	//item 추가
	int itemAdd(C bean) throws SQLException;
	int rankAdd(C bean) throws SQLException;
	//item 수정
	int itemUpdate(C bean) throws SQLException;
	//item 삭제
	int itemDelete(int item) throws SQLException;
}
