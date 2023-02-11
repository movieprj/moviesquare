import OTT
import kobis_daysInfo
import kobis_details

if __name__ == '__main__':
    #클래스 객체 생성
    ref = OTT.ott_crawling()
    # ott_crawling 클래스에 있는 method 실행 (init)
    ref.init_page()
    # 4개의 ott 사이트 데이터 리스트 출력문
    ref.print_list()
    
    #연도는 엑셀파일로 저장되므로 크롤링에서 제외함
    daysInfo = kobis_daysInfo.daysInfo_crawling()
    daysInfo.init_page()
    weeklyInfo = kobis_daysInfo.weeklyInfo_crawling()
    weeklyInfo.init_page()
    monthlyInfo = kobis_daysInfo.monthlyInfo_crawling()
    monthlyInfo.init_page()
    
    # 영화 상세 정보 크롤링
    '''
    1. 포스터 , 2. 타이틀, 3. 참여배우, 4. 제작진, 5. 제작사, 6. 배급사,
    7. 포맷, 8. 장르, 9. 러닝타임, 10. 등급, 11. 국적, 12. 개봉일, 13. 촬영회차,
    14. 상영타입, 15. 제작비, 16. 누적관객수(현재현황), 17. 수익현황
    '''
    details = kobis_details.kobis_crawling()
    details.init_page()
    details.print_list()