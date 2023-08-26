package com.together.moviesquare.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.together.moviesquare.admin.service.AdminService;
import com.together.moviesquare.common.Paging;
import com.together.moviesquare.common.SearchPaging;
import com.together.moviesquare.member.service.MemberService;
import com.together.moviesquare.member.vo.Member;
import com.together.moviesquare.movie.service.MovieService;
import com.together.moviesquare.movie.vo.Movie;

import lombok.extern.java.Log;

@Log
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private MovieService movieservice;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//관리자 페이지 입장시 로그인 화면으로
	@RequestMapping("admin")
	public String adminLoginView(Model model,HttpSession loginSession) {
		if(loginSession != null) {
			try {
				Member mem = (Member)loginSession.getAttribute(("loginMember"));
				if(mem.getM_email().equals("admin")) {
					return "admin/adminMain";
				}else {
					loginSession.invalidate();
				}
			}catch(Exception e) {
				log.info("admin정보 확인 오류" + e.toString());
			}		
		}
		model.addAttribute("admin", "admin");
		return "member/login";
	}
	
	//관리자 로그아웃
	@RequestMapping("adminlogout.do")
	public String adminLogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		model.addAttribute("admin", "admin");
		return "member/login";
	}
	
	//관리자 로그인 성공하면 관리자 메인 페이지로 이동
	@RequestMapping("adminLogin.do")
	public String adminMainView(Member member, HttpSession loginSession, SessionStatus status, RedirectAttributes redirectAttributes) {
		Member loginMember = memberservice.selectMember(member.getM_email());
		log.info("login정보 : "+ loginMember);
		if(loginMember!=null && this.bcryptPasswordEncoder.matches(member.getM_pw(), loginMember.getM_pw())) {
			loginSession.setAttribute("loginMember", loginMember);
			status.setComplete();
			return "admin/adminMain";
		}else {
			redirectAttributes.addFlashAttribute("admin", "admin");
			redirectAttributes.addFlashAttribute("adminFail","잘못된 비밀번호입니다. 다시 확인해주세요");
			return "redirect:admin";
		}
	}
	
	//회원 관리 페이지 이동
	@RequestMapping("mlist.do")
	public ModelAndView memberListViewMethod(@RequestParam(name="page", required=false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;  
		int listCount = service.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		log.info("확인"+ listCount+", " + paging.toString());
		//페이징 계산 처리 끝 ---------------------------------------
		ArrayList<Member> list = service.selectList(paging);
		log.info("확인2"+ list.toString());
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			mv.setViewName("admin/managerment");
		}else {
			mv.addObject("message", currentPage + " 회원 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//admin 회원관리(회원닉네임 검색)
	@RequestMapping("msearchId.do")
	public ModelAndView userIDMethod(@RequestParam("keyword") String keyword, @RequestParam(name="page", required=false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = service.userIDSearchCount(keyword);
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Member> list = service.userIDSearch(searchpaging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			mv.addObject("action", "userid");
			mv.setViewName("admin/managerment");
		}else {
			mv.addObject("message", 
					currentPage + " 회원 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//영화 제작비 추가 페이지
	@RequestMapping("movieCost.do")
	public ModelAndView movieCost(@RequestParam(name="page", required=false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;  
		int listCount = movieservice.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		//페이징 계산 처리 끝 ---------------------------------------
		ArrayList<Movie> list = movieservice.selectList(paging);
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			mv.setViewName("admin/moviecost");
		}else {
			mv.addObject("message", currentPage + " 영화 제작비 호출 오류.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//영화 제작비 추가 페이지(영화 제목 검색)
	@RequestMapping("moviesearchName.do")
	public ModelAndView movieSearchMethod(@RequestParam("keyword") String keyword, @RequestParam(name="page", required=false) String page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		int limit = 10;
		int listCount = movieservice.selectSearchListCount(keyword);
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage%10==0)? currentPage-9 :  (currentPage / 10) * 10 + 1 ;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		//페이징 계산 처리 끝 ---------------------------------------
		SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
		
		ArrayList<Movie> list = movieservice.selectSearchList(searchpaging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("listCount", listCount);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("limit", limit);
			mv.addObject("action", "userid");
			mv.setViewName("admin/moviecost");
		}else {
			mv.addObject("message", 
					currentPage + " 회원 목록 조회 실패.");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//영화 제작비 입력 ajax
	@RequestMapping(value="changeCost.do", method=RequestMethod.POST)
	public ResponseEntity<String> cost(@RequestBody String param){
		try {
			JSONParser jparser = new JSONParser();
			JSONObject cost = (JSONObject)jparser.parse(param);
			
			Movie movie = new Movie();
			Number id = (Number) cost.get("id");
			int intValue = id.intValue();
			movie.setId(intValue);
			movie.setCost((String)cost.get("costInput"));
			int result = service.updateCost(movie);
			if(result > 0)
				return new ResponseEntity<String>("success", HttpStatus.OK);
			else
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
		}catch(Exception e) {
			log.info("제작비 수정 오류 발생 : " + e.toString());
		}
		return null;
	}
		
	
	//로그인 제한/가능 변경 처리용
	@RequestMapping(value="loginok.do", method=RequestMethod.POST)
	public ResponseEntity<String> changeLoginOKMethod(@RequestBody String param)  {
		try {
			JSONParser jparser = new JSONParser();
			JSONObject json = (JSONObject)jparser.parse(param);
			Member member =new Member();
			member.setM_nickname((String)json.get("m_nickname"));
			member.setM_email((String)json.get("m_email"));
			member.setSocal_id((String)json.get("socal_id"));
			member.setLogin_ok((String)json.get("login_ok"));
			log.info("내용 : " + member);
			if(service.updateLoginok(member) > 0) {
				return new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}catch(Exception e) {
			log.info(e.toString());
		}
		return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
	}
}
