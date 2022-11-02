package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	// 좋아요 토글
	public void likeToggle(int postId, int userId) {
		// 좋아요 있는지 확인
		if (getLikeCountByPostIdOrUserId(postId, userId) > 0) {
			// 있으면 제거
			likeDAO.deleteLikeByPostIdUserId(postId, userId);
		} else {
			// 없으면 추가
			likeDAO.insertLike(postId, userId);
		}
	}
	
	public int getLikeCountByPostIdOrUserId(int postId, Integer userId) {
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, userId);
	}
	
	// 내가 좋아요를 눌렀는지 확인하는 메소드
	public boolean existLike(int postId, int userId) {
		return likeDAO.existLike(postId, userId);
	}
	
	// 좋아요 개수 메소드
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostId(postId);
	}
	
	// 게시글 전체 삭제(좋아요 리스트 삭제)
	public void deleteLikeByPostId(int postId) {
		likeDAO.deleteLikeByPostId(postId);
	}
}