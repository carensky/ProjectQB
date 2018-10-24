/**
 * 18.10.21 재훈 questionUpdate.js 파일 추가 
 */



/*문제 수정 페이지 시작 */
/*페이지 로드시 수정할 문제 정보 관련 함수*/
$(function() {
		var _choiceInput1 ="<b><input type='text' name='question_choice_num' value='1' style='display: none'>1.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='1번 보기 내용을 입력해주세요.' id='question_choice_content1'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
		var _choiceInput2 ="<b><input type='text' name='question_choice_num' value='2' style='display: none'>2.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='2번 보기 내용을 입력해주세요.' id='question_choice_content2'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
		var _choiceInput3 ="<b><input type='text' name='question_choice_num' value='3' style='display: none'>3.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='3번 보기 내용을 입력해주세요.' id='question_choice_content3'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
		var _choiceInput4 ="<b><input type='text' name='question_choice_num' value='4' style='display: none'>4.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='4번 보기 내용을 입력해주세요.' id='question_choice_content4'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
		var _choiceInput5 ="<b><input type='text' name='question_choice_num' value='5' style='display: none'>5.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='5번 보기 내용을 입력해주세요.' id='question_choice_content5'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
		var _answerBtn1 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio" name="question_answer" value=""  > 1번 </label>&nbsp;&nbsp;'
		var _answerBtn2 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio2" name="question_answer" value="2"  >2번 </label>&nbsp;&nbsp;'
		var _answerBtn3 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio3" name="question_answer" value="3"  >3번 </label>&nbsp;&nbsp;'
		var _answerBtn4 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio4" name="question_answer" value="4"  >4번 </label>&nbsp;&nbsp;'
		var _answerBtn5 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio5" name="question_answer" value="5"  >5번 </label>&nbsp;&nbsp;'
		var _questionType = $("input[type=radio][name=question_type]:checked").val();
		var qdto_question_answer = $("input[type=text][name=qdto_question_answer]").val();
		
		if ($.trim(_questionType) == "단답형"){
			document.all["questionChoice"].style.display = 'none'; // 안보이게
			document.all["questionShortAnswer"].style.display = ''; // 보이게
			$("#questionAnswerRadio1").attr("disabled", true);
	        $("#questionAnswerRadio2").attr("disabled", true);
	        $("#questionAnswerRadio3").attr("disabled", true);
	        $("#questionAnswerRadio4").attr("disabled", true);
	        $("#questionAnswerRadio5").attr("disabled", true);
			$("#questionType2Answer").attr("disabled", false);
			$("#choiceInput").attr("disabled", true);
			
		} else if($.trim(_questionType) == "객관식"){
			
			document.all["questionChoice"].style.display = ''; // 보이게
			document.all["questionShortAnswer"].style.display = 'none'; // 안보이게
	        $("#questionAnswerRadio1").attr("disabled", false);
	        $("#questionAnswerRadio2").attr("disabled", false);
	        $("#questionAnswerRadio3").attr("disabled", false);
	        $("#questionAnswerRadio4").attr("disabled", false);
	        $("#questionAnswerRadio5").attr("disabled", false);
	        $("#questionType2Answer").attr("disabled", true);
	        $("#howManyChoices").attr("disabled",false);
	        $("#choiceInput").attr("disabled", false);
	        
			if (document.getElementById("howManyChoices").value == "2") {
				var cdto_qcc1 = document.getElementsByName("cdto_question_choice_content")[0].value;
				var cdto_qcc2 = document.getElementsByName("cdto_question_choice_content")[1].value;
					$('#choiceInput').append(_choiceInput1);
					$('#choiceInput').append(_choiceInput2);
					$('#answerChoiceText').append(_answerBtn1);
					$('#answerChoiceText').append(_answerBtn2);
					$('#question_choice_content1').val(cdto_qcc1);
					$('#question_choice_content2').val(cdto_qcc2);
				
					if($.trim(qdto_question_answer) == "1"){
						$('#questionAnswerRadio').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "2"){
						$('#questionAnswerRadio2').prop("checked",true);
					}
				}
			if (document.getElementById("howManyChoices").value == "3") {
				var cdto_qcc1 = document.getElementsByName("cdto_question_choice_content")[0].value;
				var cdto_qcc2 = document.getElementsByName("cdto_question_choice_content")[1].value;
				var cdto_qcc3 = document.getElementsByName("cdto_question_choice_content")[2].value;
					$('#choiceInput').append(_choiceInput1);
					$('#choiceInput').append(_choiceInput2);
					$('#choiceInput').append(_choiceInput3);
					$('#answerChoiceText').append(_answerBtn1);
					$('#answerChoiceText').append(_answerBtn2);
					$('#answerChoiceText').append(_answerBtn3);
					$('#question_choice_content1').val(cdto_qcc1);
					$('#question_choice_content2').val(cdto_qcc2);
					$('#question_choice_content3').val(cdto_qcc3);
					
					if($.trim(qdto_question_answer) == "1"){
						$('#questionAnswerRadio').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "2"){
						$('#questionAnswerRadio2').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "3"){
						$('#questionAnswerRadio3').prop("checked",true);
					}
				}
			if (document.getElementById("howManyChoices").value == "4") {
				var cdto_qcc1 = document.getElementsByName("cdto_question_choice_content")[0].value;
				var cdto_qcc2 = document.getElementsByName("cdto_question_choice_content")[1].value;
				var cdto_qcc3 = document.getElementsByName("cdto_question_choice_content")[2].value;
				var cdto_qcc4 = document.getElementsByName("cdto_question_choice_content")[3].value;
					$('#choiceInput').append(_choiceInput1);
					$('#choiceInput').append(_choiceInput2);
					$('#choiceInput').append(_choiceInput3);
					$('#choiceInput').append(_choiceInput4);
					$('#answerChoiceText').append(_answerBtn1);
					$('#answerChoiceText').append(_answerBtn2);
					$('#answerChoiceText').append(_answerBtn3);
					$('#answerChoiceText').append(_answerBtn4);
					$('#question_choice_content1').val(cdto_qcc1);
					$('#question_choice_content2').val(cdto_qcc2);
					$('#question_choice_content3').val(cdto_qcc3);
					$('#question_choice_content4').val(cdto_qcc4);
					
					if($.trim(qdto_question_answer) == "1"){
						$('#questionAnswerRadio').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "2"){
						$('#questionAnswerRadio2').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "3"){
						$('#questionAnswerRadio3').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "4"){
						$('#questionAnswerRadio4').prop("checked",true);
					}
				}	
			if (document.getElementById("howManyChoices").value == "5") {
				var cdto_qcc1 = document.getElementsByName("cdto_question_choice_content")[0].value;
				var cdto_qcc2 = document.getElementsByName("cdto_question_choice_content")[1].value;
				var cdto_qcc3 = document.getElementsByName("cdto_question_choice_content")[2].value;
				var cdto_qcc4 = document.getElementsByName("cdto_question_choice_content")[3].value;
				var cdto_qcc5 = document.getElementsByName("cdto_question_choice_content")[4].value;
					$('#choiceInput').append(_choiceInput1);
					$('#choiceInput').append(_choiceInput2);
					$('#choiceInput').append(_choiceInput3);
					$('#choiceInput').append(_choiceInput4);
					$('#choiceInput').append(_choiceInput5);
					$('#answerChoiceText').append(_answerBtn1);
					$('#answerChoiceText').append(_answerBtn2);
					$('#answerChoiceText').append(_answerBtn3);
					$('#answerChoiceText').append(_answerBtn4);
					$('#answerChoiceText').append(_answerBtn5);
					$('#question_choice_content1').val(cdto_qcc1);
					$('#question_choice_content2').val(cdto_qcc2);
					$('#question_choice_content3').val(cdto_qcc3);
					$('#question_choice_content4').val(cdto_qcc4);
					$('#question_choice_content5').val(cdto_qcc5);
					
					if($.trim(qdto_question_answer) == "1"){
						$('#questionAnswerRadio').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "2"){
						$('#questionAnswerRadio2').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "3"){
						$('#questionAnswerRadio3').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "4"){
						$('#questionAnswerRadio4').prop("checked",true);
					}
					if($.trim(qdto_question_answer) == "5"){
						$('#questionAnswerRadio5').prop("checked",true);
					}
					
				}
		}
})

