package com.together.moviesquare.boxoffice.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import lombok.extern.java.Log;

@Log
@Controller
public class BoxOfficeController {
    KobisOpenAPIRestService service = new KobisOpenAPIRestService("343599b683251114d746f16b8725dbc0");

    @RequestMapping("movierankDays.do")
    public String movierankDaysView() {
        try {
            ObjectMapper mapper = new ObjectMapper();

            // 지역코드 가져오기
            String codeSet = service.getComCodeList(true, "0105000000");
            HashMap<String, List<String>> codeResult = mapper.readValue(codeSet, new TypeReference<HashMap<String, List<String>>>() {});

            Iterator<String> keys = codeResult.keySet().iterator();
            while (keys.hasNext()) {
                String strKey = keys.next();
                List<String> strValue = codeResult.get(strKey);
                log.info("지역코드내용 : " + strValue.get(0));
            }

            String test = service.getDailyBoxOffice(true, "20230617", "", "", "K", "");
            // key(문자열 필수), 
            // targetDt(문자열 필수), - yyyymmdd 형식
            // itemPerPage(문자열, default), - default: "10", 최대: "10"
            // multiMovieYn(문자열, default), - 다양성 영화/상업영화
            // repNationCd(문자열, K) - 한국영화
            // WideAreaCd(문자열, default) - 지역코드
            
            HashMap<String, Object> dailyResult = mapper.readValue(test, new TypeReference<HashMap<String, Object>>() {});
            keys = dailyResult.keySet().iterator();
            while (keys.hasNext()) {
                String strKey = keys.next();
                Object strValue = dailyResult.get(strKey);
                log.info("내용 : " + strValue.toString());
            }
        } catch (Exception e) {
            log.info("오류 : " + e.toString());
        }

		return "boxOffice/boxofficeAPIDays";
    }
    
    @RequestMapping("movierankWeeks.do")
    public String movierankView() {
        try {
            ObjectMapper mapper = new ObjectMapper();

            // 지역코드 가져오기
            String codeSet = service.getComCodeList(true, "0105000000");
            HashMap<String, List<String>> codeResult = mapper.readValue(codeSet, new TypeReference<HashMap<String, List<String>>>() {});

            Iterator<String> keys = codeResult.keySet().iterator();
            while (keys.hasNext()) {
                String strKey = keys.next();
                List<String> strValue = codeResult.get(strKey);
                log.info("지역코드내용 : " + strValue.get(0));
            }

            String test = service.getDailyBoxOffice(true, "20230617", "", "", "K", "");
            // key(문자열 필수), 
            // targetDt(문자열 필수), - yyyymmdd 형식
            // itemPerPage(문자열, default), - default: "10", 최대: "10"
            // multiMovieYn(문자열, default), - 다양성 영화/상업영화
            // repNationCd(문자열, K) - 한국영화
            // WideAreaCd(문자열, default) - 지역코드
            
            HashMap<String, Object> dailyResult = mapper.readValue(test, new TypeReference<HashMap<String, Object>>() {});
            keys = dailyResult.keySet().iterator();
            while (keys.hasNext()) {
                String strKey = keys.next();
                Object strValue = dailyResult.get(strKey);
                log.info("내용 : " + strValue.toString());
            }
        } catch (Exception e) {
            log.info("오류 : " + e.toString());
        }

        return "boxOffice/boxofficeAPIWeeks";
    }
}
