package studyMate.dto;

public class TemporaryUser_StudyGroup {
	int userIdx;
	int studyGroupIdx;
	String memberType;
	String loginId;
	String leaderName;
	String memberName;
	String studyGroupName;
	String studyGroupIntro;
	String studyGroupGoal;
	String studyGroupTerm;
	String route;
	int leaderIdx;//[10월20일 추가]
	
	public int getLeaderIdx() {
		return leaderIdx;
	}

	public void setLeaderIdx(int leaderIdx) {
		this.leaderIdx = leaderIdx;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getLeaderName(){
		return leaderName;
	}
	
	public void setLeaderName(String leaderName){
		this.leaderName = leaderName;
	}
	
	public String getStudyGroupGoal() {
		return studyGroupGoal;
	}

	public void setStudyGroupGoal(String studyGroupGoal) {
		this.studyGroupGoal = studyGroupGoal;
	}

	public String getStudyGroupTerm() {
		return studyGroupTerm;
	}

	public void setStudyGroupTerm(String studyGroupTerm) {
		this.studyGroupTerm = studyGroupTerm;
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
	
	public String getLoginId() {
		return loginId;
	}
	
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	
	public String getMemberName() {
		return memberName;
	}
	
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	public String getStudyGroupIntro(){
		return studyGroupIntro;
	}
	
	public void setStudyGroupIntro(String studyGroupIntro){
		this.studyGroupIntro = studyGroupIntro;
	}
	
	public String getStudyGroupName() {
		return studyGroupName;
	}
	
	public void setStudyGroupName(String studyGroupName) {
		this.studyGroupName = studyGroupName;
	}
	
	
}
