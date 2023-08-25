package com.together.moviesquare.common.scheduler;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
import com.together.moviesquare.movie.service.MovieService;
import com.together.moviesquare.movie.vo.MovieResult;

import lombok.extern.java.Log;


@Log
@Component
public class MovieUpdateScheduler {
	private static final int NUM_THREADS = 6;
	private static final String API_URL = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
	private static final String API_KEY = "SP37J119Y3PU5269K86I";

	@Autowired
	private MovieService movieService;

	//@Scheduled(cron = "0 */5 * * * ?")
	public void movieInfoUpdate() throws InterruptedException, ExecutionException {
		log.info("업데이트 시작!");
		// ExecutorService 생성
		Gson gson = new Gson();
		ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);
		List<List<MovieResult>> listmList = new ArrayList<List<MovieResult>>();
		
		// Callable 리스트 생성
		int currentYear = Year.now().getValue();
		
		for (int year = 1919; year <= currentYear; year++) {
			log.info(year+"년 시작");
			List<MovieResult> mList = new ArrayList<MovieResult>();
			List<Callable<String>> callables = new ArrayList<>();
			//int startCount = 0;
			
				JsonElement count = null;
				for(int startCount=0; startCount<3000; startCount+=500) {
					callables.add(new ApiCallable(
							"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K&createDts="
									+ year + "&createDte=" + year
									+ "&ServiceKey=SP37J119Y3PU5269K86I&listCount=500&startCount=" + startCount));
				}
				// API 호출 실행
				List<Future<String>> futures = executor.invokeAll(callables);

				// 결과 출력
				for (Future<String> future : futures) {
					// System.out.println(future.get());
					try {
						JsonReader reader = new JsonReader(new StringReader(future.get()));
						reader.setLenient(true);
						JsonObject result = (JsonObject) JsonParser.parseReader(reader);
						count = result.getAsJsonArray("Data").get(0).getAsJsonObject().get("Count");
						JsonArray result2 = result.getAsJsonArray("Data").get(0).getAsJsonObject()
								.getAsJsonArray("Result");
						for (int j = 0; j < count.getAsInt(); j++) {
							JsonObject re = (JsonObject) result2.get(j);
							MovieResult movieResult = gson.fromJson(re, MovieResult.class);
							mList.add(movieResult);
						}
						
					} catch (NullPointerException e) {
						log.info(future.get());
						log.info("비어있네 삭제된듯?");
					}
				}
				listmList.add(mList);
				// ExecutorService 종료

				log.info(year+"년 종료");

			
		} // for문끝
		executor.shutdown();
		log.info(listmList.size() + "merge문 호출 횟수.");
		int sum=0;
		for(List<MovieResult> mList : listmList) {
			int f = mList.size();
			if(f == 0) {
				log.info("이건좀 아닌듯? 0사이즈 발견 1초간 휴식 ㄱ");
				Thread.sleep(1000);
				continue;
			}
			
			for (MovieResult m : mList) {
				m.setTitle(m.getTitle().trim()); 
				m.setActorsNm(m.getActors().setActorsNm());
				m.setStaffsNm(m.getStaffs().setStaffsNm());
				m.setDistributor(m.getStaffs().setDistributor());
				m.setDirectorsNm(m.getDirectors().setDirectorsNm());
			}
			log.info("movie 업데이트 또는 삽입할 사이즈" + f);
			
			movieService.mergeIntoMovieList(mList);
			sum += f;
		}
		log.info("총"+sum +"개의 movie 정보");
		log.info("merge가 성공적으로 종료.");

		
	}
	
	//시간 설정필요 되긴하는데 좀느림
	//@Scheduled(cron = "0 */2 * * * ?")
	@Scheduled(cron = "0 */10 * * * *") // 10분
	public void movieInfoUpdate44() throws InterruptedException, ExecutionException {
		log.info("업데이트 시작!");

		String response = urlCall(
				"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K"
						+ "&ServiceKey=SP37J119Y3PU5269K86I");
		JsonObject jsonTotalCount = JsonParser.parseString(response).getAsJsonObject();
		int totalCount = jsonTotalCount.get("TotalCount").getAsInt();

		// ExecutorService 생성
		Gson gson = new Gson();
		ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);
		List<List<MovieResult>> listmList = new ArrayList<List<MovieResult>>();

		// Callable 리스트 생성
		int currentYear = Year.now().getValue();

		List<String> apiList = new ArrayList<>();
		for (int startCount = 0; startCount < totalCount; startCount += 500) {
			apiList.add(
					"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K&ServiceKey=SP37J119Y3PU5269K86I&listCount=500&startCount="
							+ startCount);
		}
		log.info(apiList.size() + ": api 콜할 개수 6개씩함. ");
		// 6개씩 분할하여 실행
		int batchSize = 6;
		for (int i = 0; i < apiList.size(); i += batchSize) {
			log.info("시작");
			List<String> batch = apiList.subList(i, Math.min(i + batchSize, apiList.size()));
			List<MovieResult> mList = new ArrayList<MovieResult>();
			List<Callable<String>> callables = new ArrayList<>();
			// int startCount = 0;
			for (String api : batch) {
				callables.add(new ApiCallable(api));
			}
			JsonElement count = null;

			// API 호출 실행
			List<Future<String>> futures = executor.invokeAll(callables);

			// 결과 출력
			for (Future<String> future : futures) {
				// System.out.println(future.get());
				try {
					JsonReader reader = new JsonReader(new StringReader(future.get()));
					reader.setLenient(true);
					JsonObject result = (JsonObject) JsonParser.parseReader(reader);
					count = result.getAsJsonArray("Data").get(0).getAsJsonObject().get("Count");
					JsonArray result2 = result.getAsJsonArray("Data").get(0).getAsJsonObject().getAsJsonArray("Result");
					for (int j = 0; j < count.getAsInt(); j++) {
						JsonObject re = (JsonObject) result2.get(j);
						MovieResult movieResult = gson.fromJson(re, MovieResult.class);
						mList.add(movieResult);
					}

				} catch (NullPointerException e) {
					log.info(future.get());
					log.info("비어있네 삭제된듯?");
				}
			}
			listmList.add(mList);
			// ExecutorService 종료

			log.info("6번 종료?");

		} // for문끝
		executor.shutdown();
		log.info(listmList.size() + "merge문 호출 횟수.");
		int sum = 0;
		for (List<MovieResult> mList : listmList) {
			int f = mList.size();
			if (f == 0) {
				log.info("이건좀 아닌듯? 0사이즈 발견 1초간 휴식 ㄱ");
				Thread.sleep(1000);
				continue;
			}

			for (MovieResult m : mList) {
				m.setTitle(m.getTitle().trim());
				m.setActorsNm(m.getActors().setActorsNm());
				m.setStaffsNm(m.getStaffs().setStaffsNm());
				m.setDistributor(m.getStaffs().setDistributor());
				m.setDirectorsNm(m.getDirectors().setDirectorsNm());
			}
			log.info("movie 업데이트 또는 삽입할 사이즈" + f);

			movieService.mergeIntoMovieList(mList);
			sum += f;
		}
		log.info("총" + sum + "개의 movie 정보");
		log.info("merge가 성공적으로 종료.");

	}
	private static class ApiCallable implements Callable<String> {
		private final String apiUrl;

		public ApiCallable(String apiUrl) {
			this.apiUrl = apiUrl;
		}

		@Override
		public String call() throws Exception {
			// API 호출 코드 작성
			URI uri = new URI(apiUrl);
			URL url = uri.toURL();

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type", "application/json");

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}

			in.close();

			// API 호출 결과 반환
			return response.toString();
		}
	}
	
	public String urlCall(String apiuri) {
        try {
        	URI uri = new URI(apiuri);
            URL url = uri.toURL();
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Content-Type", "application/json");
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            String inputLine;
            StringBuffer content = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            con.disconnect();
            return content.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
		return null;
	}
	
	//@Scheduled(cron = "0 */7 * * * ?")
	//@Scheduled(fixedRate = 0, initialDelay = 0)
	public void movieInfoUpdate2() {
		log.info("업데이트 시작!");
		// ExecutorService 생성
		Gson gson = new Gson();

		
		// Callable 리스트 생성
		int currentYear = Year.now().getValue();
		
		for (int year = 1919; year <= currentYear; year++) {
			List<MovieResult> mList = new ArrayList<MovieResult>();
			int startCount = 0;
			while (true) {
				JsonElement count = null;
				String response = urlCall(
						"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K&createDts="
								+ year + "&createDte=" + year
								+ "&ServiceKey=SP37J119Y3PU5269K86I&listCount=500&startCount=" + startCount);

				if(response == null) {
					log.info("에러발생");
				}
				
				// 결과 출력
					try {
						JsonReader reader = new JsonReader(new StringReader(response));
						reader.setLenient(true);
						JsonObject result = (JsonObject) JsonParser.parseReader(reader);
						count = result.getAsJsonArray("Data").get(0).getAsJsonObject().get("Count");
						JsonArray result2 = result.getAsJsonArray("Data").get(0).getAsJsonObject()
								.getAsJsonArray("Result");
						for (int j = 0; j < count.getAsInt(); j++) {
							JsonObject re = (JsonObject) result2.get(j);
							MovieResult movieResult = gson.fromJson(re, MovieResult.class);
							mList.add(movieResult);
						}
					} catch (NullPointerException e) {
						System.out.println(response);
						System.out.println("비어있네 삭제된듯?");
					}

				
				if (count.getAsInt() != 500) {
					System.out.println(year+"년도  완료.");
					break;
				}
				startCount += 500;

				// ExecutorService 종료

			}
			if(mList== null || mList.size() <1)
				continue;
			
			for (MovieResult m : mList) {
				m.setTitle(m.getTitle().trim()); 
				m.setActorsNm(m.getActors().setActorsNm());
				m.setStaffsNm(m.getStaffs().setStaffsNm());
				m.setDistributor(m.getStaffs().setDistributor());
				m.setDirectorsNm(m.getDirectors().setDirectorsNm());
			}
			log.info(year + "년도 movie 업데이트 또는 삽입할 사이즈" + mList.size());
			
			movieService.mergeIntoMovieList(mList);
		} // for문끝

	}
	
	
	public void movieInfoUpdate3() throws InterruptedException, ExecutionException {
		log.info("업데이트 시작!");
		// ExecutorService 생성
		Gson gson = new Gson();
		ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);
		List<List<MovieResult>> listmList = new ArrayList<List<MovieResult>>();
		
		// Callable 리스트 생성
		int currentYear = Year.now().getValue();
		
		for (int year = 1919; year <= currentYear; year++) {
			List<MovieResult> mList = new ArrayList<MovieResult>();
			List<Callable<String>> callables = new ArrayList<>();
			//int startCount = 0;
			log.info(year+"년 시작");
				JsonElement count = null;
				for(int startCount=0; startCount<3000; startCount+=500) {
					callables.add(new ApiCallable(
							"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K&createDts="
									+ year + "&createDte=" + year
									+ "&ServiceKey=SP37J119Y3PU5269K86I&listCount=500&startCount=" + startCount));
				}
				// API 호출 실행
				List<Future<String>> futures = executor.invokeAll(callables);

				// 결과 출력
				for (Future<String> future : futures) {
					// System.out.println(future.get());

					try {
						JsonReader reader = new JsonReader(new StringReader(future.get()));
						reader.setLenient(true);
						JsonObject result = (JsonObject) JsonParser.parseReader(reader);
						count = result.getAsJsonArray("Data").get(0).getAsJsonObject().get("Count");
						JsonArray result2 = result.getAsJsonArray("Data").get(0).getAsJsonObject()
								.getAsJsonArray("Result");
						for (int j = 0; j < count.getAsInt(); j++) {
							JsonObject re = (JsonObject) result2.get(j);
							MovieResult movieResult = gson.fromJson(re, MovieResult.class);
							mList.add(movieResult);
							listmList.add(mList);

						}
					} catch (NullPointerException e) {
						System.out.println(future.get());
						System.out.println("비어있네 삭제된듯?");

					}

				}
				log.info(year+"년 종료");
		} // for문끝
		executor.shutdown();
		
		
			for (List<MovieResult> mList : listmList) {
				for (MovieResult m : mList) { 
				m.setTitle(m.getTitle().trim()); 
				m.setActorsNm(m.getActors().setActorsNm());
				m.setStaffsNm(m.getStaffs().setStaffsNm());
				m.setDistributor(m.getStaffs().setDistributor());
				m.setDirectorsNm(m.getDirectors().setDirectorsNm());
				}
				log.info("업데이트 또는 삽입할 사이즈" + mList.size());
				movieService.mergeIntoMovieList(mList);
			}

	}
}
