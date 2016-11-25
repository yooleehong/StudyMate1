package studyMate.service;

//import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import studyMate.dto.User;
import studyMate.mapper.UserMapper;

@Component
public class MyAuthenticationProvider implements AuthenticationProvider {

    @Autowired UserMapper userMapper;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String loginId = authentication.getName();
        String password = authentication.getCredentials().toString();
        return authenticate(loginId, password);
    }

    public Authentication authenticate(String loginId, String password) throws AuthenticationException {
        User user = userMapper.selectByLoginId(loginId);
        if (user == null) return null;
        if (user.getPassword().equals(encryptPasswd(password)) == false) return null;

        List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_전체"));//로그인에 성공한 모든 사용자에게 ROLE_전체 권한을 부여.
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_" + user.getUserType()));//user.getUserType()의 리턴값에 따라 관리자권한, 회원권한이 부여됨.
        return new MyAuthenticaion(loginId, password, grantedAuthorities, user);
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

    public static String encryptPasswd(String password) {
        try {
//            MessageDigest md = MessageDigest.getInstance("MD5");
//            byte[] passBytes = passwd.getBytes();
//            md.reset();
//            byte[] digested = md.digest(passBytes);
//            StringBuffer sb = new StringBuffer();
//            for(int i=0;i<digested.length;i++)
//                sb.append(Integer.toHexString(0xff & digested[i]));
//            return sb.toString();
        	return password;
        }
        catch (Exception e) {
            return password;
        }
    }

    public class MyAuthenticaion extends UsernamePasswordAuthenticationToken {
        private static final long serialVersionUID = 1L;
        User user;

        public MyAuthenticaion (String loginId, String password, List<GrantedAuthority> grantedAuthorities, User user) {
            super(loginId, password, grantedAuthorities);
            this.user = user;
        }

        public User getUser() {
            return user;
        }

        public void setUser(User user) {
            this.user = user;
        }
    }
}