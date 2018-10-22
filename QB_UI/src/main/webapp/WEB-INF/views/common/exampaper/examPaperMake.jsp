<%-- 
   @JSP:examPaperMake.jsp
   @DATE:2018-10-11
   @Author:김현이
   @Desc:강사-시험지 생성 페이지(스토리보드 24 of 41) --> 시험관리 탭에서 하나의 페이지로 따로 빼냈음
 --%>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${pageContext.request.contextPath}/css/examPaperMake.css"
   rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.dpn{
	display:none;
}
.ppp{
	background-color:yellow;
}

</style>
<section id="main-content">
   <section class="wrapper">
      <div class="row mt">
         <div class="col-lg-12">
            <div class="row content-panel">
               <div class="panel-body">
                  <div class="row">
                     <div class="col-lg-6">
                        <h3>문항 검색</h3>
                        <input type="hidden" class="dpn1" value="${memberDto.member_id}" />
                        <input type="hidden" class="dpn_EPN" value="" />
                        <div class="makeExamFirstRow">
                           <hr>
                           <select class="form-control makeExamSelectCategory" name="question_lg_category" id="question_lg_category">
                                 <option value="">대분류</option>
                              <c:forEach items="${list1}" var="lgCategoryList">
                                 <option value="${lgCategoryList.lg_category_code}">${lgCategoryList.lg_category_name}</option>
                              </c:forEach>
                           </select> 
                           <select class="form-control makeExamSelectCategory" name="question_md_category" id="question_md_category">
                                 <option value="">중분류</option>
                           </select> 
                           <select class="form-control makeExamSelectCategory" name="question_sm_category" id="question_sm_category">
                                 <option value="">소분류</option>
                           </select> 
                           <select class="form-control makeExamSelectCategory" name="level_type" id="level_type">
                              <option value="">난이도</option>
                              <c:forEach items="${levellist}" var="levellist">
                                 <option value="${levellist.level_code}">${levellist.level_name}</option>
                              </c:forEach>
                           </select> <select class="form-control makeExamSelectCategory" id="questiontype" name="questionType">
                              <option value="">문제타입</option>
                              <option value="">전체</option>
                              <option value="객관식">객관식</option>
                              <option value="단답형">단답형</option>
                           </select> <br> <input type="text"
                              class="form-control makeExamTextField"
                              placeholder="키워드를 입력하세요." id="keyword" name="keyword"> <input type="button"
                              class="btn btn-theme" value="검색" id="questionsearch">
                        </div>
                        <hr>
                     </div>
                     <div class="col-lg-6">
                        <h3>시험 출제 문항</h3>
                        <div class="makeExamFirstRow">
                           <hr>
                           <div id="makeExamFirstRowText">
                              <div> 출제된 문항 수 : <span id="qnum">0</span></div><br><div> 현재 총 배점 : <span id="qcore">0</span> / 100 </div>
                           </div>
                        </div>
                        <hr>
                     </div>

                  </div>
                  <!-- div 윗 줄의 문항검색 부분  -->


                  <div class="row">
                     <div class="col-lg-6" id="leftMakeExamDiv">
                        <form aciton="" method="post" id="pickQuestionForm" onsubmit="return false;">
                           
                           
                           <!-- 문제 하나의 div 시작  -->
                           <div id="questions">

                           </div>
                           
                           
                        </form>
                     </div>

                     <!-- 화면의 오른 쪽, 시험 출제 문항 부분이다  -->
                     <div class="col-lg-6" id="rightMakeExamDiv">
                        <!--  시험문제 배치 드래그 앤 드롭-->
                        <form aciton="" method="post" id="makeExamForm">
                           <div class="task-content">
                              <ul id="sortable" class="task-list selectedBox">
                              </ul>
                           </div>
                        </form>
                     </div>
                  </div>
                  <!-- div class="row" 끝 -->
                  <div class="row questionRowBtnDiv">
                     <div class="col-lg-6 pickQuestionBtnDiv">
                        <input type="button" class="btn btn-theme" value="선택출제"
                           id="pickQuestionBtn">
                     </div>
                     <div class="col-lg-6 makeExamBtnDiv">
                        <input type="button" class="btn btn-theme04" value="선택문제 삭제"
                           id="pickQuestionDeleteBtn">
                           <input type="button"
                           class="btn btn-theme" value="임시저장" data-toggle="modal"
                           data-target="#pickQuestionTempSaveModal"
                           id="pickQuestionTempSaveModalBtn">
                           <input type="hidden" id="copyTempSave" value="">
                        <!-- 한결 - 10.10 시험지 미리보기 페이지 추가-->
                        <button class="btn btn-theme" data-target="#exam_preview"
                           data-toggle="modal" id="miriBtn">시험지 미리보기</button>
                        <div id="exam_preview" class="modal fade modal_preview">
                           <div class="modal-dialog" style="width: 70%;">
                              <!-- 임시 데이터  실제 데이터는 백그라운드에서 가져와 스크립트부분에서 append방식.-->
                              <div class="row mt">
                                 <div class="col-lg-12">
                                    <div class="">
                                       <div class="row content-panel">
                                          <div id="timerblock">
                                             <h3 class="mb exampaneldetailsubject">
                                                <i class="fa fa-angle-right"></i> 비트캠프109기-JAVA기본
                                             </h3>

                                          </div>

                                          <hr>
                                          
                                          
                                          <!-- 미리보기  -->
                                          <div class="panel-body">
                                             <div class="row content-panel exampaneldetailed">
                                                <div class="col-lg-6" id="examBox"
                                                   style="border-right: 1px solid black;">
                                                   
                                                   <div id="mirileft" style="text-align: left; padding-top: 10px;">
                                                      
                                                   </div>
                                                </div>
                                                <div class="col-lg-6">
                                                   <div id="miriright" style="text-align: left;">
                                                      
                                                   </div>
                                                   
                                                </div>

                                             </div>
                                             <button
                                                class="btn btn-large btn-primary exampaneldetailBtn"
                                                data-dismiss="modal">확인</button>
                                          </div>
                                          
                                          <!-- 미리보기  끝 -->
                                          
                                          
                                       </div>
                                    </div>
                                 </div>

                              </div>

                           </div>
                        </div>
                        <!-- <input type="button" class="btn btn-theme" value="시험지 생성"
                           data-toggle="modal" data-target="#makeExamSubmitModal"
                           id="makeExamSubmitModalBtn"> -->
                        <input type="button" class="btn btn-theme" value="시험지 생성"
                        id="makeExamSubmitModalBtn">
                     </div>
                  </div>
                  <!-- 모달창 -->
                  <!-- 임시저장 모달 -->
                  <div class="modal fade" id="pickQuestionTempSaveModal"
                     tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                     aria-hidden="true">
                     <div class="modal-dialog">
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal"
                                 aria-hidden="true">&times;</button>
                              <h4 class="modal-title" id="myModalLabel">시험지 임시저장</h4>
                              <input type="hidden" id="saveEP" value="0"/>
                           </div>
                           <form action="" method="post">
                              <div class="modal-body">

                                 시험지 이름 <input type="text" class="form-control exam-paper-name"
                                    placeholder="시험지 이름을 입력하세요." name=""><br> 시험지
                                 설명
                                 <textarea type="textarea" class="form-control exam-paper-desc"
                                    placeholder="시험지 설명을 입력하세요." name=""></textarea>
                              </div>
                              <div class="modal-footer">
                                 <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                       <!-- <input type="button" class="btn btn-theme"
                                          data-toggle="modal" data-dismiss="modal" value="임시저장"
                                          id="pickQuestionTempSaveBtn"> -->
                                       <input type="button" class="btn btn-theme" value="임시저장"
                                          id="pickQuestionTempSaveBtn" onclick="makeExamSubmitBtn(0)"> <input type="button"
                                          class="btn btn-theme04" data-dismiss="modal" value="취소">
                                    </div>
                                 </div>
                              </div>
                           </form>
                        </div>
                     </div>
                  </div>
                  <!-- 시험지 생성 모달 -->
                  <div class="modal fade" id="makeExamSubmitModal" tabindex="-1"
                     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                     <div class="modal-dialog">
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal"
                                 aria-hidden="true">&times;</button>
                              <h4 class="modal-title" id="myModalLabel">시험지 생성</h4>
                              <input type="hidden" id="createEP" value="1"/>
                           </div>
                           <form action="" method="post">
                              <div class="modal-body">

                                 시험지 이름 <input type="text" class="form-control createEPaper"
                                    placeholder="시험지 이름을 입력하세요." name=""><br> 시험지
                                 설명
                                 <textarea type="textarea" class="form-control createEPDesc"
                                    placeholder="시험지 설명을 입력하세요." name=""></textarea>
                              </div>
                              <div class="modal-footer">
                                 <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                       <!-- <input type="button" class="btn btn-theme"
                                          data-toggle="modal" data-dismiss="modal" value="시험지 생성"
                                          id="makeExamSubmitBtn" onclick="makeExamSubmitBtn(1)"> -->
                                          <!-- <input type="button" class="btn btn-theme" value="시험지 생성"
                                          id="makeExamSubmitBtn" onclick="makeExamSubmitBtn('1')" /> -->
                                          <input type="button" class="btn btn-theme" value="시험지 생성"
                                          id="makeExamSubmitBtn1" onclick="makeExamSubmitBtn(1)">
                                          <input type="button"
                                          class="btn btn-theme04" data-dismiss="modal" value="취소">
                                    </div>
                                 </div>
                              </div>
                           </form>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
   <!-- /wrapper -->
