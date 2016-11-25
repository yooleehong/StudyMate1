package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.Pagination;
import studyMate.dto.StudyGroup;
import studyMate.dto.TemporaryUser_StudyGroup;
import studyMate.dto.User;
import studyMate.dto.User_StudyGroup;

public interface User_StudyGroupMapper {

	int selectCount(Pagination pagination);

	List<User> selectByUser(int studyGroupIdx);

	List<User> selectByUserName(@Param("studyGroupIdx") int studyGroupIdx, @Param("name") String name);

	//스터디 그룹을 만드는 경우 (조장이 되는경우)
	void insert(@Param("userIdx") int userIdx, @Param("studyGroupIdx") int studyGroupIdx);

	//존재하는 스터디 그룹에 가입 하는경우
	void joinStudyGroup(User_StudyGroup user_StudyGroup);//가입 승인이 나면 User_StudyGroup테이블에 insert

	//내가 가입한 스터디 그룹 갯수 카운트 (조원 입장)
	public int selectCountMyStudyGroupForMember(@Param("memberIdx") int memberIdx);

	//내가 가입한 스터디 그룹 페이지네이션 (조원 입장)
	public List<TemporaryUser_StudyGroup> selectPageMyStudyGroupListForMember(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize, @Param("memberIdx") int memberIdx);
	
	//조장이 가입신청을 승인한 경우 User_StudyGroup 테이블에 insert 해줌. (memberType 을 '조원' 으로)
	public void insertMember(@Param("userIdx") int userIdx, @Param("studyGroupIdx") int studyGroupIdx); //그리고 나서 studyGroup 테이블의 membercounter를 1 증가.
}
