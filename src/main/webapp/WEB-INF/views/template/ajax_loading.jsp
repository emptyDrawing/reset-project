<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(function(){
	$(document).ajaxStart(function() {$('.wrap-loading').removeClass('display-none');});
	$(document).ajaxComplete(function() {$('.wrap-loading').addClass('display-none')});
});
</script>
<style type="text/css" >
.wrap-loading{

	z-index:9999;
    position: fixed;
    left:0;	right:0; top:0; bottom:0;
    background: rgba(0,0,0,0.6); 
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');
}
.wrap-loading div{ 
	position: fixed;
	top:50%; left:50%;
	margin-left: -100px;
	margin-top: -100px;
}
.display-none{
	display:none;
}
</style>

<div class="wrap-loading display-none">
	<div><img src="${goRoot }imgs/Eclipse-1s-200px red.svg" /></div>
</div>  
