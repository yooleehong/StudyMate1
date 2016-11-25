package studyMate.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import net.sf.json.JSONObject;
import studyMate.dto.Comment;
import studyMate.dto.ReplyComment;
import studyMate.dto.User;
import studyMate.mapper.BoardMapper;
import studyMate.service.UserService;



//RestController라 지정해주어야함.
@RestController
public class CommentController {

	@Autowired
	BoardMapper boardmapper;
	
	//해당 게시글에 대한 댓글 등록
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/insertComment.do", method = RequestMethod.GET)
	public void insertComment(HttpServletResponse response, @RequestParam(value="commentInput") String commentInput, @RequestParam(value="boardIdx") String boardIdx) throws IOException{
		
		System.out.println("commentInsert 호출됨");
		
		int studyboardIdx = Integer.parseInt(boardIdx);
		User user=UserService.getCurrentUser();
		
	    //현재 날짜와 시각 조회  -> writeTime컬넘의 자료형이 String이 아니라 Date 형식이여서 이 format 적용 못함. 
	    //SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
		Date currentTime = new Date ( );
		//String mTime = mSimpleDateFormat.format ( currentTime );
	
		Comment comment = new Comment();
		comment.setCommentContents(commentInput);
		comment.setUserIdx(user.getIdx());
		comment.setStudyGroupBoardIdx(studyboardIdx); 
		comment.setWriteTime(currentTime);
		boardmapper.insertComent(comment);
		
		System.out.println("insert됨");
		
		//추가한 comment의 idx.
		System.out.println(comment.getIdx());
		int commentIdx = (int)comment.getIdx();
		
		//현재 날짜와 시각 pattern 바꿈
	    SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
		String writeTime = mSimpleDateFormat.format ( currentTime );
		
		//insert한 댓글의 userId, writeTime jsonObject에 실어서 보냄.
		JSONObject json = new JSONObject();
		json.put("USERID", user.getLoginId());
		//String writeTime = currentTime.toString(); //json 형식에 맞춰Date -> String으로 
		json.put("WRITETIME", writeTime);
		json.put("commentIdx", commentIdx);
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json.toString());
		
	}
	
	//댓글 수정
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/updateComment.do")
	public String updateComment(@RequestParam("commentIdx") int commentIdx, @RequestParam(value="commentInput") String commentInput){
		
		Comment comment = new Comment();
		
		Date currentTime = new Date();
		
		comment.setIdx(commentIdx);
		comment.setCommentContents(commentInput);
	
		
		boardmapper.updateComment(comment);
		
		//writeTime 보냄(수정된 시간)
		return currentTime.toString();
	}
	
	//댓글 삭제
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/deleteComment.do")
	public void deleteComment(@RequestParam("commentIdx") int commentIdx){
		
		//먼저 댓글에 달린 대댓부터 삭제함.
		boardmapper.deleteReplyByComment(commentIdx);
		
		boardmapper.deleteComment(commentIdx);

	}
	

	
	
	//답글(대댓) 등록
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/insertReply.do")
	public void insertReply(HttpServletResponse response, @RequestParam(value="replyInput") String replyInput, @RequestParam("commentIdx") int commentIdx, @RequestParam("boardIdx") int boardIdx) throws IOException{
		
		ReplyComment replyComment  = new ReplyComment();
		replyComment.setCommentIdx(commentIdx);  //commentIdx
		replyComment.setCommentContents(replyInput);	//commentContents(답글내용)
		User user=UserService.getCurrentUser();
		replyComment.setUserIdx(user.getIdx());  //userIdx
		//10.19 성경
		replyComment.setStudyGroupBoardIdx(boardIdx);
		
		boardmapper.insertReply(replyComment);
		
		//추가한 comment의 idx.
		System.out.println(replyComment.getIdx());
		int replyIdx = (int)replyComment.getIdx();
		
		JSONObject json = new JSONObject();
		json.put("USERID", user.getLoginId());
		Date currentTime = new Date ( );
		String writeTime = currentTime.toString(); 
		json.put("WRITETIME", writeTime);
		json.put("REPLYIDX", replyIdx);
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json.toString());

	}
	
	//대댓 삭제
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/deleteReply.do")
	public void deleteReply(@RequestParam("replyIdx") int replyIdx){
		
		boardmapper.deleteReply(replyIdx);

	}
	
	//대댓 수정
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/updateReply.do")
	public String updateReply(@RequestParam("replyIdx") int replyIdx, @RequestParam(value="commentInput") String commentInput){
			
		ReplyComment replyComment  = new ReplyComment();
			
		Date currentTime = new Date();
		
		replyComment.setIdx(replyIdx);
		replyComment.setCommentContents(commentInput);
		
			
		boardmapper.updateReply(replyComment);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
		String writeTime = mSimpleDateFormat.format ( currentTime );
		
		//writeTime 보냄(수정된 시간)
		return writeTime;
	}

	
	//댓글 내용 조회
	@Secured("ROLE_전체")
	@RequestMapping(value="/studyRoom/board/boardRead/selectContents.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String selectContents(@RequestParam("commentIdx") int commentIdx) throws UnsupportedEncodingException{
		
		String contents = boardmapper.selectContents(commentIdx);
		URLEncoder.encode(contents , "UTF-8");
		return contents;

	}
	
	//대댓글 내용 조회
	@Secured("ROLE_전체")	
	@RequestMapping(value="/studyRoom/board/boardRead/selectReplyContents.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String selectReplyContents(@RequestParam("replyIdx") int replyIdx) throws UnsupportedEncodingException{
	
		
		String replyContents = boardmapper.selectReplyContents(replyIdx);
		URLEncoder.encode(replyContents , "UTF-8");
		return replyContents;
	
		

	}
	

}
