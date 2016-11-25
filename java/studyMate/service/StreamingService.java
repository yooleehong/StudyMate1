package studyMate.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studyMate.dto.Stream;
import studyMate.dto.User;

@Service
public class StreamingService {
	
	@Autowired
	UserService userService;
	
	public boolean inspectionAuthority(Stream stream){
		User user=UserService.getCurrentUser();
		
			if(stream.getUserIdx()==user.getIdx()){
				return true;//동영상올린사람의 권한TEST
			}else{		
				return false;
			}
		}
	
	}
