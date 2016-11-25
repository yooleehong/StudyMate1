package studyMate.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import studyMate.dto.StudyGroupChat;

@Service
public class ChatService {
	
	private static HashMap<Integer, StudyGroupChat> studyGroupChats = new HashMap<Integer, StudyGroupChat>();

	public StudyGroupChat getStudyGroupChat(int studyGroupIdx){
		
		StudyGroupChat temp = studyGroupChats.get(studyGroupIdx);
		
		if(temp == null){
			temp = new StudyGroupChat();//studygroupidx에 해당하는게 없으면 새로 만들어주고
			temp.setStudyGroupIdx(studyGroupIdx);//studyGroupIdx를 셋 해줌
			studyGroupChats.put(studyGroupIdx, temp);//HashMap 자료구조에 put
			
			temp = studyGroupChats.get(studyGroupIdx);
		}
		
		return temp;
		
	}
}
