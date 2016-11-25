package studyMate.dto;

import java.util.Date;

public class Message {
	int idx;
	int userFrom;
	int userTo;
	String userFromName;
	String userToName;
	Date writeTime;
	String text;
	String loginId;////마지막이다ㅎㅎ
	String name;////마지막이다ㅎㅎ
	int ownership;////마지막이다ㅎㅎ
	
	public int getOwnership() {
		return ownership;
	}
	public void setOwnership(int ownership) {
		this.ownership = ownership;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getUserFrom() {
		return userFrom;
	}
	public void setUserFrom(int userFrom) {
		this.userFrom = userFrom;
	}
	public int getUserTo() {
		return userTo;
	}
	public void setUserTo(int userTo) {
		this.userTo = userTo;
	}
	public String getUserFromName() {
		return userFromName;
	}
	public void setUserFromName(String userFromName) {
		this.userFromName = userFromName;
	}
	public String getUserToName() {
		return userToName;
	}
	public void setUserToName(String userToName) {
		this.userToName = userToName;
	}
	public Date getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	
}
