package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.UserSchedule;

public interface UserScheduleMapper {
	
	UserSchedule selectByIdx(@Param("idx") int idx);
	
	List<UserSchedule> selectAll(@Param("userIdx") int userIdx);
	
	void insertUserSchedule(UserSchedule userSchedule);
	
	void deleteByIdx(@Param("idx") int idx);
}
