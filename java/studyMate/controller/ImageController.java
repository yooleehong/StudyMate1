package studyMate.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import studyMate.dto.Image;
import studyMate.mapper.ImageMapper;
import studyMate.mapper.UserMapper;

@Controller
public class ImageController {

	@Autowired
	UserMapper userMapper;

	@Autowired
	ImageMapper imageMapper;


	String dirName = "C:/Users/user/workspace/StudyMate/src/main/webapp/upload2/";//승일이
	/*String dirName = "C:/BitProject/StudyMate/src/main/webapp/upload2/";//[9월30일 수정]서버의 webapp 경로로 변경 -성경이
*/	String FetchName="/StudyMate/upload2/";//[9월30일 추가] 이미지 불러올 경로

	@RequestMapping(value = "/fileUpload.do") //파일업로드
	@ResponseBody
	public String upload(Image image,MultipartHttpServletRequest multipartRequest) { //Multipart로 받는다.

		Iterator<String> itr =  multipartRequest.getFileNames();



		while (itr.hasNext()) { //받은 파일들을 모두 돌린다.

			MultipartFile mpf = multipartRequest.getFile(itr.next());//파일하나를 가져옴
			try {
				BufferedImage bufferImage = ImageIO.read(mpf.getInputStream()); //파일읽기
				ByteArrayOutputStream baos = new ByteArrayOutputStream();//OutputStream 으로 저장

				/*아래 코드는 이미지를 연속으로 여러개 삽입시 필요한 코드이다.*/
				Image searchImage =imageMapper.show(1111); //userIdx가 1111인 유저 조회 (userIdx초기값이 1111이다.)
				if (searchImage != null) { //(조회값이 있을시)새로넣은 이미지 가 있을시
					File dir = new File(dirName+searchImage.getFileName());//이미지의 파일을 만들고
					if (dir.isFile()) {//디렉토리에 존재시
						dir.delete(); //폴더에서 이미지 파일 삭제하고
						imageMapper.fileDelete(1111);//DB에서도 이미지를 삭제한다.
					}
				}
				/* 여기까지 */

				ImageIO.write(bufferImage, "png", baos);
				String genId = UUID.randomUUID().toString(); // 파일 중복명 처리를 위한 랜덤이름
				String originFileName = mpf.getOriginalFilename();//파일의경로
				String fileName = genId + "." + FilenameUtils.getExtension(originFileName);// 저장되는 파일 이름(x.png)
				System.out.println(genId+"/"+originFileName+"/"+fileName);
				String savePath = FetchName+fileName; // 저장 될 파일 경로
				long fileSize = mpf.getSize(); // 파일 사이즈
				image.setUserIdx(1111);//임시값 'ueridx'
				image.setFileName(fileName); //여러가지 이미지 삽입을 위한 값 셋팅
				image.setOriginalfileName(originFileName);
				image.setFileSize(fileSize);
				image.setData(mpf.getBytes());
				image.setRoute(savePath+fileName);//[9월 30일 수정]이미지 불러올 경로수정
				imageMapper.fileUpload(image); //셋팅한 이미지 객체를 업로드 한다. 
				byte[] data=( byte[])image.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));   
				ImageIO.write(imag, "png", new File(dirName, image.getFileName()));//생성시 이미지 폴더에 사진추가

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


		}
		return "member/join";
	}
	@RequestMapping(value = "/fileUploadCancel.do") //이미지 업로드 했다가  회원가입안하고 페이지 나갈시 필요한 코드
	public String fileUploadCancel(Model model){
		try{
			Image searchImage =imageMapper.show(1111); //userIdx 1111 인 이미지 조회 (이미지 한번이라도 삽입시 1111로 이미지가 삽입 돼있음)
			if (searchImage != null) { //이미지가 존재시

				File dir = new File(dirName+searchImage.getFileName()); //파일을 생성하고
				if (dir.isFile()) {
					System.out.println("파일존재");
					dir.delete(); //이미지 파일을 폴더에서 삭제
					imageMapper.fileDelete(1111); //이미지 DB에서도 이미지 삭제
				}

			}
		}
		catch(Exception e){

			System.out.println("ERROR");
		}
		return "member/login";
	}

	@RequestMapping(value = "/fileUpdate.do")
	@ResponseBody
	public void fileUpdate(Image image,HttpSession session,MultipartHttpServletRequest multipartRequest) { //Multipart로 받는다.

		Iterator<String> itr =  multipartRequest.getFileNames();

		while (itr.hasNext()) { 

			try { 
				MultipartFile mpf = multipartRequest.getFile(itr.next());//파일하나를 가져옴
				String genId = UUID.randomUUID().toString(); // 파일 중복명 처리를 위한 랜덤이름
				String originFileName = mpf.getOriginalFilename();//파일의경로
				String fileName = genId + "." + FilenameUtils.getExtension(originFileName);// 저장되는 파일 이름(x.png)
				int loginIdx=(int)session.getAttribute("loginIdx");
				image.setUserIdx(loginIdx);//바꿀 유저의 idx 
				image.setData(mpf.getBytes());//바꿀이미지의 데이터
				image.setFileName(fileName);//이미지값 셋팅
				image.setOriginalfileName(originFileName);
				image.setFileSize(mpf.getSize());
				image.setRoute(FetchName+fileName);//[9월30일 수정]이미지 가져올 경로 설정
				String deleteName="";
				String updateName="";
				if(imageMapper.show(loginIdx)!=null){ //[9월 30일 수정]if 문 안쪽 변경 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
					Image deleteimage=imageMapper.show(loginIdx);//이미지 바꿀 유저의 userIdx 
					deleteName=deleteimage.getFileName(); //삭제할 이미지의 파일 이름을 조회
					imageMapper.fileUpdate(image); //파일 업뎃
					image=imageMapper.show(loginIdx);//새로운 이미지 조회
					updateName=image.getFileName(); //새로운 이미지 이름조회
					File dir = new File(dirName+deleteName); //그 이미지의 파일을 생성하고
					if (dir.isFile()) { //파일 존재시
						dir.delete();   //폴더에서 해당 이미지파일 삭제하고             
					}
				}else{//[9월 30일 수정]if 문 안쪽 변경 여기까지ㅡㅡㅡㅡㅡㅡㅡㅡㅡ
					imageMapper.fileUpload(image); //이미지 파일 업로드
					deleteName=image.getFileName();//이미지 DB에서도 해당이미지 삭제
				}

				byte[] data=( byte[])image.getData();//byte로 가져옴
				BufferedImage imag = ImageIO.read(new ByteArrayInputStream(data));   //이미지 읽기
				ImageIO.write(imag, "png", new File(dirName, updateName));//다시 폴더에 업댓이미지 삽입//[9월 30일 수정]updateName으로 수정



				System.out.println("업뎃완료");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}



		}

	}


}