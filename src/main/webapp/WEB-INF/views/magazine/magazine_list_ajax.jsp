<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:forEach items="${alist }" var="bean">
<script src="js/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(function() {
	  $(".strong").each(function(){
		  var target = $(this).text();
	  		if(target==1){
	  			$(this).text("신상&트렌드");
	  		} else if(target==2){
	  			$(this).text("화장품 펙트체크");
	  		}else if(target==3){
	  			$(this).text("인기템 리뷰");
	  		}else if(target==4){
	  			$(this).text("다이어트&운동");
	  		}
	  });  
	});

</script>
<div class="contentsBox" class="span6 element category01" data-category="category01">
    <div class="hover_img">
        <a href="magazine/${bean.mag_no}"><img src="/reset/${bean.img}" alt="main_img"></a>
    </div> 
    <div class="item_description">
        <h6><a href="magazine/${bean.mag_no}">${bean.title}</a></h6>
        <div><strong class="strong">${bean.cate}</strong></div>
        <div>
        	<span class="pop">
        		<img src="imgs/icon/like.png" alt="좋아요" class="icon"/>&emsp;${bean.pop }
        	</span>
        	&emsp;&emsp;&emsp;&emsp;
        	<span class="view">
         	<img src="imgs/icon/view.png" alt="조회수" class="icon"/>&emsp;${bean.view }
        	</span>
        </div>
    </div>                                   
</div>
</c:forEach>
<div class="pagenum_container">
<!-- 페이징 시작 -->
		<!-- 페이징  -->
		<c:choose>
		<c:when test="${paging.numberOfRecords ne NULL and paging.numberOfRecords ne '' and paging.numberOfRecords ne 0}">
		<div class="text-center marg-top">
			<ul class="pagination">
				<c:if test="${paging.currentPageNo gt 5}">  											  <!-- 현재 페이지가 5보다 크다면(즉, 6페이지 이상이라면) -->
					<li><a href="javascript:goPage(${paging.prevPageNo}, ${paging.maxPost})">이전</a></li> <!-- 이전페이지 표시 -->
				</c:if>
				<!-- 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->
					<c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1"> <!-- 변수선언 (var="i"), 조건식, 증감식 -->
		            <c:choose>
		                <c:when test="${i eq paging.currentPageNo}"> 
		                      <li class="active"><a href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li> <!-- 1페이지부터 10개씩 뽑아내고, 1,2,3페이지순으로 나타내라-->
		                </c:when>
		                	<c:otherwise>
		                    <li><a href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- begin에 의해서 변수 i는 1이기 때문에, 처음에는 c:when이 수행된다. 그 후 페이징의 숫자 2를 클릭하면 ${i}는 2로변하고, 현재는 ${i}는 1이므로 otherwise를 수행한다
					         그래서 otherwise에 있는 함수를 수행하여 2페이지의 게시물이 나타나고, 반복문 실행으로 다시 forEach를 수행한다. 이제는 i도 2이고, currentPageNo도 2이기 때문에
					     active에 의해서 페이징부분의 2에 대해서만 파란색으로 나타난다. 그리고 나머지 1,3,4,5,이전,다음을 표시하기위해 다시 c:otherwise를 수행하여 페이징도 나타나게한다.-->
				<!-- // 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->
										
				<!-- 소수점 제거 =>-->
				<fmt:parseNumber var="currentPage" integerOnly="true" value="${(paging.currentPageNo-1)/5}"/>
				<fmt:parseNumber var="finalPage" integerOnly="true" value="${(paging.finalPageNo-1)/5}"/>
					
				<c:if test="${currentPage < finalPage}"> <!-- 현재 페이지가 마지막 페이지보다 작으면 '다음'을 표시한다. -->
					<li><a href="javascript:goPage(${paging.nextPageNo}, ${paging.maxPost})">다음</a></li>
				</c:if> 
			</ul>
		</div>
		</c:when>
		</c:choose>
		</div><!-- 페이징 끝 -->