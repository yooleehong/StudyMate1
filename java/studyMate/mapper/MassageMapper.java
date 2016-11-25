package studyMate.mapper;

import java.util.List;
import studyMate.dto.Message;

public interface MassageMapper {
	
	public Message selectIdxMessage(int idx);
	
	public List<Message> receiveSelectList(int idx); 
	
	public void insert1(Message message); 
	
	public void insert2(Message message);
	
	public void delete(int idx);
	
	public List<Message> SendSelectList(int idx); 

}
//*******받은편지함********
//receiveSelectList :나의 idx 받아서  메세지조회(나의idx랑 userTo의 idx랑 같은것 출력)
//insert : 메세지 전송으로  내용을 저장함 된다.('1006내idx','1002남idx',GETDATE(),'반가워')
//delete: 삭제하려는 쪽지의 idx를 받아 삭제
//*******보낸편지함********
//SendSelectList :나의 idx 받아서 userFrom 와 같은 것 조회

/*int idx; //메세지 번호
int userFrom; //나의 idx(회원idx)
int userTo; //받는사람 idx(회원idx)
String userFromName; //나의 이름
String userToName;// 받는사람 이름
Date writeTime; //쓴시간
String text;//내용   */