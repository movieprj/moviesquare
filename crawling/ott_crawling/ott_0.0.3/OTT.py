'''
작성자     : lyr
작성일     : 2022.09.02
Version   : 0.0.3
진행 사항   : 네이버 검색 엔진에서 대표적인 * OTT 주간 순위 * 크롤링 작업 파일입니다.
            (1)넷플릭스, (2)왓챠, (3)티빙, (4)웨이브
'''

import time, sys, os
from selenium import webdriver as wd
from selenium.webdriver.common.by import By


class ott_crawling:

    def __init__(self):  # 4개의 ott 사이트 url 리스트와 영화 주간 순위 10위를 정리한 리스트를 초기화 작업하기 위한 내용

        # url 기본 포맷 상태 : https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='ott 사이트 이름 주간 순위'

        self.__ott_url = [
            'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%EB%84%B7%ED%94%8C%EB%A6%AD%EC%8A%A4+%EC%A3%BC%EA%B0%84+%EC%88%9C%EC%9C%84',
            'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%EC%99%93%EC%B1%A0+%EC%A3%BC%EA%B0%84+%EC%88%9C%EC%9C%84',
            'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%ED%8B%B0%EB%B9%99',
            'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%EC%9B%A8%EC%9D%B4%EB%B8%8C']

        self.__ott_netflix = []
        self.__ott_watcha = []
        self.__ott_tving = []
        self.__ott_wavve = []

        self.__page_index = 0

    def init_page(self):  # exe 파일 만드는 과정에서 에러 사항에 관한 예외 처리를 하기 위한 내용
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            chromedriver_path = os.path.join(sys._MEIPASS, 'chromedriver.exe')
            self.driver = wd.Chrome(chromedriver_path)
        else:
            self.driver = wd.Chrome(executable_path='chromedriver.exe')
        self.page_move()

    def page_move(self):  # ott 중 티빙과 웨이브는 검색했을 때, 바로 영화 주간 순위가 표출되지 않는 이슈로 인해
        # 전체 목록을 클릭 후에 영화 목록을 클릭하여 크롤링을 진행하는 순서로 진행됩니다.

        self.driver.get(self.__ott_url[self.__page_index])
        time.sleep(5)

        if self.__page_index == 2:
            self.driver.find_element(By.XPATH,
                                     '//*[@id="main_pack"]/section[2]/div[2]/div/div/div[1]/div/div/ul/li[1]/a').click()
            time.sleep(5)
            self.driver.find_element(By.XPATH,
                                     '//*[@id="main_pack"]/section[2]/div[2]/div/div/div[1]/div/div/ul/li[1]/div/div/div/div/div/ul/li[2]/a').click()
            time.sleep(5)
        if self.__page_index == 3:
            self.driver.find_element(By.XPATH,
                                     '//*[@id="main_pack"]/section[1]/div[2]/div/div/div[1]/div/div/ul/li[1]/a').click()
            time.sleep(5)
            self.driver.find_element(By.XPATH,
                                     '//*[@id="main_pack"]/section[1]/div[2]/div/div/div[1]/div/div/ul/li[1]/div/div/div/div/div/ul/li[2]/a').click()
            time.sleep(5)

        self.crawling()

    def crawling(self):  # ott 주간 순위를 확인했을 때 한 페이지에 10개 순위가 모두 나오지 않아서,
        # 2번 페이지 이동 루틴을 추가했습니다.
        print("크롤링 시작", self.__page_index)
        num = self.__page_index
        for i in range(1, 9):
            path = '//*[@id="mflick"]/div/div/ul[1]/li[{}]/strong/a'.format(i)

            if num == 0:
                self.__ott_netflix.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 1:
                self.__ott_watcha.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 2:
                self.__ott_tving.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 3:
                self.__ott_wavve.append(self.driver.find_element(By.XPATH, path).text)

        print("2번 페이지 이동 ...")
        if num == 2:  # 티빙만 2번 페이지 넘어가는 section 배열이 달라서 분리 진행
            self.driver.find_element(By.XPATH, '//*[@id="main_pack"]/section[2]/div[2]/div/div/div[3]/div/a[2]').click()
        else:
            self.driver.find_element(By.XPATH, '//*[@id="main_pack"]/section[1]/div[2]/div/div/div[3]/div/a[2]').click()

        time.sleep(5)
        for i in range(1, 3):
            path = '//*[@id="mflick"]/div/div/ul[2]/li[{}]/strong/a'.format(i)

            if num == 0:
                self.__ott_netflix.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 1:
                self.__ott_watcha.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 2:
                self.__ott_tving.append(self.driver.find_element(By.XPATH, path).text)
            elif num == 3:
                self.__ott_wavve.append(self.driver.find_element(By.XPATH, path).text)

        '''
        page_index : 0 = netflix
                     1 = watcha
                     2 = tving
                     3 = wavve            
        '''

        self.__page_index += 1

        if self.__page_index > 3:
            return

        self.page_move()

    def print_list(self):  # ott 주간 순위 10위를 확인할 수 있는 출력문입니다.
        print("---------------------넷플---------------------")
        for i in self.__ott_netflix:
            print(i)
        print("---------------------왓챠---------------------")
        for i in self.__ott_watcha:
            print(i)
        print("---------------------티빙---------------------")
        for i in self.__ott_tving:
            print(i)
        print("---------------------웨이브---------------------")
        for i in self.__ott_wavve:
            print(i)

