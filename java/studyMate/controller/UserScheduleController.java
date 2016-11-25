package studyMate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import studyMate.dto.Events;
import studyMate.dto.User;
import studyMate.dto.UserSchedule;
import studyMate.mapper.UserScheduleMapper;
import studyMate.service.UserService;

@Controller
public class UserScheduleController {
	
	@Autowired UserScheduleMapper userScheduleMapper;
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/myScheduleList.do", produces = "application/json; charset=UTF-8",method = RequestMethod.GET)
	public @ResponseBody List<UserSchedule> userScheduler(){
		
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		
		return userScheduleMapper.selectAll(userIdx);
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/myScheduleInsert.do", produces = "application/json; charset=UTF-8", method = RequestMethod.POST)
	public @ResponseBody List<UserSchedule> insert(UserSchedule userSchedule){
		
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		
		UserSchedule schedule = userSchedule;
		schedule.setUserIdx(userIdx);
		
		userScheduleMapper.insertUserSchedule(schedule);
		
		int userScheduleIdx = userSchedule.getIdx();
		System.out.println("userSchedule의 idx값: "+userScheduleIdx);
		
		return userScheduleMapper.selectAll(userIdx);
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/user/myScheduleDelete.do", produces = "application/json; charset=UTF-8", method = RequestMethod.GET)
	public @ResponseBody List<UserSchedule> delete(@RequestParam("idx") int idx){
		
		userScheduleMapper.deleteByIdx(idx);
		
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		
		return userScheduleMapper.selectAll(userIdx);

	}
	
}
