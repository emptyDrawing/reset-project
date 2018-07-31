package ga.beauty.reset.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;

import ga.beauty.reset.dao.entity.Qna_Vo;


public class Qna_Daotest {

	Qna_Dao<Qna_Vo> qna_Dao;
	
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {

	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		Resource resource = new ClassPathResource("applicationContext.xml");
		XmlBeanFactory factory = new XmlBeanFactory(resource);
		qna_Dao = (Qna_Dao) factory.getBean("Qna_Dao");	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testSelectAll() throws SQLException {
		
		List<Qna_Vo> list = qna_Dao.selectAll();
		assertNotNull(list);
		assertTrue(list.size()>0);
		System.out.println(list.toString());
	}
		
		

}
