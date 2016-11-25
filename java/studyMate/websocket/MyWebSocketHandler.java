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

import studyMate.dto.StudyGroupRoomDocument;
import studyMate.service.StudyGroupRoomService;

/*@ServerEndpoint(value = "/studyRoom/document/document/{studyGroupIdx}")
public class MyWebSocketHandler extends TextWebSocketHandler {

	Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>(); //클라이언트 연결 객체를 보관할 자료구조 객체 (Set)

	@Override//클라이언트 연결이 끊어졌을 때 자동으로 호출되는 메소드. 파라미터 session은 클라이언트 연결 객체이다.
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		sessionSet.remove(session);//클라이언트 연결이 끊어지면 클라이언트 객체를 보관하던 Set자료구조 sessionSet에서 제거해준다.
	}

	@Override//클라이언트가 연결되었을 때 호출됨.
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		sessionSet.add(session);//연결된 클라이언트를 자료구조에 add 해준다.
		System.out.println("추가된 세션의 id값:  "+session.getId());
	}

	@Override//클라이언트가 보낸 메세지가 서버에 도착하면 호출됨.
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> document) throws Exception {
		String text = (String)document.getPayload();//클라이언트가 보낸 메세지의 본문을 꺼내서 String 형으로 형변환 한 후 text에 저장
		System.out.print("클라이언트에서 보낸 문서 내용: "+text);
		sendMessageToAllClients(text);//연결된 모든 클라이언트에게 메세지를 보낸다.
	}

	private void sendMessageToAllClients(String text) throws IOException {//연결된 모든 클라이언트에게 메세지를 보내기 위한 메소드
		System.out.println("접속한 사용자에게 뿌릴 내용: "+text);
		TextMessage msg = new TextMessage(text);//TextMessage 객체 생성.
		for (WebSocketSession session : sessionSet)// 연결된 클라이언트 객체들을 저장하고있는 sessionSet에서 객체를 하나씩 꺼낸 후 
			session.sendMessage(msg);//메세지를 보낸다. 즉 모든 클라이언트들에게 메세지를 보내줌.

	}*/

@ServerEndpoint(value = "/studyRoom/document/document/{studyGroupIdx}")//client side 에서 접속할 server 주소
public class MyWebSocketHandler{

	//Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>(); //클라이언트 연결 객체를 보관할 자료구조 객체 (Set)

	@OnOpen//클라이언트 접속
	public void onOpen(Session session, @PathParam("studyGroupIdx") String studyGroupIdx){
		StudyGroupRoomDocument document = new StudyGroupRoomService().getStudyGroupRoomDocument(Integer.parseInt(studyGroupIdx));
		document.getClients().add(session);
		System.out.print("세션에 추가됨");
	}

	@OnClose//클라이언트 접속 종료
	public void onClose(Session session, @PathParam("studyGroupIdx") String studyGroupIdx){
		StudyGroupRoomDocument document = new StudyGroupRoomService().getStudyGroupRoomDocument(Integer.parseInt(studyGroupIdx));
		document.getClients().remove(session);
		System.out.print("세션에서 제거됨");
	}

	@OnMessage//클라이언트로부터 메세지가 온 경우 받아서 처리
	public void onMessage(@PathParam("studyGroupIdx") String studyGroupIdx, String document, Session session) throws IOException{

		JSONObject jsonObj = new JSONObject(); //클라이언트에서 보내온 객체
		JSONObject toClient = new JSONObject(); //클라이언트로 보낼 객체

		jsonObj = (JSONObject)JSONValue.parse(document);

		String writer = jsonObj.get("writer").toString();//작성중인 유저의 이름
		String writing = jsonObj.get("writing").toString();//작성여부 (작성중, 작성완료)
		String documentContents = jsonObj.get("documentContents").toString();//문서 내용
		
		System.out.println("클라이언트에서 보낸 문서 내용: "+documentContents);
		
		StudyGroupRoomDocument studyGroupRoom = new StudyGroupRoomService().getStudyGroupRoomDocument(Integer.parseInt(studyGroupIdx));
		Set<Session> clients = studyGroupRoom.getClients();

		String clientId = session.getId();



		if("작성중".equals(writing)){

			synchronized (clients){

				toClient.put("name", writer);
				toClient.put("writing", "작성중");
				toClient.put("documentContents", documentContents);
				String sendToClient = toClient.toJSONString();
				
				System.out.println("클라이언트로 보낼 문서 내용: "+sendToClient);
				
				for(Session client : clients){
					if(clientId != client.getId()){
						client.getBasicRemote().sendText(sendToClient);
					}
				}
			}
		}
		
		if("작성완료".equals(writing)){
			
			synchronized(clients){
				
				toClient.put("name",writer);
				toClient.put("writing", "작성완료");
				toClient.put("documentContents", documentContents);
				String sendToClient = toClient.toJSONString();
				
				for(Session client : clients){
					if(clientId != client.getId()){
						client.getBasicRemote().sendText(sendToClient);
					}
				}
			}
		}









		/*if(clients != null){
			synchronized(clients){
				//String text = (String)document.getPayload();//클라이언트가 보낸 메세지의 본문을 꺼내서 String 형으로 변환 한 후 text에 저장
				System.out.println("클라이언트에서 보낸 문서 내용: "+document);

				for(Session client : clients){
					if(clientId != client.getId()){
						client.getBasicRemote().sendText(document);
					}
				}
			}
		}*/






	}

	/*private void sendMessageToAllClients(String text) throws IOException {//연결된 모든 클라이언트에게 메세지를 보내기 위한 메소드
		System.out.println("접속한 사용자에게 뿌릴 내용: "+text);
		TextMessage msg = new TextMessage(text);//TextMessage 객체 생성.
		//for (WebSocketSession session : sessionSet)// 연결된 클라이언트 객체들을 저장하고있는 sessionSet에서 객체를 하나씩 꺼낸 후 
		//	session.sendMessage(msg);//메세지를 보낸다. 즉 모든 클라이언트들에게 메세지를 보내줌.


	}*/
}
