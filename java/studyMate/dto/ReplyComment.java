package studyMate.dto;

import java.util.Date;

public class ReplyComment {
	
	int idx;
	int commentIdx;
	int userIdx;
	Date writeTime;
	String commentContents;
	String userId;
	int studyGroupBoardIdx;
	

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
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
	public int getStudyGroupBoardIdx() {
		return studyGroupBoardIdx;
	}
	public void setStudyGroupBoardIdx(int studyGroupBoardIdx) {
		this.studyGroupBoardIdx = studyGroupBoardIdx;
	}

	
	
}
