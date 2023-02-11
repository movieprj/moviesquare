import time, sys, os
from selenium import webdriver as wd
from selenium.webdriver.common.by import By


class daysInfo_crawling:                                #kobis에서 일별 데이터 크롤링
    def __init__(self):
        self.__url = 'https://www.kobis.or.kr/kobis/business/stat/boxs/findDailyBoxOfficeList.do'
        self.__box_office = {}
        self.__movie_name = []

    def init_page(self):  
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            chromedriver_path = os.path.join(sys._MEIPASS, 'chromedriver.exe')
            self.driver = wd.Chrome(chromedriver_path)
        else:
            self.driver = wd.Chrome(executable_path='chromedriver.exe')
        self.page_move()

    def page_move(self):
        self.driver.get(self.__url)
        time.sleep(3)
        print()
        while self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)> #btn_0").text == "더보기":
            self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)").click()
            time.sleep(1)
        count = self.driver.find_elements(By.CSS_SELECTOR, "#tbody_0> tr")
        for j in range(1,len(count)+1):
            self.__data = []
            self.__movie_name=self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td.tal").text
            for i in range(1, 13):
                self.__data.append(self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td:nth-child("+str(i)+")").text)
            self.__box_office[self.__movie_name] = self.__data;
        print(self.__box_office)
        self.driver.close()

class weeklyInfo_crawling:                              #kobis에서 주간별 데이터 크롤링
    def __init__(self):
        self.__url = 'https://www.kobis.or.kr/kobis/business/stat/boxs/findWeeklyBoxOfficeList.do'
        self.__box_office = {}
        self.__movie_name = []

    def init_page(self):
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            chromedriver_path = os.path.join(sys._MEIPASS, 'chromedriver.exe')
            self.driver = wd.Chrome(chromedriver_path)
        else:
            self.driver = wd.Chrome(executable_path='chromedriver.exe')
        self.page_move()

    def page_move(self):
        self.driver.get(self.__url)
        time.sleep(3)
        print()
        while self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)> #btn_0").text == "더보기":
            self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)").click()
            time.sleep(1)
        count = self.driver.find_elements(By.CSS_SELECTOR, "#tbody_0> tr")
        for j in range(1,len(count)+1):
            self.__data = []
            self.__movie_name=self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td.tal").text
            for i in range(1, 13):
                self.__data.append(self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td:nth-child("+str(i)+")").text)
            self.__box_office[self.__movie_name] = self.__data;
        print(self.__box_office)
        self.driver.close()

class monthlyInfo_crawling:                                  #kobis에서 월별 데이터 크롤링
    def __init__(self):
        self.__url = 'https://www.kobis.or.kr/kobis/business/stat/boxs/findMonthlyBoxOfficeList.do'
        self.__box_office = {}
        self.__movie_name = []

    def init_page(self):
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            chromedriver_path = os.path.join(sys._MEIPASS, 'chromedriver.exe')
            self.driver = wd.Chrome(chromedriver_path)
        else:
            self.driver = wd.Chrome(executable_path='chromedriver.exe')
        self.page_move()

    def page_move(self):
        self.driver.get(self.__url)
        time.sleep(3)
        print()
        while self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)> #btn_0").text == "더보기":
            self.driver.find_element(By.CSS_SELECTOR, "#content > div.rst_sch > div:nth-child(4)").click()
            time.sleep(1)
        count = self.driver.find_elements(By.CSS_SELECTOR, "#tbody_0> tr")
        for j in range(1,len(count)+1):
            self.__data = []
            self.__movie_name=self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td.tal").text
            for i in range(1, 10):
                self.__data.append(self.driver.find_element(By.CSS_SELECTOR, "#tbody_0 > tr:nth-child("+str(j)+") > td:nth-child("+str(i)+")").text)
            self.__box_office[self.__movie_name] = self.__data;
        print(self.__box_office)
        self.driver.close()
