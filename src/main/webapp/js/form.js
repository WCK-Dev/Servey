var qListSize = 0;
var progress = 0;
var percent = 0.0;

$(document).ready(function(){
	qListSize= $('input[name="qListSize"]').val(); //전체 문항수
	
	/* ProgressBar 위치조정 (absolute top 지정) */
	var pgTopPosition = parseInt($(".progress").css('top'));
	
	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + pgTopPosition + "px";

		/* 애니메이션 없이 바로 따라감 */
		 $(".progress").css('top', newPosition);
		
	}).scroll();
	
	
	$("[class^=question]").each(function(index, item){
		/* progress 초기값 세팅(화면로딩시에 몇 %인지 == 수정일때는 0%에서 시작하면 안됨) */
		var c_type = $(item).find('input[name="c_type"]').val();
		var q_multiple = $(item).find('input[name="q_multiple"]').val();
		
		/* 작성된 객관식(체크) 답변의 수를 누적 */
		if(c_type != -1 && c_type != 0){ 
			
			// progress 초기값 세팅
			var chkedLength = $(item).find('input[type="checkbox"]:checked').length
			if(chkedLength != 0){
				progress++;
			}
			
			// 클릭이벤트 정의
			if(q_multiple == 1) { //객관식(체크) 형태로 답변하는 문항중, 답변 갯수가 1인항목들
			    onlyOneCheck(item);
			} else { //객관식(체크) 형태로 답변하는 문항중, 답변 갯수가 복수인 항목들
				multipleCheck(item);
			}
		/* 작성된 주관식 답변의 수를 누적 */
		} else if (c_type == 0) { 
			var textArea = $(item).find('textarea');
			var textVal = textArea.val();
			
			if(textVal.trim() != ''){
				progress++;
			}
			
			//textarea에 포커스를 했을 경우 프로그레스 바 갱신
			textArea.focus(function() {
				 textVal = textArea.val();
				 if(textVal.trim() != ''){
					 progress--;
				 }
				 
				pgBarChange();
			})
			//blur이벤트로 값이 입력되었을 경우에 프로그레스바 갱신
			textArea.blur(function() {
				 textVal = textArea.val();
				 if(textVal.trim() != ''){
					 progress++;
				 }
				 
				pgBarChange();
			})
		}
	}); // each End

	pgBarChange();
});// ready End

function pgBarChange(){
	/* 누적된 답변수를 통해, 작성 % 를 구하고 progressBar로 세팅 */
	percent = (progress / qListSize) * 100;
	percent = percent.toFixed(2);
	var pgBar = $(document).find('div[class="progress-bar"]')
	pgBar.css("width", percent + "%");
	pgBar.text(percent + "% Complete");
}

function onlyOneCheck(item){
	var chk = $(item).find('input[type="checkbox"]');
	
	chk.click(function(){
	   if($(this).is(':checked')){ //체크될떄
	       if(!($(item).find('input[type="checkbox"]:checked').length > 1)){ // 체크된 시점에 length가 1보다 크면 (다른 체크박스로 바꾸면 progressBar를 추가로 늘리지않음)
		       progress++;
	       }
	       chk.not(this).prop('checked',false); // 선택한 체크박스를 제외한 나머지 체크박스의 checked 해제
	   } else { // 체크를 해제할때
		   progress--;
	   }
	   
	   pgBarChange();
	})
}

