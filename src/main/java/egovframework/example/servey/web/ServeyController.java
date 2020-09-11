package egovframework.example.servey.web;

import java.sql.Date;

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
	public String login(UserVO userVO, HttpServletRequest request, RedirectAttributes ra) {
		
		UserVO user = new UserVO();
		user = serveyService.login(userVO);
		
		if(user == null) {
			ra.addFlashAttribute("loginErrMsg", "true");
			return "redirect:/login.do";
		} else {
			 request.getSession().setAttribute("user", serveyService.login(userVO));
			return "redirect:/serveyList.do";
		}
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
	public String serveyMain(ServeyVO serveyVO, LogVO logVO, ModelMap model, RedirectAttributes ra, HttpServletRequest request) {
			
			int check = serveyService.checkServey(serveyVO);
			
			if(check == 0) { //요청된 s_seq값에 따라 DB조회결과, 해당 설문이 없을 때
				ra.addFlashAttribute("noneServey", "true");
				
				return "redirect:/serveyList.do"; 
			
			}else {
				String u_id = ((UserVO)request.getSession().getAttribute("user")).getU_id();
				logVO.setU_id(u_id);
				
				model.addAttribute("servey", serveyService.selectServey(serveyVO));
				model.addAttribute("log", serveyService.checkLog(logVO));
				
				return "servey/serveyMain";
			}
			
	}
	
	@RequestMapping(value="serveyForm.do")
	public String serveyForm(ServeyVO serveyVO, QuestionVO questionVO, LogVO logVO, ModelMap model, RedirectAttributes ra, HttpServletRequest request) {
		
		int serveyCheck = serveyService.checkServey(serveyVO);
		
		if(serveyCheck == 0) {
			ra.addFlashAttribute("noneServey", "true");
			
			return "redirect:/serveyList.do"; 
		}
		
		/* 설문조사 기한에 맞는지 체크 */
		serveyVO = serveyService.selectServey(serveyVO);
		Date now = new Date(System.currentTimeMillis());
		Date s_stratdate = serveyVO.getS_startdate();
		Date s_enddate = serveyVO.getS_enddate();

		if(now.before(s_stratdate) || now.after(s_enddate)) { // 검사기한이 지나거나, 이전일때
			ra.addFlashAttribute("notPeriod", "true");
			
			return "redirect:/serveyMain.do?s_seq=" + questionVO.getS_seq();
		}
		
		/*이미 설문에 참여한 유저인지 로그를 확인*/
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
	
	@RequestMapping(value="serveyModify.do")
	public String serveyModify(ServeyVO serveyVO, QuestionVO questionVO, LogVO logVO, ModelMap model, RedirectAttributes ra, HttpServletRequest request) {
		
		int serveyCheck = serveyService.checkServey(serveyVO);
		
		if(serveyCheck == 0) {
			ra.addFlashAttribute("noneServey", "true");
			
			return "redirect:/serveyList.do"; 
		}
		
		serveyVO = serveyService.selectServey(serveyVO);
		Date now = new Date(System.currentTimeMillis());
		Date s_stratdate = serveyVO.getS_startdate();
		Date s_enddate = serveyVO.getS_enddate();

		if(now.before(s_stratdate) || now.after(s_enddate)) {
			ra.addFlashAttribute("notPeriod", "true");
			
			return "redirect:/serveyMain.do?s_seq=" + questionVO.getS_seq();
		}
		
		/*이미 설문에 참여한 유저인지 로그를 확인*/
		String u_id = ((UserVO)request.getSession().getAttribute("user")).getU_id();
		logVO.setU_id(u_id);
		
		int check = serveyService.checkLog(logVO);
		
		if(check == 0) { // 설문 작성 기록이 없을떄
			ra.addFlashAttribute("noneLog", "true");
			
			return "redirect:/serveyMain.do?s_seq=" + questionVO.getS_seq();
			
		} else { // 있을경우 정상수행
			
			AnswerVO answerVO = new AnswerVO();
			answerVO.setS_seq(questionVO.getS_seq());
			answerVO.setU_id(u_id);
			
			model.addAttribute("questionList", serveyService.selectQuestionList(questionVO));
			model.addAttribute("choiceList", serveyService.selectChoiceList());
			model.addAttribute("answerList", serveyService.selectAnswerList(answerVO));
			
			return "servey/serveyModify";
		}
	}
	
	@RequestMapping(value="insertAnswer.do")
	@ResponseBody
	public String insertAnswer(AnswerVO answerVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		answerVO.setU_id(user.getU_id());
		
		return serveyService.insertAnswer(answerVO) + "";
	}
	
	@RequestMapping(value="updateAnswer.do")
	@ResponseBody
	public String updateAnswer(AnswerVO answerVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		answerVO.setU_id(user.getU_id());
		
		return serveyService.updateAnswer(answerVO) + "";
	}
	
	@RequestMapping(value="insertLog.do")
	@ResponseBody
	public String insertLog(LogVO logVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		logVO.setU_id(user.getU_id());
		
		return serveyService.insertLog(logVO) + "";
	}
	
	@RequestMapping(value="updateLog.do")
	@ResponseBody
	public String updateLog(LogVO logVO, HttpServletRequest request) {
		
		UserVO user = (UserVO)request.getSession().getAttribute("user");
		logVO.setU_id(user.getU_id());
		
		return serveyService.updateLog(logVO) + "";
	}
	
}
