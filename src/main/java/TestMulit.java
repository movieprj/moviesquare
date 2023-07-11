import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
import com.together.moviesquare.movie.vo.MovieResult;

public class TestMulit {
	private static final int NUM_THREADS = 1;
	private static final String API_URL = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
	private static final String API_KEY = "SP37J119Y3PU5269K86I";

	public static void main(String[] args) throws InterruptedException, ExecutionException {
		// ExecutorService 생성
		Gson gson = new Gson();
		ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);
		List<MovieResult> mList = new ArrayList<MovieResult>();
		// Callable 리스트 생성

		
		for (int year = 1919; year <= 1920; year++) {
			List<Callable<String>> callables = new ArrayList<>();
			int startCount = 0;
			while (true) {
				JsonElement count = null;
				callables.add(new ApiCallable(
						"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&movieId=K&createDts="
								+ year + "&createDte=" + year
								+ "&ServiceKey=SP37J119Y3PU5269K86I&listCount=500&startCount=" + startCount));

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
							// JsonObject re =
							// result.getAsJsonArray("Data").get(0).getAsJsonObject().getAsJsonArray("Result").get(0).getAsJsonObject();
							MovieResult movieResult = gson.fromJson(re, MovieResult.class);
							mList.add(movieResult);
							//System.out.println(movieResult.toString());
						}
					} catch (NullPointerException e) {
						System.out.println(future.get());
						System.out.println("비어있네 삭제된듯?");

					}



				}
				if (count.getAsInt() != 500) {
					System.out.println("끗.");
					break;
				}
				startCount += 500;

				
				// ExecutorService 종료
				
			}
			

		}
		executor.shutdown();
		
		for (MovieResult m: mList) {
			System.out.println(m.toString());
			m.getActors().setActorsNm();
			m.getStaffs().setStaffsNm();
			m.getStaffs().setDistributor();
			m.getDirectors().setDirectorsNm();
			System.out.println(m.toString());
		}
		
//		Set<String> movieSeqSet = new HashSet<>();
//		for (MovieResult movie : mList) {
//		    movieSeqSet.add(movie.getMovieSeq());
//		}
//
//		List<String> movieSeqList = new ArrayList<>(movieSeqSet);
//		Collections.sort(movieSeqList);
//
//		try (PrintWriter writer = new PrintWriter("movieSeq.txt")) {
//		    for (String movieSeq : movieSeqList) {
//		        writer.println(movieSeq);
//		    }
//		} catch (FileNotFoundException e) {
//		    e.printStackTrace();
//		}
//	
//
//		Map<String, Integer> movieSeqMap = new HashMap<>();
//		for (MovieResult movie : mList) {
//		    String movieSeq = movie.getMovieSeq();
//		    if (movieSeqMap.containsKey(movieSeq)) {
//		        movieSeqMap.put(movieSeq, movieSeqMap.get(movieSeq) + 1);
//		    } else {
//		        movieSeqMap.put(movieSeq, 1);
//		    }
//		}
//
//		try (PrintWriter writer = new PrintWriter("movieSeq2.txt")) {
//			for (Map.Entry<String, Integer> entry : movieSeqMap.entrySet()) {
//				writer.println("movieSeq " + entry.getKey() + "는 " + entry.getValue() + "번 중복됩니다.");
//			}
//		} catch (FileNotFoundException e) {
//		    e.printStackTrace();
//		}
		

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
}
