package studyMate.service;

import studyMate.dto.File;
import java.io.IOException;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import studyMate.mapper.FileMapper;

@Service
public class FileService {
	
	@Autowired
	FileMapper fileMapper;

	/*public boolean fileUpload(MultipartHttpServletRequest multipartRequest) {
		// TODO Auto-generated method stub
		
		System.out.println("오니");
		
		boolean isSuccess = false;
		String uploadPath = "C:/BitProject";
		
		File dir = new File(uploadPath);
		
		if(!dir.isDirectory()){
			dir.mkdirs();
		}
		
		Iterator<String> iter = multipartRequest.getFileNames();
		
		while(iter.hasNext()){
			String uploadFileName = iter.next();
			//실제 파일 객체를 뽑는다.
			MultipartFile mFile = multipartRequest.getFile(uploadFileName);
			//파일명
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			if(saveFileName != null && saveFileName.equals("")){
				//같은 이름의 파일이면 + 시각 붙이기
				if(new File(uploadPath + saveFileName).exists()){
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				
				try{
					//transferTo() : 원하는 위치에 저장해줌.
					mFile.transferTo(new File(uploadPath + saveFileName));
					isSuccess = true;
				//에러처리	
				}catch(IllegalStateException e){
					e.printStackTrace();
					isSuccess = false;
				}catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} //if end
		} //while end
		
		return isSuccess;
				
	} //fileUpload end
	
	*/
	
	
	///안씀
	public void fileUpload(MultipartHttpServletRequest multipartRequest) throws IOException{
		
		Iterator<String> iter = multipartRequest.getFileNames();
		
		while(iter.hasNext()){
			
			String uploadFileName = iter.next();
			//실제 파일 객체를 뽑는다.
			MultipartFile mFile = multipartRequest.getFile(uploadFileName);
			//파일명
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			//null이 아니고 비어있지 않으면
			if(saveFileName != null && saveFileName.equals("")){
				File file = new File() ;
				file.setFileName(saveFileName);
				file.setFileSize(200);
				file.setData(mFile.getBytes());
				fileMapper.insertFile(file);			
			}
			
		}
	}

}





//별도 저장 작업을 하지 않으면 임시경로에 잠시 저장되었다가 사라지게 된다.