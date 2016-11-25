package studyMate.mapper;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.User_User_StudyGroup;

public interface User_User_StudyGroupMapper {
	
	User_User_StudyGroup selectByLoginIdForAuthentication(@Param("loginId") String loginId, @Param("studyGroupIdx") int studyGroupIdx);
}
