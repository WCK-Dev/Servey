<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사 응답 폼</title>
<%@include file="../cmmn/common_top.jsp"%>
</head>
<style>
	* { font-family: 'Noto Sans KR', sans-serif; }
	
	.wrapper { margin: 50px auto; width: 80%; border: 2px solid black;}
	
	p { font-size: 1.5em}
</style>

<script>
	function next(wrap_index) {
		var hide = wrap_index - 4;
		var show = wrap_index + 1; 
		
		
		$("#wrap"+hide).css("display", "none");
		$("#wrap"+show).toggle();
		$('html, body').stop().animate({scrollTop: 0}, 300);
		
	}
	
	function submit(totalCnt) {
		
		var sum = 0;
		
		$("[class^=question]").each(function(index, item){
			
			var q_no = $(item).children('input[name=q_no]').val();
			var c_type = $(item).children('input[name=c_type]').val();
			var s_seq = $(item).children('input[name=s_seq]').val();
			var a_answer = "";
			
			if(c_type != 0) {
				$(item).children(':checkbox:checked').each(function(index, item){
					if(index == 0) {
						a_answer = $(item).val();
					} else {
						a_answer += ","+$(item).val();
					}
				})
			} else {
				a_answer = $(item).children('textarea').val();
			}
			
			$.ajax({
				type : 'POST',
				url : "insertAnswer.do",
				dataType : "text",
				data : {"q_no" : q_no
					   ,"a_answer": a_answer
					   ,"s_seq": s_seq
						},
				
				success : function (result) {
					sum += result;
				}
			}); // ajax End
		}); // each End
		
		if(sum == totalCnt) {
			alert("설문이 제출되었습니다.\r\n 참여해주셔서 감사합니다.");
		}
		
	}
</script>
<body>
<!-- forEach로 문항 뿌리기 -->
<c:forEach items="${questionList }" var="question" varStatus="i">

	
	<c:if test="${(i.index)%5 == 0}">
		<!-- 5문항씩 div로 나누기 -->
		<div class="container wrapper" id="wrap${i.index }"<c:if test="${!i.first}">style="display:none;"</c:if>>
	</c:if>
	
		<div class="question${question.q_no }" style="margin-bottom: 20px">
			<input type="hidden" name="q_no" value="${question.q_no}"> 
			<input type="hidden" name="c_type" value="${question.c_type }">
			<input type="hidden" name="s_seq" value="${question.s_seq }">
			<p class="q-text"><b>문항 ${question.q_no }. <c:if test="${question.q_category != ''}">[${question.q_category }]</c:if></b> ${question.q_text }</p>
			
			<c:forEach items="#{choiceList }" var="choice">
				<c:if test="${question.c_type == choice.c_type }">
					<input type="checkbox" id="${question.q_no }.${choice.c_value }" value="${choice.c_value }" style="margin-left: 7%">
					<label for="${question.q_no }.${choice.c_value }" style="padding-left: 10px; padding-right: 20px">${choice.c_text }</label>
					<br>
				</c:if>
			</c:forEach>
			<c:if test="${question.c_type == 0}">
				<textarea rows="12" cols="130" id="${question.q_no }" style="margin-left: 7%"></textarea>
			</c:if>
			
		</div>
	
		<c:if test="${(i.index + 1)%5 == 0}">
			<!-- 반복횟수가 마지막이 아니면 다음버튼을 출력 -->
			<c:if test="${!i.last }">
				<div align="right">
					<button class="btn btn-primary" onclick="next(${i.index})">다음</button>
				</div>
			<!-- /5문항씩 div로 나누기 -->
			</div>
		</c:if>
		
		</c:if>
		<c:if test="${i.last }">
			<!-- 반복횟수가 마지막이면 설문 제출버튼 출력 -->
			<button class="btn btn-primary btn-block" onclick="submit(${i.index + 1})">설문 제출</button>
		</div>
		</c:if>
</c:forEach>
</body>
<%@include file="../cmmn/common_bot.jsp"%>
</html>