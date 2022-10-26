package com.sns.timeline;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

@RequestMapping("/timeline")
@RestController
public class TimelineRestController {
	
	@Autowired
	private PostBO postBO;

	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("writeTextArea") String writeTextArea,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpSession session) {
		String userLoginId = (String)session.getAttribute("userLoginId");
		Integer userId = (Integer)session.getAttribute("userId");
		
		int row = postBO.addPost(userId, userLoginId, writeTextArea, file);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userId == null) {
			result.put("code", 300);
			result.put("errorMessage", "로그인을 해주세요");
		    return result;
		}
		
		if (row > 0) {
			result.put("code", 100);
			result.put("result", "success");
		} else {
			result.put("code", 400);
			result.put("errorMessage", "게시글 업로드에 실패했습니다.");
		}
		
		return result;
	}
}
