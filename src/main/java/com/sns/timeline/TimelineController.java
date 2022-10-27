package com.sns.timeline;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.model.CardView;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private TimelineBO timelineBO;
	
	/*
	 * 타임라인 화면
	 */
	@RequestMapping("/timeline_view")
	public String timelineView(HttpSession session, Model model) {
		
		// 로그아웃일 때 로그인 하게 이동
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}

		// List<Post> postList = postBO.getPostList();
		List<CardView> cardViewList = timelineBO.generateCardList(userId);
		
		// model.addAttribute("postList", postList);
		model.addAttribute("cardList", cardViewList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}

