package studyMate.mapper;

import studyMate.dto.Document;

public interface DocumentMapper {
	
	Document selectByIdx(int idx);
	Document selectByUserName(String userName);
	Document selectByStudyGroupIdx(int studyGroupIdx);
	Document selectOne();
	
	
	void insertDocument(Document document);
	void updateDocument(Document document);
	void deleteDocument(int studyGroupIdx);
}
