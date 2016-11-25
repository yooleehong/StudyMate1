package studyMate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import studyMate.dto.Pagination;
import studyMate.dto.StudyGroup;
import studyMate.dto.StudyGroupBoard;
import studyMate.dto.StudyGroupImage;
import studyMate.dto.User;
import studyMate.dto.User_User_StudyGroup;
import studyMate.mapper.BoardMapper;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.StudyGroupMapper;
import studyMate.service.AuthenticationOfLeaderOrMember;
import studyMate.service.BoardService;
import studyMate.service.UserService;
import studyMate.util.PageUtil;

@Controller
public class BoardController {

	@Autowired
	BoardMapper boardmapper;
	@Autowired
	BoardService boardservice;
	@Autowired
	AuthenticationOfLeaderOrMember leaderOrMember;//조장||조원 권한 검사

	@Autowired
	ImageMapper imageMapper;
	int studyGroupIdx=0;
	@Autowired
	StudyGroupMapper studyGroupMapper;//[10월17일 추가]
	
	String FetchName="/StudyMate/studyGroupImage/";// 이미지 불러올 경로[10월18일]

	//스터디 그룹에 해당하는 게시글 리스트 조회. 
	/*@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/board/boardList.do")
	public String BoardlistAll(HttpSession session, Model model, @RequestParam(value = "pg", defaultValue = "1") int currentPage, @RequestParam("idx") int studyGroupIdx){
		session.setAttribute("studyGroupIdx", studyGroupIdx);
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();
		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){
			int pageSize = 10;

			int recordCount = boardmapper.selectCountStudyGroupBoard(studyGroupIdx);
			List<StudyGroupBoard> list = boardmapper.selectPageStudyGroupBoard(currentPage, pageSize, studyGroupIdx);

			model.addAttribute("list", list);
			model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
			model.addAttribute("currentPage", currentPage);

			model.addAttribute("idx",studyGroupIdx);//스터디 그룹 idx 보냄.


			return "studyRoom/board/boardList";
		}else{
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";
		}


	}*/

	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/board/boardList.do")
	public String BoardlistAll(HttpSession session,Model model,Pagination pagination)
	{

		if(pagination.getIdx()>0){
			studyGroupIdx=pagination.getIdx();   
			//페이지 네이션으로 부터 StudyGroupIdx를 가져옴
			session.setAttribute("studyGroupIdx", studyGroupIdx);//[유리] 
			model.addAttribute("idx", studyGroupIdx);
		}
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();
		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){
			pagination.setIdx(studyGroupIdx);//스터디그룹 idx 셋팅

			pagination.setRecordCount(boardmapper.selectCountStudyGroupBoard(pagination));//[10월14일 수정]
			model.addAttribute("list",boardmapper.selectPageStudyGroupBoard(pagination));//[10월14일 수정]
			model.addAttribute("idx",studyGroupIdx);//스터디 그룹 idx 보냄.
			StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);

			if(studyGroupImage==null){
				StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
				model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
				model.addAttribute("GroupName",studyGroup.getStudyGroupName());

			}else{
				model.addAttribute("route",FetchName+studyGroupImage.getFileName());
				//model.addAttribute("route", studyGroupImage.getRoute());
				model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
			}
			if(leaderOrMember.equals("조장")){
				model.addAttribute("leader","yes");
			}else{
				model.addAttribute("leader","no");		
			}
		

