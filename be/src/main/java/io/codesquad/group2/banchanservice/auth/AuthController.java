package io.codesquad.group2.banchanservice.auth;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.websocket.server.PathParam;

@RestController
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

//    @GetMapping("/login")
//    public void login(HttpServletResponse response) {

//       String githubAuthTokenUri = authService.createGithubAuthTokenUri();
//       response.setHeader("Location", githubAuthTokenUri);

//       return new ResponseEntity(HttpStatus.SEE_OTHER);
//    }

    @GetMapping("/auth/githublogin")
    public ResponseEntity<String> login(@PathParam("code") String code) {
        String githubAuthorizationToken = authService.getAccessToken(code);

        return new ResponseEntity(authService.getUserInformationFromToken(githubAuthorizationToken), HttpStatus.OK);
    }
}
