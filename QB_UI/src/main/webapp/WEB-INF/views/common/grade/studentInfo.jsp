<%--
	@JSP:studentInfo.jsp
	@DATE:2018-10-11
	@Author:양회준
	@Desc:학생 & 성적 관리(스토리보드 20 of 41)	
 --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/studentInfo.css" rel="stylesheet">

<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">
			<div class="col-lg-12">
				<div class="row content-panel">
					<%-- 탭 머리 시작 --%>
					<div class="panel-heading">
						<ul class="nav nav-tabs nav-justified">
          					<li class="active">
            					<a data-toggle="tab" href="#studentInfo">학생정보</a>
          					</li>
          					<li>
            					<a data-toggle="tab" href="#studentChart">학생 개인 성적확인</a>
          					</li>
          					<li>
            					<a data-toggle="tab" href="#classChart">클래스 통계</a>
          					</li>
        				</ul>
					</div><!-- panel-heading -->
					<%-- 탭 머리 종료 --%>
					
					<%-- 탭 본문 영역 시작--%>
					<div class="panel-body">
						<div class="tab-content">
							<%-- 학생 정보 탭 시작 --%>
							<div id="studentInfo" class="tab-pane active">
								<div class="row">
								<%-- 학생 목록 시작 --%>
								<div class="col-lg-2">
									<section class="panel">
										<div class="panel-body">																					
											<table id="studentList1" class="table table-hover">
												<h4>${studentList[0].class_name}</h4>
									                <thead>
									                  <tr>
									                    <th><i class="fa fa-bullhorn"></i>학생목록</th>
									                  </tr>
									                </thead>
									                <tbody>									                
												<c:forEach items="${studentList}" var="studentList">												
								                  <tr>
								                    <td id="${studentList.member_id}" class="studentListMembers">
								                      <img src="${pageContext.request.contextPath}/img/friends/fr-05.jpg"
															class="img-circle" width="25"> ${studentList.member_name}
								                    </td>
								                   </tr>												
												</c:forEach>
											</tbody>
											</table>
										</div>
									</section>
								</div>
								<%-- 학생 목록 끝 --%>
								
								
								<%-- 선택 학생 정보 영역 시작 --%>
								<div class="col-lg-10">
									<h3 id="studentListName">${studentList[0].member_name}</h3>
									<h4 id="studentListEmail">이메일 : ${studentList[0].member_email}</h4>
									<h4 id="studentListPhone">핸드폰 : ${studentList[0].member_phone}</h4>

										<!-- page start-->
										<div class="tab-pane" id="chartjs">
											<div class="row mt">
												<%--각 시험 성적 바 차트 --%>
												<div class="col-lg-6">
													<div class="content-panel">
														<h4>
															<i class="fa fa-angle-right"></i> 각 시험 성적
														</h4>
														<div class="panel-body text-center">
															<canvas id="bar1" height="300" width="400"></canvas>
														</div>
													</div>
												</div>
											
											<%-- 반/학생 평균 선 차트 --%>
											<div class="col-lg-6">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 반/학생 평균 비교
													</h4>
													<div class="panel-body text-center">
														<canvas id="line1" height="300" width="400"></canvas>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<%-- 선택 학생 정보 영역 끝 --%>
								
								
								</div><!-- row -->
							</div><!-- studentInfo -->
							<%-- 학생 정보 탭 끝 --%>
							
							<%-- 학생 개인 성적확인 탭 시작 --%>
						<div id="studentChart" class="tab-pane">
							<div class="row">
								<!-- 학생목록 시작-->
								<div class="col-lg-2">
									<section class="panel">
										<div class="panel-body">
											<table id="studentList2" class="table table-hover">
												<h4 id="tab2_className">${studentList[0].class_name}</h4>
									                <thead>
									                  <tr>
									                    <th><i class="fa fa-bullhorn"></i>학생목록</th>
									                  </tr>
									                </thead>
									                <tbody>									                
												<c:forEach items="${studentList}" var="studentList">												
								                  <tr>
								                    <td id="${studentList.member_id}" class="tab2studentListMembers">
								                      <img src="${pageContext.request.contextPath}/img/friends/fr-05.jpg"
															class="img-circle" width="25"> ${studentList.member_name}
								                    </td>
								                   </tr>
								                </c:forEach>
											</tbody>
											</table>
										</div>
									</section>
								</div>
								<!-- 학생목록 끝-->
								<!-- 학생 개인성적 리스트 시작-->
								<div class="col-lg-10 unread">
									<section class="panel">
										<header class="panel-heading wht-bg">
											<h4 class="gen-case">
												<span id="tab2_studentName">${studentList[0].member_name}</span>
												<form action="#" class="pull-right mail-src-position">
													<div class="input-append">
														<input type="text" id="searchExamValue"class="form-control "
															placeholder="검색어를 입력하세요">
													</div>
												</form>
											</h4>
										</header>
										<div class="panel-body minimal">
											<div class="table-inbox-wrap">
												<table class="table table-hover">
													<tbody id="studentExamTable">
														<c:forEach items="${studentExamScoreInfo}" var="studentExamScoreInfo">
														<tr class="unread">															
															<td class="view-message  dont-show"><img
																	src="${pageContext.request.contextPath}/img/friends/fr-05.jpg"
																	class="img-thumbnail" width="150"></td>
															<td class="view-message "><h3 class="tab2_examPaper">${studentExamScoreInfo.exam_info_name}</h3>
																	<p><c:forEach items="${studentExamScoreInfo.smCtgrName}" var="test">${test}&nbsp;&nbsp;</c:forEach></p></td>
															<td class="view-message  text-right"><p class="tab2_examDate">시험 날짜 :
																	${studentExamScoreInfo.exam_info_date }</p>
																<p class="tab2_examTime">
																시험 시간 : ${studentExamScoreInfo.exam_info_start}~${studentExamScoreInfo.exam_info_end }</p>
																<p>(${studentExamScoreInfo.exam_info_time })</p></td>
															<td class="view-message inbox-small-cells">
																<button type="button" id="pastExamBtn"class="btn btn-round btn-info pastExamBtn" value="${studentExamScoreInfo.exam_info_num }">성적확인</button>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="mail-option">
												<ul class="unstyled inbox-pagination">
													<li><span>1-50 of 99</span></li>
													<li><a class="np-btn" href="#"><i
															class="fa fa-angle-left  pagination-left"></i></a></li>
													<li><a class="np-btn" href="#"><i
															class="fa fa-angle-right pagination-right"></i></a></li>
												</ul>
											</div>
										</div>
									</section>
								</div>
								<!-- 학생 개인성적 리스트 끝 -->
							</div>
							<!-- /row -->
						</div>
						<%-- 학생 개인 성적 탭 끝 --%>
						
						<%-- 클래스 통계 탭 시작 --%>
						<div id="classChart" class="tab-pane">
							<h3><i class="fa fa-angle-right"></i> ${studentList[0].class_name}</h3>
							<div class="row">
								<%-- 클래스 학생 표/차트 시작 --%>
								<div class="col-lg-12">
																		
										<div class="row">
										
											<%-- 반평균 막대 차트 --%>
											<div class="col-lg-6">
												<div class="content-panel pnHeight">
													<h4>
														<i class="fa fa-angle-right"></i> 각 시험 평균
													</h4>
													<div class="panel-body text-center">
														<canvas id="bar2" height="240"></canvas>
													</div>
												</div>
											</div>
											<%-- 반 등수 표 --%>
											<div class="col-lg-6">
												<div class="content-panel pnHeight">
													<h4>
														<i class="fa fa-angle-right"></i> 반 등수
													</h4>
													<div class="btn-group pull-right">
														<select id="searchExam" class="form-control searchControl"
																name="searchExam">
															<option value="" >시험 목록</option>		
															<c:forEach items="${classChart}" var="classChart">
																<option value="exam_info_name">${classChart.exam_info_name}</option>		
															</c:forEach>
														</select>
													</div>
													<br><br>
													<div class="panel-body text-center">
														<div class="table-inbox-wrap">
															<table id="classRankTable"
																class="table table-bordered table-striped table-condensed">
																<thead>
																	<tr>
																		<th>이름</th>									
																		<th>순위</th>
																	</tr>
																</thead>
																<%-- <tbody id="classRankView">
																	<c:forEach items="${classRank}" var="classRank">																	
																	<tr>
																		<td id="member_name" class="member_name">${classRank.member_name}</td>																		
																		<td id="score_chart_rank" class="score_chart_rank">${classRank.score_chart_rank}</td>																	
																	</tr>																	
																	</c:forEach>
																</tbody> --%>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row mt">
											<%-- 점수별 학생 분포 차트 --%>
											<div class="col-lg-12">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 점수별 학생 분포
													</h4>
													<div class="btn-group pull-right">
														<select id="searchSpread" class="form-control searchControl"
																name="searchSpread">
															<option value="">시험 목록</option>		
															<c:forEach items="${classChart}" var="classChart">
																<option value="${classChart.exam_info_num }">${classChart.exam_info_name}</option>		
															</c:forEach>
														</select>
													</div>
													<div class="panel-body text-center">
														<canvas id="line2" height=75%></canvas>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row mt">
											<%-- 학생별 성적표 시작--%>
											<div class="col-lg-12">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 학생별 성적표
													</h4>
													<div class="panel-body text-center">
														<table id="studentPerGrade" class="display"
															style="width: 100%">
															<thead>
																<tr>
																	<th>학생 이름</th>
																		<c:forEach items="${classChart}" var="subject">
																		<th>${subject.exam_info_name}</th>
																		</c:forEach>
																	<th>평균</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach items="${studentExamScoreList}" var="tablelist">
																<tr>
																	<td>${tablelist.member_name}</td>
																	<c:forEach items="${tablelist.score_list}" var="subjectScore">
																		<td>${subjectScore}</td>
																	</c:forEach>
																	<td>${tablelist.avg_score}</td>
																</tr>
																</c:forEach>
															</tbody>
														</table>

													</div>
												</div>
											</div>
											<%-- 학생별 성적표 끝--%>
										</div>
								</div>
								<%-- 클래스 학생 표/차트 끝 --%>
							</div>
							<!-- /row -->
							</div>
							<%-- 클래스 통계 탭 끝 --%>
						
						</div> <!-- tab-content -->
					</div> <!-- panel-body -->
				</div><!-- /row content-panel-->
			</div><!-- /col-lg-12 -->
		</div><!-- /row mt -->
	</section><!-- /wrapper -->
