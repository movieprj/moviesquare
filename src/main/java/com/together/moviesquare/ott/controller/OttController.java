package com.together.moviesquare.ott.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.together.moviesquare.ott.service.OttService;
import com.together.moviesquare.ott.vo.Ott;

@Controller
public class OttController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private OttService ottService;
	
	public Logger log;
	
	
	@RequestMapping(value = "/ottBoardList.do", method = RequestMethod.GET)
    public ModelAndView ottBoardList() throws Exception {
        List<Ott> ottList = ottService.selectAll();
        ModelAndView mv = new ModelAndView("ottBoardListView");
        mv.addObject("ottList", ottList);
        mv.setViewName("ott/ottBoardList");
        // 조회 실패한 것에 대한 error 추가 필요
        return mv;
    }
}
