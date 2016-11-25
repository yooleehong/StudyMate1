package studyMate.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import studyMate.dto.Image;
import studyMate.dto.StreamImage;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupImage;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.mapper.UserMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.UserService;

@Controller
public class MemberController {

	@Autowired
	UserMapper userMapper;

	@Autowired
	UserService userService;

	@Autowired
	ImageMapper imageMapper;
	@Autowired
	StudyGroupMapper studyGroupMapper;//[유리방금추가]
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
	
	String dirName = "C:/Users/user/workspace/StudyMate/src/main/webapp/upload2/";//[9월30일 수정]서버의 webapp 경로로 변경 -승일이
	String dirName2 = "C:/Users/user/workspace/StudyMate/src/main/webapp/studyGroupImage/"; //승일이
	String dirName3 = "C:/Users/user/workspace/StudyMate/src/main/webapp/StreamImage/";// 승일이
	
/*	String dirName = "C:/BitProject/StudyMate/src/main/webapp/upload2/";//[9월30일 수정]서버의 webapp 경로로 변경 - 성경이
	String dirName2 = "C:/BitProject/StudyMate/src/main/webapp/studyGroupImage/"; //- 성경이
	String dirName3 = "C:/BitProject/StudyMate/src/main/webapp/StreamImage/";//[10월18일 수정] - 성경이
*/	String FetchName="/StudyMate/upload2/";//[9월30일 추가] 이미지 불러올 경로
	String FetchName1="/StudyMate/studyGroupImage/";// //[유리방금추가]
	
	/*@RequestMapping(value = "/member/user/main.do")
	@RequestMapping(value = "/member/user/myPage.do")
	public String main(Model model){
		return "member/user/main";
		return "member/user/myPage";
	}*/

