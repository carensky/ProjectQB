/*
 	@JSP:adminMember.js
 	@DATE:2018.10.16
 	@Author:유영준
 	@Desc:회원관리 js(스토리보드 10 of 41)
 */


$(document).ready(function(){
	function allCheckFunc( obj ) {
		$("[name=chk]").prop("checked", $(obj).prop("checked") );
}

/* 체크박스 체크시 전체선택 체크 여부 */
function oneCheckFunc( obj )
{
	var allObj = $("#checkall");
	var objName = $(obj).attr("name");

	if( $(obj).prop("checked") )
	{
		checkBoxLength = $("[name="+ objName +"]").length;
		checkedLength = $("[name="+ objName +"]:checked")
		.length;

		if( checkBoxLength == checkedLength ) {
			allObj.prop("checked", true);
		} else {
			allObj.prop("checked", false);
		}
	}
	else
	{
		allObj.prop("checked", false);
	}
}

/* 각각의 체크박스를 클릭시 전체선택 체크박스도 선택 및 해제되도록 구현 */
$(function(){
	$("#checkall").click(function(){
		allCheckFunc( this );
	});
	$("[name=chk]").each(function(){
		$(this).click(function(){
			oneCheckFunc( $(this) );
		});
	});
});

$(function(){
	
	/*수정버튼 눌렀을때 부모창 값을 모달창에 가져오기*/
	$("button[name='updatebtn']").click(function(){
		action='modify';
		type='PUT';
		memberid=this.value;
		
		var row =$(this).parent().parent();
		var tr = row.children();
		
		var member_id_modal=tr.eq(2).text();
		var member_email_modal=tr.eq(4).text();
		var member_phone_modal=tr.eq(5).text();
		var member_name_modal=tr.eq(3).text();
		var member_enable_modal = tr.eq(6).text();
		var class_name_modal = tr.eq(1).text();
		var role_code_modal = tr.eq(7).text();
		
		$('#cid').val(member_id_modal);
		$('#cemail').val(member_email_modal);
		$('#curl').val(member_phone_modal);
		$('#cname').val(member_name_modal);
		$('#class_name').val(class_name_modal);
		
		if(role_code_modal == '학생'){
			$("#agree_s").attr("checked", true);
			$("#agree_t").attr("checked", false);
		}
		else if(role_code_modal == '선생님'){
			$("#agree_t").attr("checked", true);
			$("#agree_s").attr("checked", false);
		}

		
	});
	
	/*멤버 수정*/
	$('#updateMemberBtn').click(function() {
		var role_code_val;
		
		if ($('#agree_s').is(":checked"))
		{
		  role_code_val=$('#agree_s').val();
		}
		else if($('#agree_t').is(":checked")){
			role_code_val=$('#agree_t').val();
		}
		
		
		console.log("바뀌는 권한 값 ??>>>" + role_code_val);
		var _param = {member_email:$("#cemail").val(), member_phone:$("#curl").val()
				, member_id:$("#cid").val(), class_name:$("#class_name option:selected").text()
				, role_code:role_code_val }

		var _data = JSON.stringify(_param); //jsonString으로 변환	                                                      
		$.ajax({
   			  type : "post",
   			  url : "adminMemberUpdate.do",
   			  cache: false,
   			  dataType: "json",
   			  data:_data,  
   			  processData: false,
   			  contentType: "application/json; charset=utf-8",
   			  success : function(data, status){
   				  alert("해당아이디값"+memberid);
   				  location.href="adminMember.do";
   			  },
   			  error: function(request, status, error){
   				  
   				  if($("#agree_s").attr("checked", false) && $("#agree_t").attr("checked", false)){
   					  
   				  alert("권한을 확인해주세요");
   				  }
   			  }
   		});
		
	});	
});

$(function(){
	
	/* 멤버 삭제(실제 삭제X) */
	
	$("button[name='deletebtn']").click(function(){
		action = 'modify';
		type = 'PUT';
		memberid = this.value;
	});
	$('#deleteMemberBtn').click(function() {
		var _param = {member_id:$('#member_id').val(), member_enable:$('#member_enable').val()}
		
		var _data = JSON.stringify(_param); //jsonString으로 변환
		
		$.ajax({
			type : "post",
			url : "adminMemberDelete.do",
			cache : false,
			dataType : "json",
			data : _data,
			processData : false,
			contentType : "application/json; charset=utf-8",
			success : function(data, status){
				alert("삭제되었습니다");
				location.href="adminMember.do";
			},
			error: function(request, status, error){
				alert("에러에러에러에러에러");
			}
		});
	});
	});
});

function oneCheckbox(a){

    var obj = document.getElementsByName("agree");

    for(var i=0; i<obj.length; i++){

        if(obj[i] != a){

            obj[i].checked = false;

        }

    }

}

