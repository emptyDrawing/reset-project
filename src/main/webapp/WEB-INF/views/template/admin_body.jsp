<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${login_user_type eq 'CEO' }">
	<%@ include file ="./admin_body_admin.jsp"%>
</c:if>
<c:if test="${login_user_type eq '직원' }">
	<%@ include file ="./admin_body_admin.jsp"%>
</c:if>
<c:if test="${login_user_type eq '광고주'}">
	<%@ include file ="./admin_body_adv.jsp"%>
</c:if>
<c:if test="${login_user_type eq '일반' || login_user_type eq null}">
	<%@ include file ="../error/error.jsp" %>
</c:if>
