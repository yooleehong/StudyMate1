package studyMate.dto;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.Session;

public class StudyGroupChat {
	
	private int studyGroupIdx;
	private Set<Session> chatClients = Collections.synchronizedSet(new HashSet<Session>());
	
	public int getStudyGroupIdx(){
		return studyGroupIdx;
	}
	
	public void setStudyGroupIdx(int studyGroupIdx){
		this.studyGroupIdx = studyGroupIdx;
	}
	
	public Set<Session> getChatClients(){
		return chatClients;
	}
}
