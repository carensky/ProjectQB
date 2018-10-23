package onet.com.teacher.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.sql.SQLException;
import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import onet.com.teacher.service.TeacherService;
import onet.com.vo.ClassDto;
import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamPaperDto;
import onet.com.vo.MemberDto;
import onet.com.vo.QuestionDto;
import onet.com.vo.Question_choiceDto;

@Controller
@RequestMapping("/teacher/")
public class TestManageController {

	@Autowired
	private TeacherService teacherService;
	
	

	/*성태용 시작*/
	/*문제리스트 뿌려주기*/
	@RequestMapping(value="questionListView.do")
	public @ResponseBody ModelAndView classListView(Model model) {
		List<QuestionDto> question = teacherService.question();
		model.addAttribute("question", question);
		List<Question_choiceDto> question_choice = teacherService.question_choice();
		model.addAttribute("question_choice", question_choice);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.examPaperMake_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}
	/*문제 검색*/
	@RequestMapping(value="questionSearch.do")
	public @ResponseBody ModelAndView questionSearch(@RequestParam("lgsearchtype") String lgsearchtype, 
			@RequestParam("mdsearchtype") String mdsearchtype, @RequestParam("smsearchtype") String smsearchtype,
			@RequestParam("leveltype") String leveltype,@RequestParam("keyword") String keyword,
			@RequestParam("questiontype") String questiontype) {
		
		List<QuestionDto> question = teacherService.questionSearch(lgsearchtype,mdsearchtype,smsearchtype,leveltype,questiontype,keyword);
		List<Question_choiceDto> question_choice = teacherService.question_choice();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.examPaperMake_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}
	
	/*시험지 리스트 뿌려주기*/
	@RequestMapping("examManagement.do")
	public String examManagement(Model model, Principal principal) {
		String member_id = principal.getName();
		
		List<ExamPaperDto> myexamPaperList;
		List<ExamPaperDto> myTempExamList;
		List<ExamInfoDto> examScheduleList;
		
		myexamPaperList = teacherService.myExamPaperList(member_id);			
		myTempExamList = teacherService.myTempExamList(member_id);			
		examScheduleList = teacherService.examScheduleList(member_id);
		
		model.addAttribute("myexamPaperList", myexamPaperList);
		model.addAttribute("myTempExamList", myTempExamList);
		model.addAttribute("examScheduleList", examScheduleList);
		
		return "common.teacher.exam.examManagement";
	}
	@RequestMapping("deleteExam.do")
	public @ResponseBody int deleteExam(@RequestParam("exam_paper_num") int exam_paper_num) {
		
		int result = teacherService.deleteExam(exam_paper_num);	
		
		if(result == 0) {
			System.out.println("삭제실패");
		}
		
		return result;
	}
	
	@RequestMapping("updateExamView.do")
	public String updateExamView(RedirectAttributes redirectAttributes, int exam_paper_num) {
		List<QuestionDto> question = teacherService.updateExamView(exam_paper_num);
		redirectAttributes.addFlashAttribute("examquestion", question);
		List<Question_choiceDto> question_choice = teacherService.question_choice();
		redirectAttributes.addFlashAttribute("examquestion_choice", question_choice);
		
		return "redirect:examPaperMake.do";
	}
	/*성태용 끝*/
	
	/*민지 시작*/
	@RequestMapping("examScheduleRegist.do")
	public String examScheduleRegist(Model model, int exam_paper_num, String exam_paper_name) {
		
		List<MemberDto> classMemberList;
		classMemberList= teacherService.classMemberList(exam_paper_num);
		model.addAttribute("classMemberList", classMemberList);

		ClassDto classInfo;
		classInfo = teacherService.classInfo(exam_paper_num);
		
		String class_name = classInfo.getClass_name();
		int class_num = classInfo.getClass_num();
		model.addAttribute("class_name", class_name);
		model.addAttribute("class_num", class_num);
		
		return "common.teacher.exam.examScheduleRegist";
	}
	/*민지:10.18 시험등록 */
	@RequestMapping(value="examInfoInsert.do", method =  RequestMethod.POST)
	public  String examInfoInsert(ExamInfoDto dto,HttpServletResponse response) throws ClassNotFoundException, SQLException, UnsupportedEncodingException {
		System.out.println("시험등록컨트롤러들어옴");
		int result = 0;
		String viewpage="";
		
		result=teacherService.examInfoInsert(dto);
		if(result > 0) {
			System.out.println("시험등록성공");
			String class_name = dto.getClass_name();
			System.out.println(class_name);
			
			String url = URLEncoder.encode(class_name, "UTF-8");
			viewpage = "redirect:examManagement.do?class_name="+url+"&class_num="+dto.getClass_num();
		}else {
			System.out.println("시험등록 실패");
			
		}
		return viewpage;
	}
	
