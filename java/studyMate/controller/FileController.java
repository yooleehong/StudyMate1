package studyMate.controller;


import java.io.BufferedOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import studyMate.dto.File;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupImage;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.FileMapper;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.FileService;
import studyMate.service.UserService;


/**
* Handles requests for the application home page.
*/
@Controller
public class FileController {
	
   @Autowired
   FileService fileService;
   @Autowired
   FileMapper fileMapper;
   @Autowired
   ImageMapper imageMapper; //[유리방금추가]
   @Autowired
   StudyGroupMapper studyGroupMapper; //[유리방금추가]
   @Autowired
   AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
   
   String FetchName="/StudyMate/studyGroupImage/";// //[유리방금추가]

   //해당 스터디 그룹의 자료공유 페이지로.
   @RequestMapping(value = "/studyRoom/fileShare/fileUpload.do", method = RequestMethod.GET)
   public String dragAndDrop(@RequestParam("idx") int studyGroupIdx, Model model) { 
	   
	   System.out.println("studygroupIdx값:  "+studyGroupIdx);
	   
	   //업로드된 파일 리스트 보여주기 위함.
	   model.addAttribute("fileList", fileMapper.selectByStudyGroup(studyGroupIdx));
	   model.addAttribute("idx", studyGroupIdx);
	 //[유리방금추가] 시작
	   StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
		
		if(studyGroupImage==null){
			StudyGroup studyGroup=new StudyGroup();
			studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
			model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
			model.addAttribute("GroupName",studyGroup.getStudyGroupName());

		}else{
			model.addAttribute("route",FetchName+studyGroupImage.getFileName());
			//model.addAttribute("route", studyGroupImage.getRoute());
			model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
		}
		
		//[유리방금추가] 끝
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();

		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();

 			if(leaderOrMember.equals("조장")){
				model.addAttribute("leader","yes");
			}else{
				model.addAttribute("leader","no");		
			}
 			
       return "studyRoom/fileShare/fileUpload";
   }
   
   //file upload
   @RequestMapping(value = "/studyRoom/fileShare/fileUpload.do", method = RequestMethod.POST)  //ajax에서 호출하는 부분
   @ResponseBody
   public String upload(MultipartHttpServletRequest multipartRequest, Model model, @RequestParam("idx") int studyGroupIdx) throws IOException { //Multipart로 받는다.
        
       Iterator<String> itr =  multipartRequest.getFileNames();
       
       while (itr.hasNext()) { //받은 파일들을 모두 돌린다.
            
           MultipartFile mpf = multipartRequest.getFile(itr.next());
           String originFileName = mpf.getOriginalFilename();
          
           System.out.println("FILE_INFO: "+originFileName); //받은 파일 리스트 출력
           
           File file = new File() ;
           
           if (mpf.getSize() > 0 ) {
        	   	file.setUserIdx(UserService.getCurrentUser().getIdx());
        	   	file.setStudyGroupIdx(studyGroupIdx);
				file.setFileName(originFileName);
				file.setFileSize((int)mpf.getSize());
				file.setData(mpf.getBytes());
				fileMapper.insertFile(file);							
           }
       
      }
       return "success";
   }
   
   
   
   //file download
   //file 테이블에서 파일 데이터를 조회하여 웹브라우저로 출력한다.
   // (웹 브라우저에서 이 파일이 다운로드 된다.)
   //HTTP Response에는 header가 포함되어 있다. -> 전송되는 데이터의 앞에 붙는 메모와 비슷한 역할
   // >헤더  ->  전송되는 데이터의 형태와 인코딩, 전송되는 데이터의 압축 여부, 전송되는 데이터가 파일인 경우에 파일명. 등등 포함
   @RequestMapping("/studyRoom/fileShare/fileDownload.do")
   public void getFile(@RequestParam Map<String, Object> map, HttpServletResponse response, @RequestParam("idx") int idx) throws Exception{
	   
	   File file = fileMapper.selectByIdx(idx);
	   if(file == null) return;
	   
	   //HTTP Response의 헤더에 파일이름을 추가 하기 전에, 파일명을 인코딩 한다.
	   String fileName = URLEncoder.encode(file.getFileName(),"UTF-8"); //한글 파일명 깨지지 않도록 함.
	   //HTTP Response에 포함된 데이터가, 다운로드할 파일이라는 정보를 헤더에 추가한다.
	   response.setContentType("application/octet-stream");
	   //HTTP Response의 헤더에 첨부 파일 이름을 추가한다.
	   response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
	   System.out.println("file의 데이타: "+file.getData());
	   //HTTP Response의 데이터를 출력하기 위한 binary output stream 객체를 생성한다.
	   try(BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())){
		   //HTTP Response의 데이터를 출력한다.
		   output.write(file.getData());
	   }
	   
   }
   
   // 파일들을 압축한  후 다운로드 한다. 
   @RequestMapping(value = "/studyRoom/fileShare/fileZipDownload.do", method = RequestMethod.POST)
   public void getZipFile(HttpServletResponse response, @RequestParam(value="txt1") String valueArr1) throws Exception{
	   
	   String[] valueArr= valueArr1.split(","); //받아온 인덱스 번호를 값으로 하는 배열 선언.
	   File[] files = new File[valueArr.length]; // File클래스 배열 선언.
	 
	   //현재 날짜와 시각 조회 (압축 파일명에 붙여주기 위함.)
	   SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
	   Date currentTime = new Date ( );
	   String mTime = mSimpleDateFormat.format ( currentTime );
	      
	   //압축될 파일 이름 
	   //String zipFileName = "C:/test/zip_file.zip";  //local 경로에 저장시 사용.
	   String zipFileName = "studyDrive_"+ mTime +".zip";
	   
	   //해더 설정
	   response.setContentType("application/zip");
	   response.addHeader("Content-Disposition", "attachment; filename=" + zipFileName+ ";");
	   //압축 파일을 생성하기 위한 객체 생성. ZipOutputStream : 압축될 바이트를 하나씩 꺼내 FileOutputStream으로 전달해 압축이 되도록함.
	   //ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
	   
	   ServletOutputStream outputStream;
 
	   try{
		   outputStream = response.getOutputStream();
		   ZipOutputStream out = new ZipOutputStream(outputStream);

		   for(int i=0; i<valueArr.length; i++){
			   
			   int fileIdx = Integer.parseInt(valueArr[i]);
			   files[i] = fileMapper.selectByIdx(fileIdx);
			   
			   String fileName = URLEncoder.encode(files[i].getFileName(),"UTF-8"); //한글 파일명 깨지지 않도록 함.		   
			   
			   //압축할 파일명들 지정.
			   ZipEntry ze = new ZipEntry(fileName);
			   out.putNextEntry(ze);
			   
			   //file data OutputStream에 write한다. (write할 데이타, 오프셋, write할 길이)
			   out.write(files[i].getData(), 0, files[i].getFileSize());
	
			   out.closeEntry();
		   }
	   
		   out.flush();
		   out.close();
	   
	   }catch (Exception e) {
		   e.printStackTrace();
	   }

   } 
   
   //파일 삭제
   @RequestMapping("/studyRoom/fileShare/fileDelete.do")
   public void deleteFile(HttpServletResponse response, @RequestParam("idx") int idx) throws Exception{
	   
	   fileMapper.deleteFile(idx);
	   
   }
   
   
}
