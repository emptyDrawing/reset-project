package ga.beauty.reset.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ga.beauty.reset.dao.entity.Qna_Vo;

@Repository
public class Qna_DaoImpl implements Qna_Dao<Qna_Vo> {
	
	@Autowired
	SqlSession sqlSession;

	
	public Qna_DaoImpl() {
	
	}
	
	
	@Override
	public List<Qna_Vo> selectAll() throws SQLException {
		System.out.println(sqlSession);
		return sqlSession.selectList("qna_mapper.selectAll");
	}

	@Override
	public void insertOne(Qna_Vo bean) throws SQLException {
		sqlSession.insert("qna_mapper.insertOne", bean);
	}

	@Override
	public void insertTwo(Qna_Vo bean) throws SQLException {
		sqlSession.insert("qna_mapper.insertTwo", bean);
	}

	@Override
	public Qna_Vo selectOne(int qa_no) throws SQLException {
		return sqlSession.selectOne("qna_mapper.selectOne", qa_no);
	}

	@Override
	public int updateOne(Qna_Vo bean) throws SQLException {
		return sqlSession.update("qna_mapper.updateOne", bean);
	}

	@Override
	public int deleteOne(int qa_no) throws SQLException {
		return sqlSession.delete("qna_mapper.deleteOne", qa_no);
	}



	
	

}
