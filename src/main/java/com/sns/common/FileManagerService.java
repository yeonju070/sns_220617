package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component	// 일반적인 String bean
public class FileManagerService {
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	// 마지막 / 를 쳐서 경로 추가
	// 실제 이미지가 저장될 경로(서버)
	public static final String FILE_UPLOAD_PATH = "C:\\Users\\강정빈\\spring_project\\sns\\workspace\\images/";
	
	// input : MultipartFile, userLoginId
	// output : imagePath(DB의 imagePath)
	public String saveFile(String userLoginId, MultipartFile file) {
		// 파일 디렉토리 예) yeonJu_19324356/sun.png
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/"; // yeonJu_19324356/
		String filePath = FILE_UPLOAD_PATH + directoryName;	// C:\\Users\\강정빈\\spring_project\\memo\\workspace\\images/yeonJu_19324356/
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;	// directory 생성 실패시 null return
		}
		
		// 파일 업로드 : byte 단위로 파일 업로드한다.
		// BO로 보내지않고 업로드가 실패한다면 여기서 수행하고 끝낸다.
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());	// OriginalFilename은 사용자가 업로드한 파일 이름이다.
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		// 성공했으면 이미지 url path를 리턴한다.(WebMvconfig에서 매핑한 이미지 path)
		// http://localhost/images/yeonJu_19324356/sun.png
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	public void deleteFile(String imagePath) {
		// imagePath : /images/yeonJu_19324356/sun.png
		
		// /images/ => 이 구문을 제거
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path)) {
			try {
				Files.delete(path);	// 이미지 삭제
			} catch (IOException e) {
				log.error("[이미지 삭제] 이미지 삭제 실패 imagePath{}", imagePath);
			}
			
			// 디렉토리(폴더) 삭제
			path = path.getParent();
			if (Files.exists(path)) {
				try {
					Files.delete(path);	// 디렉토리 삭제
				} catch (IOException e) {
					log.error("[이미지 삭제] 디렉토리 삭제 실패 imagePath{}", imagePath);
				}
			}
		}
	}
}