/*문제 타입 (객관식, 단답형) 변경 시 정답 입력 div 변경*/
$(function() {
	$("#question_type_1").click(function(){ 
		document.all["questionChoice"].style.display = ''; // 보이게
		document.all["questionShortAnswer"].style.display = 'none'; // 안보이게
        $("#questionAnswerRadio1").attr("disabled", false);
        $("#questionAnswerRadio2").attr("disabled", false);
        $("#questionAnswerRadio3").attr("disabled", false);
        $("#questionAnswerRadio4").attr("disabled", false);
        $("#questionAnswerRadio5").attr("disabled", false);
        $("#questionType2Answer").attr("disabled", true);
        $("#howManyChoices").attr("disabled",false);
        $("#choiceInput").attr("disabled", false);
        $("#howManyChoices").val("10");
        
   });
   $("#question_type_2").click(function(){
		document.all["questionChoice"].style.display = 'none'; // 안보이게
		document.all["questionShortAnswer"].style.display = ''; // 보이게
		$("#questionAnswerRadio1").attr("disabled", true);
        $("#questionAnswerRadio2").attr("disabled", true);
        $("#questionAnswerRadio3").attr("disabled", true);
        $("#questionAnswerRadio4").attr("disabled", true);
        $("#questionAnswerRadio5").attr("disabled", true);
		$("#questionType2Answer").attr("disabled", false);
		$("#howManyChoices").attr("disabled",true);
		$("#choiceInput").attr("disabled", true);
   });
});

