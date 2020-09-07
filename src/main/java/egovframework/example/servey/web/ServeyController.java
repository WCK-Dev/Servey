package egovframework.example.servey.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.servey.service.ServeyService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ServeyController {
	
	/** EgovSampleService */
	@Resource(name = "serveyService")
	private ServeyService serveyService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	
	@RequestMapping(value="serveyMain.do")
	public String serveyMain() {
		
		System.out.print("설문 Form로 이동하게 수정");
		
		return "servey/serveyForm";
	}
	
}
