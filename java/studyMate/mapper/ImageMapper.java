package studyMate.mapper;

import java.util.List;

import studyMate.dto.Image;
import studyMate.dto.Stream;
import studyMate.dto.StreamImage;
import studyMate.dto.StudyGroupImage;


public interface ImageMapper {

	
		Image show(int userIdx);
		List<Image> allShow();//전체 회원이미지 보기
		List<StudyGroupImage> StudyAllShow();//[10월18일 수정]
		void fileUpload(Image image);
		void fileUpdate(Image image);//업뎃할 useridx와 data가 있어야함
		void setIdx(Image image);//업뎃할 useridx와 data가 있어야함
		void fileDelete(int userIdx);
		void insert(StudyGroupImage studyGroupImage);//[10월17일 수정]
		StudyGroupImage selectStudyImage(int studyGroupIdx);
		List<StreamImage> StreamAllShow();//전체 스트림이미지 보기
		void streamInsert(StreamImage streamImage);//[10월 18일 수정]
		List<StreamImage> selectStreamImage(int studyGroupIdx);//[10월 18일 수정]
		StreamImage selectImage (Stream stream);////[10월19일추가]스트림idx에 맞는 이미지가져오기
}		
