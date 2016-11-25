package studyMate.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.sf.json.JSONObject;
import studyMate.dto.Pagination;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupImage;
import studyMate.dto.TemporaryStudyGroup;
import studyMate.dto.TemporaryUser_StudyGroup;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.mapper.UserMapper;
import studyMate.mapper.User_StudyGroupMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.StudyGroupService;
import studyMate.service.UserService;
import studyMate.util.PageUtil;

@Controller
public class StudyGroupController {

	@Autowired
	StudyGroupMapper studyGroupMapper;
	@Autowired
	StudyGroupService studyGroupService;
	@Autowired
	UserMapper userMapper;
	@Autowired
	User_StudyGroupMapper user_studyGroupMapper;
	@Autowired
	ImageMapper imageMapper;
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
	
	
	
	
	

	//String dirName = "C:/Users/user/workspace/StudyMate/src/main/webapp/studyGroupImage/";//승일이
	String dirName = "C:/develop/eclipse_work/StudyMate/src/main/webapp/studyGroupImage/";
	String FetchName="/StudyMate/studyGroupImage/";// //[유리방금추가]
	//1-1)로그인한 user가 가입한 스터디 그룹 리스트 조회
	//1-2)가입된 스터디 없으면 추천 스터디 그룹 리스트 조회 
	//2)승인대기 스터디 그룹 리스트 조회

	@Secured("ROLE_전체")
	@RequestMapping(value="/studyMain/studyRecommendList.do")
	public String recommendList(HttpSession session,Model model, Pagination pagination){
		/*새롭게 추가된 부분*/
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();//시큘리티를 이용한 loginid 조회
		String loginId=authentication.getName();
		User user=userMapper.selectByLoginId(loginId); //조회한 loginId user 조회
		session.setAttribute("loginIdx", user.getIdx()); //조회한 유저의 idx를 세션에 심음

		user = UserService.getCurrentUser();

		if(user.getLoginId().equals("admin"))//관리자가 로그인 하면
			return "redirect:/manager/main.do";//관리자 페이지로 redirect
		else{
			model.addAttribute("list", studyGroupMapper.selectRecommendList());
			pagination.setRecordCount(studyGroupMapper.selectCountStudyGroup(pagination));
			model.addAttribute("list2", studyGroupMapper.selectPageStudyGroupList(pagination));
			model.addAttribute("test2","none");
			model.addAttribute("test1","block");
			model.addAttribute("images",imageMapper.allShow());//[유리방금추가]
			model.addAttribute("groupImages",imageMapper.StudyAllShow());//[유리방금추가]
			return "/studyMain/studyRecommendList";
		}
	}

