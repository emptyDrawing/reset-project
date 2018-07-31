package ga.beauty.reset.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import ga.beauty.reset.dao.entity.Comment_Vo;
import ga.beauty.reset.services.Comment_Service;

@RestController
public class Comment_Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	Comment_Service service;
	
	String convert_err = "co_type error";
	
	private String convert_Type(String co_type) {
		// co_type를 영어에서 한글로 바꾸는 메소드 입니다.
		if(co_type.equals("event")){
			return co_type="이벤트";
		}else if(co_type.equals("magazine")) {
			return co_type="매거진";
		}else if(co_type.equals("review")) {
			return co_type="리뷰";
		}else {
			return convert_err;
		}
	}

	/*//댓글의 갯수를 확인하는 컨트롤러
	@RequestMapping(value="/{co_type}/{p_no}/comment", method=RequestMethod.GET)
	public ResponseEntity<Integer> count(@PathVariable("co_type") String co_type
			,@PathVariable("p_no") int p_no){
		ResponseEntity<Integer> entity=null;
		Comment_Vo bean = new Comment_Vo();
		bean.setCo_type(co_type);
		bean.setP_no(p_no);
		try {
			entity = new ResponseEntity<>(service.countComment(bean),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}*/
	
	//TODO: 댓글의 목록을 보여줍니다. / / 김형준
	//댓글의 목록을 보여주는 컨트롤러
	@RequestMapping(value="/{co_type}/{p_no}/comment", method=RequestMethod.GET)
	public ResponseEntity<List<Comment_Vo>> list(@PathVariable("co_type") String co_type
			,@PathVariable("p_no") int p_no){
		ResponseEntity<List<Comment_Vo>> entity=null;
		String result= convert_Type(co_type);
		Comment_Vo bean = new Comment_Vo();
		bean.setCo_type(result);
		bean.setP_no(p_no);
		try {
			entity = new ResponseEntity<>(service.listComment(bean),HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity=new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		return entity;
	}
	
	//TODO: 댓글의 입력합니다. / / 김형준
	//댓글을 입력하는 컨트롤러
	@RequestMapping(value="/{co_type}/{p_no}/comment/add", method=RequestMethod.POST)
	public ResponseEntity<String> register(@PathVariable("co_type") String co_type, @RequestBody Comment_Vo bean){
		ResponseEntity<String> entity=null;
		
		try {
			String result = convert_Type(co_type);
			bean.setCo_type(result);
			service.addComment(bean);
			entity=new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity=new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//TODO: 댓글의 수정합니다. / / 김형준
	//댓글을 수정하는 컨트롤러
	@RequestMapping(value="/{co_type}/{p_no}/comment/{co_no}",method= {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("co_type") String co_type
			,@PathVariable("p_no") int p_no
			,@PathVariable("co_no") int co_no
			,@RequestBody Comment_Vo bean){
		ResponseEntity<String> entity = null;
		String result= convert_Type(co_type);
		try {
			bean.setCo_type(result);
			bean.setP_no(p_no);
			bean.setCo_no(co_no);
			service.modifyComment(bean);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity =new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//TODO: 댓글의 삭제합니다. / / 김형준
	//댓글을 삭제하는 컨트롤러
	@RequestMapping(value="/{co_type}/{p_no}/comment/{co_no}", method=RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("co_type") String co_type
			,@PathVariable("p_no") int p_no
			,@PathVariable("co_no") int co_no
			){
		ResponseEntity<String> entity =null;
		String result= convert_Type(co_type);
		try {
			Comment_Vo bean = new Comment_Vo();
			bean.setCo_type(result);
			bean.setP_no(p_no);
			bean.setCo_no(co_no);
			service.removeComment(bean);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
}//class-end

