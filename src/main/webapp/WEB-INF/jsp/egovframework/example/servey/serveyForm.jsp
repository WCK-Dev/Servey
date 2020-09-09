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

<script>
	var qListSize;
	var 
	
	$(document).ready(function(){
		qListSize= $('input[name="qListSize"]').val() - 1; //전체 문항수
		console.log(qListSize);
		
		$("[class^=question]").each(function(index, item){
			/* 각 div안의 체크박스의 이름 */
			var chkboxName = $(item).find('input[type="checkbox"]').attr('name');
			/* 16번대(중복답변가능) 질문항목인지 검사하기위해, 16-1, 16-2, 16-3을 16으로 변환 */
			if(chkboxName != undefined) chkboxName = chkboxName.substring(0, 2);
			
			if(chkboxName != 16) { // 16번대 질문이 아니면 하나만 클릭할 수 있도록 click이벤트 추가
			    onlyOneCheck(item);
			} else { //16번대 질문에는 2개까지 답변할 수 있도록 click이벤트 추가
				multipleCheck(item);
			}
		}); // each End

	});// ready End
	
	function onlyOneCheck(item){
		var chk = $(item).find('input[type="checkbox"]');
		
 		chk.click(function(){
		    if($(this).is(':checked')){
		       chk.not(this).prop('checked',false); // 선택한 체크박스를 제외한 나머지 체크박스의 checked 해제
		   }
		})
	}
	
	function multipleCheck(item) {
		var chk = $(item).find('input[type="checkbox"]');
		var none = $(item).find('input[type="checkbox"]:last'); // 마지막 체크박스 (없음 체크박스)
		var multiple = chk.parent().find('input[type="hidden"][name="q_multiple"]').val(); //체크할수 있는 최대 숫자  
		
		//없음을 클릭할 경우(나머지 체크박스를 모두 false로)
		none.click(function(){
		    if($(this).is(':checked')){
		       chk.not(this).prop('checked',false);
		   }
		})
		
		//없음이 아닌 경우
		chk.not(none).click(function(){
			var chkedLength = $(item).find('input[type="checkbox"]:checked').length; // 현재 체크된 숫자
			
			if($(this).is(':checked') && chkedLength > multiple) {
				$(this).prop('checked', false);
				alert(multiple+"개이상 선택할 수 없습니다!");
			} else {
				none.prop('checked', false); //클릭시에 없음 버튼을 false로
			}
		})
	}
	
	function next(wrap_index) {
		var hide = wrap_index - 4; // 숨길div 번호
		var show = wrap_index + 1; // 나타낼 div 번호
		var nowDiv = $("#wrap"+hide); // 유효성 검사를 시행할 div (== 검사후 숨길 div)
		var nextDiv = $("#wrap"+show); //유효성 검사후 나타낼 div
		
		if(testValidation(nowDiv)) {
			nowDiv.css("display", "none");
			nextDiv.toggle();
			$('html, body').stop().animate({scrollTop: 0}, 300);
		}
	}
	
	function testValidation(div){
		var itemLeng = div.find("[class^=question]").length; // 전체 반복하는 횟수(Div안의 question숫자)
		var exitFlag = true;
		
		div.find("[class^=question]").each(function(index, item){
			var c_type = $(item).find('input[name="c_type"]').val();
			var q_no = $(item).find('input[name="q_no"]').val();
			var q_required = $(item).find('input[name="q_required"]').val();
			var q_multiple = $(item).find('input[name="q_multiple"]').val();
			
			if(c_type != -1 && q_required == "true"){
				
				if(c_type != 0){ //주관식 답변이 아닐때 (체크박스 문항일 경우)
					var chkedleng = $(item).find('input[type="checkbox"]:checked').length;
					console.log(q_no +"번 문항 leng : " + chkedleng);

					if(q_multiple == 1){ // 단일 체크 문항일 경우
						if(chkedleng != 1) {
							alert(q_no + "번 문항에 답변해주세요!");
							exitFlag = false;
							return false;
						}
					} else {
						var noneFlag = $(item).find('input[type="checkbox"]:last').prop("checked"); // 없음을 체크했는지 여부
						console.log(noneFlag);
						if(chkedleng != q_multiple && !noneFlag) { // 체크개수가 요구되는 숫자와 다르고 없음을 체크하지도 않은 경우
							alert(q_no + "번 문항에 답변해주세요!");
							exitFlag = false;
							return false;
						}
					}
	
				} else { //주관식 답변문항일 경우
					var textVal = $(item).children('textarea').val();
					if(textVal.trim() == '' || textVal.trim() == null){
						alert(q_no + "번 문항에 답변해주세요!");
						exitFlag = false;
						return false;
					}
				}
				
			}
			
		})
		
		return exitFlag;		
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
					sum++;
					if(sum == totalCnt){
						alert("설문이 제출되었습니다.\r\n참여해주셔서 감사합니다.");
						insertLog();
						location.href="serveyMain.do?s_seq=" + s_seq;
					}
				}
			}); // ajax End
		}); // each End
	}
	
	function insertLog(){
		var s_seq = $("input[name=s_seq]").val();
		
		$.ajax({
			type : 'POST',
			url : "insertLog.do",
			dataType : "text",
			data : {"s_seq": s_seq},
			
			success : function (result) {
				if(result == 1) {
					console.log("로그입력 완료");
				}
			}
		});
	}
</script>
<body>
<!-- Progress Bar -->
<div class="progress" style="margin:0 auto; width:60%">
	<input type="hidden" name="qListSize" value="${fn:length(questionList)}">
	<div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100">25% Complete</div>
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
			
			<c:forEach items="#{choiceList }" var="choice">
				<c:if test="${question.c_type == choice.c_type }">
					<input type="checkbox" id="${question.q_no }.${choice.c_value }" name="${question.q_no }" value="${choice.c_value }" style="margin-left: 7%">
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
</html>