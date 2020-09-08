package egovframework.example.servey.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.servey.service.AnswerVO;
import egovframework.example.servey.service.QuestionVO;
import egovframework.example.servey.service.ServeyService;
import egovframework.example.servey.service.ServeyVO;
import egovframework.example.servey.service.UserVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ServeyController {
	
	/** EgovSampleService */
	@Resource(name = "serveyService")
	private ServeyService serveyService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String login() {
		
		return "servey/login";
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(UserVO userVO, HttpServletRequest request) {
		
		request.getSession().setAttribute("user", serveyService.login(userVO));
		
		return "redirect:/serveyList.do";
	}
	
	
	@RequestMapping(value="serveyList.do")
	public String serveyMain(ModelMap model) {
		
		model.addAttribute("serveyList", serveyService.selectServeyList());
		
		return "servey/serveyList";
	}

	@RequestMapping(value="serveyMain.do")
	public String serveyMain(ServeyVO serveyVO, ModelMap model) {
		
		model.addAttribute("servey", serveyService.selectServey(serveyVO));
		
		return "servey/serveyMain";
	}
	
	@RequestMapping(value="serveyForm.do")
	public String serveyForm(QuestionVO questionVO, ModelMap model) {
		
		model.addAttribute("questionList", serveyService.selectQuestionList(questionVO));
		model.addAttribute("choiceList", serveyService.selectChoiceList());
		
		return "servey/serveyForm";
	}
	
	@ResponseBody
	@RequestMapping(value="insertAnswer.do")
	public String insertAnswer(AnswerVO answerVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		answerVO.setU_id(user.getU_id());
		
		System.err.println(serveyService.insertAnswer(answerVO));

		return "";
	}
	
}
