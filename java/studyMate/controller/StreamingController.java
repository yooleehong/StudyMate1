package studyMate.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import studyMate.dto.Image;
import studyMate.dto.Pagination;
import studyMate.dto.Stream;
import studyMate.dto.StreamImage;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupBoard;
import studyMate.dto.StudyGroupImage;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.dto.WebcamBoard;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.StreamMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.mapper.WebcamMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.BoardService;
import studyMate.service.StreamingService;
import studyMate.service.UserService;

@Controller
public class StreamingController {
	
	@Autowired
	StreamMapper streamMapper;
	@Autowired
	WebcamMapper webcamMapper;
	@Autowired	
	ImageMapper imageMapper;//[10월18일 추가]
	@Autowired
	StudyGroupMapper studyGroupMapper;//[유리방금추가]
	@Autowired
	StreamingService streamingService;
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
	
	String FetchName="/StudyMate/studyGroupImage/";// //[유리방금추가]
	String dirName = "C:/red5-server/webapps/oflaDemo/streams/";
	String dirName2 = "C:/Users/user/workspace/StudyMate/src/main/webapp/StreamImage/";
	//해당 게시글에 대한 댓글 등록
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/main.do")
	public String streaming(Model model){
		
		
		return "streaming/main";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/upload.do" , method = RequestMethod.GET) //기본 페이지 로딩
	public String upload(HttpSession session,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		//[유리방금추가] 시작
		StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
		
		if(studyGroupImage==null){
			StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
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
		
		return "streaming/upload";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/StreamBoard.do") //스트림 보드
	public String StreamBoard(HttpSession session,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
	if(studyGroupIdx>0){
			pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
			model.addAttribute("idx",studyGroupIdx);
		}
		 pagination.setRecordCount(streamMapper.StreamCount(pagination));
	       model.addAttribute("list", streamMapper.StreamPage(pagination));
	       	model.addAttribute("streamLists", imageMapper.selectStreamImage(studyGroupIdx));//[10월19일추가]스터디 idx에 맞는 모든이미지 정보 저장
	    	//[유리방금추가] 시작
			StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
			
			if(studyGroupImage==null){
				StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
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
	       	
	       	
		return "streaming/StreamBoard";
	}	

	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/StreamDetails.do") //스트림 보드 클릭시 
	public String StreamDetails(Stream stream,Model model,Pagination pagination,HttpSession session){
		 stream =streamMapper.StreamDetailPage(stream.getIdx()); 
		model.addAttribute("stream",stream);//idx에 맞는 정보 조회
		 int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		 model.addAttribute("idx",studyGroupIdx);
		 model.addAttribute("streamList", streamMapper.selectIdxStream(stream));//[10월19일추가]useridx와 스터디그룹idx에맞는동영상가져오기
		 model.addAttribute("streamImageList", imageMapper.selectStreamImage(studyGroupIdx));//[10월19일추가]스터디 idx에 맞는 모든이미지 정보 저장
		 StreamImage streamImage=new StreamImage(); 
		 streamImage = imageMapper.selectImage(stream);
		 if(streamImage==null){
			 
			 model.addAttribute("streamRoute","/StudyMate/resources/images/streamMain.PNG");//[10월19일추가]스트림idx에 맞는 이미지가져오기
		 }else{
			 model.addAttribute("streamRoute","/StudyMate/StreamImage/"+streamImage.getFileName());//[10월19일추가]스트림idx에 맞는 이미지가져오기		  
		 }
		//[유리방금추가] 시작
			StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
			
			if(studyGroupImage==null){
				StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
				model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
				model.addAttribute("GroupName",studyGroup.getStudyGroupName());

			}else{
				model.addAttribute("route",FetchName+studyGroupImage.getFileName());
				//model.addAttribute("route", studyGroupImage.getRoute());
				model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
			}
			
			//[유리방금추가] 끝
		 //삭제버튼
			if(streamingService.inspectionAuthority(stream)){
			model.addAttribute("Authority","yes");	//권한
			}else{
			model.addAttribute("Authority","no");
			}
			User user = UserService.getCurrentUser();
			String loginId = user.getLoginId();

			User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

			String leaderOrMember = uusg.getMemberType();

	 			if(leaderOrMember.equals("조장")){
					model.addAttribute("leader","yes");
				}else{
					model.addAttribute("leader","no");		
				}
			
		return "streaming/StreamDetails";
	}	
	
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/upload.do" , method = RequestMethod.POST)//파일업로드 
	public String upload(Stream stream,Model model,HttpSession session,MultipartHttpServletRequest multipartRequest,Pagination pagination) { //Multipart로 받는다.
        
        Iterator<String> itr =  multipartRequest.getFileNames();
        
       
       
        while (itr.hasNext()) { //받은 파일들을 모두 돌린다.
             
            MultipartFile mpf = multipartRequest.getFile(itr.next());//파일하나를 가져옴
            try {
				BufferedImage bufferImage = ImageIO.read(mpf.getInputStream()); //파일읽기
				ByteArrayOutputStream baos = new ByteArrayOutputStream();//OutputStream 으로 저장
				
					String genId = UUID.randomUUID().toString(); // 파일 중복명 처리를 위한 랜덤이름
		            String originFileName = mpf.getOriginalFilename();//파일의경로
		            String fileName = genId + "." + FilenameUtils.getExtension(originFileName);// 저장되는 파일 이름(x.mp4)
		            System.out.println(genId+"/"+originFileName+"/"+fileName);
		            String savePath = dirName + fileName; // 저장 될 파일 경로
	                long fileSize = mpf.getSize(); // 파일 사이즈
	                mpf.transferTo(new File(savePath)); //파일을 폴더에 생성
	                stream.setFileName(fileName);//저장 된 파일이름
	                stream.setRoute(savePath); //저장경로
	                stream.setUserIdx((int)session.getAttribute("loginIdx"));//받아온 idx
	                stream.setStudyGroupIdx((int)session.getAttribute("studyGroupIdx")); //받아온 그룹 번호로 셋팅
	                streamMapper.insert(stream);//DB에 데이터 삽입
	                model.addAttribute("success","<script type='text/javascript'>alert('동영상 업로드 완료');</script>"); //업로드 완료 메세지 작성
	                model.addAttribute("stream",streamMapper.selectStream(fileName));//idx에 맞는 정보 조회[10월18일수정]
            } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
          //[유리방금추가] 시작
    		StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
    		
    		if(studyGroupImage==null){
    			StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
    			model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
    			model.addAttribute("GroupName",studyGroup.getStudyGroupName());

    		}else{
    			model.addAttribute("route",FetchName+studyGroupImage.getFileName());
    			//model.addAttribute("route", studyGroupImage.getRoute());
    			model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
    		}
    		
    		//[유리방금추가] 끝
            
       }
		return "streaming/uploadNext"; //[10월18일수정]
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/uploadNext.do" , method = RequestMethod.GET)//[10월 18일 추가]
	public String uploadGet(HttpSession session,Stream stream,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		//[유리방금추가] 시작
				StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
				
				if(studyGroupImage==null){
					StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
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
		
		return "streaming/uploadNext";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/uploadNext.do" , method = RequestMethod.POST)//[10월 18일 추가]
	public String uploadPost(Stream stream,Model model,MultipartHttpServletRequest multipartRequest,HttpSession session,Pagination pagination){
		StreamImage streamImage = new StreamImage();
		Iterator<String> itr =  multipartRequest.getFileNames();

		while (itr.hasNext()) { //받은 파일들을 모두 돌린다.

			MultipartFile mpf = multipartRequest.getFile(itr.next());//파일하나를 가져옴
			try {
				
				BufferedImage bufferImage = ImageIO.read(mpf.getInputStream()); //파일읽기
				ByteArrayOutputStream baos = new ByteArrayOutputStream();//OutputStream 으로 저장

				String genId = UUID.randomUUID().toString(); // 파일 중복명 처리를 위한 랜덤이름
				String originFileName = mpf.getOriginalFilename();//파일의경로
				String fileName = genId + "." + FilenameUtils.getExtension(originFileName);// 저장되는 파일 이름(x.mp4)
				System.out.println(genId+"/"+originFileName+"/"+fileName);
				String savePath = dirName2 + fileName; // 저장 될 파일 경로
				long fileSize = mpf.getSize(); // 파일 사이즈
				mpf.transferTo(new File(savePath)); //파일을 폴더에 생성
				streamImage.setFileName(fileName);
				streamImage.setRoute(savePath); //저장경로
				int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
				streamImage.setStudyGroupIdx(studyGroupIdx); //받아온 그룹 번호로 셋팅
				streamImage.setFileSize(fileSize);//파일사이즈
				streamImage.setData(mpf.getBytes());
				streamImage.setStreamIdx(stream.getIdx());
				streamImage.setStreamTitle(stream.getTitle());
				streamImage.setStreamUserIdx((int)session.getAttribute("loginIdx"));
				imageMapper.streamInsert(streamImage);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		model.addAttribute("stream",streamMapper.selectStream(stream.getFileName()));//idx에 맞는 정보 조회[10월18일수정]
		 
		return "streaming/StreamDetailing";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/StreamDetailing.do")//[10월 1일 추가]
	public String StreamDetailing(Model model){
	
		return "streaming/StreamDetailing";
	}	
	
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/main.do")//[10월 1일 추가]
	public String main(Model model){
	
		return "streaming/webcam/main";
	}	

	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/StreamDelete.do")//[10월 1일 추가]
	public String StreamDelete(HttpSession session,Stream stream,Pagination pagination,Model model){
		streamMapper.streamDelete(stream.getIdx());
		
		return "streaming/StreamDelete";
	}	
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/board.do")//[10월 1일 추가] 웹캠들어왔을때 첫페이지
	public String board(HttpSession session,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		if(studyGroupIdx>0){
				pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
				model.addAttribute("studyGroupIdx",studyGroupIdx);
			}
			 pagination.setRecordCount(webcamMapper.webcamCount(pagination)); //보드 페이지 글수
		       model.addAttribute("list", webcamMapper.webcamPage(pagination));//보드페이지 글조회
		       
		return "streaming/webcam/board";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/boardDtails.do")//[10월 1일 추가] 보드 글 클릭시 들어가는페이지(만든사람일때)
	public String boardDtails(HttpSession session,@RequestParam("idx") int idx,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		if(studyGroupIdx>0){
				pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
				model.addAttribute("studyGroupIdx",studyGroupIdx);
			}
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		model.addAttribute("webcam",webcamMapper.webcamSelect(idx));  //캠보드idx에 맞는웹캠 db조회
		return "streaming/webcam/boardDtails";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/boardObserve.do")//[10월 1일 추가] 보드 글 클릭시 들어가는페이지(만든사람이아닐때)
	public String boardObserve(HttpSession session,@RequestParam("idx") int idx,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		if(studyGroupIdx>0){
				pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
				model.addAttribute("studyGroupIdx",studyGroupIdx);
			}
		model.addAttribute("webcam",webcamMapper.webcamSelect(idx)); //캠보드idx에 맞는웹캠 db조회
		
		return "streaming/webcam/boardObserve";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/setting.do")//[10월 1일 추가] 보드글 클릭시 만든사람일때 캠 서버여는페이지
	public String setting(Model model,Pagination pagination){
		return "streaming/webcam/setting";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/create.do" , method = RequestMethod.GET)//[10월 1일 추가]캠 보드 만드는 페이지
	public String create(HttpSession session,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		if(studyGroupIdx>0){
				pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
				model.addAttribute("studyGroupIdx",studyGroupIdx);
			}
		return "streaming/webcam/create";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/create.do" , method = RequestMethod.POST)//[10월 1일 추가] 캠보드 만들때  폼에서 post로 받음
	public String create(WebcamBoard webcamBoard,HttpSession session,Model model,Pagination pagination){
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx");
		if(studyGroupIdx>0){
				pagination.setIdx(studyGroupIdx); //페이지 네이션에 studyGroupIdx 실어보냄
				model.addAttribute("studyGroupIdx",studyGroupIdx);
				webcamBoard.setStudyGroupIdx(studyGroupIdx);
			}
		int loginIdx =(int)session.getAttribute("loginIdx");
		webcamBoard.setUserIdx(loginIdx); //캠보드정보  title만 받았기에 useridx 도 심어줌 
		webcamMapper.webcamInsert(webcamBoard);//캠방 DB에 넣기
		return "streaming/webcam/creating";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/creating.do")//[10월 1일 추가] 추가시 파라미터 정상 전달을 위해 거쳐서 가는 PAGE
	public String creating(Model model,Pagination pagination){

		return "streaming/webcam/creating";
	}
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/page1.do")//[10월 1일 추가]  파라미터 정상 전달을 위해 거쳐서 가는 PAGE1 (실제로는 boardDtails 로이동)
	public String page1(Model model,Pagination pagination){

		return "streaming/webcam/page1";
	}
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/page2.do")//[10월 1일 추가] 파라미터 정상 전달을 위해 거쳐서 가는 PAGE1 (실제로는 boardObserve 로이동)
	public String page2(Model model,Pagination pagination){

		return "streaming/webcam/page2";
	}
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/end.do")//[10월 1일 추가] 방송 종료 클릭시 방송 삭제
	public String end(WebcamBoard webcamBoard,Model model,Pagination pagination){
		webcamMapper.webcamDelete(webcamBoard.getIdx());//방송삭제후
		return "streaming/webcam/creating";//보드로 이동
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/webcam/authority.do")//[10월 1일 추가] 보드 클릭시 넘어가는 페이지로 여기서 만든사람인지 아닌지 구별
	public String authority(HttpSession session,WebcamBoard webcamBoard,Model model,Pagination pagination){
		webcamBoard =webcamMapper.webcamSelect(webcamBoard.getIdx()); //보드 idx에 맞는 캠보드db조회
		int loginIdx =(int)session.getAttribute("loginIdx");
		int createIdx=webcamBoard.getUserIdx();
		model.addAttribute("idx", webcamBoard.getIdx());
		if(createIdx==loginIdx){//보드의  만든유저IDX와 로그인한 IDX가 같으면 서버생성페이지로
		return "streaming/webcam/page1";
		}else{ //아니면 보드 그냥 보는페이지
			return "streaming/webcam/page2";	
		}
	}
	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/ViewChating/main.do")//[10월 10일 추가] 화상 채팅
	public String ViewChating(Model model){

		return "streaming/ViewChating/main";
	}

	@Secured("ROLE_전체")
	@RequestMapping(value="/streaming/ViewChating/room.do")//[10월 11일 추가] 화상 채팅
	public String room(){

		return "streaming/ViewChating/room";
	}
	
	

}
