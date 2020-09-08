<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사 메인페이지</title>
<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
	
	.wrapper { margin: 20px auto; width: 80%; border: 2px solid black;}
	
	p { font-size: 1.5em}
</style>

<%@include file="../cmmn/common_top.jsp"%>
<script>
	function serveyStrat(s_seq, u_id){
		/* ajax요청을 통해 log에 해당 유저가 이 설문에 답한 이력이 있는지 검사 */
		
		/* 있으면 alert를 통해 이미 참여한 설문임을 알리고, return false */
		//if() {
			
		//} else { /* 없을 경우에만 정상적으로 설문 작성 페이지로 이동 */
			location.href='serveyForm.do?s_seq=' + s_seq;
		//}
		
	}
</script>
</head>
<body>
<div class="userBox" style="width: 80%; padding-top:20px; text-align: right;">
	${sessionScope.user.u_name }(${sessionScope.user.u_id })님 환영합니다.
</div>
	
<div class="container wrapper">

<p>퓨전소프트 회원분들을 대상으로 ${servey.s_name }를 진행합니다.</p>
<p> 응답하신 내용은 통계법 33조(비밀의 보호)에 의거 비밀이 보장되며,</p>
<p>서비스 개선을 위한 자료 외에 어떠한 목적으로도 사용되지 않음을 약속드립니다.</p>
<p>많은 참여 부탁드리며, 앞으로도 교육정책 및 교육과정 정보를 보다 빠르게 활용하실 수 있도록</p>
<p>더욱 노력하겠습니다.</p>
 
 <br><br>
 
<p> ㅇ 조사주관 : ${servey.s_company }</p>
<p>ㅇ 참여대상 : 회원(로그인 필요)</p>
<p>ㅇ 참여기간 : '<fmt:formatDate timeZone="UTC" pattern="yy. MM. dd.(E)" value="${servey.s_startdate }"/> ~ <fmt:formatDate timeZone="UTC" pattern="yy. MM. dd.(E)" value="${servey.s_enddate }"/>, 총 5일간</p>
<p>ㅇ 참여방법 : 하단의 설문시작 버튼을 클릭하여 총 19개의 문항에 답변을 마치면 응모 완료</p>
<p>ㅇ 당첨자 발표 : '20. 10. 01.(목), 퓨전소프트 공지사항 게시판</p>
 
 <br><br>
 
 <p>**유의사항</p>
 	<p>- 당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.</p>
 	<p>- 1인 1회에 한하여 참여가능 합니다.</p>
<button class="btn btn-primary btn-block" onclick="serveyStrat(${servey.s_seq}, '${sessionScope.user.u_id }')">설문 시작</button>
</div>
</body>
</html>