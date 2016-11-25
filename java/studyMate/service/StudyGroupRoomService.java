package studyMate.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import studyMate.dto.StudyGroupRoomDocument;

@Service
public class StudyGroupRoomService {
	
	//스터디 그룹을 키 값 형태로 저장
	private static HashMap<Integer, StudyGroupRoomDocument> studyGroupRoomDocuments = new HashMap<Integer, StudyGroupRoomDocument>();
	
	//스터디 그룹 idx로 조회한 스터디 그룹을 리턴
	public StudyGroupRoomDocument getStudyGroupRoomDocument(int studyGroupIdx){
		StudyGroupRoomDocument document1 = studyGroupRoomDocuments.get(studyGroupIdx);
		
		if(document1 == null){
			document1 = new StudyGroupRoomDocument();
			
			document1.setStudyGroupIdx(studyGroupIdx);
			studyGroupRoomDocuments.put(studyGroupIdx, document1);
			
			document1 = studyGroupRoomDocuments.get(studyGroupIdx);
		}
		
		return document1;
	}
}
