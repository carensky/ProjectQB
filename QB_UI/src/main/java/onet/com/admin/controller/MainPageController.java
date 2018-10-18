package onet.com.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import onet.com.admin.service.AdminMainPageService;
import onet.com.vo.ClassDto;

@Controller
@RequestMapping(value="/admin/")
public class MainPageController {
	
	@Autowired
	private AdminMainPageService adminMainPageService;
	/*태용 시작*/
	@RequestMapping(value="classInsert.do",method=RequestMethod.POST)
	public String classInert(ClassDto dto) {
		
		int result = 0;
		String viewpage="";
		
		result = adminMainPageService.classInsert(dto);
		if(result > 0) {
			viewpage = "redirect:adminMain.do";
		}
		return viewpage;
	}

	@RequestMapping(value="classCheck.do")
	public @ResponseBody Map<String, Object> idCheck(@RequestParam("class_name") String class_name) {
		String classname = adminMainPageService.classCheck(class_name);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", classname == null);
		map.get("result");
		return map;
	}
	
	@RequestMapping(value="classSearch.do")
	public @ResponseBody Model classSearch(Model model, @RequestParam("searchtext") String searchtext){
		List<ClassDto> search_text = adminMainPageService.classSearch(searchtext);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", search_text);
		model.addAttribute("result",search_text);
		System.out.println(map.get("result"));
		return model;
	}
	/*태용 끝*/
}