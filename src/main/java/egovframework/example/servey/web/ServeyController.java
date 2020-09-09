package egovframework.example.servey.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.servey.service.AnswerVO;
import egovframework.example.servey.service.LogVO;
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
	
	@RequestMapping(value="logout.do")
	public String logout(HttpServletRequest request) {
		
		request.getSession().removeAttribute("user");
		
		return "redirect:/login.do";
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
	public String serveyForm(QuestionVO questionVO, ModelMap model, RedirectAttributes ra, HttpServletRequest request) {
		
		/*이미 설문에 참여한 유저인지 로그를 확인*/
		LogVO logVO = new LogVO();
		logVO.setS_seq(questionVO.getS_seq());
		String u_id = ((UserVO)request.getSession().getAttribute("user")).getU_id();
		logVO.setU_id(u_id);
		
		int check = serveyService.checkLog(logVO);
		
		if(check == 1) { // 이미 설문작성 기록이 있을때
			
			ra.addFlashAttribute("Duplicate", "true");
			
			return "redirect:/serveyMain.do?s_seq=" + questionVO.getS_seq();
		} else { // 없을경우 정상수행
			
			model.addAttribute("questionList", serveyService.selectQuestionList(questionVO));
			model.addAttribute("choiceList", serveyService.selectChoiceList());
			
			return "servey/serveyForm";
		}
	}
	
	@RequestMapping(value="insertAnswer.do")
	@ResponseBody
	public String insertAnswer(AnswerVO answerVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		answerVO.setU_id(user.getU_id());
		
		return serveyService.insertAnswer(answerVO) + "";
	}
	
	@RequestMapping(value="insertLog.do")
	@ResponseBody
	public String insertLog(LogVO logVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		logVO.setU_id(user.getU_id());
		
		return serveyService.insertLog(logVO) + "";
	}
	
}