/*객관식 문제 보기 개수 셀렉트박스 값 변경*/
$('#howManyChoices').change(
		function() {
			var remove = document.getElementById("choiceInput");
			remove.innerHTML="";
			var remove1 = document.getElementById("answerChoiceText");
			remove1.innerHTML="";
														
			var _choiceInput1 ="<b><input type='text' name='question_choice_num' value='1' style='display: none'>1.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='1번 보기 내용을 입력해주세요.' id='question_choice_content1'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
			var _choiceInput2 ="<b><input type='text' name='question_choice_num' value='2' style='display: none'>2.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='2번 보기 내용을 입력해주세요.' id='question_choice_content2'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
			var _choiceInput3 ="<b><input type='text' name='question_choice_num' value='3' style='display: none'>3.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='3번 보기 내용을 입력해주세요.' id='question_choice_content3'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
			var _choiceInput4 ="<b><input type='text' name='question_choice_num' value='4' style='display: none'>4.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='4번 보기 내용을 입력해주세요.' id='question_choice_content4'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
			var _choiceInput5 ="<b><input type='text' name='question_choice_num' value='5' style='display: none'>5.</b> <input type='text' name='question_choice_content' class='form-control-inline' placeholder='5번 보기 내용을 입력해주세요.' id='question_choice_content5'> <span class='fileupload fileupload-new imageup' data-provides='fileupload'> <div class='fileupload-preview fileupload-exists thumbnail' style='max-width: 300px; max-height: 180px; line-height: 20px;'></div> <span>  <span class='btn btn-theme02 btn-file'> <span class='fileupload-new'> <i class='fa fa-paperclip'></i>image </span> <span class='fileupload-exists'><i class='fa fa-undo'></i>Change </span>  <input type='file' class='default' /> </span> <a href='' class='btn btn-theme04 fileupload-exists' data-dismiss='fileupload'><i class='fa fa-trash-o'></i> Remove</a> </span> </span><br>"
			var _answerBtn1 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio" name="question_answer" value=""  > 1번 </label>&nbsp;&nbsp;'
			var _answerBtn2 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio2" name="question_answer" value="2"  >2번 </label>&nbsp;&nbsp;'
			var _answerBtn3 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio3" name="question_answer" value="3"  >3번 </label>&nbsp;&nbsp;'
			var _answerBtn4 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio4" name="question_answer" value="4"  >4번 </label>&nbsp;&nbsp;'
			var _answerBtn5 ='<label class="questionChoiceRadioButton"> <input type="radio" id="questionAnswerRadio5" name="question_answer" value="5"  >5번 </label>&nbsp;&nbsp;'
			var qdto_question_answer = $("input[type=text][name=qdto_question_answer]").val();
			console.log($.trim(qdto_question_answer));
									
			if (document.getElementById("howManyChoices").value == "2") {
				$('#choiceInput').append(_choiceInput1);
				$('#choiceInput').append(_choiceInput2);
				$('#answerChoiceText').append(_answerBtn1);
				$('#answerChoiceText').append(_answerBtn2);
									
				if($.trim(qdto_question_answer) == "1"){
					$('#questionAnswerRadio').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "2"){
					$('#questionAnswerRadio2').prop("checked",true);
				}
			}
			
			if (document.getElementById("howManyChoices").value == "3") {
				$('#choiceInput').append(_choiceInput1);
				$('#choiceInput').append(_choiceInput2);
				$('#choiceInput').append(_choiceInput3);
				$('#answerChoiceText').append(_answerBtn1);
				$('#answerChoiceText').append(_answerBtn2);
				$('#answerChoiceText').append(_answerBtn3);
									
				if($.trim(qdto_question_answer) == "1"){
					$('#questionAnswerRadio').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "2"){
					$('#questionAnswerRadio2').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "3"){
					$('#questionAnswerRadio3').prop("checked",true);
				}
			}
			if (document.getElementById("howManyChoices").value == "4") {
				$('#choiceInput').append(_choiceInput1);
				$('#choiceInput').append(_choiceInput2);
				$('#choiceInput').append(_choiceInput3);
				$('#choiceInput').append(_choiceInput4);
				$('#answerChoiceText').append(_answerBtn1);
				$('#answerChoiceText').append(_answerBtn2);
				$('#answerChoiceText').append(_answerBtn3);
				$('#answerChoiceText').append(_answerBtn4);
			
				
				if($.trim(qdto_question_answer) == "1"){
					$('#questionAnswerRadio').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "2"){
					$('#questionAnswerRadio2').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "3"){
					$('#questionAnswerRadio3').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "4"){
					$('#questionAnswerRadio4').prop("checked",true);
				}
			}	
			if (document.getElementById("howManyChoices").value == "5") {
				$('#choiceInput').append(_choiceInput1);
				$('#choiceInput').append(_choiceInput2);
				$('#choiceInput').append(_choiceInput3);
				$('#choiceInput').append(_choiceInput4);
				$('#choiceInput').append(_choiceInput5);
				$('#answerChoiceText').append(_answerBtn1);
				$('#answerChoiceText').append(_answerBtn2);
				$('#answerChoiceText').append(_answerBtn3);
				$('#answerChoiceText').append(_answerBtn4);
				$('#answerChoiceText').append(_answerBtn5);
		
				if($.trim(qdto_question_answer) == "1"){
					$('#questionAnswerRadio').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "2"){
					$('#questionAnswerRadio2').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "3"){
					$('#questionAnswerRadio3').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "4"){
					$('#questionAnswerRadio4').prop("checked",true);
				}
				if($.trim(qdto_question_answer) == "5"){
					$('#questionAnswerRadio5').prop("checked",true);
				}
										
			}
	})	

