package studyMate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import studyMate.dto.Pagination;
import studyMate.dto.Stream;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupBoard;
import studyMate.dto.TemporaryComments;
import studyMate.dto.User;
import studyMate.mapper.ManagerMapper;


@Controller
public class ManagerController {

   

   @Autowired
   ManagerMapper managerMapper;   
   
   @Secured("ROLE_관리자")
   @RequestMapping(value ="/manager/userManager.do" )
   public String userManager(User user,Model model,HttpSession session,Pagination pagination){
          //System.out.println("로그인 유저idx"+loginIdx);
          pagination.setRecordCount(managerMapper.managerSelectCount(pagination));
          model.addAttribute("list", managerMapper.managerSelectPage(pagination));
          return "manager/userManager";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userDelete.do", method = RequestMethod.GET)
   public String complete(@RequestParam("idx") int idx, Pagination pagination, Model model){
      managerMapper.managerDeleteByIdx(idx);
///      int page=pagination.getCurrentPage();
   return "/manager/complete";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userDetails.do") //[추가] 유저 클릭 후 버튼 창 
   public String userDetails(@RequestParam("idx") int idx, Pagination pagination, Model model){
      
          model.addAttribute("idx",idx);
          
   return "/manager/userDetails";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userPasswdUpdate.do", method = RequestMethod.GET) //[추가] 페스워드 관리자용 수정 페이지 
   public String userPasswdUpdateGet(User user, Pagination pagination, Model model){
      model.addAttribute("idx",user.getIdx()); //idx 심어두기
   return "/manager/userPasswdUpdate";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userPasswdUpdate.do", method = RequestMethod.POST) //[추가] 페스워드 관리자용 수정 페이지 
   public String userPasswdUpdatePost(User user, Pagination pagination, Model model){
      managerMapper.managerPwUpdate(user);//user 객체 를 이용한 pw 업뎃
   return "/manager/userComplete";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userEmailUpdate.do", method = RequestMethod.GET) //[추가] 이메일 관리자용 수정 페이지 
   public String userEmailUpdateGet(User user, Pagination pagination, Model model){
      model.addAttribute("idx",user.getIdx()); //idx 심어두기
   return "/manager/userEmailUpdate";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userEmailUpdate.do", method = RequestMethod.POST) //[추가] 이메일 관리자용 수정 페이지 
   public String userEmailUpdatePost(User user, Pagination pagination, Model model){
      managerMapper.managerEmailUpdate(user);//user 객체 를 이용한 email 업뎃
   return "/manager/userComplete";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/userComplete.do") //유저정보 수정후 이동 페이지 (파라미터 포함해 전달하기 위함)
   public String userComplete(Pagination pagination, Model model){
   return "/manager/userComplete";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/complete.do")
   public String complete(Pagination pagination, Model model){
   return "/manager/complete";
   }
   

   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/groupManager.do")
   public String groupManager(Model model,HttpSession session,Pagination pagination){
          //int loginIdx=(int)session.getAttribute("loginIdx");
          //System.out.println("로그인 유저idx"+loginIdx);
          pagination.setRecordCount(managerMapper.managerSelectCountStudyGroup(pagination));
          model.addAttribute("list", managerMapper.managerSelectPageStudyGroupList(pagination));
          
      return "manager/groupManager";
   }
   
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/groupDetails.do")
   public String groupDetails(StudyGroup studyGroup, Model model,HttpSession session,Pagination pagination){
          //int loginIdx=(int)session.getAttribute("loginIdx");
          //System.out.println("로그인 유저idx"+loginIdx);
          pagination.setIdx(studyGroup.getIdx());
          studyGroup=managerMapper.managerSelectByStudyIdx(studyGroup.getIdx());
          model.addAttribute("StudyGroup",studyGroup);
//             System.out.println("studyIdx : "+studyGroup.getIdx());
      return "manager/groupDetails";
   }
   
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/groupDelete.do")
   public String groupDelete(StudyGroup studyGroup,Model model,Pagination pagination){
      managerMapper.managerDeleteGroupBoard(studyGroup);
      managerMapper.managerDeleteGroup(studyGroup);
      return "manager/groupComplete";
   }

   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/boardManager.do")
   public String boardManager(@RequestParam("idx") int idx,StudyGroupBoard studyGroupBoard,Model model,Pagination pagination){
      if(idx>0){
         pagination.setIdx(idx);
      }
///      System.out.println("보드매니저 4나와야함//그룹idx : "+pagination.getIdx());
      pagination.setRecordCount(managerMapper.managerSelectCountStudyGroupBoard(pagination));
          model.addAttribute("list", managerMapper.managerSelectPageStudyGroupBoardList(pagination));
      return "manager/boardManager";
   }
   
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/boardelete.do")
   public String boardelete(StudyGroupBoard studyGroupBoard,Model model,Pagination pagination){
      managerMapper.managerDeleteGroupOneBoard(studyGroupBoard.getIdx());
      return "manager/groupBoardComplete";
   }
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/boardDetails.do") //스트림 보드 클릭시
   public String boardDetails(StudyGroupBoard studyGroupBoard,Model model,Pagination pagination){
      
       model.addAttribute("board",studyGroupBoard); //idx 전달 용
      return "manager/boardDetails";
   }
   
   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/main.do")
   public String main(Model model){
      return "manager/main";
   }

   
   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/groupBoardComplete.do")
   public String groupBoardComplete(Model model,Pagination pagination){
      return "manager/groupBoardComplete";
   }

   @Secured("ROLE_관리자")
   @RequestMapping(value="/manager/groupComments.do")//[추가]댓글 컨트롤러 생성
   public String groupComments(@RequestParam("idx") int idx,Model model,Pagination pagination){
      if(idx>0){
         pagination.setIdx(idx);
      }
      pagination.setRecordCount(managerMapper.managerCommentsCount(pagination));
        model.addAttribute("list", managerMapper.managerCommentsPage(pagination));
      
      return "manager/groupComments";
   }
   
}