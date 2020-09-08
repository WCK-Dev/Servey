<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사 메인페이지</title>
<%@include file="../cmmn/common_top.jsp"%>
</head>
<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
	
	.wrapper { margin: 20px auto; width: 80%; border: 2px solid black;}
	
	p { font-size: 1em}
</style>

<script>
$(document).ready(function(){
	if('${Duplicate}' == 'true'){
		alert("죄송합니다.\r\n회원님은 이미 해당 설문에 참여하셨습니다.");
	}
});
</script>
<body>
<div class="userBox" style="width: 80%; padding-top:20px; text-align: right;">
	${sessionScope.user.u_name }(${sessionScope.user.u_id })님 환영합니다.
</div>
	
<div class="container wrapper">

	<h2>참여하실 설문을 선택해주세요.</h2>
	 <br><br>
	 
	<c:forEach items="${serveyList }" var="servey">
		<div style="border: 2px solid lightgray; margin-bottom : 10px; padding: 20px;">
			<h2>설문명 : ${servey.sName }</h2>
			<p>설문조사 시작일 : <fmt:formatDate timeZone="UTC" pattern="yyyy-MM-dd" value="${servey.sStartdate }"/><p>
			<p>설문조사 종료일 : <fmt:formatDate timeZone="UTC" pattern="yyyy-MM-dd" value="${servey.sEnddate }"/><p>
			<p>조사주관 : ${servey.sCompany }<p>
			
			<div align="right">
				<button class="btn btn-primary" onclick="location.href='serveyMain.do?s_seq=${servey.sSeq}'">설문참여</button>
			</div>
		</div>
	</c:forEach>
</div>
</body>
</html>