/* 취소 버튼 */
$("#btnUpdateCancel").click(function(){
	location.href="questionManagement.do"
})

/* 문제 삭제 버튼*/
$('#singleDeleteModal').on('show.bs.modal', function(question_num){
	action='modify';
	type='PUT';
	var question_num = $('#qdto_question_num').val();  //question_num 받아오기
	console.log (question_num); 
	$('#singleDeleteConfirmBtn').val(question_num); //버튼에 value값을 가져온 question_num으로 넣어준다
})

$('#singleDeleteConfirmBtn').click(function(){
	var question_num = document.getElementById('singleDeleteConfirmBtn').value;
		
		$.ajax({
			url : "singleQuestionDelete.do",
			type:'post',
			data : {
					 'question_num' : question_num
					},
			success:function(data){
				if((data.result)=="삭제가능"){
					swal({
						title: "문제가 삭제되었습니다.",
						text: "",
						icon: "success"
					}).then(function(){
						window.location = "questionManagement.do"
					});
				}else{
					swal("문제를 삭제 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
				}
			},
			error: function(error){
				swal('문제 삭제 도중 에러가 발생했습니다.')
			}
		})
})	

/* 문제 수정 완료 버튼 - 유효성 검사 */
function check(){
	
	var _smCategory = $("#question_sm_category2 option:selected").val();
	var _questionLevel = $("#level_type2 option:selected").val();
	var _questionName = $("input[type=text][name=question_name]").val();
	var _questionChoiceAnswer = $("input[type=radio][name=question_answer]:checked").val();
	var _questionChoiceContent1 = $("input[type=text][id=question_choice_content1]").val();
	var _questionChoiceContent2 = $("input[type=text][id=question_choice_content2]").val();
	var _questionChoiceContent3 = $("input[type=text][id=question_choice_content3]").val();
	var _questionChoiceContent4 = $("input[type=text][id=question_choice_content4]").val();
	var _questionChoiceContent5 = $("input[type=text][id=question_choice_content5]").val();
	var _shortAnswerQuestion = $("input[type=radio][name=question_type]:checked").val();
	var _choiceQuantity = document.getElementById("howManyChoices").value;
	var question_num = $('#qdto_question_num').val();
	
	if ($.trim(_shortAnswerQuestion) == "객관식") {
		/*객관식 문제 유효성검사*/
		if ($.trim(_smCategory) == "") {
			swal("문제의 대,중,소 분류를 선택해주세요");
			document.getElementById("question_sm_category2").focus();
			return false;
		} else if ($.trim(_questionChoiceAnswer) == "") {
			swal("문제의 정답을 선택해주세요");
			return false;
		} else if ($.trim(_questionLevel) == "") {
			swal("문제의 난이도를 선택해주세요");
			document.getElementById("level_type2").focus();
			return false;
		/*객관식 문제 보기 5개인 경우*/
		} else if ($.trim(_choiceQuantity) == "5"){
			if ($.trim(_questionChoiceContent1) == "") {
				swal("객관식 1번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent2) == "") {
				swal("객관식 2번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent3) == "") {
				swal("객관식 3번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent4) == "") {
				swal("객관식 4번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent5) == "") {
				swal("객관식 5번 보기를 입력해주세요");
			} else {
				var questionInsertConfirm = confirm(
				"문제를 정말로 수정하시겠습니까?");
				if(questionInsertConfirm == true){
					var question_num = $('#qdto_question_num').val();
					
					$.ajax({
						url : "singleQuestionDelete.do",
						type:'post',
						data : {
								 'question_num' : question_num
								},
						success:function(data){
							if((data.result)=="삭제가능"){
							}else{
								swal("문제를 수정 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
							}
						},
						error: function(error){
							swal('문제 수정 도중 에러가 발생했습니다.')
						}
					})
					swal({
							title: "문제 수정",
							text: "해당 문제가 수정되었습니다.",
							icon: "success"
						});
					
					return true;
				}else{
					return false;
				}
			} 
		/*객관식 문제 보기 4개인 경우*/
		} else if ($.trim(_choiceQuantity) == "4"){
			if ($.trim(_questionChoiceContent1) == "") {
				swal("객관식 1번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent2) == "") {
				swal("객관식 2번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent3) == "") {
				swal("객관식 3번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent4) == "") {
				swal("객관식 4번 보기를 입력해주세요");
				return false;
			} else {
				var questionInsertConfirm = confirm(
				"문제를 정말로 수정하시겠습니까?");
				if(questionInsertConfirm == true){
					var question_num = $('#qdto_question_num').val();
					alert("유효성검사 통과 후 ajax 실행 전")
					
					$.ajax({
						url : "singleQuestionDelete.do",
						type:'post',
						data : {
								 'question_num' : question_num
								},
						success:function(data){
							if((data.result)=="삭제가능"){
							}else{
								swal("문제를 수정 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
							}
						},
						error: function(error){
							swal('문제 수정 도중 에러가 발생했습니다.')
						}
					})
					swal({
							title: "문제 수정",
							text: "해당 문제가 수정되었습니다.",
							icon: "success"
						});
					return true;
				}else{
					return false;
				}
			}
		/*객관식 문제 보기 3개인 경우*/
		} else if ($.trim(_choiceQuantity) == "3"){
			if ($.trim(_questionChoiceContent1) == "") {
				swal("객관식 1번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent2) == "") {
				swal("객관식 2번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent3) == "") {
				swal("객관식 3번 보기를 입력해주세요");
				return false;
			}else {
				var questionInsertConfirm = confirm(
				"문제를 정말로 수정하시겠습니까?");
				if(questionInsertConfirm == true){
					var question_num = $('#qdto_question_num').val();
					alert("유효성검사 통과 후 ajax 실행 전")
					
					$.ajax({
						url : "singleQuestionDelete.do",
						type:'post',
						data : {
								 'question_num' : question_num
								},
						success:function(data){
							if((data.result)=="삭제가능"){
							}else{
								swal("문제를 수정 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
							}
						},
						error: function(error){
							swal('문제 수정 도중 에러가 발생했습니다.')
						}
					})
					swal({
							title: "문제 수정",
							text: "해당 문제가 수정되었습니다.",
							icon: "success"
						});
					return true;
				}else{
					return false;
				}
			}
		/*객관식 문제 보기 2개인 경우*/	
		} else if ($.trim(_choiceQuantity) == "2"){
			if ($.trim(_questionChoiceContent1) == "") {
				swal("객관식 1번 보기를 입력해주세요");
				return false;
			} else if ($.trim(_questionChoiceContent2) == "") {
				swal("객관식 2번 보기를 입력해주세요");
				return false;
			}else {
				var questionInsertConfirm = confirm(
				"문제를 정말로 수정하시겠습니까?");
				if(questionInsertConfirm == true){
					var question_num = $('#qdto_question_num').val();
					alert("유효성검사 통과 후 ajax 실행 전")
					
					$.ajax({
						url : "singleQuestionDelete.do",
						type:'post',
						data : {
								 'question_num' : question_num
								},
						success:function(data){
							if((data.result)=="삭제가능"){
							}else{
								swal("문제를 수정 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
							}
						},
						error: function(error){
							swal('문제 수정 도중 에러가 발생했습니다.')
						}
					})
					swal({
							title: "문제 수정",
							text: "해당 문제가 수정되었습니다.",
							icon: "success"
						});
					return true;
				}else{
					return false;
				}
			} 
			
		} 
	/*주관식 문제 생성 유효성검사*/
	}else {
		if ($.trim(_smCategory) == "") {
			swal("문제의 대,중,소 분류를 선택해주세요");
			document.getElementById("question_sm_category2").focus();
			return false;
		} else if ($.trim(_questionLevel) == "") {
			swal("문제의 난이도를 선택해주세요");
			document.getElementById("level_type2").focus();
			return false;
		}else{
			var questionInsertConfirm = confirm(
					"문제를 정말로 수정하시겠습니까?");
			if(questionInsertConfirm == true){
				var question_num = $('#qdto_question_num').val();
				alert("유효성검사 통과 후 ajax 실행 전")
				
				$.ajax({
					url : "singleQuestionDelete.do",
					type:'post',
					data : {
							 'question_num' : question_num
							},
					success:function(data){
						if((data.result)=="삭제가능"){
						}else{
							swal("문제를 수정 할 수 없습니다.", "해당 문제를 사용하는 시험지가 존재합니다", "error");
						}
					},
					error: function(error){
						swal('문제 수정 도중 에러가 발생했습니다.')
					}
				})
				swal({
							title: "문제 수정",
							text: "해당 문제가 수정되었습니다.",
							icon: "success"
						});
				return true;
			}else{
				return false;
			}
		}
	}
}
