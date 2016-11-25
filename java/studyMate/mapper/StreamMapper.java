package studyMate.mapper;

import java.util.List;
import studyMate.dto.Pagination;
import studyMate.dto.Stream;
import studyMate.dto.WebcamBoard;


public interface StreamMapper {
		/*동영상 스트리밍 관련*/
		void insert(Stream stream); //[10월 1일 주석수정]스트림 페이지 DB에 데이터 삽입
		List<Stream> StreamPage(Pagination pagination); //페이지당 리스트 저장
		int StreamCount(Pagination pagination);//페이지 갯수
		Stream StreamDetailPage(int idx); //페이지당 리스트 저장
		Stream selectStream(String fileName); //파일이름에 맞는 스트림정보빼기
		List<Stream> selectIdxStream(Stream stream); //studyGroupIdx에 맞는 스트림정보빼기[10월19일추가]
		void streamDelete(int idx);//[10월19일 추가] 스트림idx에 맞는 동영상 삭제
		}
