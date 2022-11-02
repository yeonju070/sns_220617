package com.sns.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.comment.model.Comment;

@Repository
public interface CommentDAO {

	public void insertComment(
			@Param("userId") int userId, 
			@Param("postId") int postId, 
			@Param("content") String content);
	
	public List<Comment> selectCommentListByPostId(int postId);
	
	// 게시글 전체 삭제(댓글 삭제 포함)
	public void deleteCommentByPostId(int postId);
	
	// 댓글 단독 삭제
	public void deleteCommentBYCommentIdAndUserId(
			@Param("commentId") int commentId,
			@Param("userId") int userId);
	
	// 댓글 개수
	public int selectCommentByPostIdOrUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);
}