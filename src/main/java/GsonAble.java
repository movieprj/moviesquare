import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.together.moviesquare.movie.vo.MovieResult;

public class GsonAble {
    private static final String API_URL = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
    private static final String API_KEY = "SP37J119Y3PU5269K86I";
    private static final int THROTTLE_LIMIT = 200;
    
    public static void main(String[] args) throws UnsupportedEncodingException {
    	Gson gson = new Gson();
        System.setOut(new PrintStream(System.out, true, "UTF-8"));
        HttpClient httpClient = HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build();

        List<CompletableFuture<JsonObject>> futures = new ArrayList<>();
        for (int i = 33000; i <= 33010; i++) {
            String movieSeq = String.format("%05d", i);
            URI uri = URI.create(API_URL + "?collection=kmdb_new2&detail=Y&movieId=K&movieSeq=" + movieSeq + "&ServiceKey=" + API_KEY);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .build();
            CompletableFuture<JsonObject> future = httpClient.sendAsync(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8))
                    .thenApply(HttpResponse::body)
                    .thenApply(jsonString -> {
                        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);
                        return jsonObject;
                    })
                    .exceptionally(e -> null);
            futures.add(future);
            
         // 쓰로틀링
            if (i % THROTTLE_LIMIT == 0) {
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }

        CompletableFuture<Void> allFutures = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));
        allFutures.join();

        List<JsonObject> results = new ArrayList<>();
        for (CompletableFuture<JsonObject> future : futures) {
            JsonObject result = future.join();
            if (result != null) {
                results.add(result);
                JsonObject re = result.getAsJsonArray("Data").get(0).getAsJsonObject().getAsJsonArray("Result").get(0).getAsJsonObject();
                
                MovieResult movieResult = gson.fromJson(re , MovieResult.class);
                System.out.println(movieResult);
            }
        }

        System.out.println(results);
    }
}