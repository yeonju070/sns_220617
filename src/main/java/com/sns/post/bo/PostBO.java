package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.dao.PostDAO;
import com.sns.post.model.Post;

@Service
public class PostBO {

	@Autowired
	private PostDAO PostDAO;

	@Autowired
	private FileManagerService fileManagerService;

	public int addPost(int userId, String userLoginId, String writeTextArea, MultipartFile file) {

		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 처리 => 서버에 업로드
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}

		return PostDAO.insertPost(userId, userLoginId, writeTextArea, imagePath);
	}

	public List<Post> getPostList() {
		return PostDAO.selectPostList();
	}
}
