package studyMate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.User_User_StudyGroupMapper;

@Service
public class AuthenticationOfLeaderOrMember {
	
	@Autowired
	User_User_StudyGroupMapper user_user_studyGroupMapper;
	
	public User_User_StudyGroup authentication(String loginId, int studyGroupIdx){
		User_User_StudyGroup uusg = user_user_studyGroupMapper.selectByLoginIdForAuthentication(loginId, studyGroupIdx);
		return uusg;
	}
	
}
