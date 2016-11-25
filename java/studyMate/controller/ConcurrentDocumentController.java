package studyMate.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import studyMate.dto.Document;
import studyMate.mapper.DocumentMapper;


@Controller
public class ConcurrentDocumentController {
	
	@Autowired
	DocumentMapper documentMapper;
	
	/*@RequestMapping(value = "/studyRoom/document/documentDown.do", method = RequestMethod.POST)
	public void downloadDocument(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("컨트롤러의 word 다운로드 액션메소드 호출 됨.");
		
		response.setHeader("Content-Disposition", "attachment; filename="+"tempName.doc");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		
		XWPFDocument document =new XWPFDocument();

		//document.
		
		
		//response.setContentType("application/vnd.word");
		//response.setHeader("Content-Disposition", "attachment;filename=" + "임시파일" + "ServieRequestList.doc");		
		//System.out.println("header setting complete!");
		
	}*/
	
	@RequestMapping(value = "/studyRoom/document/save.do", produces = "application/json; charset=UTF-8", method = RequestMethod.POST)
	public @ResponseBody String saveDocument(Model model, Document document, HttpServletResponse response) throws IOException{
		System.out.println("저장 액션메소드 호출");
		
		/*JSONObject jsonObj = new JSONObject();
		jsonObj = (JSONObject)JSONValue.parse(document);
		
		String userName = jsonObj.get("writer").toString();
		String contents = jsonObj.get("documentContents").toString();
		int studyGroupIdx = Integer.parseInt(jsonObj.get("studyGroupIdx1").toString());
		int userIdx = Integer.parseInt(jsonObj.get("userIdx1").toString());
		
		Document iDocument = new Document();
		iDocument.setStudyGroupIdx(studyGroupIdx);
		iDocument.setUserIdx(userIdx);
		iDocument.setUserName(userName);
		iDocument.setContents(contents);*/
		
		
		//Document iDocument = document;
		//System.out.println(iDocument.getStudyGroupIdx());
		//System.out.println(iDocument.getUserIdx());
		//System.out.println(iDocument.getContents());
		
		
		//-----------------------------------------------------
		
		int studyGroupIdx = document.getStudyGroupIdx();
		
		Document tempDocument = documentMapper.selectByStudyGroupIdx(studyGroupIdx);
		
		if(tempDocument != null){
			documentMapper.updateDocument(document);
			System.out.println("update 완료");
		}else{
			documentMapper.insertDocument(document);
			System.out.println("insert 완료");
		}
		
		
		
		return "SUCCESS";
		
	}
	
	@RequestMapping(value = "/studyRoom/document/documentDown.do", produces = "application/json; charset=UTF-8", method = RequestMethod.POST)
	public void documentDown(Model model, String contents, HttpServletResponse response)throws Exception{
		
		/*JSONObject jsonObj = new JSONObject();
		jsonObj = (JSONObject)JSONValue.parse(document);*/
		
		String documentContents = contents;
		System.out.println("contents값(태그들이 나와야함) : "+documentContents);
		byte[] documentContentsByte = documentContents.getBytes();
		//model.addAttribute("contents", documentContents);
		
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=temp;");
		
		System.out.println("contents의 데이터: "+documentContentsByte);
		
		try(BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())){
			System.out.println("try문 들어옴");
			output.write(documentContentsByte);
			System.out.println("output.write 완료");
		}
		
		
		//return "studyRoom/document/documentDown";
		
	}
	
	@RequestMapping(value = "/studyRoom/document/documentDown1.do" )
	public String documentDown1(Model model, HttpServletResponse response, @RequestParam("idx") int idx)throws Exception{
		
		Document tDocument = documentMapper.selectByStudyGroupIdx(idx);
		
		if(tDocument != null){
			
			String documentContents = tDocument.getContents();
			System.out.println("contents값(태그들이 나와야함) : "+documentContents);
			byte[] documentContentsByte = documentContents.getBytes();
			//model.addAttribute("contents", documentContents);
			
			response.setContentType("text/html; charset=UTF-8");
			response.setHeader("Content-Description", "JSP Generated Data");
			response.setHeader("Content-Disposition", "attachment;filename=temp.html;");
			
			System.out.println("contents의 데이터: "+documentContentsByte);
			
			/*try(BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())){
				output.write(documentContentsByte);
			}*/
			model.addAttribute("contents", documentContents);
			
			//documentMapper.deleteDocument(idx);//여기서 삭제가 아니라 insert하기 직전에 삭제하도록..? 10_04
			
			return "studyRoom/document/documentDown";
			
		}else{
			model.addAttribute("error","<script>alert('작성중인 문서가 없습니다.');</script>");
			return "studyRoom/document/document";
		}
		
	}
	
}
