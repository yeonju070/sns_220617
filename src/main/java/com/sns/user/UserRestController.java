package com.sns.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.common.EncryptUtils;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@RequestMapping("/user")
@RestController    // @Controller + @ResponseBody
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Object> result = new HashMap<>();
		boolean isDuplicated = userBO.existLoginId(loginId);
		if (isDuplicated) {
			result.put("result", true); // 중복
			result.put("code", 100); // 성공
		} else {
			result.put("result", false); // 중복 아님
			result.put("code", 100); // 성공
		}
				
		return result;
	}
	
	/*
	 * 회원가입 API
	 * @param loginId
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		// 암호화 => 해싱       aaaa  =>asdjklfaljk         aaaa =>asdjklfaljk
		// md5 
		String encryptPassword = EncryptUtils.md5(password);
		
		// db insert
		userBO.addUser(loginId, encryptPassword, name, email);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 100);
		result.put("result", "success");
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request) {
		
		// password 해싱		-> DB에서 id, 해싱된 password로 가져와 본다.
		//					   있으면 로그인, 없으면 잘못된 정보
		String encryptPassword = EncryptUtils.md5(password);
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		if (user != null) {	// 로그인 가능
			result.put("code", 100);	// 성공
			result.put("result", "success");
			
			// 세션에 유저 정보를 담는다.(로그인 상태 유지)
			HttpSession session = request.getSession();
			session.setAttribute("userName", user.getName());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userId", user.getId());
		} else {	// 로그인 실패
			result.put("code", 400);	// 실패
			result.put("errorMessage", "존재하지 않는 사용자입니다.");
		}
		
		return result;
	}
}