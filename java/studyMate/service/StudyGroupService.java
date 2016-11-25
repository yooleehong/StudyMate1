package studyMate.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studyMate.dto.ApplicationForm;
import studyMate.dto.StudyGroup;
import studyMate.dto.User;
import studyMate.mapper.StudyGroupMapper;

@Service
public class StudyGroupService {
	
	@Autowired
	StudyGroupMapper studyGroupMapper;		
	
	//현재 로그인된 사용자가 가입한 스터디 리스트 조회
	public List<StudyGroup> selectList() {
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		
		return studyGroupMapper.selectList(userIdx);
	}
	
	//승인 대기중 리스트 조회
	public List<StudyGroup> selectStandByList(){
		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();
		
		return studyGroupMapper.selectStandByList(userIdx);
	}
	
	
	//스터디 가입 신청서 등록
	public void insertApplication(ApplicationForm applForm){
		
		//User user = UserService.getCurrentUser();
		//int userIdx = user.getIdx();
		//applForm.setUserIdx(userIdx);
		
		studyGroupMapper.insertApplication(applForm);
		
	}

	//이미 신청 또는 가입된 스터디인지 검사.
	public int selectDoubleCheck(ApplicationForm applForm) {
		// TODO Auto-generated method stub
		
		//User user = UserService.getCurrentUser();
		//int userIdx = user.getIdx();
		//applForm.setUserIdx(userIdx);
		
		return studyGroupMapper.selectDoubleCheck(applForm);
	}
	
	
	
	//studyGroup 생성 전 검사
	public String studyGroupValidateBeforeInsert(studyMate.dto.StudyGroup studygroup) {

		String s = studygroup.getStudyGroupName();
		if (StringUtils.isBlank(s))
			return "스터디명을 입력하세요.";
		
		s = studygroup.getStudyGroupIntro();
		if (StringUtils.isBlank(s))
			return "스터디 소개를 입력하세요.";
		
		s = studygroup.getStudyGroupTerm();
		if (StringUtils.isBlank(s))
			return "스터디 기간을 입력하세요.";
		
		int i = studygroup.getMaxCounter();
		if (i < 2)
			return "최소 정원은 2명 이상이어야합니다.";

		s = studygroup.getStudyGroupGoal();
		if (StringUtils.isBlank(s))
			return "스터디 목표를 입력하세요.";
		
		s = studygroup.getStudyGroupContents();
		if (StringUtils.isBlank(s))
			return "스터디 내용을 입력하세요.";

		return null;
	}
}
