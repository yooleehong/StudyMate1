package studyMate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import studyMate.dto.Message;
import studyMate.dto.User;
import studyMate.mapper.MassageMapper;
import studyMate.mapper.UserMapper;
import studyMate.service.UserService;

@Controller
public class MessageController {

	@Autowired
	UserMapper userMapper;
	@Autowired
	MassageMapper messagemapper;

	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/main.do", method = RequestMethod.GET)
	public String main(Model model) {
		User user = UserService.getCurrentUser();
		int loginIdx = user.getIdx();
		model.addAttribute("idx",loginIdx);
		model.addAttribute("receive", messagemapper.receiveSelectList(loginIdx));//받은 편지함
		model.addAttribute("send", messagemapper.SendSelectList(loginIdx));//보낸 편지함
		return "member/message/main";
	}

	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/main.do", method = RequestMethod.POST)
	public String mainPost(User user, Model model) {
		List<User> list = userMapper.selectByName(user);
		System.out.println(user.getLoginId());
		model.addAttribute("list", list);
		user = UserService.getCurrentUser();
		int loginIdx = user.getIdx();
		model.addAttribute("idx",loginIdx);
		model.addAttribute("receive", messagemapper.receiveSelectList(loginIdx));//받은 편지함
		model.addAttribute("send", messagemapper.SendSelectList(loginIdx));//보낸 편지함
		model.addAttribute("view","yes");
		return "member/message/select";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/select.do", method = RequestMethod.GET)
	public String select(Model model) {
		User user = UserService.getCurrentUser();
		int loginIdx = user.getIdx();
		model.addAttribute("idx",loginIdx);
		model.addAttribute("receive", messagemapper.receiveSelectList(loginIdx));//받은 편지함
		model.addAttribute("send", messagemapper.SendSelectList(loginIdx));//보낸 편지함
		return "member/message/select";
	}
	
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/select.do", method = RequestMethod.POST)
	public String insert(Message Message, Model model){
		messagemapper.insert1(Message);
		messagemapper.insert2(Message);
		User user = UserService.getCurrentUser();
		int loginIdx = user.getIdx();
		model.addAttribute("idx",loginIdx);
		model.addAttribute("receive", messagemapper.receiveSelectList(loginIdx));//받은 편지함
		model.addAttribute("send", messagemapper.SendSelectList(loginIdx));//보낸 편지함
		return "member/message/main";
	}
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/detail.do", method = RequestMethod.GET)
	public String detail(Message message, Model model) {
		model.addAttribute("idx",message.getIdx());
		
		return "member/message/detail";
	}
	@Secured("ROLE_전체")
	@RequestMapping(value = "/member/message/delete.do", method = RequestMethod.POST)
	public String delete(Message Message, Model model){
		messagemapper.delete(Message.getIdx());
		User user = UserService.getCurrentUser();
		int loginIdx = user.getIdx();
		model.addAttribute("idx",loginIdx);
		model.addAttribute("receive", messagemapper.receiveSelectList(loginIdx));//받은 편지함
		model.addAttribute("send", messagemapper.SendSelectList(loginIdx));//보낸 편지함
		return "member/message/main";
	}
	
}
