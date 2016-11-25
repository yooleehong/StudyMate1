package studyMate.mapper;

import java.util.List;

import studyMate.dto.File;

public interface FileMapper {
	
	//file upload
	public void insertFile(File file);
	
	//file download 
	//파일 인덱스로 파일 조회.
	public File selectByIdx(int idx);
	
	//=> index 추출 Test
	
	//파일 이름으로 인덱스 뽑아오려고.. 이건아닌듯
	public int selectByName(String name);
	//해당 스터디 그룹에 업로드된 파일 조회
	public List<File> selectByStudyGroup(int studyGroupIdx);
	
	//파일 삭제
	public void deleteFile(int idx);

}
