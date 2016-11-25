package studyMate.dto;

public class StudyGroup {
	int idx;
	int leaderIdx;
	String leaderName;
	String studyGroupName;
	int memberCounter;
	int maxCounter;
	String studyGroupIntro;
	String studyGroupTerm;
	String studyGroupGoal;
	String studyGroupContents;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getLeaderIdx() {
		return leaderIdx;
	}
	public void setLeaderIdx(int leaderIdx) {
		this.leaderIdx = leaderIdx;
	}
	
	public String getLeaderName(){
		return leaderName;
	}
	
	public void setLeaderName(String leaderName){
		this.leaderName = leaderName;
	}
	public String getStudyGroupName() {
		return studyGroupName;
	}
	public void setStudyGroupName(String studyGroupName) {
		this.studyGroupName = studyGroupName;
	}
	public int getMemberCounter() {
		return memberCounter;
	}
	public void setMemberCounter(int memberCounter) {
		this.memberCounter = memberCounter;
	}
	public int getMaxCounter() {
		return maxCounter;
	}
	public void setMaxCounter(int maxCounter) {
		this.maxCounter = maxCounter;
	}
	public String getStudyGroupIntro() {
		return studyGroupIntro;
	}
	public void setStudyGroupIntro(String studyGroupIntro) {
		this.studyGroupIntro = studyGroupIntro;
	}
	public String getStudyGroupTerm() {
		return studyGroupTerm;
	}
	public void setStudyGroupTerm(String studyGroupTerm) {
		this.studyGroupTerm = studyGroupTerm;
	}
	public String getStudyGroupGoal() {
		return studyGroupGoal;
	}
	public void setStudyGroupGoal(String studyGroupGoal) {
		this.studyGroupGoal = studyGroupGoal;
	}
	public String getStudyGroupContents() {
		return studyGroupContents;
	}
	public void setStudyGroupContents(String studyGroupContents) {
		this.studyGroupContents = studyGroupContents;
	}
	
	
}
