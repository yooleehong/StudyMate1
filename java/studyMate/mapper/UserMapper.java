package studyMate.mapper;

import java.util.List;

import studyMate.dto.User;

public interface UserMapper {
	
	User selectByLoginId(String loginId);//로그인 아이디로 유저 조회
	User selectByEmail(String email);//이메일로 유저 조회
	List<User> selectByName(User user);//마지막이다ㅎㅎ
	void insert(User user);//유저 추가
    void update(User user);//유저 수정
    void deleteByIdx(int idx);//유저 삭제
    
}
