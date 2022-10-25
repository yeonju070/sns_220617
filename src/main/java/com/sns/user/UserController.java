package com.sns.user;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	
	/*
	 * 회원가입 화면
	 */
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp");
		return "template/layout";
	}
	
	/*
	 * 로그인 화면
	 */
	@RequestMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	/*
	 * 로그아웃
	 */
	@RequestMapping("/sign_out")
	public String signOut(HttpSession session) {
		// 로그아웃 -> 세션에 있는 모든 것을 비운다.
		session.removeAttribute("userName");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userId");
		
		return "redirect:/user/sign_in_view";	
	}
	
	/*
	 * 타임라인 화면
	 */
	@RequestMapping("/timeline_view")
	public String timelineView(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}