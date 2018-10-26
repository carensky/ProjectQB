/**
 * 18.10.10 현이 teacherMyExamPaper.js 파일 추가
 * 18.10.16 한결 선택문제 출제 및 삭제 
 */

jQuery(document).ready(function() {


   TaskList.initTaskWidget();
   
   /*선택문제 출제 + 문제 수 +카운트*/
   $('#pickQuestionBtn').click(function(){
      /*문제 수*/
      var sortable_li_num = $('#qnum').text();
      /*선택한 애들의 순서 지정할 배열 생성*/
      var selected = new Array();
      
      
      if($('#sortable input[name="checkbox[]"]').length == 0){
    	  /*오른쪽 선택문제가 아무것도 없을 때 >> 최초 선택문제 출제시*/
    	  $('.questions input[name="checkbox[]"]:checked').each(function() {
    	         selected.push("<li><div class='row'>" 
    	               + $(this).parents(".qnumdiv").parents(".questionDiv").html()
    	               + "<hr><div class='col-lg-12 qscore'>배점:&nbsp; <input type='number' " +
    	                     "class='form-control questionScoreInputTag' id='insertedQScore' name='quantity' val='1' min='1' max='20'  " +
    	                     "onchange='plusqcore()' /><hr></div></div></li>");
    	         /*문제 수 +1*/
    	         sortable_li_num++;
    	      });
      }else{
    	  /*오른쪽 선택문제에 데이터가 있을 때 경고문*/
    	  var chkArray = [];
    	  $('#sortable input[name="checkbox[]"]').each(function(){
    		 chkArray.push($(this).val()); 
    	  });
    	  for(i=0;i<chkArray.length;i++){
    		  $('.questions input[name="checkbox[]"]:checked').each(function() {
    			 if(chkArray[i] == $(this).val()){
    				 swal("같은 문제가 이미 출제되었습니다.\n"+"문제 제목 : "+$(this).parents('.qnumdiv').siblings('#questiontitle').find('b').text());
    			 }
    		  });
    	  }
    	  
    	  $('.questions input[name="checkbox[]"]:checked').each(function() {
 	         selected.push("<li><div class='row'>" 
 	               + $(this).parents(".qnumdiv").parents(".questionDiv").html()
 	               + "<hr><div class='col-lg-12 qscore'>배점:&nbsp; <input type='number' " +
 	                     "class='form-control questionScoreInputTag' id='insertedQScore' name='quantity' val='1' min='1' max='20'  " +
 	                     "onchange='plusqcore()' /><hr></div></div></li>");
 	         /*문제 수 +1*/
 	         sortable_li_num++;
 	      });
      }

      $('.task-list').append(selected);
      $('input[name="checkbox[]"]:checked').prop('checked',false);
      
      /*이동한 문제수 만큼 문제 개수 카운트*/
      $('#qnum').text(sortable_li_num);
   });
   
   /*미리보기*/
   $('#miriBtn').click(function(){
      var miriselected = new Array();
      var miricount = 0;
      var mirilength = Math.round($('#sortable>li').length/2);
      var change = "mirileft";
      
      $('#miriright').children().remove();
      $('#mirileft').children().remove();
      $("#sortable>li").each(function(index){
         if(mirilength == index){
            change ="miriright"
         }
         $('#'+change).append("<span>"+(index+1)+". </span>"
         +$(this).find("#questiontitle").html());
         
         miricount++;
      });   
   })
   
   /*선택문제 삭제 + 문제 수 -카운트 / 점수 -카운트*/
   $('#pickQuestionDeleteBtn').click(function(){
      /*문제 수 / 점수값 가져오기*/
      var sortable_li_num = $('#qnum').text();
      var qc = Number($('#qcore').text());
      
      /*체크된 애들만 실행*/
      $('#sortable input[name="checkbox[]"]:checked').each(function() {
         /*선택문제 삭제부분*/
         $(this).closest("li").remove();
         sortable_li_num--;
         
         /*점수 -카운트*/
         qc = qc - Number($(this).parents('.qnumdiv').siblings(".qscore").children("#insertedQScore").val());
      });
      $('#qnum').text(sortable_li_num);
      $('#qcore').text(qc);
   });

   /*임시저장 버튼 눌렀을 떄*/
   $('#pickQuestionTempSaveModalBtn').click(function(){
	   $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
		   if($(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val()==""){
			   $(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val("0");
			   
		   }
	   });
	   $('#pickQuestionTempSaveModal').modal(); 
   });
   
   /*점수가 100점일때 그리고 배점에 빈칸이 없을 떄 시험지생성 활성화*/
   $('#makeExamSubmitModalBtn').click(function(){
	   var count = [];
	   var score = [];
	   
	   $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
		   var eachScore = $(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val();
		   count.push(index);
		   if(eachScore!=""){
			   score.push(eachScore);
		   }
	   });
	   if(count.length == score.length && $('#qcore').text()==100){
		   $('#makeExamSubmitModal').modal();
	   }else{
		   swal("각 문제의 배점 및 총 배점을 확인해주세요.\n총 배점이 100점일때만 시험지를 생성할 수 있습니다.\n");
	   }
	   
   });
   
});

