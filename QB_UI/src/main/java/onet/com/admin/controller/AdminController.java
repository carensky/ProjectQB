﻿package onet.com.admin.controller;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import onet.com.admin.service.AdminService;
import onet.com.common.service.CommonService;
import onet.com.teacher.service.TeacherService;
import onet.com.vo.CategoryDto;
import onet.com.vo.ClassDto;
import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamPaperDto;
import onet.com.vo.MemberDto;
import onet.com.vo.NoticeDto;
import onet.com.vo.QuestionDto;
import onet.com.vo.Question_choiceDto;
import onet.com.vo.RoleDto;

@Controller
@RequestMapping(value="/admin/")
public class AdminController {
	
	/*재훈 10.08 문제분류관련 start*/
	@Autowired
	private AdminService adminService;

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TeacherService teacherService;
	
	/*양회준 10.14 관리자 메인 시작*/
	@RequestMapping("adminMain.do")
	public String adminMain(Model model) {
		
		return "admin.adminMain";
	}
	/*양회준 10.14 관리자 메인 끝*/
	
	@RequestMapping("questionCategory.do")
	public String questionCategory(Model model) throws Exception {
		
		List<CategoryDto> list1;
		list1=adminService.lgProblemCategoryList();
		model.addAttribute("list1",list1);
		
		List<CategoryDto> list2;
		list2=adminService.mdProblemCategoryList();
		model.addAttribute("list2",list2);
		
		List<CategoryDto> list3;
		list3=adminService.smProblemCategoryList();
		model.addAttribute("list3",list3);
		
		return "admin.questionCategory";
	}
	/*재훈 10.08 문제분류관련 end*/
	
