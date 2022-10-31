package com.sns.post.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.dao.PostDAO;
import com.sns.post.model.Post;

@Service
public class PostBO {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private LikeBO likeBO;

	@Autowired
	private FileManagerService fileManagerService;

	public int addPost(int userId, String userLoginId, String writeTextArea, MultipartFile file) {

		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 처리 => 서버에 업로드
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}

		return postDAO.insertPost(userId, userLoginId, writeTextArea, imagePath);
	}

	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public Post getPostByPostIdAndUserId(int postId, int userId) {
		return postDAO.selectPostByPostIdAndUserId(postId, userId);
	}
	
	public void deletePost(int postId, int userId) {
		// 기존글 가져오기
		Post post = getPostByPostIdAndUserId(postId, userId);
		if(post == null) {
			log.warn("[delete post] 삭제할 게시글이 없습니다. postId:{}", postId);
			return;
		}
		
		// 이미지가 있으면 이미지 삭제
		if (post.getImagePath() != null) {
			fileManagerService.deleteFile(post.getImagePath());
		}
		
		// 글 삭제
		postDAO.deletePost(postId, userId);
		
		// 좋아요들 삭제
		likeBO.getLikeCountByPostId(postId);
		
		// 댓글들 삭제
	}
}
