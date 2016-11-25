package studyMate.service;

import studyMate.dto.User;
import studyMate.service.MyAuthenticationProvider;
import studyMate.mapper.UserMapper;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	//getCurrentUser() 메소드 현재 로그인된 사용자에 꺼내기
	public static User getCurrentUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication instanceof MyAuthenticationProvider.MyAuthenticaion)
			return ((MyAuthenticationProvider.MyAuthenticaion) authentication).getUser();
		return null;
	}
	//현재 사용자 정보가 변경된 경우에, Spring Security가 메모리에 보관하고 있는 현재 사용자 객체도 변경되어야 함.
	public static void setCurrentUser(User user) {
		((MyAuthenticationProvider.MyAuthenticaion)
				SecurityContextHolder.getContext().getAuthentication()).setUser(user);
	}

	public String userValidateBeforeJoin(User user) {
		String s = user.getLoginId();
		if (StringUtils.isBlank(s))
			return "아이디를 입력하세요.";

		if (s.length() < 3)
			return "아이디는 3글자 이상이어야 합니다.";

		User u = null;
		u = userMapper.selectByLoginId(s);
		if (u != null)
			return "아이디가 중복됩니다.";

		s = user.getPassword();
		if (StringUtils.isBlank(s))
			return "비밀번호를 입력하세요.";

		if (s.length() < 6)
			return "비밀번호는 6글자 이상이어야 합니다.";


		s = user.getName();
		if (StringUtils.isBlank(s))
			return "이름을 입력하세요.";

		if (s.length() < 2)
			return "정확한 이름을 입력하세요.";

		s = user.getEmail();
		if (StringUtils.isBlank(s))
			return "이메일을 입력하세요.";

		u = userMapper.selectByEmail(s);
		if (u != null)
			return "이메일이 중복됩니다.";


		user.setUserType("회원");//관리자는 DB에 미리 insert. 조장을 나타내줄 수 있는 컬럼이 하나 필요함. 수정할것 !

		return null;
	}

	public String userValidateBeforeUpdate(User user){

		String s = user.getPassword();
		if(StringUtils.isBlank(s))
			return "비밀번호를 입력하세요.";

		if (s.length() < 6)
			return "비밀번호는 6글자 이상이어야 합니다.";

		s = user.getEmail();
		if(StringUtils.isBlank(s))
			return "이메일을 입력하세요.";

		s = user.getPhoneNumber();
		if(StringUtils.isBlank(s))
			return "핸드폰 번호를 입력하세요.";

		return null;
	}


}
