package com.sns.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {
	
	// 좋아요 개수
	public int selectLikeCountByPostIdOrUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);

	// 좋아요가 눌렸는지 확인하는 메소드
	public boolean existLike(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	// 좋아요 개수
	public int selectLikeCountByPostId(int postId);
	
	// 좋아요가 눌려져있지 않으면 추가하는 메소드
	public void insertLike(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	// 좋아요가 눌려져있으면 삭제하는 메소드
	public void deleteLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	// 게시글 전체삭제(좋아요 리스트 삭제)
	public void deleteLikeByPostId(int postId);
}