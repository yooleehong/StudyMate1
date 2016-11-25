package studyMate.dto;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.Session;

public class StudyGroupRoomDocument {
	private int studyGroupIdx;//스터디 그룹 idx
	private boolean isWrite;//작성 여부
	private Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	
	public int getStudyGroupIdx(){
		return studyGroupIdx;
	}
	
	public void setStudyGroupIdx(int studyGroupIdx){
		this.studyGroupIdx = studyGroupIdx;
	}
	
	public boolean getIsWrite(){
		return isWrite;
	}
	
	public void setIsWrite(boolean isWrite){
		this.isWrite = isWrite;
	}
	
	public Set<Session> getClients(){
		return clients;
	}
}
