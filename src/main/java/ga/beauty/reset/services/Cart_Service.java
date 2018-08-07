package ga.beauty.reset.services;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ga.beauty.reset.dao.Cart_DaoImp;
import ga.beauty.reset.dao.entity.Items_Vo;
import ga.beauty.reset.dao.entity.Members_Vo;
import ga.beauty.reset.utils.LogEnum;

@Service
public class Cart_Service {
	Logger logger=Logger.getLogger(getClass());
	
	@Autowired
	Cart_DaoImp Cart_Dao;
	
	// 찜 확인
	public int Cart_check(int item,String email) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+item+"/"+email);
		Members_Vo member=new Members_Vo();
		member=Cart_Dao.cartList(email);
		String cart=member.getCart();
		if(cart.contains(";"+item)) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// 찜목록 조회
	public 	List<Items_Vo> Cart_List(String email) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+email);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Items_Vo> list=new ArrayList<Items_Vo>();
		Members_Vo member=new Members_Vo();
		member=Cart_Dao.cartList(email);
		logger.debug(LogEnum.DEBUG+"확인"+member.getCart());
		String[] temp=null;
		temp=member.getCart().split(";");
		logger.debug(LogEnum.DEBUG+temp);
		if(!temp.equals(null)) {
		for(int j=0;j<temp.length;j++) {
			logger.debug(LogEnum.DEBUG+temp[j]);
		}
		for(int i=1;i<temp.length;i++) {
			list.add(Cart_Dao.selectOne(Integer.parseInt(temp[i])));
		}
		}
		return list;
	}
	
	// 찜목록에 추가
	public int Cart_Add(int item,String email) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+item+"/"+email);
		
		Members_Vo member=new Members_Vo();
		member=Cart_Dao.cartList(email);
		
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
		logger.info(LogEnum.CART+"계정["+email+"]이  상품 [No"+item+"]을 찜했습니다.");

		return Cart_Dao.cartUpdate(map);
		}
		return 0;
		
	}
	
	// 찜목록에서 제거
	public int Cart_Del(int item,String email) throws SQLException {
		logger.debug(LogEnum.DEBUG+"param: "+item+"/"+email);
		
		Members_Vo member=new Members_Vo();
		member=Cart_Dao.cartList(email);
		
		logger.debug(LogEnum.DEBUG+member.getCart());
		String cart=member.getCart();
		
		String temp=";"+item;
		logger.debug(LogEnum.DEBUG+cart.contains(temp));
		
		if(cart.contains(temp)) {
		String[] temp2=cart.split(temp);
		cart="";
		for(int i=0;i<temp2.length;i++) {
			if(temp2[i].equals(temp)){
				temp2[i]="";
			}
			cart+=temp2[i];
		}
		logger.debug(LogEnum.DEBUG+"cart: "+cart);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cart", cart);
		map.put("email", email);
		logger.info(LogEnum.CART+"계정["+email+"]이  상품 [No"+item+"]을 찜취소 했습니다.");
		return Cart_Dao.cartUpdate(map);
		} else {
			return 0;
		}
	}
}

