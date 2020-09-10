<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"	   uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사 응답 폼</title>
<%@include file="../cmmn/common_top.jsp"%>
</head>
<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
	
	.wrapper { margin: 15px auto; width: 80%; border: 2px solid black;}
	
	p { font-size: 1.5em}
</style>
<script type="text/javascript"src="${pageContext.request.contextPath }/js/form.js"></script>
<body>
<!-- Progress Bar -->
<div class="progress" style="margin:0 auto; width:60%">
	<input type="hidden" name="qListSize" value="${fn:length(questionList)}">
	<div class="progress-bar" role="progressbar" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<!-- forEach로 문항 뿌리기 -->
<c:forEach items="${questionList }" var="question" varStatus="i">

	
	<c:if test="${(i.index)%5 == 0}">
		<!-- 5문항씩 div로 나누기 -->
		<div class="container wrapper" id="wrap${i.index }"<c:if test="${!i.first}">style="display:none"</c:if>>
	</c:if>
	
		<div class="question${question.q_no }" style="margin-bottom: 20px">
			<input type="hidden" name="s_seq" value="${question.s_seq }">
			<input type="hidden" name="q_no" value="${question.q_no}"> 
			<input type="hidden" name="c_type" value="${question.c_type }">
			<input type="hidden" name="q_required" value="${question.q_required }">
			<input type="hidden" name="q_multiple" value="${question.q_multiple }">
			<p class="q-text"><b>문항 ${question.q_no }. <c:if test="${question.q_category != ''}">[${question.q_category }]</c:if></b> ${question.q_text }</p>
			
			<c:forEach items="${answerList }" var="answer">
				<c:if test="${answer.q_no == question.q_no }">
					<c:set value="${fn:split(answer.a_answer,',')}" var="userAnswer"/>
					<c:forEach items="${choiceList }" var="choice">
						<c:if test="${question.c_type == choice.c_type }">
							<input type="checkbox" id="${question.q_no }.${choice.c_value }" name="${question.q_no }" value="${choice.c_value }" style="margin-left: 7%"
								<c:forEach items="${userAnswer }" var="eachAnswer">
									<c:if test="${choice.c_value == eachAnswer }">checked</c:if>
								</c:forEach>
							>
							<label for="${question.q_no }.${choice.c_value }" style="padding-left: 10px; padding-right: 20px">${choice.c_text }</label>
							<br>
						</c:if>
					</c:forEach>
					<c:if test="${question.c_type == 0}">
						<textarea rows="12" cols="130" id="${question.q_no }" style="margin-left: 7%"><c:if test="${question.q_no == answer.q_no }">${answer.a_answer }</c:if></textarea>
					</c:if>
				</c:if> <!-- answerList 반복시 q_no가 같은지 체크 -->
			</c:forEach> <!-- answerList반복 -->
			
		</div>
	
	<c:if test="${(i.index + 1)%5 == 0}">
			<!-- 반복횟수가 마지막이 아니면 다음버튼을 출력 -->
			<c:if test="${!i.last }">
				<div align="right">
					<button class="btn btn-primary" onclick="next(${i.index})">다음</button>
				</div>
			</div>
		</c:if>
	</c:if>
		
	<c:if test="${i.last }">
			<!-- 반복횟수가 마지막이면 설문 제출버튼 출력 -->
			<button class="btn btn-primary btn-block" onclick="modify(${i.index + 1})">설문 내용 수정</button>
		</div>
	</c:if>
</c:forEach>
</body>
</html>