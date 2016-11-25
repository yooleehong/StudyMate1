package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.StudyGroupSchedule;

public interface StudyGroupScheduleMapper {
	
	List<StudyGroupSchedule> selectAll(@Param("studyGroupIdx") int studyGroupIdx);
	
	void insert(StudyGroupSchedule studyGroupSchedule);
	
	void delete(@Param("idx") int idx);
}
