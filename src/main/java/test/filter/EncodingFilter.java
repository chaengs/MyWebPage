package main.java.test.filter;
/*
 * 	[ 요청을 가로채서 중간에 원하는 작업을 할수 있는 필터 만들기 ]
 *
 *  1. javax.servlet.Filter 인터페이스를 구현한다.
 *  2. web.xml 을 만들고 거기에 필터를 정의하고 맵핑한다.
 *  3. doFilter() 메소드 안에서 원하는 작업을 한다.
 */

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter {
    private String encoding;

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("Encoding Filter doFilter() 동작중");

        //인코딩 설정이 안됐다면
        if(servletRequest.getCharacterEncoding() == null){
            servletRequest.setCharacterEncoding(encoding);
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //"encoding"이라는 값으로 저장된 초기화 파라미터 (utf-8) 읽어와서 필드에 저장
        encoding = filterConfig.getInitParameter("encoding");
    }
}