	/*민지 끝*/
	
	/*한결 시작*/
	@RequestMapping("checkExam_paper.do")
	public @ResponseBody String checkExam_paper(@RequestParam("exam_paper_name") String exam_paper_name) {	
		String result = teacherService.examPaperCheck(exam_paper_name);
		return result;
	}	
	
	/* 10.17 시험지 테이블 insert and update*/

	@RequestMapping("examPaperInsert.do")
	public @ResponseBody int examPaperInsert(@RequestParam("exam_paper_name") String exam_paper_name,
			@RequestParam("member_id") String member_id,@RequestParam("exam_paper_desc") String exam_paper_desc,
			@RequestParam("exam_paper_status") String exam_paper_status) {
		int result = teacherService.examPaperInsert(exam_paper_name,member_id,exam_paper_desc,exam_paper_status);
		return result;
	}
	
	@RequestMapping("examPaperUpdate.do")
	public @ResponseBody int examPaperUpdate(@RequestParam("exam_paper_name") String exam_paper_name,
			@RequestParam("member_id") String member_id,@RequestParam("exam_paper_desc") String exam_paper_desc,
			@RequestParam("exam_paper_num") String exam_paper_num, @RequestParam("exam_paper_status") String exam_paper_status) {
		int result = teacherService.examPaperUpdate(exam_paper_name,member_id,exam_paper_desc,exam_paper_num, exam_paper_status);
		return result;
	}
	
	/*10.18 시험지 문제 테이블 select insert update delete*/
	@RequestMapping("examQuestionSelect.do")
	public @ResponseBody int examQuestionSelect(@RequestParam("exam_paper_num") String exam_paper_num,
			@RequestParam("question_num") String question_num) {
		int result = teacherService.examQuestionSelect(exam_paper_num, question_num);
		return result;
	}
	@RequestMapping("examQuestionInsert.do")
	public @ResponseBody int examQuestionInsert(@RequestParam("exam_paper_num") String exam_paper_num, 
			@RequestParam("question_num") String question_num, @RequestParam("exam_question_seq")String exam_question_seq, 
			@RequestParam("exam_question_score") String exam_question_score) {
		int result = teacherService.examQuestionInsert(exam_paper_num,question_num, exam_question_seq, exam_question_score);
		return result;
	}

	@RequestMapping("examQuestionDelete.do")
	public @ResponseBody int examQuestionDelte(@RequestParam("exam_paper_num") String exam_paper_num) {
		int result = teacherService.examQuestionDelete(exam_paper_num);
		return result;
	}

	/*한결 끝*/
	
	
	/*민지 시험일정 수정 시작*/
	@RequestMapping("examScheduleUpdate.do")
	public String examScheduleUpdate(Model model, int exam_info_num) {

		
		List<ExamInfoDto> classExamList;
		classExamList= teacherService.classExamList(exam_info_num);
		model.addAttribute("classExamList", classExamList);
		/*
		List<ExamPaperDto> examPaperList;
		examPaperList = teacherService.examPaperList(class_num);
		model.addAttribute("examPaperList", examPaperList);
		System.out.println("examPaperList 값은>>>>>>>>>>>>>>>>>>>>>"+examPaperList);
		*/
		
		
		return "common.teacher.exam.examScheduleUpdate";
	}
	
	@RequestMapping("examInfoIUpdate.do")
	public String examInfoIUpdate(ExamInfoDto dto) {
		
		System.out.println("시험일정 수정 컨트롤러!!!!!!!!!!!!!!!!!");
		
		int result = teacherService.examInfoIUpdate(dto);
		
		if(result == 0) {
			System.out.println("에에에엥에에러 안바꼇어 바보들아");
		}
		
		return "redirect:examManagement.do";
	}
		
	/*민지 시험일정 수정 끝*/
	
	/* 민지 - 18.10.23 시험 일정 삭제 시작 */
	@RequestMapping(value = "teacherExamSchedultDelete.do", method = RequestMethod.POST)
	public @ResponseBody String teacherExamSchedultDelete(@RequestParam("exam_info_num") int exam_info_num) //@RequestBody (비동기: 객체 형태로 받아요) 
	{	
		/*deptService.insertDept(dto);
		return dto.toString();*/
		int result = teacherService.teacherExamSchedultDelete(exam_info_num);
		String result2 = String.valueOf(result);
		return result2;
		
	}
	/* 민지 - 18.10.23 시험 일정 삭제 끝 */
}