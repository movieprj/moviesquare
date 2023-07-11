import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.MalformedJsonException;
import com.together.moviesquare.movie.vo.MovieResult;

public class TestMulit2 {
    private static final int NUM_THREADS = 1;
    private static final String API_URL = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
    private static final String API_KEY = "SP37J119Y3PU5269K86I";
    
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        // ExecutorService 생성
    	Gson gson = new Gson();
    	ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);

        // Callable 리스트 생성
        for(int j=0;j<40000; j+=1) {
        
        List<Callable<String>> callables = new ArrayList<>();
        for (int i =24000+ j; i <24000+ 1+j; i++) {
        	String movieSeq = String.format("%05d", i);
            callables.add(new ApiCallable(API_URL+"?collection=kmdb_new2&detail=Y&movieId=K&movieSeq="+ movieSeq + "&ServiceKey=" + API_KEY));
        }

        // API 호출 실행
        List<Future<String>> futures = executor.invokeAll(callables);
        
        // 결과 출력
        for (Future<String> future : futures) {
            //System.out.println(future.get());
           
            try {
            	JsonReader reader = new JsonReader(new StringReader(future.get()));
				reader.setLenient(true);
				JsonObject result = (JsonObject) JsonParser.parseReader(reader);
            JsonObject re = result.getAsJsonArray("Data").get(0).getAsJsonObject().getAsJsonArray("Result").get(0).getAsJsonObject();
            MovieResult movieResult = gson.fromJson(re , MovieResult.class);
            System.out.println(movieResult.toString());
            }
            catch (NullPointerException e) {
            	System.out.println(future.get());
				System.out.println("비어있네 삭제된듯?");
            }

        }
        System.out.println(j+"번끗.");
        // ExecutorService 종료
        
        }
        executor.shutdown();
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
