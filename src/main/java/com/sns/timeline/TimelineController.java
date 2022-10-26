package com.sns.timeline;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.model.Post;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	/*
	 * 타임라인 화면
	 */
	@RequestMapping("/timeline_view")
	public String timelineView(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}

		List<Post> postList = postBO.getPostList();
		// List<CardView> 
		
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}

