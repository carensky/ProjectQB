<%-- 
	@JSP:examPaperDo.jsp
	@DATE:2018-10-12
	@Author:우한결
	@Desc:학생 시험보기 페이지(스토리보드 39 of 41)
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/css/examPaperDo.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/lib/onet-js/examPaperDo.js"></script> --%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script>
	//	프로그레스바 script 부분
	var exam_info_time = "${exam_info.exam_info_time}";
	var hour_ms = parseInt(exam_info_time.substr(0, 2)) * 3600000;
	var minute_ms = parseInt(exam_info_time.substr(3, 5)) * 60000;
	var second_ms = parseInt(exam_info_time.substr(6)) * 1000;

	var total_time = hour_ms + minute_ms + second_ms;
	console.log("토탈 타임: " + total_time);
	var current_time = 0;
	var refresh_interval = 50;
	var timer;

	function refresh_bar() {
		$("#progressbar1").progressbar({
			value : current_time
		});
		current_time += refresh_interval;
		if (current_time > total_time)
			clearInterval(timer);
	}

	// document.ready 시작 
	$(function() {

		// 프로그레스바 script
		$("#progressbar1").progressbar({
			max : total_time,
			value : current_time
		});
		timer = setInterval(refresh_bar, refresh_interval);

		
		// 문제 및 답지 체크 script 시작 
		// 문제 보기를 클릭했을 때 답안지에도 표시 
		$('input[type="radio"]').click(function() {
			var oximg_v_class = "oximg_v_" + $(this).attr("id").substr(0, 6);
			$("." + oximg_v_class).css("display", "none");

			var img_id = "img_" + $(this).attr("id");
			var ans_img_id = "ans_" + img_id;
			$('#' + img_id).css("display", "block");
			$('#' + ans_img_id).css("display", "block");
		});

		// 답안지를 클릭했을 때 문제 보기에도 표시 
		$('.answer_choice').click(function() {
			var ques_num = $(this).find('img').attr('class').substr(15);
			$("." + ques_num).css("display", "none"); // 이걸로 한 문제의 체크 이미지 전체를 지운다. 

			var img_ques_id = $(this).find('img').attr('id').substr(4);
			$("#" + img_ques_id).css("display", "block"); //  문제 보기에 체크 이미지 보이게  
			$(this).find('img').css("display", "block"); // 답지에 체크 이미지 보이게 
		});

		// 단답형 답 문제지와 답지 동시에 입력하기 
		$('.trd_div input[type="text"]').change(function(){
			var ques_num2 = $(this).attr('id')
			var _index = ques_num2.lastIndexOf("_");
			var ques_num = ques_num2.substr(0, _index);
			$("#" + ques_num).val($(this).val());
		});
		
		$('.fst_div input[type="text"], .scd-div input[type="text"]').change(function(){
			var ques_num2 = $(this).attr('id').substr(0, 6);
			var ques_num = ques_num2 + "_answer";
			$("#" + ques_num).val($(this).val());
		});		
		
		
		// 제출 버튼 눌렀을 때 form 제출 
		$('#examPaperSubmit').click(function(){
			$('#answerForm').submit();
			self.close();
			opener.location.href = '${pageContext.request.contextPath}/student/pastExam.do';	//시험 제출 후 자식창이 닫히고 부모창에서 페이지 이동하기, 나중에 뒤에 인자값 들고가야함
		});
		
	});  // document.ready 종료 
</script>
</head>
<body>
<%
	String questionCount2 = request.getAttribute("questionCount").toString();
	int questionCount = Integer.parseInt(questionCount2);
	
	double halfCount = questionCount / 2;
	String str = Double.toString(halfCount);			//	반으로 나눈 것의 String 값
	
	String firstRow2 = str.substring(0, str.indexOf(".")); 
	int firstRow = 0;
	int secondRow = 0;
	
	if (questionCount % 2 == 0) {	//	 짝수 
		firstRow = Integer.parseInt(firstRow2);
		secondRow = Integer.parseInt(firstRow2);
	} else {
		firstRow = Integer.parseInt(firstRow2) + 1;
		secondRow = Integer.parseInt(firstRow2);
	}