</section>
   <!-- /wrapper -->

<script>
$(document).ready(function(){
	
	$.ajax({
		url : "questionListView.do",
		type:'GET',
		dataType:"html",
		success:function(data){
			$('#questions').html(data);
		},
		error : function(error) {
			console.log("===========실패");
		}
	})
   $('#question_lg_category').change(function(){
      $('#question_md_category').children('option:not(:first)').remove();
      $('#question_sm_category').children('option:not(:first)').remove();
      <c:forEach items="${list2}" var="mdlist">
      if(document.getElementById("question_lg_category").value == "${mdlist.lg_category_code}"){
         $('#question_md_category').append("<option value=${mdlist.md_category_code}><div class='dpn' style='display:none;' value='${mdlist.lg_category_code}'></div>${mdlist.md_category_name}</option>")
      }
      </c:forEach>
      /* console.log("this  // " + $(this).val());
      console.log("Q // "+$('.lg-dpn').val());
      if($(this).val()== $('.lg-dpn').val()){
    	  $('.lg-dpn').parents('.questionDiv').addClass("ppp");
      }  */
   });
   
   $('#question_md_category').change(function(){
      $('#question_sm_category').children('option:not(:first)').remove();
      <c:forEach items="${list3}" var="smlist">
      if(document.getElementById("question_md_category").value == "${smlist.md_category_code}"){
         $('#question_sm_category').append("<option value=${smlist.sm_category_code}>${smlist.sm_category_name}</option>")
      }
      </c:forEach>
   });
   $('#questionsearch').click(function(){
	   var lgsearchtype = document.getElementById("question_lg_category").value;
	   var mdsearchtype = document.getElementById("question_md_category").value;
	   var smsearchtype = document.getElementById("question_sm_category").value;
	   var leveltype = document.getElementById("level_type").value;
	   var questiontype = document.getElementById("questiontype").value;
	   var keyword = $("#keyword").val();
	   
	   console.log(keyword);
	   
		$.ajax({
			  url : "questionSearch.do",
			  type:'GET',
			  data : {
				  'lgsearchtype' : lgsearchtype,
				  'mdsearchtype' : mdsearchtype,
				  'smsearchtype' : smsearchtype,
				  'leveltype' : leveltype,
				  'questiontype' : questiontype,
				  'keyword' : keyword
			  },
			  dataType:"html",
			  success:function(data){
				  $('#questions').html(data);
			  }
		   });
   });
})

</script>

<!-- /MAIN CONTENT -->
<script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
<script src="${pageContext.request.contextPath}/lib/tasks.js"
   type="text/javascript"></script>
<script
   src="${pageContext.request.contextPath}/lib/onet-js/examPaperMake.js"
   type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script> <!-- layout.jsp 에서 cdn으로 걸은 jquery-3.3.1가 안 먹혀서 다시 걸음 -->