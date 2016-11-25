package studyMate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import studyMate.dto.Comment;
import studyMate.dto.Pagination;
import studyMate.dto.ReplyComment;
import studyMate.dto.StudyGroupBoard;

public interface BoardMapper {
   
   public void insertBoard(StudyGroupBoard sgb);
   
   //public List<StudyGroupBoard> BoardlistAll(int studyGroupIdx);
   
   //스터디 그룹 게시판 페이지네이션
   public List<StudyGroupBoard> selectPageStudyGroupBoard(Pagination pagination);//[10월14일 수정]
   
   public int selectCountStudyGroupBoard(Pagination pagination);//[10월14일 수정]
   
   public StudyGroupBoard read(@Param("boardIdx") int boardIdx);
   public void update(StudyGroupBoard studygroupboard);
   public void delete(Integer idx);
   
   //댓글 조회
   public List<Comment> commentListAll(int studyGroupBoardIdx);
   //댓글 등록
   public void insertComent(Comment comment);
   //댓글 수정
   public void updateComment(Comment comment);
   //댓글 삭제
   public void deleteComment(int idx);
   
   
   //답글(대댓) 조회
   public List<ReplyComment> replyListAll(int studyGroupBoardIdx);
   //답글 등록
   public void insertReply(ReplyComment replyComment);
   //답글 수정
   public void updateReply(ReplyComment replyComment);
   //답글 삭제
   public void deleteReply(int replyIdx);
   //댓글 삭제에 의한 답글 삭제 (댓글 삭제 위해 달려있는 대댓부터 삭제함)
   public void deleteReplyByComment(int commentIdx);

   
   //댓글 내용 조회
   public String selectContents(int commentIdx);
   //대댓글 내용 조회
   public String selectReplyContents(int replyIdx); 
   
   
   //page별 댓글 조회 
   public List<Comment> commentPageListAll(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize, @Param("studyGroupBoardIdx") int studyGroupBoardIdx);
   //댓글 개수 조회
   public int selectCountComment(int studyGroupBoardIdx);

   
}