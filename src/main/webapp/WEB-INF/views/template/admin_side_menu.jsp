<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${login_user_type eq 'CEO' }">
	<%@ include file ="./admin_side_menu_admin.jsp"%>
</c:if>
<c:if test="${login_user_type eq '직원' }">
	<%@ include file ="./admin_side_menu_admin.jsp"%>
</c:if>
<c:if test="${login_user_type eq '광고주'}">
	<%@ include file ="./admin_side_menu_adv.jsp"%>
</c:if>
