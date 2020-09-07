<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<body>

<div class="container wrapper">
	<!-- forEach필요 -->
	<div class="questions1">
		<p class="question-text"><b>문항 n. [전반적 만족도]</b> 퓨전 소프트의 서비스에 대해 전반적으로 얼마나 만족하십니까?</p>
		<div class="choices" style="margin-left: 7%;">
			<input type="checkbox" id="val1" value=""><label for="val1" style="padding-left: 10px; padding-right: 20px">매우 만족</label>
			<input type="checkbox" id="val2" value=""><label for="val2" style="padding-left: 10px; padding-right: 20px">대체로 만족</label>
			<input type="checkbox" id="val3" value=""><label for="val3" style="padding-left: 10px; padding-right: 20px">약간 만족</label>
			<input type="checkbox" id="val4" value=""><label for="val4" style="padding-left: 10px; padding-right: 20px">보통</label>
			<input type="checkbox" id="val5" value=""><label for="val5" style="padding-left: 10px; padding-right: 20px">약간 불만족</label>
			<input type="checkbox" id="val6" value=""><label for="val6" style="padding-left: 10px; padding-right: 20px">대체로 불만족</label>
			<input type="checkbox" id="val7" value=""><label for="val7" style="padding-left: 10px; padding-right: 20px">매우 불만족</label>
		</div>
	</div>

</div>

<%@include file="../cmmn/common_bot.jsp"%>
</body>
</html>