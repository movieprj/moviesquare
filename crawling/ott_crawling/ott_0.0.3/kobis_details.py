import time, sys, os
from selenium import webdriver as wd
from selenium.webdriver.common.by import By

'''
1. 포스터
2. 타이틀
3. 참여배우
4. 제작진(4-1 제작 / 4-2 프로듀서)
5. 제작사
6. 배급사
7. 포맷
8. 장르
9. 러닝타임
10. 등급
11. 국적
12. 개봉일
13. 촬영회차
14. 상영타입

# 관리자에서 수동 입력 가능하게끔 구현 진행 요청.
15. 제작비
16. 누적관객수(현재현황)
17. 수익현황

'''

class kobis_crawling:
    def __init__(self):  # kobis에서 일별 데이터 크롤링
        self.__url = 'https://kobis.or.kr/kobis/business/mast/mvie/searchMovieList.do'
        self.__data = []

    def init_page(self):
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            chromedriver_path = os.path.join(sys._MEIPASS, 'chromedriver.exe')
            self.driver = wd.Chrome(chromedriver_path)
        else:
            self.driver = wd.Chrome(executable_path='chromedriver.exe')
        self.crawling()

    def crawling(self):
        self.driver.get(self.__url)
        time.sleep(2)
        self.driver.find_element(By.XPATH, '/html/body/div[1]/div[2]/div[2]/div[4]/form/div/ul/li[2]/a').click()

        print('-------크롤링 시작(kobis 상세 페이지)-------')
        for i in range(1,11):
            try:
                # 1개 영화 선택
                self.driver.find_element(By.XPATH, '/html/body/div[1]/div[2]/div[2]/div[4]/table/tbody/tr['+str(i)+']/td[1]/span/a').click()
                time.sleep(2)

                # 포스터 이미지 링크 (1. 포스터)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[2]/div/div[1]/div[2]/a/img').get_attribute('src'))

                # 영화 타이틀 제목 (2. 타이틀)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[1]/div[1]/div/strong').text)

                # 제작사 (5. 제작사)
                self.__data.append(self.driver.find_element(By.XPATH,'/html/body/div[3]/div[2]/div/div[1]/div[5]/div/dl/dd[1]/a').text)

                # 배급사 (6. 배급사)
                self.__data.append(self.driver.find_element(By.XPATH,'/html/body/div[3]/div[2]/div/div[1]/div[5]/div/dl/dd[2]/a').text)

                # 요약정보 (7. 포맷 / 8. 장르 / 9. 러닝 타임 / 10. 등급 / 11. 국적)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[2]/div/div[1]/div[2]/dl/dd[4]').text)

                # 개봉일 (12. 개봉일)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[2]/div/div[1]/div[2]/dl/dd[5]').text)

                # 촬영회차 (13. 촬영회차)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[2]/div/div[1]/div[2]/dl/dd[9]').text)

                # 상영타입 (14. 상영타입)
                self.__data.append(self.driver.find_element(By.XPATH, '/html/body/div[3]/div[2]/div/div[1]/div[2]/dl/dd[10]').text)

                # ------------------------ Exception 영역 ------------------------
                # 배우 (3. 참여 배우)
                self.__data.append(self.driver.find_element(By.XPATH,'/html/body/div[3]/div[2]/div/div[1]/div[6]/div/dl/div[2]/dd/table/tbody/tr/td').text)

            except Exception:
                self.__data.append('배우 조회에 실패했습니다.')

            finally:
                try:
                    # 제작진 (4-1. 제작)
                    self.__data.append(self.driver.find_element(By.XPATH,'/html/body/div[3]/div[2]/div/div[1]/div[6]/div/dl/div[4]/dd[2]/table/tbody/tr/td').text)
                except Exception:
                    self.__data.append('제작 조회에 실패했습니다.')
                finally:
                    try:
                        # 제작진 (4-2. 프로듀서)
                        self.__data.append(self.driver.find_element(By.XPATH,'/html/body/div[3]/div[2]/div/div[1]/div[6]/div/dl/div[5]/dd/table/tbody/tr/td').text)
                    except Exception:
                        self.__data.append('프로듀서 조회에 실패했습니다.')
                    finally:
                        # 닫기 버튼
                        self.driver.find_element(By.XPATH, '/html/body/div[3]/div[1]/div[1]/a[2]').click()


    def print_list(self):  # 포스터 디테일 내용
        print("-------포스터 디테일 내용 로그-------")
        for i in self.__data:
            print(i)