	@RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
	public String login(HttpSession session,Model model) throws IOException{
		session.removeAttribute("loginIdx");
		File dir = new File(dirName);
		File dir2 = new File(dirName2);//[10월17일 추가]
		File dir3 = new File(dirName3);//[10월18일 추가]
		
		if (!dir2.isDirectory()) {//[10월17일 추가]
			dir2.mkdirs();
			//다가져와서 만들기
			List<StudyGroupImage> image=imageMapper.StudyAllShow(); //회원이미지 다가져옴
			Iterator<StudyGroupImage> itr = image.iterator();
			while (itr.hasNext()) {   	    
				StudyGroupImage oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName2, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기    


		}else if (dir2.isDirectory()) {//[10월17일 추가]
			dir2.delete();
			dir2.mkdirs();
			//다가져와서 만들기
			List<StudyGroupImage> image=imageMapper.StudyAllShow(); //회원이미지 다가져옴
			Iterator<StudyGroupImage> itr = image.iterator();  	        	
			while (itr.hasNext()) {    	    
				StudyGroupImage oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName2, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기	    	

		}
		
		if (!dir3.isDirectory()) {//[10월18일 추가]
			dir3.mkdirs();
			//다가져와서 만들기
			System.out.println("dir3없을때");
			List<StreamImage> image=imageMapper.StreamAllShow(); //회원이미지 다가져옴
			Iterator<StreamImage> itr = image.iterator();
			while (itr.hasNext()) {   	    
				StreamImage oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName3, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기    


		}else if(dir3.isDirectory()) {//[10월18일 추가]
			dir3.delete();
			dir3.mkdirs();
			//다가져와서 만들기
			System.out.println("dir3있을때");
			List<StreamImage> image=imageMapper.StreamAllShow(); //회원이미지 다가져옴
			Iterator<StreamImage> itr = image.iterator();  	        	
			while (itr.hasNext()) {    	    
				StreamImage oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName3, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기	    	

		}
	
		



		if (dir.isDirectory()) {
			dir.delete();
			dir.mkdirs();
			List<Image> image=imageMapper.allShow(); //회원이미지 다가져옴
			Iterator<Image> itr = image.iterator();  	        	
			while (itr.hasNext()) {    	    
				Image oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기	    	   
		}else if(!dir.isDirectory()) {
			dir.mkdirs();
			List<Image> image=imageMapper.allShow(); //회원이미지 다가져옴
			Iterator<Image> itr = image.iterator();
			while (itr.hasNext()) {   	    
				Image oneImage=itr.next();
				byte[] data=( byte[])oneImage.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));	
				ImageIO.write(imag, "png", new File(dirName, oneImage.getFileName()));//하나의 회원 이미지를 폴더에 넣어두기
			}//회원모두꺼 다 넣기        
		}
		model.addAttribute("user", new User());
		return "member/login";
	}

	@RequestMapping(value = "/member/join.do", method = RequestMethod.GET)
	public String join(Model model){
		model.addAttribute("user", new User());
		return "member/join";
	}

	@RequestMapping(value = "/member/join.do", method = RequestMethod.POST)
	public String join(Model model, User user){

		String message = userService.userValidateBeforeJoin(user);
		if(message == null){ //가입 가능할시
			userMapper.insert(user); 
			Image image=imageMapper.show(1111); //이미지를 임시로 userIdx를 1111로 맞춰둠  
			image.setUserIdx(user.getIdx()); //1111을 나의 userIdx로 바꿔 임시로 이미지dto에 저장
			imageMapper.setIdx(image); //userIdx 1111 을 설정한 userIdx 로 바꿈
			model.addAttribute("success", "<script type='text/javascript'>alert('가입되었습니다.');</script>");
			return "member/login";
		}else{
			model.addAttribute("error", message);
			return "member/join";
		}
	}

	//회원정보 수정
	/*@RequestMapping(value = "/member/user/myProfile.do", method = RequestMethod.GET)*/
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/myInfoModify.do", method = RequestMethod.GET)
	public String myProfile(Model model){
		//UserService 클래스의 static 메소드로 현재 세션에 있는(로그인 한) User를 꺼내는 메소드
		User user=UserService.getCurrentUser();
		model.addAttribute("user",user);
		Image image=imageMapper.show(user.getIdx()); //유저 IDX 에 맞는 이미지 꺼내옴
		if(image==null){//조회결과가 null=이미지 없는사람
			model.addAttribute("url","/StudyMate/resources/images/icon-my0.png");//임의의 이미지 보여줌

		}
		else{
			model.addAttribute("url",FetchName+image.getFileName());//나의 사진을 조회해 가져와 보여줌[9월30일 수정]경로 dirname으로 변경

		}
		return "member/user/myInfoModify";
	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/myInfoModify.do", method = RequestMethod.POST)
	public String myProfile(Model model, User user){

		String message = userService.userValidateBeforeUpdate(user);

		if(message == null){
			userMapper.update(user);

			//현재 세션도 업데이트
			UserService.setCurrentUser(user);
			model.addAttribute("success", "수정이 완료되었습니다.");
		}else{
			model.addAttribute("error", message);
		}
		Image image=imageMapper.show(user.getIdx()); //유저 IDX 에 맞는 이미지 꺼내옴
		if(image==null){//사진안넣은사람
			model.addAttribute("url","/StudyMate/resources/images/icon-my0.png");//임의의 이미지 보여줌

		}
		else{
			model.addAttribute("url",FetchName+image.getFileName());//나의 사진을 조회해 가져와 보여줌[9월30일 수정]경로 dirname으로 변경

		}

		return "member/user/myInfoModify";
	}

	//회원 탈퇴
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/unregister.do", method = RequestMethod.GET)
	public String unregister(Model model){
		model.addAttribute("user", UserService.getCurrentUser());

		return "member/user/unregister";
	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/unregister.do", method = RequestMethod.POST)
	public String unregister(Model model, User user, @RequestParam("password2") String password2, @RequestParam("idx") int idx){

		User currentUser = UserService.getCurrentUser();

		if(currentUser.getPassword().equals(password2)){
			Image image=imageMapper.show(idx);//idx에 맞는 이미지 조회
			if(image==null){//이미지 없는회원이면
				//아무것도 안한다.
			}
			else{//이미지있는 회원이면

				String deleteName=image.getFileName(); //이미지의 파일이름을 넣는다.
				File dir = new File(dirName+deleteName); //삭제할 파일 만들어서
				if (dir.isFile()) { //파일 존재여부 체크
					System.out.println("파일존재");
					dir.delete(); //존재하므로 폴더에서 이미지 삭제
				}

				imageMapper.fileDelete(idx); //이미지DB 에서 이미지 삭제

			}

			userMapper.deleteByIdx(idx); //유저 마무리로 삭제

			model.addAttribute("success","<script type='text/javascript'>alert('그동안 이용해주셔서 감사합니다.');</script>");
			return "member/login";

		}else{
			model.addAttribute("error","비밀번호가 일치하지 않습니다.");
			return "member/user/unregister";
		}

	}


	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/mySchedule.do" , method = RequestMethod.GET)
	public String mySchedule(){
		return "member/user/mySchedule";
	}



	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/fileShare/fileShare.do", method = RequestMethod.GET)
	public String test7(){
		return "studyRoom/fileShare/fileShare";
	}









	@RequestMapping(value = "/member/user/findId.do", method = RequestMethod.GET)
	public String test1(){
		return "member/user/findId";
	}
	@RequestMapping(value = "/member/user/findPw.do", method = RequestMethod.GET)
	public String test2(){
		return "member/user/findPw";
	}



	@RequestMapping(value = "/member/user/myPage.do", method = RequestMethod.GET)
	public String test6(){
		return "member/user/myPage";
	}

	//10.18 -성경
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/locate/locate.do", method = RequestMethod.GET)
	public String test8(@RequestParam("idx") int studyGroupIdx, Model model){

		model.addAttribute("idx", studyGroupIdx);
		//[유리방금추가] 시작
				StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);
				
				if(studyGroupImage==null){
					StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
					model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
					model.addAttribute("GroupName",studyGroup.getStudyGroupName());

				}else{
					model.addAttribute("route",FetchName1+studyGroupImage.getFileName());
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

		return "studyRoom/locate/locate";
	}

}
