package studyMate.mapper;

import java.util.List;

import studyMate.dto.Pagination;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupBoard;
import studyMate.dto.TemporaryComments;
import studyMate.dto.User;

public interface ManagerMapper {//[수정] 모든 주석 정리 
   
   //유저 페이지네이션 페이지
   List<User> managerSelectPage(Pagination pagination);
   //유저 페이지 네이션 카운트
   int managerSelectCount(Pagination pagination);
   //유저 삭제
   void managerDeleteByIdx(int idx);
   //[추가]유저 객체 로 유저 비번 업뎃
   void managerPwUpdate(User user);
   //[추가]유저 객체 로 유저 이메일 업뎃
   void managerEmailUpdate(User user);
   //스터디 그룹 페이지 네이션 페이지
   public List<StudyGroup> managerSelectPageStudyGroupList(Pagination pagination);
   //스터디 그룹 페이지 네이션 카운트
   public int managerSelectCountStudyGroup(Pagination pagination);
   //스터디 그룹 보드 페이지 네이션 페이지
   public List<StudyGroupBoard> managerSelectPageStudyGroupBoardList(Pagination pagination); 
   //스터디 그룹 보드 페이지 네이션 카운트
   public int managerSelectCountStudyGroupBoard(Pagination pagination);
   //그룹 idx로 스터디그룹 조회
   public StudyGroup managerSelectByStudyIdx(int studyIdx); 
   //그룹삭제
   public void managerDeleteGroup(StudyGroup studyGroup);
   //그룹의 게시판글 삭제
   public void managerDeleteGroupBoard(StudyGroup studyGroup);
   //그룹의 게시판글 하나 삭제
   public void managerDeleteGroupOneBoard(int idx);
   //댓글과 리플 보여주는 Mapper [추가]
   List<TemporaryComments> managerCommentsPage(Pagination pagination);
   int managerCommentsCount(Pagination pagination);

}