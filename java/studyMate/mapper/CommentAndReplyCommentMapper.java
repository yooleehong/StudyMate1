package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.CommentAndReplyComment;

public interface CommentAndReplyCommentMapper {

	public int selectCount(@Param("boardIdx") int studyGroupBoardIdx);// 갯수 카운트
	
	public List<CommentAndReplyComment> selectPage();
	
}
