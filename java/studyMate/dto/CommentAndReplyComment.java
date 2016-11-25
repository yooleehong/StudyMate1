package studyMate.dto;

import java.util.Date;

public class CommentAndReplyComment {
	
	int cIdx;
	int studyGroupBoardIdx;
	int userIdx;
	Date cWriteTime;
	String commentContents;
	
	int rIdx;
	int replyCommentIdx;
	Date rWriteTime;
	String rCommentContents;
	
	public int getcIdx() {
		return cIdx;
	}
	public void setcIdx(int cIdx) {
		this.cIdx = cIdx;
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
	public Date getcWriteTime() {
		return cWriteTime;
	}
	public void setcWriteTime(Date cWriteTime) {
		this.cWriteTime = cWriteTime;
	}
	public String getCommentContents() {
		return commentContents;
	}
	public void setCommentContents(String commentContents) {
		this.commentContents = commentContents;
	}
	public int getrIdx() {
		return rIdx;
	}
	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}
	public int getReplyCommentIdx() {
		return replyCommentIdx;
	}
	public void setReplyCommentIdx(int replyCommentIdx) {
		this.replyCommentIdx = replyCommentIdx;
	}
	public Date getrWriteTime() {
		return rWriteTime;
	}
	public void setrWriteTime(Date rWriteTime) {
		this.rWriteTime = rWriteTime;
	}
	public String getrCommentContents() {
		return rCommentContents;
	}
	public void setrCommentContents(String rCommentContents) {
		this.rCommentContents = rCommentContents;
	}
	
	
	
}
