package studyMate.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import net.sf.json.JSONObject;
import studyMate.dto.ApplicationForm;
import studyMate.dto.Pagination;
import studyMate.dto.StudyGroup;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.ApplicationFormMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.mapper.UserMapper;
import studyMate.mapper.User_StudyGroupMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.StudyGroupService;
import studyMate.service.UserService;
import studyMate.util.PageUtil;
@Controller
public class ApplicationFormController {
	@Autowired
	StudyGroupMapper studyGroupMapper;
	@Autowired
	StudyGroupService studyGroupService;
	@Autowired
	UserMapper userMapper;
	@Autowired
	ApplicationFormMapper applicationFormMapper;
	@Autowired
	User_StudyGroupMapper user_studyGroupMapper;
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
	//스터디 신청서 페이지로 이동
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/applicationForm.do", method = RequestMethod.GET)
	public String applicationGet(Model model, ApplicationForm applicationform, StudyGroup studyGroup, @RequestParam("idx") int idx){
		User currentUser = UserService.getCurrentUser();//현재 로그인한 유저를 꺼내서
		model.addAttribute("user", currentUser);//모델에 등록해줌. 신청서 페이지에서 userIdx 필요.
		//System.out.println("현재 로그인한 사용자의 idx: "+currentUser.getIdx());
		//model.addAttribute("studyGroup",studyGroupMapper.selectByStudyIdx(idx));
		//System.out.println("스터디그룹의 idx: "+studyGroupMapper.selectByStudyIdx(idx).getIdx());
		//model.addAttribute("applicationForm", new ApplicationForm());
		return "studyMain/applicationForm";
	}
	//스터디 가입 신청서 등록  -> x
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/applicationForm.do", method = RequestMethod.POST)
	public String applicationPost(ApplicationForm applForm, Model model,Pagination pagination){
		System.out.println("신청서작성POST");
		//해당 스터디에 이미 신청/가입되어있으면 신청서 등록하지 않음
		if(studyGroupService.selectDoubleCheck(applForm)==1){	
			model.addAttribute("error","<script type='text/javascript'>alert('이미 신청/가입 된 스터디 입니다.');</script>");
			return "/studyMain/applicationForm";
			//신청서 등록	
		}else{
			studyGroupService.insertApplication(applForm);
			model.addAttribute("success","<script type='text/javascript'>alert('신청이 완료되었습니다.');</script>");
			return "redirect:/studyMain/studyListAll.do";
		}
		//전 페이지로 이동
		//return selectDetail(model, applForm.getStudyGroupIdx());	
	}
		//스터디 가입 신청서 등록 
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyMain/applicationByLayer.do")
	public void applicationByLayer(HttpServletResponse response, @RequestParam("studyGroupIdx") int studyGroupIdx ,@RequestParam("reason") String reason){
		User currentUser = UserService.getCurrentUser();
		int userIdx = currentUser.getIdx();
		
		ApplicationForm applicationForm = new ApplicationForm();
		applicationForm.setReason(reason);
		applicationForm.setUserIdx(userIdx);
		applicationForm.setStudyGroupIdx(studyGroupIdx);
				
		JSONObject json = new JSONObject();
		
		//해당 스터디에 이미 신청/가입되어있으면 신청서 등록하지 않음
		if(studyGroupService.selectDoubleCheck(applicationForm)==1){	
			json.put("RESULT", "fail");
		}else{
			studyGroupService.insertApplication(applicationForm);
			json.put("RESULT", "succ");	
		}
		try {
	          response.setContentType("application/json");
	          PrintWriter out = response.getWriter();
	          out.println(json);
	          out.close();
	      } catch (IOException e) {
	          e.printStackTrace();
	      }
		
		
	}
	//승인 대기중인 나의 스터디 신청 리스트
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyManage/applicantList.do")
	public String applicantList(Model model, @RequestParam(value = "pg", defaultValue = "1") int currentPage){
		int pageSize = 10;
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		int recordCount = applicationFormMapper.selectCountMyApplicationForm(userIdx);
		List<ApplicationForm> list = applicationFormMapper.selectPageMyApplicationFormList(currentPage, pageSize, userIdx);
		model.addAttribute("list", list);
		model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
		model.addAttribute("currentPage", currentPage);
		return "/studyManage/applicantList";
	}
	//나의 스터디에 신청한 사람들의 신청서 리스트 보기 (조장입장에서 승인하기 위해)
	@RequestMapping(value = "/studyManage/applicantListForLeader.do")
	public String studyManage(Model model, @RequestParam("idx") int studyGroupIdx,
			@RequestParam(value = "pg", defaultValue = "1") int currentPage){
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);
		String authen = uusg.getMemberType();
		if(authen.equals("조원")){ //조원인 경우 스터디 신청자들을 보면 안됨.
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";//이 전 url로 이동. 
		}else{
			int pageSize = 10;
			int recordCount = applicationFormMapper.selectCountApplicationForm(studyGroupIdx);
			List<ApplicationForm> list = applicationFormMapper.selectPage(currentPage, pageSize, studyGroupIdx);
			model.addAttribute("list", list);
			model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
			model.addAttribute("currentPage", currentPage);
			return "/studyManage/applicantListForLeader";
		}
	}
	//가입신청서 승인
	@RequestMapping(value = "/studyManage/applicantApprove.do")
	public String applicantApprove(Model model, @RequestParam("idx") int studyGroupIdx, @RequestParam("userIdx") int userIdx, @RequestParam(value = "pg", defaultValue = "1") int currentPage){
		System.out.println("studyGroupIdx값: "+studyGroupIdx);
		System.out.println("userIdx값: "+userIdx);
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);
		
		if(uusg.getMemberType().equals("조원")){
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";
		}else{
			//User_StudyGroup 테이블에 insert
			user_studyGroupMapper.insertMember(userIdx, studyGroupIdx);
			//ApplicationForm 테이블의 레코드에서 isAccept를 '승인' 으로 update
			applicationFormMapper.updateApplicationForm(userIdx, studyGroupIdx);
			return "/studyManage/applicantListForLeader";
		}
		
	}
	//가입신청서 거절
	@RequestMapping(value = "/studyManage/applicantReject.do")
	public String applicantReject(Model model, @RequestParam("idx") int studyGroupIdx, @RequestParam("userIdx") int userIdx, @RequestParam(value = "pg", defaultValue = "1") int currentPage){
		System.out.println("studyGroupIdx값: "+studyGroupIdx);
		System.out.println("userIdx값: "+userIdx);
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);
		
		if(uusg.getMemberType().equals("조원")){
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";
		}else{
			//ApplicationForm 테이블에서 삭제 ? 아니면 isAccept컬럼값을 '거절' 로 ?
			//일단 삭제.
			applicationFormMapper.deleteApplicationForm(userIdx, studyGroupIdx);
			return "/studyManage/applicantListForLeader";
		}
		}
}