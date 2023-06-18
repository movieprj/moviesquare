package com.together.moviesquare.boxoffice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import lombok.extern.java.Log;

@Log
@Controller
public class BoxOfficeController {
	KobisOpenAPIRestService service = new KobisOpenAPIRestService("343599b683251114d746f16b8725dbc0");
	@RequestMapping("movierank.do")
	public String movierankView() {
		try {
			ObjectMapper mapper = new ObjectMapper();
			
			//지역코드 가져오기
			String codeSet = service.getComCodeList(true,"0105000000");
			HashMap<String,Object> codeResult = mapper.readValue(codeSet, HashMap.class);
			
			Iterator<String> keys = codeResult.keySet().iterator();
			while( keys.hasNext() ){
				String strKey = keys.next();
				List<String> strValue = (ArrayList<String>)codeResult.get(strKey);
				log.info("지역코드내용 : " + strValue.get(0));
			}
			String test = service.getDailyBoxOffice(true, "20230617","","","K","0105001");
			HashMap<String, Object> dailyResult = mapper.readValue(test,HashMap.class);
			dailyResult = mapper.readValue(test,HashMap.class);
			keys = dailyResult.keySet().iterator();
			while( keys.hasNext() ){
				String strKey = keys.next();
				Object strValue = dailyResult.get(strKey);
				log.info("내용 : " + strValue.toString());
			}
		}catch(Exception e) {
			log.info("오류 : " + e.toString());
		}
		
		return "boxOffice/boxofficeAPI";
	}
}
