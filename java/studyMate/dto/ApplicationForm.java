package studyMate.dto;

public class ApplicationForm {
	
	private int idx;
	private int userIdx;
	private String userName;
	private int studyGroupIdx;
	private String studyGroupName;
	private String reason;
	private String isAccept;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	
	public String getUserName(){
		return userName;
	}
	
	public void setUserName(String userName){
		this.userName = userName;
	}
	
	public int getStudyGroupIdx() {
		return studyGroupIdx;
	}
	public void setStudyGroupIdx(int studyGroupIdx) {
		this.studyGroupIdx = studyGroupIdx;
	}
	
	public String getStudyGroupName(){
		return studyGroupName;
	}
	
	public void setStudyGroupName(String studyGroupName){
		this.studyGroupName = studyGroupName;
	}
	
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getIsAccept() {
		return isAccept;
	}
	public void setIsAccept(String isAccept) {
		this.isAccept = isAccept;
	}
	
	

}
