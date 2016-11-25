package studyMate.mapper;

import java.util.List;

import studyMate.dto.Events;

public interface EventsMapper {
	List<Events> selectAll();
	
	void insertUserSchedule(Events e);
	
	void deleteByIdx(int event_id);
	
}