%>	
	<div class="col-lg-12 mt">
		<div id="timerblock">
			<h3 class="mb exampaneldetailsubject">
				<i class="fa fa-angle-right"></i> ${exam_info.exam_info_name}
			</h3>
			<h4>남은 시간: ${exam_info.exam_info_time}</h4>
		</div>
		<div id="progressbar1"></div>
		<hr>
		<div class="panel-body">
			<div class="row content-panel exampaneldetail">
				<c:set var="firstRow" value="<%=firstRow%>"/>
				<c:set var="secondRow" value="<%=secondRow%>"/>
			
			<form method="post" id="answerForm">
			
				<c:forEach var="question" items="${questionList}" varStatus="status"> <!--  문제 하나의 테이블, id값에는 문제고유번호가 들어간다 -->		
					<c:if test="${question.exam_question_seq < 2}">
						<div class="col-lg-5 fst_div" id="examBox">	
					</c:if>
							<table class="questionTable">
 								<input type="hidden" name="student_answer[${status.index}].member_id" value="${pageContext.request.userPrincipal.name}"> 
								<input type="hidden" name="student_answer[${status.index}].exam_info_num" value="${exam_info.exam_info_num}">
		                        <input type="hidden" name="student_answer[${status.index}].question_num" value="${question.question_num}"> 
		                        <input type="hidden" name="student_answer[${status.index}].exam_question_seq" value="${question.exam_question_seq}"> 
								<tr class="questionTr">
									<td class="questionTd questionSpace"><b>${question.exam_question_seq}. </b></td>
									<td class="questionSpace"><b>${question.question_name} &nbsp;&nbsp;(${question.exam_question_score}점)</b></td>
								</tr>
								<c:if test="${not empty question.question_img}"> <!-- 이미지 있으면 추가 -->
									<tr class="ques_choice">
										<td class="questionTd"></td>  
										<td><img class="question_img" src="${pageContext.request.contextPath}/img/${question.question_img}"></td>
									</tr>
								</c:if>
								<c:choose>
									<c:when test="${question.question_type eq '객관식'}">
										<c:forEach var="questionChoice" items="${questionChoiceList}">
											<c:if test="${questionChoice.question_num eq question.question_num}">
											<tr class="ques_choice">
												<td class="questionTd">
													<div class="wrap">
														<img class="oximg_v oximg_v_ques_${question.exam_question_seq}" id="img_ques_${question.exam_question_seq}_${questionChoice.question_choice_num}" 
														src="${pageContext.request.contextPath}/img/oximg_v.png">
													</div>
													${questionChoice.question_choice_num})
												</td>  	
												<td>
													<input type="radio" name="student_answer[${status.index}].student_answer_choice" id="ques_${question.exam_question_seq}_${questionChoice.question_choice_num}" 
													value="${questionChoice.question_choice_num}">
													<label for="ques_${question.exam_question_seq}_${questionChoice.question_choice_num}">${questionChoice.question_choice_content}</label>
												</td>
											</tr>
											</c:if>
										</c:forEach>
									</c:when>
									<c:when test="${question.question_type eq '단답형'}">
										<tr class="ques_choice">
											<td class="questionTd"></td>  
											<td><input type="text" id="ques_${question.exam_question_seq}" class="" name="student_answer[${status.index}].student_answer_choice"></td>
										</tr>
									</c:when>
								</c:choose>
							</table>	
							<c:if test="${question.exam_question_seq == firstRow }">
								</div>
								<div class="col-lg-5 scd-div">
							</c:if>
                </c:forEach>
                </div>
                
                </form>
                
                
                
                
				<div class="col-lg-2 trd_div">
					<!-- OMR 시작 div -->
					<table class="tg">
						<tr>
							<th class="tg-baqh qname" colspan="6">답안지</th>
						</tr>
						<c:forEach var="question" items="${questionList}">
							<tr>
								<td class="tg-baqh qnumber">${question.exam_question_seq}</td>
								<c:choose>
									<c:when test="${question.question_type eq '객관식'}">
										<c:forEach var="questionChoice" items="${questionChoiceList}" varStatus="status">
											<c:if test="${questionChoice.question_num eq question.question_num}">
												<td class="tg-baqh answer_choice">
					                                <div class="wrap"><img class="answer_oximg_v oximg_v_ques_${question.exam_question_seq}" 
					                                id="ans_img_ques_${question.exam_question_seq}_${questionChoice.question_choice_num}" 
					                                src="${pageContext.request.contextPath}/img/oximg_v.png"></div>
					                                ${questionChoice.question_choice_num} 
					                            </td>					                            
											</c:if>
										</c:forEach>
									</c:when>
									<c:when test="${question.question_type eq '단답형'}">
										<td class="tg-baqh answer_choice" colspan="5"><input type="text" class="" name="" id="ques_${question.exam_question_seq}_answer" ></td>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
					<br>
				</div>
			</div>
			<button class="btn btn-theme03 exampaneldetailBtn" id="examPaperSubmit">제출하기</button>
		</div>
	</div>
</body>
</html>