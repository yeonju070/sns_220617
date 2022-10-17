package com.sns.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@RequestMapping("/sign_up_view")
	public String signUp() {

		return "sns/signUp";
	}

	@RequestMapping("/sign_in_view")
	public String signIn() {
		
		return "sns/signIn";
	}
}