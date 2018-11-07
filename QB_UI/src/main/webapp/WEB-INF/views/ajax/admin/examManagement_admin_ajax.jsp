<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

	<c:forEach items="${classList}" var="classlist">
	<form action="" method="post" id="pickMyExamPaperForm">

		<div class="col-lg-12">

			<!-- 시험지 하나의 div 시작 -->
			<div id="myExamPaperDiv">
			
					<!-- 시험지 한 개 시작 -->
					<div class="exam-paper-name">
		
						<h4 class="miri" id="${classlist.exam_paper_num}"
							data-target="#exam_preview" data-toggle="modal">
							<strong>${classlist.exam_paper_name}</strong>
							<se:authorize access="hasRole('ROLE_ADMIN')">
							<span> ( 출제자 : ${classlist.member_id } / ${classlist.class_name } )</span>
							</se:authorize>
						</h4>
						<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${classlist.exam_paper_desc}

						<div class="pdf_download text-right">
							<a href="#">PDF 다운로드 <img src="../img/file-download.png"></a>
							<button type="button" id="${classlist.exam_paper_num}"
								class="btn btn-theme04 buttonGroup" onclick="deleteExamCheck()"
								value="${classlist.exam_paper_name }">삭제</button>
							<button type="button" id="${classlist.exam_paper_num}"
								class="btn btn-theme buttonGroup" onclick="updateExamCheck()">시험지수정</button>
							<se:authorize access="hasRole('ROLE_TEACHER')">
							<button type="button" class="btn btn-theme buttonGroup"
								onclick="location.href='examScheduleRegist.do?exam_paper_num=${classlist.exam_paper_num}&exam_paper_name=${classlist.exam_paper_name}'">시험등록</button>
							</se:authorize>
							<input type="hidden" id="hidden_class_num"
								value='${param.class_num}'>
						</div>
						<hr>
					</div>
		
			</div>
		</div>
	</form>
</c:forEach>

<script>
$(document).ready(function(){
	$('.miri').click(function(){
		var exam_paper_num = $(this).attr('id');
		
			 $.ajax({
				  url : "../teacher/examMiri.do",
				  type:'GET',
				  data : {
					  'exam_paper_num' : exam_paper_num
				  },
				  dataType:"html",
				  success:function(data){
					  $('.book').html(data);
				  }
			   });
	   });

});
</script>