package io.codesquad.group2.banchanservice.auth;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@Service
public class AuthService {

    private final String REQUEST_BASE_URL = "https://github.com/login/oauth/authorize?client_id";

    private final String EXCHANGE_TOKEN_URL = "https://github.com/login/oauth/access_token";

    private final String REQUEST_USER_INFO_URL = "https://api.github.com/user";

    @Value("${CLIENT_ID}")
    private String CLIENT_ID;

    @Value("${CLIENT_SECRET}")
    private String CLIENT_SECRET;

    @Value("${STATE}")
    private String STATE;


//    public String createGithubAuthTokenUri() {
//        return UriComponentsBuilder.fromHttpUrl(REQUEST_BASE_URL)
//                .queryParam("client_id", CLIENT_ID)
//                .queryParam("state", STATE)
//                .build().encode().toString();
//    }

    public String getAccessToken(String code) {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("client_id", CLIENT_ID);
        requestBody.add("client_secret", CLIENT_SECRET);
        requestBody.add("code", code);
//        requestBody.add("state", STATE);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestBody, headers);
        GithubAccessToken githubAccessToken = restTemplate.postForObject(EXCHANGE_TOKEN_URL, request, GithubAccessToken.class);

        return githubAccessToken.getAccessToken();
    }

    public User getUserInformationFromToken(String githubAccessToken) {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(githubAccessToken);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
        ResponseEntity<User> userInformation = restTemplate.exchange(REQUEST_USER_INFO_URL, HttpMethod.GET, request, User.class);

        return userInformation.getBody();
    }
}
