<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<%@include file="../cmmn/common_top.jsp"%>

<style>
* { font-family: 'Noto Sans KR', sans-serif; }
* { box-shadow: 0 0!important;}

.wrapper { margin: 50px auto; width: 500px;}
</style>

</head>
<body>
<div class="container wrapper">
	<form class="text-center border border-light p-5" action="login.do" method="post">
		<p class="h4 mb-4">로그인 페이지</p>
		
	    <!-- ID -->
	    <input type="text" name="u_id" class="form-control mb-4" placeholder="ID" value="${rememberId }">
	
	    <!-- Password -->
	    <input type="password" name="u_pwd" class="form-control mb-4" placeholder="Password">
		
	    <!-- Sign in button -->
	    <button class="btn btn-info btn-block my-4" type="submit">Sign in</button>
	</form>
</div>

<%@include file="../cmmn/common_bot.jsp"%>
</body>
</html>