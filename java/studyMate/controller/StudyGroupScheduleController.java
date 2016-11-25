package studyMate.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import studyMate.dto.StudyGroupSchedule;
import studyMate.mapper.StudyGroupScheduleMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
//[수정]필요없는 import 정리

@Controller
public class StudyGroupScheduleController {
	
	@Autowired 
	StudyGroupScheduleMapper sgsMapper;
	
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사

	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/schedule/studyGroupScheduleList.do",produces = "application/json; charset=UTF-8",method = RequestMethod.GET)
	public @ResponseBody List<StudyGroupSchedule> studyGroupScheduler(HttpSession session){//[추가]세션값 사용을위한것
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx"); //[추가]스터디 그룹 로딩시 첫화면때 이미 세션을 심어둠 (사용)
		
/*		User user = UserService.getCurrentUser(); //필없
		String loginId = user.getLoginId();		//필없
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);	
		String leaderOrMember = uusg.getMemberType();		
		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){*/ //[수정]오류때문에 잠시 주석처리
		
		return sgsMapper.selectAll(studyGroupIdx);
//		}else{
//			return null;//임시..0920
//		}
		
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/schedule/studyGroupScheduleInsert.do", produces = "application/json; charset=UTF-8", method = RequestMethod.POST)
	public @ResponseBody void insert(StudyGroupSchedule studyGroupSchedule,HttpSession session){//[추가]세션값 사용을위한것
		
		int studyGroupIdx=(int)session.getAttribute("studyGroupIdx"); //[추가]스터디 그룹 로딩시 첫화면때 이미 세션을 심어둠 (사용)
		studyGroupSchedule.setStudyGroupIdx(studyGroupIdx);
		sgsMapper.insert(studyGroupSchedule);
		
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/schedule/studyGroupScheduleDelete.do", produces = "application/json; charset=UTF-8", method = RequestMethod.GET) //[수정]POST를 GET으로 변경
	public @ResponseBody void delete(@RequestParam("idx") int idx){
		System.out.println("조장새끼2: "+idx);
		sgsMapper.delete(idx); //[이해를 돕기위한 설명충추가]넘어가는 idx는 글의 idx임 
		
	}
	
	
}