</section><!-- /MAIN CONTENT -->
<%--ChartJS--%>
<%--ChartJS CDN--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<%--ChartJS 차트 경로--%>
<script src="${pageContext.request.contextPath}/lib/onet-js/studentInfo.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	 $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
	        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
	    } );
	//차트 데이터 담을 배열
	var chartStudentDatas = new Array();
	var chartClassDatas = new Array();
	var chartLabels = new Array();	
	var spreadScore;
	//시험번호
	var examInfoNum = "${classChart[0].exam_info_num}";
	var examInfoName = "${classChart[0].exam_info_name}";
	
	//학생목록 배열에 jstl값 담기
	<c:forEach items="${studentChart}" var="studentChart">
		chartStudentDatas.push("${studentChart.score_chart_score}");
	</c:forEach>
	<c:forEach items="${classChart}" var="classChart">
		chartClassDatas.push("${classChart.class_chart_avg}");
		chartLabels.push("${classChart.exam_info_name}");
	</c:forEach>
	
	//학생&성적관리 학생목록 데이터 담은 배열
	var studentArr= new Array();
	//학생목록 배열에 jstl값 담기		
	<c:forEach items="${studentList}" var="studentList">
		var json=new Object();
		json.member_id="${studentList.member_id}";
		json.member_email="${studentList.member_email}";
		json.member_name="${studentList.member_name}";
		json.member_phone="${studentList.member_phone}";
		json.class_name="${studentList.class_name}";
		studentArr.push(json);
	</c:forEach>
	
	var memberName=studentArr[0].member_name;
	var className=studentArr[0].class_name;
	//tab2AjaxData
	var tab2AjaxData="";
	//tab2AjaxData 가져오기 함수
	function tab2Ajax(){
		$.ajax({
			type:"post",
			url:"studentExamScoreInfo.do",
			data:{"member_name":memberName,
				"class_name":className
				},
			datatype:"json",
			success:function(data, status){
				console.log(data);
				tab2AjaxData=data;
				var studentExamScoreSrc = "";				
				$("#studentExamTable").empty();
				$(data).each(function(index, element){
					var smCtgr="";
					$(element.smCtgrName).each(function(index, name){ //소분류 추출
						smCtgr += name+'&nbsp;&nbsp;';
					});
					studentExamScoreSrc += '<tr class="unread"><td class="view-message">';
					studentExamScoreSrc += '<img src="${pageContext.request.contextPath}/img/friends/fr-05.jpg" class="img-thumbnail" width="150"></td>';
					studentExamScoreSrc += '<td class="view-message "><h3 class="tab2_examPaper">'+element.exam_info_name+'</h3>';
					studentExamScoreSrc += '<p>'+smCtgr+'</p></td>';
					studentExamScoreSrc += '<td class="view-message  text-right"><p class="tab2_examDate">시험 날짜 : '+element.exam_info_date+'</p>';
					studentExamScoreSrc += '<p class="tab2_examTime">시험 시간 : '+element.exam_info_start+'~'+element.exam_info_end+'</p><p>('+element.exam_info_time+')</p></td>';
					studentExamScoreSrc += '<td class="view-message  inbox-small-cells">';
					studentExamScoreSrc += '<button type="button" id="pastExamBtn" class="btn btn-round btn-info pastExamBtn" value="'+element.exam_info_num+'">성적확인</button></td></tr>';		
				});
				$("#studentExamTable").append(studentExamScoreSrc);			
			},
			error:function(error, status){
				console.log("실패1:"+status);
			}
		});
	}
	
	//tab2AjaxData 가져오기 실행
	tab2Ajax();	
	//첫 화면 차트	
	functionChart();
	//두번째 화면 차트
	functionChart2();	
	//점수분포 차트
	spreadChart();
	
	$('#studentList1').DataTable({
		"ordering": false,
		"scrollY":"390px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
        }
	});
	$('#studentList2').DataTable({
		"ordering": false,
		"scrollY":"390px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
        }
	});
	var rankTable=$('#classRankTable').DataTable({
		"ordering": false,
		"scrollY":"220px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {"url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"},
        "processing":true,
		"ajax": {
           url: 'adminMemberAjax.do',
           method: "post",
           url:"classRank.do",
			data:{"exam_info_name":function(){ return examInfoName}},
           dataSrc:"",
           xhrFields: {withCredentials: true}
		},
		"columns":
			[
			{data: "member_name" },
			{data: "score_chart_rank" }       
			]
	});
	
	//학생 목록 선택 이벤트-tab1
	$(".studentListMembers").click(function(){		
		//가져온 차트데이터 담을 배열(학생점수, 반평균, 과목)	
		chartStudentDatas = [];
		chartClassDatas = [];
		chartLabels = [];		
		//클릭한 목록의 학생이름 가져오기 & 출력
		var memberName=$(this).text().trim();
		$("#studentListName").text(memberName);
		//학생 목록의 인덱스 가져오기
		var memberIndex=$(".studentListMembers").index(this);
		//선택한 학생의 이메일과 핸드폰 값 가져와 출력하기
		$("#studentListEmail").text("이메일 : "+studentArr[memberIndex].member_email);
		$("#studentListPhone").text("핸드폰 : "+studentArr[memberIndex].member_phone);
		//ajax 차트 요청할 parameter
		memberName=studentArr[memberIndex].member_name;
		className=studentArr[memberIndex].class_name;
		//비동기 실행
		$.ajax({
			type:"post",
			url:"studentChartInfo.do",
			data:{"member_name":memberName,
				"class_name":className
				},
			datatype:"json",
			success:function(data, status){
				//넘어온 map객체의 학생차트정보
				$(data.studentName).each(function(index, element){					
					chartStudentDatas.push(element.score_chart_score);
				});
				//넘어온 map객체의 클래스차트정보
				$(data.className).each(function(index, element){
					chartLabels.push(element.exam_info_name);
					chartClassDatas.push(element.class_chart_avg);					
				});
				functionChart();
				functionChart2();
			},
			error:function(error, status){
				console.log("실패2:"+status);
			}
		});		
	});
	//학생목록 이벤트 종료
	
	//학생 목록 선택 이벤트-tab2
	
	$(".tab2studentListMembers").click(function(){
		
		$("#searchExamValue").val("");
		//클릭한 목록의 학생이름 가져오기 & 출력
		var memberName=$(this).text().trim();
		var className=$("#tab2_className").text().trim();
		$("#tab2_studentName").text(memberName);
		//학생 목록의 인덱스 가져오기
		var memberIndex=$(".tab2studentListMembers").index(this);
		//ajax 시험 정보 요청할 parameter
		memberName=studentArr[memberIndex].member_name;
		className=studentArr[memberIndex].class_name;
		
		tab2Ajax();
	});
	
	//학생목록 이벤트 종료
	$("#searchExamValue").keyup(function(){	
		$("#studentExamTable").empty();
		var inputKey=$("#searchExamValue").val();
		var studentExamScoreSrc="";
		$(tab2AjaxData).each(function(index, element){
			var smCtgr="";
			if(element.exam_info_name.match(inputKey) || element.smCtgrName.toString().match(inputKey) ||
					element.exam_info_date.match(inputKey)){//시험명, 소분류, 날짜 검색
				$(element.smCtgrName).each(function(index, name){ //소분류 추출
					smCtgr += name+'&nbsp;&nbsp;';
				});
				studentExamScoreSrc += '<tr class="unread"><td class="view-message">';
				studentExamScoreSrc += '<img src="${pageContext.request.contextPath}/img/friends/fr-05.jpg" class="img-thumbnail" width="150"></td>';
				studentExamScoreSrc += '<td class="view-message "><h3 class="tab2_examPaper">'+element.exam_info_name+'</h3>';
				studentExamScoreSrc += '<p>'+smCtgr+'</p></td>';
				studentExamScoreSrc += '<td class="view-message  text-right"><p class="tab2_examDate">시험 날짜 : '+element.exam_info_date+'</p>';
				studentExamScoreSrc += '<p class="tab2_examTime">시험 시간 : '+element.exam_info_start+'~'+element.exam_info_end+'</p><p>('+element.exam_info_time+')</p></td>';
				studentExamScoreSrc += '<td class="view-message  inbox-small-cells">';
				studentExamScoreSrc += '<button type="button" class="btn btn-round btn-info">성적확인</button></td></tr>';
			}
		});
		$("#studentExamTable").append(studentExamScoreSrc);
	})
		
	/*지난 시험지 보기*/

	$(document).on('click', '#pastExamBtn', function(){	//	ajax로 가져온 버튼이 안 먹을 때 click 이벤트		
		var popUrl = "${pageContext.request.contextPath}/student/pastExamPaper.do?exam_info_num=" + $(this).val();
		var popOption = "width=1000px, resizable=no, location=no, left=50px, top=100px";
		window.open(popUrl, "지난 시험보기",popOption);		
	});
	
	//첫화면 차트
	function functionChart(){
		//각 시험 성적 바 차트 시작				
		var ctx = document.getElementById('bar1').getContext('2d');
		var myBarChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
		      labels: chartLabels,
		      datasets: [
		        {
		          label: "반 평균",
		          backgroundColor: 'rgb(255, 99, 132)',
		          borderColor: 'rgb(255, 99, 132)',
		          data: chartClassDatas
		        }
		      ]
		    },
		    options:{
		      layout: {
		          padding: {
		              left: 10,
		              right: 10,
		              top: 10,
		              bottom: 10
		          }
		      },
		      scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
		    	
		        yAxes: [{
		         ticks: {
		             max: 100,
		             min: 0,
		             stepSize: 10
		         }
		     }]
		       },
		       tooltips: {
		    	    enabled: true,
		    	    mode: 'label',
		    	    callbacks: {
		    	      title: function(tooltipItems, data) {
		    	        var idx = tooltipItems[0].index;
		    	        return data.labels[idx];
		    	      }
		    	    }
		    	  },		       
		       
		    }
		});
		//각 시험 성적 바 차트 끝
		
		//반/학생 평균 선 차트 시작
		var ctx = document.getElementById('line1').getContext('2d');
		var chart = new Chart(ctx, {
		  // The type of chart we want to create
		  type: 'line',
		  // The data for our dataset
		  data: {
		      labels: chartLabels,
		      datasets: [
		        {
		          label: "반 평균 성적",
		          backgroundColor: 'rgb(255, 99, 132)',
		          borderColor: 'rgb(255, 99, 132)',
		          fill : false,
		          lineTension : 0,
		          data: chartClassDatas,
		      },
		      {
		          label: "학생 성적",
		          backgroundColor: 'rgb(122, 99, 132)',
		          borderColor: 'rgb(122, 99, 132)',
		          fill : false,
		          lineTension : 0,
		          data: chartStudentDatas,
		        }
		      ]
		    },
		    options: {
		        scale: {
		            ticks: {
		              beginAtZero:true,
		                min:0,
		                max:100
		            }
		        },
		        layout: {
		            padding: {
		                left: 10,
		                right: 10,
		                top: 10,
		                bottom: 10
		            }
		        },
		        scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
		          yAxes: [{
		           ticks: {
		               max: 100,
		               min: 0,
		               stepSize: 10
		           }
		       }]
		         },
			       tooltips: {
			    	    enabled: true,
			    	    mode: 'label',
			    	    callbacks: {
			    	      title: function(tooltipItems, data) {
			    	        var idx = tooltipItems[0].index;
			    	        return data.labels[idx];
			    	      }
			    	    }
			    	  },		         
		        
		    }
		});
		//반/학생 평균 선 차트 끝
	}
	//첫화면 차트
	
	//클래스 통계화면 첫 차트 시작
	function functionChart2(){
		var ctx = document.getElementById('bar2').getContext('2d');
		var myBarChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: chartLabels,
				datasets: [
					{
						label: "각 시험 평균",
						backgroundColor: 'rgb(255, 99, 132)',
						borderColor: 'rgb(255, 99, 132)',
						data: chartClassDatas,
					}
					]
			},
			options:{
				layout: {
					padding: {
						left: 10,
						right: 10,
						top: 10,
						bottom: 10
					}
				},
				scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
					yAxes: [{
						ticks: {
							max: 100,
							min: 0,
							stepSize: 10
						}
					}]
				},
			       tooltips: {
			    	    enabled: true,
			    	    mode: 'label',
			    	    callbacks: {
			    	      title: function(tooltipItems, data) {
			    	        var idx = tooltipItems[0].index;
			    	        return data.labels[idx];
			    	      }
			    	    }
			    	  },				
			}
		});
	} //클래스 통계화면 첫 차트 끝
	
	// 시험문제 목록 선택 시작
	$("#searchExam").change(function() {
		$("#searchExam option:selected").each(function () {
			examInfoName=$("#searchExam option:selected").text();
			rankTable.ajax.reload();
		});
	});
	
	
	//양회준 10.29 점수별 학생분포
	$("#searchSpread").change(function() {
		$("#searchSpread option:selected").each(function () {
			examInfoNum=$("#searchSpread option:selected").val();
			spreadChart();
		});
	});
	
	function spreadChart(){
	//점수별 학생분포
		$.ajax({
			type:"post",
			url:"studentScoreSpread.do",
			data:{
				"exam_info_num":examInfoNum,
				"class_name":className				  
				},
			datatype:"json",
			success:function(data){
				var ctx = document.getElementById('line2').getContext('2d');
				var myBarChart = new Chart(ctx, {
				    type: 'line',
				    
				    data: {
				      labels: ["0~10", "11~20", "21~30", "31~40", "41~50", "51~60", 
				    	  "61~70", "71~80", "81~90", "91~100"],
				      datasets: [
				        {
				          label: className,
				          backgroundColor: 'rgb(196, 128, 96)',
				          borderColor: 'rgb(255, 99, 132)',
				          lineTension: 0 ,
				          fill : false,
				          data: data,
				        }
				      ]
				    },
				    options:{
				      layout: {
				          padding: {
				              left: 10,
				              right: 10,
				              top: 10,
				              bottom: 10
				          }
				      }
				    }
				});					
			},
			error:function(error){
				console.log("실패3:"+status);
			}
		});
	}
})
</script>