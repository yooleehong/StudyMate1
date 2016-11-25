package studyMate.service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studyMate.dto.StudyGroupBoard;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;

@Service
public class BoardService {
	
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사
	
	public String studyGroupBoardError(StudyGroupBoard studygroupboard) {

		String s = studygroupboard.getBoardTitle();
		if (StringUtils.isBlank(s))
			return "글 제목을 입력하세요.";
		
		s = studygroupboard.getBoardContents();
		if (StringUtils.isBlank(s))
			return "글 내용을 입력하세요.";
		
		return null;
	}
	
	//09.20 추가. 글 작성자인지 아닌지 검사.
	public boolean isAuthor(StudyGroupBoard studyGroupBoard){
		System.out.println("user의 idx값: "+UserService.getCurrentUser().getIdx());
		System.out.println("studyGroupBoard의 userIdx값: "+studyGroupBoard.getUserIdx());
		return (UserService.getCurrentUser() != null) &&
				(studyGroupBoard.getUserIdx() == UserService.getCurrentUser().getIdx());
	}
	
	//09.20추가. 글을 쓸 수 있는지 없는지 검사.
	public boolean canCreate(int studyGroupIdx){
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);
		String leaderOrMember = uusg.getMemberType();
		
		if(user == null) return false;
		if ("관리자".equals(user.getUserType())) return true;
		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")) return true;
        
		return false;
	}
	
	//09.20추가. 글을 수정할 수 있는지 없는지 검사. (작성자인지 확인하는 메소드 호출)
	public boolean canEdit(StudyGroupBoard studyGroupBoard){
		System.out.println("isAuthor 값: "+isAuthor(studyGroupBoard));
		return isAuthor(studyGroupBoard);
	}
	
	//09.20추가. 
	public boolean canDelete(StudyGroupBoard studyGroupBoard){
		User user = UserService.getCurrentUser();
		if(user == null) return false;
		
		return isAuthor(studyGroupBoard);
	}
}
