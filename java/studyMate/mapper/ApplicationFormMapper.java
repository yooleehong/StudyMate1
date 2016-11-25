package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.ApplicationForm;
import studyMate.dto.Pagination;

public interface ApplicationFormMapper {

	//applicationform 테이블 레코드 카운트 (조장 입장)
	public int selectCountApplicationForm(@Param("studyGroupIdx") int studyGroupIdx);
	
	//pagination (조장 입장)
	public List<ApplicationForm> selectPage(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize, @Param("studyGroupIdx") int studyGroupIdx);
	
	//승인 대기중인 내가 신청한 신청서 갯수 카운트
	public int selectCountMyApplicationForm(@Param("userIdx") int userIdx);
	
	//내가 신청한 신청서 페이지네이션
	public List<ApplicationForm> selectPageMyApplicationFormList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize, @Param("userIdx") int userIdx);
	
	//조장이 가입신청을 승인한 경우 ApplicationForm 테이블의 해당 레코드의 isAccept 컬럼을 '승인'으로 바꿔줌.
	public void updateApplicationForm(@Param("userIdx") int userIdx, @Param("studyGroupIdx") int studyGroupIdx);
	
	//조장이 가입신청을 거절한 경우 ApplicationForm 테이블에서 삭제
	public void deleteApplicationForm(@Param("userIdx") int userIdx, @Param("studyGroupIdx") int studyGroupIdx);
	
	
}
