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
<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
	
	.wrapper { margin: 20px auto; width: 80%; border: 2px solid black;}
	
	p { font-size: 1.5em}
</style>

<script>
	$(document).ready(function(){
		if('${Duplicate}' == 'true')	alert("회원님은 이미 해당 설문에 참여하셨습니다.\r\n설문 답변을 수정하시려면 수정하기를 선택해주세요.");
		if('${noneLog}' == 'true')		alert("회원님은 해당 설문에 답변하신 기록이 없습니다..\r\n먼저 설문시작을 통해 설문을 제출해주세요.");
		if('${notPeriod}' == 'true')	alert("지금은 설문조사기간이 아닙니다.\r\n현재는 설문을 등록, 수정할 수 없습니다.");
	});

	function serveyStrat(s_seq){
			location.href='serveyForm.do?s_seq=' + s_seq;
	}

	function serveyModify(s_seq){
			location.href='serveyModify.do?s_seq=' + s_seq;
	}
</script>

</head>
<body>
<div class="userBox" style="width: 80%; padding-top:20px; text-align: right;">
	${sessionScope.user.u_name }(${sessionScope.user.u_id })님 환영합니다.
	<button class="btn btn-danger" onclick="location.href='logout.do'">로그아웃</button>
</div>

<div class="container wrapper">
 <!-- 일수 계산용 parseNumber -->
 <fmt:parseNumber value="${servey.s_startdate.time / (1000*60*60*24)}" integerOnly="true" var="startDate"/>
 <fmt:parseNumber value="${servey.s_enddate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"/>

<p>${servey.s_company } 회원분들을 대상으로 ${servey.s_name }를 진행합니다.</p>
<p> 응답하신 내용은 통계법 33조(비밀의 보호)에 의거 비밀이 보장되며,</p>
<p>서비스 개선을 위한 자료 외에 어떠한 목적으로도 사용되지 않음을 약속드립니다.</p>
<p>많은 참여 부탁드리며, 앞으로도 교육정책 및 교육과정 정보를 보다 빠르게 활용하실 수 있도록</p>
<p>더욱 노력하겠습니다.</p>
 
 <br><br>
 
<p> ㅇ 조사주관 : ${servey.s_company }</p>
<p>ㅇ 참여대상 : 회원(로그인 필요)</p>
<p>ㅇ 참여기간 : '<fmt:formatDate pattern="yy. MM. dd.(E)" value="${servey.s_startdate }"/> ~ <fmt:formatDate pattern="yy. MM. dd.(E)" value="${servey.s_enddate }"/>, 총 ${endDate - startDate }일간</p>
<p>ㅇ 참여방법 : 하단의 설문시작 버튼을 클릭하여 총 19개의 문항에 답변을 마치면 응모 완료</p>
<p>ㅇ 당첨자 발표 : '20. 10. 01.(목), 퓨전소프트 공지사항 게시판</p>
 
 <br><br>
 
 <p>**유의사항</p>
 	<p>- 당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.</p>
 	<p>- 1인 1회에 한하여 참여가능 합니다.</p>
 	
<c:choose>
	<c:when test="${log == 0 }">
		<button class="btn btn-primary btn-block" onclick="serveyStrat(${servey.s_seq})">설문 시작</button>
	</c:when>
	<c:otherwise>
		<button class="btn btn-danger btn-block" onclick="serveyModify(${servey.s_seq})">설문 수정</button>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>