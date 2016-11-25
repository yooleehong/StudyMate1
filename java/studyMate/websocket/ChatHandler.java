package studyMate.websocket;

import java.io.IOException;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import studyMate.dto.StudyGroupChat;
import studyMate.service.ChatService;

@ServerEndpoint(value="/studyRoom/board/tempChat/{studyGroupIdx}")
public class ChatHandler {
	
	@OnOpen
	public void onOpen(Session session, @PathParam("studyGroupIdx") String studyGroupIdx){
		
		StudyGroupChat chat = new ChatService().getStudyGroupChat(Integer.parseInt(studyGroupIdx));
		chat.getChatClients().add(session);
		
	}
	
	@OnClose
	public void onClose(Session session, @PathParam("studyGroupIdx") String studyGroupIdx) throws IOException{
		//여기서부터 퇴장 알리기 위해 10.11 추가
		/*String exitMsg = exitUserName+ "님이 퇴장하셨습니다.";
		StudyGroupChat chat = new ChatService().getStudyGroupChat(Integer.parseInt(studyGroupIdx));
		Set<Session> chatClients = chat.getChatClients();
		String clientId = session.getId();
		
		if(chatClients != null){
			synchronized (chatClients){
				for(Session client : chatClients){
					client.getBasicRemote().sendText(exitMsg);
				}
			}
		}*/
		//여기까지. 10.11 추가 내용
		StudyGroupChat chat = new ChatService().getStudyGroupChat(Integer.parseInt(studyGroupIdx));
		chat.getChatClients().remove(session);
		
	}
	
	@OnMessage
	public void onMessage(@PathParam("studyGroupIdx") String studyGroupIdx, String tempMessage, Session session) throws IOException{
		
		JSONObject jsonObj = new JSONObject();
		JSONObject toClient = new JSONObject();
		
		jsonObj = (JSONObject)JSONValue.parse(tempMessage);
		
		String userName = jsonObj.get("name").toString();
		String msg;
		
		if(jsonObj.get("tempMsg") == null){
			msg = "";
		}else{
			msg = jsonObj.get("tempMsg").toString();
			System.out.println("msg값: "+msg);
		}
		
		
		//System.out.println("클라이언트에서 전송한 msg값: "+msg);
		StudyGroupChat chat = new ChatService().getStudyGroupChat(Integer.parseInt(studyGroupIdx));
		Set<Session> chatClients = chat.getChatClients();
		String clientId = session.getId();
		
		if(chatClients != null){
			synchronized (chatClients){
				
				toClient.put("name", userName);
				toClient.put("msg", msg);
				
				String sendToClient = toClient.toJSONString();
				
				for(Session client : chatClients){
					client.getBasicRemote().sendText(sendToClient);
				}
			}
		}
		
	}
	
}