			return "studyRoom/board/boardList";
		}else{
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";
		}


	}

	/*//게시글 보기. -> pagination 하자.
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead.do")
	public String read(@RequestParam("idx") int studyGroupIdx ,Model model, @RequestParam("boardIdx") int boardIdx,@RequestParam(value = "pg", defaultValue = "1") int currentPage){

		int pageSize = 5;
		int recordCount = 0;
		
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();

		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){
			StudyGroupBoard studyGroupBoard = boardmapper.read(boardIdx);

			model.addAttribute("studyGroupIdx", studyGroupIdx); // 스터디 그룹 idx 보냄.
			model.addAttribute("idx", studyGroupIdx);//1018추가
			model.addAttribute("boardIdx",boardIdx);  // 게시글 idx 보냄.

			model.addAttribute("boardTitle",studyGroupBoard.getBoardTitle()); 
			model.addAttribute("boardCotents",studyGroupBoard.getBoardContents());

			//해당 게시글에 대한 댓글 조회해서 보냄  -> 페이지네이션된 댓글로 보내기.
			model.addAttribute("commentList",boardmapper.commentListAll(boardIdx));
			
			//해당 게시글에 대한 대댓글 조회해서 보냄
			model.addAttribute("replyList",boardmapper.replyListAll(boardIdx));

			//user객체 보냄
			model.addAttribute("loginUserIdx",UserService.getCurrentUser().getIdx());

		////[잘풀려라 시작]
					if(boardservice.canDelete(boardmapper.read(boardIdx))){
						model.addAttribute("Authority","yes");	//권한
					}else{
						
						model.addAttribute("Authority","no");	//권한
					}
				
					StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);

					if(studyGroupImage==null){
						StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
						model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
						model.addAttribute("GroupName",studyGroup.getStudyGroupName());

					}else{
						model.addAttribute("route",FetchName+studyGroupImage.getFileName());
						//model.addAttribute("route", studyGroupImage.getRoute());
						model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
					}
				////[잘풀려라 끝]
					if(leaderOrMember.equals("조장")){
						model.addAttribute("leader","yes");
					}else{
						model.addAttribute("leader","no");		
					}

			return "studyRoom/board/boardRead";
		}else{
			model.addAttribute("error","<script>alert('권한이 없습니다.');</script>");
			return "redirect:/";
		}
	}*/
	
	//게시글 보기. -> 댓글 페이지별 리스트 보내기.
	@RequestMapping(value="/studyRoom/board/boardRead.do")
	public String read(@RequestParam("idx") int studyGroupIdx ,Model model, @RequestParam("boardIdx") int boardIdx, @RequestParam(value = "pg", defaultValue = "1") int currentPage){

		System.out.println(boardIdx);
			
		StudyGroupBoard studyGroupBoard = boardmapper.read(boardIdx);

		model.addAttribute("studyGroupIdx", studyGroupIdx); // 스터디 그룹 idx 보냄.
		model.addAttribute("boardIdx",boardIdx);  // 게시글 idx 보냄.
		
		model.addAttribute("boardTitle",studyGroupBoard.getBoardTitle()); 
		model.addAttribute("boardCotents",studyGroupBoard.getBoardContents());
		
		int pageSize = 10;
		int recordCount = boardmapper.selectCountComment(boardIdx);
		//요기가 문제일듯
		model.addAttribute("commentList", boardmapper.commentPageListAll(currentPage, pageSize, boardIdx));	
		model.addAttribute("pages", PageUtil.getPageList(currentPage, pageSize, recordCount));
		model.addAttribute("currentPage", currentPage);
		
		//해당 게시글에 대한 댓글 조회해서 보냄
		//model.addAttribute("commentList",boardmapper.commentListAll(boardIdx));
		
		//해당 게시글에 대한 대댓글 조회해서 보냄
		model.addAttribute("replyList",boardmapper.replyListAll(boardIdx));
		
		//user객체 보냄
		model.addAttribute("loginUserIdx",UserService.getCurrentUser().getIdx());
		//유리 10월28일 추가
		model.addAttribute("idx", studyGroupIdx);
		StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);

		if(studyGroupImage==null){
			StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
			model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
			model.addAttribute("GroupName",studyGroup.getStudyGroupName());

		}else{
			model.addAttribute("route",FetchName+studyGroupImage.getFileName());
			//model.addAttribute("route", studyGroupImage.getRoute());
			model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
		}
		if(leaderOrMember.equals("조장")){
			model.addAttribute("leader","yes");
		}else{
			model.addAttribute("leader","no");		
		}
		
		
		return "studyRoom/board/boardRead";
	}


	//수정페이지로.
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardModify.do", method=RequestMethod.GET)
	public String updateGET(Model model, @RequestParam("studyGroupIdx") int studyGroupIdx, @RequestParam("boardIdx") int boardIdx){
		
		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();
		
		StudyGroupBoard studyGroupBoard = boardmapper.read(boardIdx);
		model.addAttribute("studyGroupBoard",studyGroupBoard);
		model.addAttribute("studyGroupIdx", studyGroupIdx); // 스터디 그룹 idx 보냄.
		model.addAttribute("boardIdx",boardIdx);  // 게시글 idx 보냄.

		model.addAttribute("boardTitle", studyGroupBoard.getBoardTitle());
		model.addAttribute("boardCotents", studyGroupBoard.getBoardContents());
		StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);

		if(studyGroupImage==null){
			StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
			model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
			model.addAttribute("GroupName",studyGroup.getStudyGroupName());

		}else{
			model.addAttribute("route",FetchName+studyGroupImage.getFileName());
			//model.addAttribute("route", studyGroupImage.getRoute());
			model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
		}
		if(leaderOrMember.equals("조장")){
			model.addAttribute("leader","yes");
		}else{
			model.addAttribute("leader","no");		
		}
		
		return "studyRoom/board/boardModify";
	}

	//수정.
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardModify.do", method=RequestMethod.POST)
	public String updatePOST(Model model, @RequestParam("studyGroupIdx") int studyGroupIdx, StudyGroupBoard studygroupboard, @RequestParam("idx") int boardIdx){

		String errorMsg = boardservice.studyGroupBoardError(studygroupboard);//service에서 권한검사까지 함.

		if(errorMsg != null){
			model.addAttribute("errorMsg", errorMsg);
			return "studyRoom/board/boardList";//일단 리스트도 가도록 함.
		}

		if(boardservice.canEdit(boardmapper.read(boardIdx))){
			boardmapper.update(studygroupboard);
		}

		model.addAttribute("idx", studyGroupIdx);

		return "redirect:/studyRoom/board/boardList.do";//페이지네이션 처리로 수정할것. 0920
	}

	//삭제.
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardDelete.do")
	public String delete(Model model,@RequestParam("studyGroupIdx") int studyGroupIdx, @RequestParam("boardIdx") int boardIdx){

		if(boardservice.canDelete(boardmapper.read(boardIdx))){
			boardmapper.delete(boardIdx);
		}

		model.addAttribute("idx",studyGroupIdx);

		return "redirect:/studyRoom/board/boardList.do";//페이지네이션으로 수정 해야함. 0920
	}

	//글 작성 페이지로.
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/board/boardWrite.do", method = RequestMethod.GET)
	public String insertBoardGET(Model model,StudyGroup studygroup) {

		User user = UserService.getCurrentUser();
		String loginId = user.getLoginId();
		int studyGroupIdx = studygroup.getIdx();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();

		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){
			model.addAttribute("idx",studygroup.getIdx());
			model.addAttribute("studygroupboard", new StudyGroupBoard());
			
			StudyGroupImage studyGroupImage = imageMapper.selectStudyImage(studyGroupIdx);

			if(studyGroupImage==null){
				StudyGroup studyGroup=studyGroupMapper.selectByStudyIdx(studyGroupIdx);
				model.addAttribute("route","/StudyMate/resources/images/icon-profile2.png");
				model.addAttribute("GroupName",studyGroup.getStudyGroupName());

			}else{
				model.addAttribute("route",FetchName+studyGroupImage.getFileName());
				//model.addAttribute("route", studyGroupImage.getRoute());
				model.addAttribute("GroupName",studyGroupImage.getStudyGroupName());
			}
			if(leaderOrMember.equals("조장")){
				model.addAttribute("leader","yes");
			}else{
				model.addAttribute("leader","no");		
			}
			
			return "studyRoom/board/boardWrite";
		}else{
			model.addAttribute("error","");
			return "redirect:/";
		}


	}

	//글 작성.
	@Secured("ROLE_전체")
	@RequestMapping(value = "/studyRoom/board/boardWrite.do", method = RequestMethod.POST)
	public String insertBoardPOST(Model model,@ModelAttribute("studygroupboard")StudyGroupBoard studygroupboard,@RequestParam("idx") int studyGroupIdx) {

		User user = UserService.getCurrentUser();
		int userIdx = user.getIdx();


		/*String loginId = user.getLoginId();
		User_User_StudyGroup uusg = leaderOrMember.authentication(loginId, studyGroupIdx);

		String leaderOrMember = uusg.getMemberType();

		if(leaderOrMember.equals("조원")||leaderOrMember.equals("조장")){

		}*/
		
		

		studygroupboard.setStudyGroupIdx(studyGroupIdx);
		studygroupboard.setUserIdx(userIdx);

		String errorMsg = boardservice.studyGroupBoardError(studygroupboard);
		if(errorMsg != null){
			model.addAttribute("errorMsg", errorMsg);
			return "studyRoom/board/boardWrite";
		}

		if(boardservice.canCreate(studygroupboard.getIdx())){
			boardmapper.insertBoard(studygroupboard);
			model.addAttribute("success", "<script type='text/javascript'>alert('?');</script>");	
			model.addAttribute("idx", studyGroupIdx);
		}
		return "redirect:/studyRoom/board/boardList.do?idx="+studyGroupIdx;
		//return "redirect:/studyRoom/board/boardList.do?bd="+pagination.getBd();페이지네이션 처리로 수정
	}

}