function multipleCheck(item) {
	var chk = $(item).find('input[type="checkbox"]');
	var none = $(item).find('input[type="checkbox"]:last'); // 마지막 체크박스 (없음 체크박스)
	var multiple = Number(chk.parent().find('input[type="hidden"][name="q_multiple"]').val()); //체크할수 있는 최대 숫자  
	
	//없음을 클릭할 경우(나머지 체크박스를 모두 false로)
	none.click(function(){
		var chkedLength = $(item).find('input[type="checkbox"]:checked').length; // 현재 체크된 숫자
		
	    if($(this).is(':checked')){
	    	
	    	if(chkedLength != (multiple + 1)) {
	    		progress ++;
	    	}
	       chk.not(this).prop('checked',false);
	    } else {
			progress--;
		}
	    
	    pgBarChange();
	})
	
	//없음이 아닌 경우
	chk.not(none).click(function(){
		var chkedLength = $(item).find('input[type="checkbox"]:checked').length; // 현재 체크된 숫자
		
		if($(this).is(':checked')){
			
			if($(none).prop('checked') == true){
				progress--;
			}
			
			if(chkedLength == multiple && ($(none).prop('checked') == false)) {
				progress ++;
			} 
			if(chkedLength > multiple) {
				$(this).prop('checked', false);
				alert(multiple+"개이상 선택할 수 없습니다!");
			}
			none.prop('checked', false); //클릭시에 없음 버튼을 false로
		
		} else {
			
			if(chkedLength == (multiple - 1)){
				progress --;
			}
		}
		
		pgBarChange();
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
	var exitFlag = true; // 유효성 검사가 each 안에서 수행되므로, 유효성에 위배될때 검사를 멈추고 탈출할 flag
	
	div.find("[class^=question]").each(function(index, item){
		var c_type = $(item).find('input[name="c_type"]').val();
		var q_no = $(item).find('input[name="q_no"]').val();
		var q_required = $(item).find('input[name="q_required"]').val();
		var q_multiple = $(item).find('input[name="q_multiple"]').val();
		
		if(c_type != -1 && q_required == "true"){
			
			if(c_type != 0){ //주관식 답변이 아닐때 (체크박스 문항일 경우)
				var chkedleng = $(item).find('input[type="checkbox"]:checked').length;

				if(q_multiple == 1){ // 단일 체크 문항일 경우
					if(chkedleng != 1) {
						alert(q_no + "번 문항에 답변해주세요!");
						exitFlag = false;
						//each를 종료
						return false; 
					}
				} else {
					var noneFlag = $(item).find('input[type="checkbox"]:last').prop("checked"); // 없음을 체크했는지 여부
					if(chkedleng != q_multiple && !noneFlag) { // 체크개수가 요구되는 숫자와 다르고 없음을 체크하지도 않은 경우
						alert(q_no + "번 문항에 답변해주세요!");
						exitFlag = false;
						//each를 종료
						return false;
					}
				}

			} else { //주관식 답변문항일 경우
				var textVal = $(item).children('textarea').val();
				if(textVal.trim() == ''){
					alert(q_no + "번 문항에 답변해주세요!");
					exitFlag = false;
					//each를 종료
					return false;
				}
			}
		}
	}) //each End
	return exitFlag;		
}

function submit(totalCnt) {
	//next버튼클릭시에, 해당 페이지에서는 유효성 검사를 하고 넘어오므로, 마지막 페이지만 검사하기 위해 마지막 div를 조회
	var nowDiv = $("[id^=wrap]:last");
	
	if(testValidation(nowDiv)){ //유효성에 문제 없을경우
		var sum = 0; //DB에 정상적으로 입력된 문항 수를 누적
		
		$("[class^=question]").each(function(index, item){
			
			var q_no = $(item).children('input[name=q_no]').val();
			var c_type = $(item).children('input[name=c_type]').val();
			var s_seq = $(item).children('input[name=s_seq]').val();
			var a_answer = "";
			
			if(c_type != 0) { //객관식 문항
				$(item).children(':checkbox:checked').each(function(index, item){ //답변수가 여러개인 multiple문항의 경우, 체크된 숫자만큼 값을 누적해서 DB입력
					if(index == 0) {
						a_answer = $(item).val();
					} else {
						a_answer += ","+$(item).val(); //두번째 반복부터는 ,로 누적해서 입력
					}
				})
			} else { //주관식문항
				a_answer = $(item).children('textarea').val();
			}
			
			$.ajax({ // 각 문항을 ajax로 DB에 입력
				type : 'POST',
				url : "insertAnswer.do",
				dataType : "text",
				data : {"q_no" : q_no
					,"a_answer": a_answer
					,"s_seq": s_seq
				},
				
				success : function (result) {
					sum++; //DB row하나가 입력될 때마다 누적
					if(sum == totalCnt){ //전체 입력이 완료된 경우, 메시지 출력후 로그테이블에 입력;
						alert("설문이 제출되었습니다.\r\n참여해주셔서 감사합니다.");
						insertLog();
						location.href="serveyMain.do?s_seq=" + s_seq;
					}
				}
			}); // ajax End
		}); // each End
	}
	
}

function modify(totalCnt) {
	var nowDiv = $("[id^=wrap]:last");
	
	if(testValidation(nowDiv)){
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
				url : "updateAnswer.do",
				dataType : "text",
				data : {"q_no" : q_no
					   ,"a_answer": a_answer
					   ,"s_seq": s_seq
						},
				
				success : function (result) {
					sum++;
					if(sum == totalCnt){
						alert("설문이 수정되었습니다.\r\n참여해주셔서 감사합니다.");
						updateLog();
						location.href="serveyMain.do?s_seq=" + s_seq;
					}
				}
			}); // ajax End
		}); // each End
	}
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

function updateLog(){
	var s_seq = $("input[name=s_seq]").val();
	
	$.ajax({
		type : 'POST',
		url : "updateLog.do",
		dataType : "text",
		data : {"s_seq": s_seq},
		
		success : function (result) {
			if(result == 1) {
				console.log("로그수정 완료");
			}
		}
	});
}