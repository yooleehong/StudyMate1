package studyMate.dto;

import java.util.Date;

public class WebcamBoard {
	
	int idx;
	String title;
	int userIdx;
	String userId;
	int studyGroupIdx;
	Date uploadTime;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	
	public String getUserId(){
		return userId;
	}
	
	public void setUserId(String userId){
		this.userId = userId;
	}
	public int getStudyGroupIdx() {
		return studyGroupIdx;
	}
	public void setStudyGroupIdx(int studyGroupIdx) {
		this.studyGroupIdx = studyGroupIdx;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

}
