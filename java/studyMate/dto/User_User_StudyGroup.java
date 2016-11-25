package studyMate.dto;

//ex) 스터디 그룹1 에서는 '조장'의 권한을 갖으며 스터디 그룹2 에서는 '조원'의 권한을 갖는 경우의 권한부여를 위해 생성.
public class User_User_StudyGroup {
	
	int idx;
	String loginId;
	String userType;
	
	int userIdx;
	int studyGroupIdx;
	String memberType;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getStudyGroupIdx() {
		return studyGroupIdx;
	}
	public void setStudyGroupIdx(int studyGroupIdx) {
		this.studyGroupIdx = studyGroupIdx;
	}
	public String getMemberType() {
		return memberType;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	
	
}