	/* 영준 10.08 회원관리관련 시작 */
	@RequestMapping("adminMember.do")
	public String adminMember(Model model) throws Exception {
		List<ClassDto> classList;
		classList=adminService.classList();
		model.addAttribute("classList", classList);
		
		List<MemberDto> memberList;
		memberList=adminService.memberList();
		model.addAttribute("memberDto", memberList);

		List<RoleDto> roleList;
		roleList = adminService.roleList();
		model.addAttribute("roleList", roleList);
				
		return "admin.adminMember";
		
	}
	@RequestMapping(value="adminMemberView.do")
	public @ResponseBody ModelAndView adminMemberView() {
		List<MemberDto> memberList = adminService.adminMemberView();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin.adminMember");
		mv.addObject("memberList", memberList);
		
		return mv;
	}
	
	
	@RequestMapping(value="adminMemberUpdate.do", method = RequestMethod.POST)
	public @ResponseBody String adminMemberUpdate(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
	{	
		int result = adminService.updateMember(dto);
		String result2 = String.valueOf(result);
		return result2;
		
	}
	
	/* 영준 - 10.22 회원관리 회원 삭제 시작 */
	@RequestMapping(value="adminMemberDelete.do", method = RequestMethod.POST)
	public @ResponseBody int adminMemberDelete(@RequestParam String member_id)
	{	
		System.out.println(member_id);
		int result = adminService.deleteMember(member_id);
		return result;
	}
	/* 영준 - 10.22 회원관리 회원 삭제 끝 */

	/* 영준 - 10.22 선택회원 등록 시작 */
	@RequestMapping(value="adminMemberInsert.do", method = RequestMethod.POST)
	public @ResponseBody String adminMemberInsert(@RequestBody MemberDto dto)
	{
		int result = adminService.insertMember(dto);
		String result2 = String.valueOf(result);
		return result2;
	}
	/* 영준 - 10.22 선택회원 등록 끝 */
	
	/* 영준 10.15 회원관리관련 끝 */
	
	/*민지 10.12 클래스멤버리스트 , 클래스 리스트 관련 */
	@RequestMapping("adminClassInfo.do")
	public String adminClassInfo(Model model, int class_num) throws Exception{
		
		
//전체 클래스 데이터
		List<ClassDto> classList;
		classList=adminService.classList();
		model.addAttribute("classList", classList);
// 해당 클래스 데이터
		List<ClassDto> classlist;
		classlist=adminService.classlist(class_num);
		model.addAttribute("classlist", classlist);
		
		List<MemberDto> classMemberList;
		classMemberList= teacherService.classMemberList(class_num);
		model.addAttribute("classMemberList", classMemberList);
		return "admin.adminClassInfo";
	}

	
	@RequestMapping(value = "adminClassMemberUpdate.do", method = RequestMethod.POST)
	public @ResponseBody String adminClassMemberUpdate(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
	{	
		
		/*deptService.insertDept(dto);
		return dto.toString();*/
		int result = adminService.classMemberUpdate(dto);
		String result2 = String.valueOf(result);
		return result2;
		
	}
	/*민지 10.12 클래스멤버리스트 관련 끝*/

	
	
	/*민지 10.13 클래스 멤버 삭제 관련*/
		@RequestMapping(value = "adminClassMemberDelete.do", method = RequestMethod.POST)
		public @ResponseBody String adminClassMemberDelete(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
		{	
			/*deptService.insertDept(dto);
			return dto.toString();*/
			int result = adminService.classMemberDelete(dto);
			String result2 = String.valueOf(result);
			return result2;
			
		}
	/*민지 10.13 클래스 멤버 삭제 관련 끝*/


	/*현이 18.10.09 관리자 마이페이지 시작*/
		
	@RequestMapping("myPage.do")
	public String mypage() {

		return "common.admin.common.myPage";
	}
	
	/*현이 18.10.09 관리자 마이페이지 끝*/

	
	/*민지 18.10.10 메시지 페이지 시작*/
	@RequestMapping("myMessage.do")
	public String myMessage() {

		return "common.admin.common.myMessage";
	}
	/*민지 18.10.10 메시지 페이지 끝*/
	

	
	
	// 관리자 클래스 상세보기  - 공지사항
	//10.15민지
	@RequestMapping("adminClassMain.do")
	public String adminClassMain(Model model, String class_name) {

		List<NoticeDto> notice;
		notice=commonService.admin_Main(class_name);
		model.addAttribute("notice", notice);
		
		List<ExamInfoDto> exam_info = commonService.admin_exam_info(class_name);
		
		model.addAttribute("exam_info", exam_info);
		return "common.adminClass.admin.notice.notice";
	}
	//10.15민지 클래스 수정
	@RequestMapping(value = "adminClassUpdate.do",  method =  RequestMethod.POST)
		public @ResponseBody String adminClassUpdate(@RequestBody ClassDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
		{	
			/*deptService.insertDept(dto);
			return dto.toString();*/
			int result = adminService.classUpdate(dto);
			String result2 = String.valueOf(result);
			return result2;
			
		}
	

	@RequestMapping("noticeDetail.do")
	public String noticeDetail() {
		
		return "common.adminClass.admin.notice.noticeDetail";
	}
	
	@RequestMapping("noticeWrite.do")
	public String noticeWrite() {

		return "common.adminClass.admin.notice.noticeWrite";
	}

	@RequestMapping("noticeUpdate.do")
	public String noticeUpdate() {
		
		return "common.adminClass.admin.notice.noticeUpdate";
	}
	
	
	// 관리자 클래스 상세보기 - 시험 관리 
	@RequestMapping("examScheduleDetail.do")
	public String examScheduleDetail() {
		System.out.println("시험일정 상세 컨트롤러");
		return "common.adminClass.admin.exam.examScheduleDetail";
	}  
	
	@RequestMapping("examPaperUpdate.do")
	public String examPaperUpdate() {

		return "common.adminClass.admin.exam.examPaperUpdate";
	}
	
	
	
	// 관리자 클래스 상세보기 - 시험지 관련 
	@RequestMapping("examPaperMake.do")
	public String examPaperMake(){
		
		return "common.adminClass.admin.examPaperMake";
	}
	
	@RequestMapping("examPaperModify.do")
	public String examPaperModify(){
		
		return "common.adminClass.admin.exampaper.examPaperModify";
	}
	
	
	
	// 관리자 클래스 상세보기 - 학생 & 성적관리 
	@RequestMapping("studentInfo.do")
	public String studentInfo(){
		
		return "common.adminClass.admin.grade.studentInfo";
	}
	
	
	// 관리자 클래스 상세보기 - 문제 관리 
	/* 재훈 10.15 문제 관리 페이지 관련 start */
	@RequestMapping("questionManagement.do")
	public String questionManagement(Model model, Principal principal) throws Exception {
		List<CategoryDto> lgCatList;
		
		lgCatList=adminService.lgCategoryList();
		model.addAttribute("lgCatList",lgCatList);
		
		List<CategoryDto> mdCatList;
		mdCatList=adminService.mdCategoryList();
		model.addAttribute("mdCatList",mdCatList);
		
		List<CategoryDto> smCatList;
		smCatList=adminService.smCategoryList();
		model.addAttribute("smCatList",smCatList);
		
		List<CategoryDto> quesLevelList;
		quesLevelList=adminService.questionLevelList();
		model.addAttribute("quesLevelList",quesLevelList);
		
		String member_id = principal.getName();
		MemberDto memberDto = commonService.myPageInfo(member_id);
		model.addAttribute("memberDto", memberDto);
		
		return "common.adminClass.admin.question.questionManagement";
	}
	
	@RequestMapping(value="insertQuestion.do", method=RequestMethod.POST)
	public String insertQuestion(QuestionDto dto2, Question_choiceDto dto) throws ClassNotFoundException, SQLException {
	
		if (dto2.getQuestion_type().equals("객관식")) {
		adminService.insertQuestion(dto2);
		adminService.insertQuestionChoice(dto2, dto);
		} else {
		adminService.insertQuestion(dto2);
		}
		return "common.adminClass.admin.question.questionManagement";
	}
	
	@RequestMapping(value="myQuestionView.do")
	public @ResponseBody ModelAndView classListView(Model model) {
		List<QuestionDto> question = teacherService.question();
		model.addAttribute("question", question);
		List<Question_choiceDto> question_choice = teacherService.question_choice();
		model.addAttribute("question_choice", question_choice);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.questionManagement_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}
	/*
	@RequestMapping(value="myQuestionSearch.do")
	public @ResponseBody ModelAndView questionSearch(@RequestParam("lgsearchtype") String lgsearchtype, 
			@RequestParam("mdsearchtype") String mdsearchtype, @RequestParam("smsearchtype") String smsearchtype,
			@RequestParam("leveltype") String leveltype, @RequestParam("questiontype") String questiontype,
			@RequestParam("keyword") String keyword) {
		
		List<QuestionDto> question = teacherService.questionSearch(lgsearchtype,mdsearchtype,smsearchtype,leveltype,questiontype);
		List<Question_choiceDto> question_choice = teacherService.question_choice();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.questionManagement_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}
	*/

	
	/* 재훈 10.20 문제삭제 관련 start */
	@RequestMapping("singleQuestionDelete.do")
	public @ResponseBody Map<String,Object> singleQuestionDelete(int question_num){
		System.out.println("컨트롤러 진입>>>>>" + question_num);
		Map<String,Object> map = new HashMap <String,Object>();
		int result = commonService.singleQuestionDelete(question_num);
		if(result == 0) {
			System.out.println("컨트롤러 if문 >> result 값 0");
			map.put("result", "삭제불가");
		}else {
			System.out.println("컨트롤러 if문 >> result 값 0이 아닐때");
			map.put("result", "삭제가능");
		}
		return map;
	}
	/* 재훈 10.21 문제수정 관련 start */
	@RequestMapping("singleUpdateCheck.do")
	public @ResponseBody Map<String,Object> singleUpdateCheck(int question_num){
		System.out.println("문제수정 컨트롤러 진입>>>>>" + question_num);
		Map<String,Object> map = new HashMap <String,Object>();
		int result = commonService.singleUpdateCheck(question_num);
		if(result == 0) {
			System.out.println("컨트롤러 if문 >> result 값 0");
			map.put("result", "삭제불가");
		}else {
			System.out.println("컨트롤러 if문 >> result 값 0이 아닐때");
			map.put("result", "삭제가능");
		}
		return map;
	}
	/*문제수정페이지로 이동시 문제 &문제보기 정보 가져와서 뿌려주기*/

	/* 재훈 10.15 문제 관리 페이지 관련 end */

	@RequestMapping("questionUpdate.do")
	public String questionUpdate(Model model, int question_num) {
		System.out.println("컨트롤러 진입>>> question_num값: " +question_num);
		
		List<QuestionDto> qdto;
		qdto=commonService.questionInfo(question_num);
		model.addAttribute("qdto",qdto);
		
		List<Question_choiceDto> cdto;
		cdto=commonService.questionChoiceInfo(question_num);
		model.addAttribute("cdto",cdto);
		
		List<CategoryDto> lgCatList;
		lgCatList=adminService.lgCategoryList();
		model.addAttribute("lgCatList",lgCatList);
		
		List<CategoryDto> mdCatList;
		mdCatList=adminService.mdCategoryList();
		model.addAttribute("mdCatList",mdCatList);
		
		List<CategoryDto> smCatList;
		smCatList=adminService.smCategoryList();
		model.addAttribute("smCatList",smCatList);
		
		List<CategoryDto> quesLevelList;
		quesLevelList=adminService.questionLevelList();
		model.addAttribute("quesLevelList",quesLevelList);
		
		return "common.adminClass.admin.question.questionUpdate";
	}	
	
	

	/* 재훈 10.15 문제 관리 페이지 관련 end */
	

	/*현이 18.10.09 관리자 마이페이지 시작*/
	/*양회준 10.15 내 정보 수정 시작*/
	@RequestMapping(value = "myPage.do", method = RequestMethod.GET)
	public String myPageInfo(Model model, Principal principal) throws ClassNotFoundException, SQLException {
		String member_id = principal.getName();
		System.out.println("아이디 : " +member_id);
		MemberDto memberDto = commonService.myPageInfo(member_id);
		model.addAttribute("memberDto", memberDto);
		return "common.admin.common.myPage";
	}
	/*양회준 10.15 내 정보 수정 끝*/
	/*현이 18.10.09 관리자 마이페이지 끝*/
	
	@RequestMapping(value = "myPage.do", method = RequestMethod.POST)
	public String myPageUpdate(MemberDto memberDto)
			throws IOException, ClassNotFoundException, SQLException {
		String url = "redirect:myPage.do";
		try {
			url = commonService.myPageUpdate(memberDto);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		// 예외 발생에 상관없이 목록페이지 요청 처리
		return url;
	}
	
	/* 양회준 10.15 내정보 탈퇴 시작*/
	@RequestMapping("myPageDrop.do")
	public String myPageDrop(MemberDto memberDto)
			throws IOException, ClassNotFoundException, SQLException {
			memberDto.setMember_enable("0");
			System.out.println(memberDto.getMember_enable());
			commonService.myPageDrop(memberDto);
		
		// 예외 발생에 상관없이 목록페이지 요청 처리
		return "redirect:/login.jsp";
	}
	/* 양회준 10.15 내정보 탈퇴 끝*/	
	
	/* 양회준 10.16 내정보 비밀번호 확인 시작*/
	@RequestMapping(value="memberDrop.do", method=RequestMethod.POST)
	public @ResponseBody int memberDrop(@RequestParam("member_id") String member_id, 
			@RequestParam("member_pwd") String member_pwd) throws IOException, ClassNotFoundException, SQLException {
		System.out.println("intoAjax");
		System.out.println(member_id);
		System.out.println(member_pwd);
		int result = commonService.memberDrop(member_id, member_pwd);		
		return result;
	}
	/* 양회준 10.16 내정보 비밀번호 확인 끝*/

	// 정원 - 문제분류관리 - insert
	@RequestMapping("lgCatAdd.do")
	public @ResponseBody Map<String, Object> lgCatAdd(String lgCatAdd) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(lgCatAdd.trim()=="") {
			map.put("result", "null");
			return map;
		}else {
		String result = adminService.lgCatAdd(lgCatAdd);
		map.put("result", result);
		return map;
	}
	}	
	@RequestMapping("mdCatAdd.do")
	public @ResponseBody Map<String, Object> mdCatAdd(String selectLgCat, String mdCatAdd) {
		System.out.println("<<<" + mdCatAdd + ">>>");
		Map<String, Object> map = new HashMap<String, Object>();
		if(selectLgCat.trim()=="") {
			map.put("result", "null");
			return map;
		}else if(mdCatAdd.trim()=="") {
			map.put("result", "textNull");
			return map;
		}else {
		String result = adminService.mdCatAdd(selectLgCat, mdCatAdd);
		System.out.println(result);
		map.put("result", result);
		return map;
	}
	}
	@RequestMapping("smCatAdd.do")
	public @ResponseBody Map<String, Object> smCatAdd(String selectMdCat, String smCatAdd) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(selectMdCat.trim()=="") {
			map.put("result", "null");
			return map;
		}else if(smCatAdd.trim()=="") {
			map.put("result", "textNull");
			return map;
		}else {
		String result = adminService.smCatAdd(selectMdCat, smCatAdd);
		System.out.println(result);
		map.put("result", result);
		return map;
	}
	}	
	// 정원 - 문제분류관리 insert 끝
	
	// 정원 - 문제분류관리 update 시작
	@RequestMapping("lgUpdate.do")
	public @ResponseBody Map<String, Object> lgUpdate(String lgCatCode, String lgCatName, String lgBeforeName) {
		Map<String, Object> map = new HashMap<String, Object>();
		CategoryDto dto = new CategoryDto();
		String check = adminService.lgCatIdCheck(lgCatName);
		if((lgCatName.equals(lgBeforeName)) || check == null) {
			dto.setLg_category_code(lgCatCode);
			dto.setLg_category_name(lgCatName);
			adminService.lgUpdate(dto);
			map.put("result", "null");
			return map;
		}else{
			map.put("result","Notnull");
			return map;
		}
		
	}	
		@RequestMapping("mdUpdate.do")
		public @ResponseBody Map<String, Object> mdUpdate(String mdCatCode, String mdCatName, String lgSelectCode, String mdBeforeName) {
			Map<String, Object> map = new HashMap<String, Object>();
			CategoryDto dto = new CategoryDto();
			String check = adminService.mdCatIdCheck(mdCatName);
			if((mdCatName.equals(mdBeforeName)) || check == null) {
				dto.setLg_category_code(lgSelectCode);
				dto.setMd_category_code(mdCatCode);
				dto.setMd_category_name(mdCatName);
				adminService.mdUpdate(dto);
				map.put("result", "null");
				return map;
			}else {
				map.put("result","Notnull");
				return map;
			}
		}
		
		@RequestMapping("smUpdate.do")
		public @ResponseBody Map<String, Object> smUpdate(String smCatCode, String smCatName, String mdSelectCode, String smBeforeName) {
			Map<String, Object> map = new HashMap<String, Object>();
			CategoryDto dto = new CategoryDto();
			String check = adminService.smCatIdCheck(smCatName);
			if((smCatName.equals(smBeforeName)) || check == null) {
				dto.setMd_category_code(mdSelectCode);
				dto.setSm_category_code(smCatCode);
				dto.setSm_category_name(smCatName);
				adminService.smUpdate(dto);
				map.put("result", "null");
				return map;
			}else {
				map.put("result","Notnull");
				return map;
			}
		}
	// 정원 - 문제분류관리 update 끝

	
	
	//10.17민지- 클래스수정 중복체크
	@RequestMapping(value="classNameCheck.do", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> idCheck(@RequestParam("class_name") String class_name) {
		String memberid = adminService.classCheck(class_name);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", memberid == null);
		map.get("result");
		return map;
	}
	
	// 정원 -문제분류 delete 시작
	@RequestMapping("lgDelete.do")
	public @ResponseBody Map<String, Object> lgDelete(String lgDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = adminService.lgDelete(lgDeleteCode);
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}	
			return map;
	} 
	
	@RequestMapping("mdDelete.do")
	public @ResponseBody Map<String, Object> mdDelete(String mdDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = adminService.mdDelete(mdDeleteCode);
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}
			return map;
	}
	
	@RequestMapping("smDelete.do")
	public @ResponseBody Map<String, Object> smDelete(String smDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
			int result = adminService.smDelete(smDeleteCode);
			if(result == 0) {
				map.put("result", "삭제불가");
			}else {
				map.put("result", "삭제가능");
			}
			return map;
	}
	
	
	@RequestMapping("selectLgList.do")
	public ModelAndView selectLgList(String lgCode) {
		List<CategoryDto> list1 = adminService.selectLgList(lgCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax");
		mv.addObject("list1", list1);
		return mv;
	}


	@RequestMapping("selectMdList.do")
	public ModelAndView selectMgList(String lgCode) {
		List<CategoryDto> list2 = adminService.selectMdList(lgCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax2");
		mv.addObject("list2", list2);
		return mv;
	}
	
	@RequestMapping("selectSmList.do")
	public ModelAndView selectSmList(String lgCode) {
		List<CategoryDto> list3 = adminService.selectSmList(lgCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		System.out.println(list3);
		return mv;
	}
	
	@RequestMapping("selectMdRealList.do")
	public ModelAndView selectMdRealList(String mdCode) {
		List<CategoryDto> list2 = adminService.selectMdRealList(mdCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax2");
		mv.addObject("list2", list2);
		return mv;
	}
	
	@RequestMapping("selectSmRealList.do")
	public ModelAndView selectSmRealList(String mdCode) {
		List<CategoryDto> list3 = adminService.selectSmRealList(mdCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		return mv;
	}
	
	@RequestMapping("selectSmRealList2.do")
	public ModelAndView selectSmRealList2(String smCode) {
		List<CategoryDto> list3 = adminService.selectSmRealList2(smCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		return mv;
	}

	/*민지:10.18 시험등록  끝*/

	
		
	//양회준 10-22 admin 회원관리 비동기 검색
	@RequestMapping(value="memberSearchAjax.do", method=RequestMethod.POST)
	public @ResponseBody List<MemberDto> memberSearchAjax(@RequestParam("searchRole") String searchRole, 
			@RequestParam("searchClassName") String searchClassName, @RequestParam("searchMemberInfo") String searchMemberInfo,
			@RequestParam("searchBox") String searchBox) throws IOException, ClassNotFoundException, SQLException {
				
		List<MemberDto> memberDto = adminService.memberSearchAjax(searchRole, searchClassName, searchMemberInfo, searchBox);
		
		return memberDto;
	}
	
	//양회준 10-23 admin 회원관리 비동기 일괄등록
	@RequestMapping(value="updateStudentsAjax.do", method=RequestMethod.POST)
	public @ResponseBody String updateStudentsAjax(@RequestParam("updateStudentArr") ArrayList<String> updateStudentArr) 
			throws IOException, ClassNotFoundException, SQLException {
		System.out.println("arraylist인데 바로 찍히네?="+updateStudentArr);
		
		int result = adminService.updateStudentsAjax(updateStudentArr);
		
		return ""+result;
	}
	//양회준 10-23 admin 회원관리 비동기 일괄삭제
	@RequestMapping(value="deleteStudentsAjax.do", method=RequestMethod.POST)
	public @ResponseBody String deleteStudentsAjax(@RequestParam("deleteStudentArr") ArrayList<String> deleteStudentArr) 
			throws IOException, ClassNotFoundException, SQLException {
		System.out.println("arraylist인데 바로 찍히네?="+deleteStudentArr);
		
		int result = adminService.deleteStudentsAjax(deleteStudentArr);
		
		return ""+result;
	}
	
}