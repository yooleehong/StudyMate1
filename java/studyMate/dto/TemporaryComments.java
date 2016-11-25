package studyMate.dto;

import java.util.Date;

public class TemporaryComments {
	int idx;
	int studyGroupBoardIdx;
	int userIdx;
	Date writeTime;
	String commentContents;
	String userId; 
	int commentIdx;
	int repleUserIdx; //여기서 부터는 리플 관련 변수
	Date repleWriteTime;
	String repleCommentContents;
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}
	public int getRepleUserIdx() {
		return repleUserIdx;
	}
	public void setRepleUserIdx(int repleUserIdx) {
		this.repleUserIdx = repleUserIdx;
	}
	public Date getRepleWriteTime() {
		return repleWriteTime;
	}
	public void setRepleWriteTime(Date repleWriteTime) {
		this.repleWriteTime = repleWriteTime;
	}
	public String getRepleCommentContents() {
		return repleCommentContents;
	}
	public void setRepleCommentContents(String repleCommentContents) {
		this.repleCommentContents = repleCommentContents;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getStudyGroupBoardIdx() {
		return studyGroupBoardIdx;
	}
	public void setStudyGroupBoardIdx(int studyGroupBoardIdx) {
		this.studyGroupBoardIdx = studyGroupBoardIdx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public Date getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
	public String getCommentContents() {
		return commentContents;
	}
	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
