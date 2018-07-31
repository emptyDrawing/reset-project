<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery-1.12.4.js"></script>

</head>
<body>
	<div id="modDiv" style="display : none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="commenttext">
		</div>
		<div>
			<button type="button" id="commentModBtn">수정</button>
			<button type="button" id="commentDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>
	
	<h2>ajax test page</h2>
	
	<div>
		WRITER <input type="text" name="writer" id="writer">
	</div>
	<div>
		content <input type="text" name="content" id="content">
	</div>
	<div>
		email <input type="text" name="email" id="email">
	</div>
	<div>
		co_type <input type="text" name="co_type" id="co_type">
	</div>
	<div>
		p_no <input type="text" name="p_no" id="p_no">
	</div>
	<button id="addBtn">입력</button>
	<ul id="comment">
	</ul>
	<ul id="pagination">
	</ul>
<script type="text/javascript">
	
		var p_no=1;
		
		getPageList(1);
		
	function getAllList(){
		$.getJSON("comment/all/"+p_no,function(data){
			var str="";
			console.log(data.length);
			
		$(data).each(
			function(){
			str+="<li data-co_no='"+this.co_no+"' class='commentLi'>"
			   +this.co_no+":"+this.content
			   +"<button>MOD</button></li>";
		});
		
		$("#comment").html(str);
		
		});
	}
	
	function getPageList(page){
		$.getJSON("/comment/"+p_no+"/"+page,function(){
			console.log(data.list.length);
			var str="";
			$(data.list).each(function(){
				str+="<li data-co_no='"+this.co_no+"' class='commentLi'>"
				+this.co_no+":"+this.content+
				"<button>MOD</button></li>";
			});
			
			$("#comment").html(str);
			
			printPaging(data.pageMaker);
		});
	}
	
	function printPaging(pageMaker){
		var str="";
		if(pageMaker.prev){
			str+="<li><a href='"+(pageMaker.startPage-1)+"'><<</a></li>";
		}
		
		for(var i=pageMaker.startPage,len=pageMaker.endPage; i<=len; i++){
			var strClass=pageMaker.cri.page ==i?'class=active':'';
			str+="<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.next){
			str=="<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
		}
		$('.pagination').html(str);
	}
	
	
		$("#addBtn").on("click",function(){
			var writer =$("#writer").val();
			var content =$("#content").val();
			var email =$("#email").val();
			var co_type =$("#co_type").val();
			var p_no =$("#p_no").val();
			
			$.ajax({
				type:'post',
				url: '/reset/comment',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method_Override" : "POST"		
				},
				dataType:'text',
				data : JSON.stringify({
					writer : writer,
					email : email,
					content : content,
					co_type : co_type,
					p_no : p_no
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						getAllList();
					}
				}
			});
		});
		
		$("#comment").on("click",".commentLi button",function(){
			var comment =$(this).parent();
			
			var co_no =comment.attr("data-co_no");
			var content =comment.text();
			
			$(".modal-title").html(co_no);
			$("#commenttext").val(content);
			$("#modDiv").show("slow");
		});
		
		$("#commentDelBtn").on("click",function(){
			var co_no=$(".modal-title").html();
			var content=$("#commenttext").val();
			$.ajax({
				type: 'delete',
				url: '/comment/'+co_no,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				
				dataType : 'text',
				success : function(result){
					console.log("result:"+result);
					if(result=='success'){
						alert("삭제되었습니다");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		$("#commentModBtn").on("click",function(){
			var co_no=$(".modal-title").html();
			var content=$("#commenttext").val();
			
			$.ajax({
				type: 'put',
				url:'/comment/'+co_no,
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data:JSON.stringify({content:content}),
				dataType:'text',
				success:function(result){
					console.log("result:"+result);
					if(result=='success'){
						$("#modDiv").hide("slow");
						getPageList(content);
					}
				}
			});
		});
</script>
</body>
</html>