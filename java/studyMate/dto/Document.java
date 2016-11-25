package studyMate.dto;

import java.util.Date;

public class Document {
	
	int idx;
	int studyGroupIdx;
	int userIdx;
	String userName;
	String title;
	String contents;
	Date writeTime;
	
	public int getIdx() {
		return idx;
	}
	
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	public int getStudyGroupIdx() {
		return studyGroupIdx;
	}
	
	public void setStudyGroupIdx(int studyGroupIdx) {
		this.studyGroupIdx = studyGroupIdx;
	}
	
	public int getUserIdx() {
		return userIdx;
	}
	
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContents() {
		return contents;
	}
	
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public Date getWriteTime() {
		return writeTime;
	}
	
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
	
	
	
}
