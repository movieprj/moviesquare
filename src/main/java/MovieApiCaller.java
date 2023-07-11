import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

public class MovieApiCaller {
    private static final String API_URL = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp";
    private static final String API_KEY = "SP37J119Y3PU5269K86I";

    public static void main(String[] args) {
        HttpClient httpClient = HttpClient.newHttpClient();

        List<CompletableFuture<String>> futures = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            String movieSeq = String.format("%05d", i);
            System.out.println(API_URL + "?collection=kmdb_new2&detail=Y&movieId=K&movieSeq=" + movieSeq + "&ServiceKey=" + API_KEY);
            URI uri = URI.create(API_URL + "?collection=kmdb_new2&detail=Y&movieId=K&movieSeq=" + movieSeq + "&ServiceKey=" + API_KEY);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .build();
            CompletableFuture<String> future = httpClient.sendAsync(request, HttpResponse.BodyHandlers.ofString())
                    .thenApply(HttpResponse::body)
                    .exceptionally(e -> null);
            futures.add(future);
        }

        CompletableFuture<Void> allFutures = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));
        allFutures.join();

        List<String> results = new ArrayList<>();
        for (CompletableFuture<String> future : futures) {
            String result = future.join();
            if (result != null) {
                results.add(result);
            }
        }

        System.out.println(results);
    }
}