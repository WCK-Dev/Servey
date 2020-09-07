package egovframework.example.cmmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.servey.service.UserVO;

public class AuthInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("user");
		
		if(obj == null || ((UserVO)obj).getUser_id().equals("")) { 
			response.sendRedirect("/Servey/login.do");
			return false;
		}
		return true; // 조건문에 걸리지않으면 (로그인 상태이면) 컨트롤러에 요청정보를 전송하게 됨
	}
	
}
