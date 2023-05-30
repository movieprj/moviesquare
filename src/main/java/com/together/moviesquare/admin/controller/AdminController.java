package com.together.moviesquare.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.together.moviesquare.admin.service.AdminService;
import com.together.moviesquare.member.vo.Member;

import lombok.extern.java.Log;

@Log
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	@RequestMapping("adminMem.do")
	public String memberManagement(Model model) {
		List<Member> member = service.selAllMember();
		if(member!=null) {
			model.addAttribute("member", member);
			log.info(member.toString());
		}
		return "admin/managerment";
	}
}
