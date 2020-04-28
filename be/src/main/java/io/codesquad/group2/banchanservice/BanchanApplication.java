package io.codesquad.group2.banchanservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class BanchanApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(BanchanApplication.class, args);
	}

}