function makeExamSubmitBtn(num){
	var examName = "";
	var memId = $('.dpn1').val();
	var examDesc = "";
	var examPStatus = num;
	if(num==0){
		if($('.exam-paper-name').val()==""){
			swal("시험지 이름을 작성해주세요");
		}else if($('.exam-paper-desc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)");
		}
		examName=$('.exam-paper-name').val().trim();
		examDesc=$('.exam-paper-desc').val().trim();
		$('.createEPaper').val(examName);
		$('.createEPDesc').val(examDesc);
	}else{
		if($('.createEPaper').val()==""){
			swal("시험지 이름을 작성해주세요");
		}else if($('.createEPDesc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)");
		}
		examName=$('.createEPaper').val().trim();
		examDesc=$('.createEPDesc').val().trim();

	}

}
function insertEP(){
	$.ajax({
        url:"checkExam_paper.do",
        type:"get",
        data:{"exam_paper_name":examName},
        success:function(data){
           console.log("1. 같은 값이 있는지 체크한다. 결과값은 >> " + data + " || 첫번째 checkExam_paper.do");
           if(data == ""){
              /*공백 >> 데이터 없음(null) >> 시험지를 만든다.*/
              console.log("2-1. data 값이 null 값이다. >> 새로운 시험지를 insert한다.")
              var promise = $.ajax({
                 url:"examPaperInsert.do",
                 type:"get",
                 dataType:"json",
                 data:{
                    "exam_paper_name":examName, 
                    "member_id":memId,
                    "exam_paper_desc":examDesc,
                    "exam_paper_status":examPStatus
                    },
                  success:function(data){
                	  $.ajax({
                	      url:"checkExam_paper.do",
                	      type:"get",
                	      data:{"exam_paper_name":examName},
                	      success:function(epnum){
                	         
                	         /*시험지 번호를 저장시킨다.*/
                	         
                	         $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
                	         console.log("   시험지 번호 = " + epnum);
                	         console.log("   문제번호 = "+$(this).val());
                	         var questionNum = $(this).val();
                	         console.log("   문제 배치번호 = " + (Number(index) + 1));
                	         var EQSeq=(Number(index) + 1);
                	         console.log("   점수 = "+$(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val());
                	         $.ajax({
                	            url:"examQuestionInsert.do",
                	            type:"get",
                	            dataType:"json",
                	            data:{
                	               "exam_paper_num":epnum,
                	               "question_num":$(this).val(),
                	               "exam_question_seq":EQSeq,
                	               "exam_question_score":$(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val()
                	            },
                	            success:function(data){
                	               console.log(data);
                	               
                	            }
                	         });
                	         console.log("여기까지 시험지 번호를 받아와서 시험지 문제에 넣는 과정~ 이 여러번 나와야 함.");
                	      });         
                	         /*내 시험지로 이동*/
                	         if(num==1){
                	         location.href=$('.dpn_EPN').val()+"/teacher/examManagement.do";
                	         }else{
                	        	 $('#pickQuestionTempSaveModal').modal('hide'); 
	 							 swal("임시 저장되었습니다.");
                	         }
                	      },
                	      error:function(xml){
                	         console.log("에러가 나부렀네 ㅠㅠ 왜일까용? 뭘까용?");
                	      }
                	   });
                  }
              });
           
           } else{
              console.log("2-1. data값이 있다. data 값은 [" + data + "] 이다.")
              /*그 외... 데이터 있음 >> update*/
              $.ajax({
                 url:"examPaperUpdate.do",
                 type:"get",
                 dataType:"json",
                 data:{
                    "exam_paper_name":examName, 
                    "member_id":memId,
                    "exam_paper_desc":examDesc,
                    "exam_paper_num":data,
                    "exam_paper_status":examPStatus
                 },
                 success:function(data){
                    console.log("업데이트 성공 >> " + data);
                    if(data == "0"){
                       console.log("0이면 실패인가?");
                    }else if(data == "1"){
                       console.log("1이면 성공이고?")
                    }
                 },
                 error:function(xml){
                    swal("업데이트 에러입니다.");
                 }
              });
              $.ajax({
                       url:"examQuestionDelete.do",
                       type:"get",
                       dataType:"json",
                       data:{
                          "exam_paper_num":data
                          },
                       success:function(Qnum){
                          console.log("시험지 번호 ["+data+"] 값 애들 다 지움 >> "+Qnum);
                       }
                    });
              $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
                 console.log("시험지 번호 = " + data);
                 console.log("문제번호 = "+$(this).val());
                 var questionNum = $(this).val();
                 console.log("문제 배치번호 = " + index + 1);
                 var EQSeq=(Number(index) + 1);
                 console.log("점수 = "+$(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val());
                 var Score = $(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val();
                    /*insert자리*/
                    $.ajax({
                       url:"examQuestionInsert.do",
                       type:"get",
                       dataType:"json",
                       data:{
                          "exam_paper_num":data,
                          "question_num":$(this).val(),
                          "exam_question_seq":EQSeq,
                          "exam_question_score":Score
                       },
                       success:function(data){
                          console.log(data);
                          
                          
                       }
                    });
                 });
              /*내 시험지로 이동*/
              if(num==1){
              location.href=$('.dpn_EPN').val()+"/teacher/examManagement.do";
              }else{
            	  $('#pickQuestionTempSaveModal').modal('hide'); 
	 			  swal("임시 저장되었습니다.");
              }
           }
        },
        error:function(xml){
           swal("문제가 생겨부럿네");
        }
     });
}

function plusqcore(){
	var qc = Number($('#qcore').val());
	$('.questionScoreInputTag').each(function(){
		if($(this).val()>100){
			swal("한 문제당 최대 배점은 20점까지 인정됩니다.");
			$(this).val(20);
			qc += Number(20);
		} else {
			qc += Number($(this).val());
		}
	});
		if(qc > 100){
			swal("총 점수가 100점이 넘을 수 없습니다.");
			$('#qcore').text(qc);
		}
		$('#qcore').text(qc);
};


$(function() {
	$("#sortable").sortable();
	$("#sortable").disableSelection();
});