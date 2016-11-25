package studyMate.mapper;

import java.util.List;

import studyMate.dto.Pagination;
import studyMate.dto.WebcamBoard;

public interface WebcamMapper {

	/*캠 관련*/
	List<WebcamBoard> webcamPage(Pagination pagination); //[10월 1일 수정]열려있는 캠방들
	int webcamCount(Pagination pagination);//[10월 1일 수정]열려있는 캠방 갯수
	void webcamInsert(WebcamBoard webcamBoard); //[10월 1일 수정]idx에 맞는 캠방삭제
	void webcamDelete(int idx); //[10월 1일 수정]idx에 맞는 캠방삭제
	WebcamBoard webcamSelect(int idx); //[10월 1일 수정]idx에 맞는 캠방조회



}