	@Secured("ROLE_전체")
	@RequestMapping(value="/studyMain/studyRecommendList.do", method = RequestMethod.POST)
	public String recommendListPost(Model model, Pagination pagination){

		User user = UserService.getCurrentUser();

		if(user.getLoginId().equals("admin"))//관리자가 로그인 하면
			return "redirect:/manager/main.do";//관리자 페이지로 redirect
		else{
			model.addAttribute("list", studyGroupMapper.selectRecommendList());

			pagination.setRecordCount(studyGroupMapper.selectCountStudyGroup(pagination));
			model.addAttribute("list2", studyGroupMapper.selectPageStudyGroupList(pagination));
			model.addAttribute("test2","inline");
			model.addAttribute("test1","none");

			return "/studyMain/studyRecommendList";
		}
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/layerDetal.do", method = RequestMethod.GET)
	public void layerDetal(Model model, HttpServletResponse response, @RequestParam("idx") int studyIdx){
		StudyGroup studyGroup =  studyGroupMapper.selectByStudyIdx(studyIdx);
		
		String studyGroupName = studyGroup.getStudyGroupName();
		String leaderName = studyGroup.getLeaderName();
		int maxCounter = studyGroup.getMaxCounter();
		String studyGroupGoal = studyGroup.getStudyGroupGoal();
		String studyGroupContents = studyGroup.getStudyGroupContents();
		
		
		JSONObject json = new JSONObject(); 
		json.put("STUDYNAME", studyGroupName);
		json.put("LEADERNAME", leaderName); 
		json.put("MAXCOUNT", maxCounter); 
		json.put("STUDYGOAL", studyGroupGoal); 
		json.put("STUDYCONTENTS", studyGroupContents); 
			
		
		  try {
	          response.setContentType("application/json; charset=UTF-8");
	          PrintWriter out = response.getWriter();
	          out.println(json);
	          out.close();
	      } catch (IOException e) {
	          e.printStackTrace();
	      }
		
	}

	//가입 승인이 된 스터디 리스트 보기 (조원 입장)
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/studyListForMember.do")
	public String selectListForMember(Model model, @RequestParam(value = "pg", defaultValue = "1") int currentPage){
		int pageSize = 6;
		User user = UserService.getCurrentUser();
		int memberIdx = user.getIdx();

		int recordCount = user_studyGroupMapper.selectCountMyStudyGroupForMember(memberIdx);
		List<TemporaryUser_StudyGroup> list = user_studyGroupMapper.selectPageMyStudyGroupListForMember(currentPage, pageSize, memberIdx);

		model.addAttribute("list", list);
		model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("images",imageMapper.allShow());//[유리방금추가]
		model.addAttribute("groupImages",imageMapper.StudyAllShow());//[유리방금추가]
		return "studyMain/studyListForMember";
	}

	//조장의 스터디 리스트 보기 (본인이 생성한)
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyMain/studyListForLeader.do", method = RequestMethod.GET)
	public String selectListForLeader(Model model, @RequestParam(value = "pg", defaultValue = "1") int currentPage){

		int pageSize = 6;
		User user = UserService.getCurrentUser();
		int leaderIdx = user.getIdx();
		int recordCount = studyGroupMapper.selectCountMyStudyGroupForLeader(leaderIdx);
		List<TemporaryStudyGroup> list = studyGroupMapper.selectPageMyStudyGroupListForLeader(currentPage, pageSize, leaderIdx); //[수정] TemporaryStudyGroup 으로 변경

		System.out.println("recordCount값: "+recordCount);
		System.out.println("페이지네이션 list 사이즈: "+list.size());
		System.out.println("페이지 사이즈: "+pageSize);
		model.addAttribute("list",list);
		model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("images",imageMapper.allShow());//[유리방금추가]
		model.addAttribute("groupImages",imageMapper.StudyAllShow());//[유리방금추가]

		return "studyMain/studyListForLeader";
		//pagination.setRecordCount(studyGroupMapper.selectCountMyStudyGroup(pagination, userIdx));
		//model.addAttribute("list", studyGroupMapper.selectPageMyStudyGroupList(pagination, userIdx));

		/*List<StudyGroup> studyList =  studyGroupService.selectList(); 
		List<StudyGroup> standByList = studyGroupService.selectStandByList();

		model.addAttribute("standByList", standByList);

		//가입된 스터디가 없으면 추천 스터디 리스트 조회
		if(studyList.isEmpty()){		
			List<StudyGroup> studyRecommendList = studyGroupMapper.selectRecommendList();
			model.addAttribute("list", studyRecommendList);

			return "studyMain/studyListBlank";
		}else{
			model.addAttribute("list", studyList);
			return "studyMain/studyList";
		}*/

		//pagination.setRecordCount(studyGroupMapper.selectCountStudyGroup(pagination));

		//model.addAttribute("list", studyGroupMapper.selectPageStudyGroupList(pagination));

	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/studyListAll.do")
	public String studyGroupListAll(Model model, Pagination pagination){
		pagination.setRecordCount(studyGroupMapper.selectCountStudyGroup(pagination));
		model.addAttribute("list", studyGroupMapper.selectPageStudyGroupList(pagination));

		return "studyMain/studyListAll";
	}


	//스터디 그룹 index로 스터디 상세 정보 조회
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/studyDetail.do", method = RequestMethod.GET)
	public String selectDetail(Model model, @RequestParam("idx") int studyIdx){

		model.addAttribute("studyGroup", studyGroupMapper.selectByStudyIdx(studyIdx));

		return "studyMain/studyDetail";
	}



	//스터디 그룹 생성
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/studyCreate.do", method = RequestMethod.GET)
	public String studyCreateGet(Model model){

		//세션에서 로그인 아이디 꺼내기.
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = principal.toString();

		User leader = userMapper.selectByLoginId(loginId);
		model.addAttribute("leader", leader);
		model.addAttribute("studyGroup", new StudyGroup());

		return "studyMain/studyCreate";
	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/studyCreate.do", method = RequestMethod.POST)
	public String studyCreatePost(Model model, studyMate.dto.StudyGroup studyGroup,MultipartHttpServletRequest multipartRequest,HttpSession session,StudyGroupImage studyGroupImage, @RequestParam(value = "pg", defaultValue = "1") int currentPage){

		String errorMessage = studyGroupService.studyGroupValidateBeforeInsert(studyGroup);

		if(errorMessage == null){
			studyGroupMapper.insertStudyGroup(studyGroup);
			user_studyGroupMapper.insert(UserService.getCurrentUser().getIdx(), studyGroup.getIdx());
			//파일 업로드
			Iterator<String> itr =  multipartRequest.getFileNames();
			int count=0;

			while (itr.hasNext()) { //받은 파일들을 모두 돌린다.

				MultipartFile mpf = multipartRequest.getFile(itr.next());//파일하나를 가져옴
				try {
					count++;
					BufferedImage bufferImage = ImageIO.read(mpf.getInputStream()); //파일읽기
					ByteArrayOutputStream baos = new ByteArrayOutputStream();//OutputStream 으로 저장

					String genId = UUID.randomUUID().toString(); // 파일 중복명 처리를 위한 랜덤이름
					String originFileName = mpf.getOriginalFilename();//파일의경로
					String fileName = genId + "." + FilenameUtils.getExtension(originFileName);// 저장되는 파일 이름(x.mp4)
					System.out.println(genId+"/"+originFileName+"/"+fileName);
					String savePath = dirName + fileName; // 저장 될 파일 경로
					long fileSize = mpf.getSize(); // 파일 사이즈
					mpf.transferTo(new File(savePath)); //파일을 폴더에 생성
					studyGroupImage.setFileName(fileName);//저장 된 파일이름
					studyGroupImage.setRoute(savePath); //저장경로
					int studyGroupIdx=studyGroup.getIdx();
					StudyGroup studygroup2 = studyGroupMapper.selectByStudyIdx(studyGroupIdx);
					studyGroupImage.setStudyGroupName(studygroup2.getStudyGroupName());//받아온 그룹이름
					studyGroupImage.setStudyGroupIdx(studyGroupIdx); //받아온 그룹 번호로 셋팅
					studyGroupImage.setFileSize(fileSize);//파일사이즈
					studyGroupImage.setData(mpf.getBytes());
					imageMapper.insert(studyGroupImage);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

			return "redirect:/studyMain/studyListForLeader.do";
			
		}else{
			model.addAttribute("error",errorMessage);
			
			int pageSize = 6;
			User user = UserService.getCurrentUser();
			int leaderIdx = user.getIdx();
			int recordCount = studyGroupMapper.selectCountMyStudyGroupForLeader(leaderIdx);
			List<TemporaryStudyGroup> list = studyGroupMapper.selectPageMyStudyGroupListForLeader(currentPage, pageSize, leaderIdx); //[수정] TemporaryStudyGroup 으로 변경
			System.out.println("recordCount값: "+recordCount);
			System.out.println("페이지네이션 list 사이즈: "+list.size());
			System.out.println("페이지 사이즈: "+pageSize);
			model.addAttribute("list",list);
			model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
			model.addAttribute("currentPage", currentPage);
			
			model.addAttribute("images",imageMapper.allShow());//[유리방금추가]
			model.addAttribute("groupImages",imageMapper.StudyAllShow());//[유리방금추가]
			
			return "/studyMain/studyListForLeader";
			//return "/studyMain/studyCreate.do";
		}
	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/document/document.do", method = RequestMethod.GET)
	public String concurrentDocument(Model model, @RequestParam("idx") int studyGroupIdx){

		User user = UserService.getCurrentUser();

		model.addAttribute("user", user);
		model.addAttribute("idx", studyGroupIdx);
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
		String loginId = user.getLoginId();

		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();

 			if(leaderOrMember.equals("조장")){
				model.addAttribute("leader","yes");
			}else{
				model.addAttribute("leader","no");		
			}
		
		
		return "studyRoom/document/document";
		
	}


	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/schedule/schedule.do" , method = RequestMethod.GET)
	public String studyGroupSchedule(Model model, @RequestParam("idx") int studyGroupIdx){
		model.addAttribute("idx", studyGroupIdx);
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
				
		return "studyRoom/schedule/schedule";
	}

	//10.09 추가
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/board/tempChat.do")
	public String tempChat(Model model, @RequestParam("idx") int studyGroupIdx){

		User user = UserService.getCurrentUser();

		System.out.println("studyGroupIdx값: "+studyGroupIdx);
		System.out.println("userName값: "+user.getName());



		model.addAttribute("myProfile",imageMapper.show(user.getIdx()));//채팅할때 이미지 출력 위해
		model.addAttribute("user", user);
		model.addAttribute("idx", studyGroupIdx);

		return "studyRoom/board/tempChat";
	}
	
	
	//10.21추가
	@Secured("ROLE_전체")
	@RequestMapping(value = "/deleteStudyGroup.do")
	public String deleteStudyGroup(@RequestParam("idx") int idx){
		
		
		
		return "/studyMain/studyListForLeader";//삭제 후 내가 개설한 스터디 목록페이지로 이동
	}

}
