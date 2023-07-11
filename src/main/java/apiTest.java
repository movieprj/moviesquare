
import org.springframework.web.reactive.function.client.WebClient;

import com.google.gson.Gson;

import reactor.core.publisher.Mono;

public class apiTest {
	private static final String API_KEY = "SP37J119Y3PU5269K86I";

	
    public static void main(String[] args) {
        WebClient webClient = WebClient.create();
        
        
        
        String url = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=N&director=%EB%B0%95%EC%B0%AC%EC%9A%B1&ServiceKey=SP37J119Y3PU5269K86I";

        Mono<String> result = webClient.get()
        	    .uri(url)
        	    .retrieve()
        	    .bodyToMono(String.class);

        	result.subscribe(response -> {
        	    System.out.println(response);
        	}, error -> {
        	    // handle error
        	});
    }

}


