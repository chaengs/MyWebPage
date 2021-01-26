package test.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;

// web.xml 필터 설정 대신에 annotation 을 활용해서 필터를 동작하게 할수도 있다.
@WebFilter(urlPatterns = {"/users/private/*","/cafe/private/*","/file/private/*"})
public class LoginFilter implements Filter {
    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //부모 type을 자식 type으로 casting
        HttpServletRequest req = (HttpServletRequest)servletRequest;
        //자식 type을 이용해서 HttpSession 참조값 얻기
        HttpSession session = req.getSession();
        //로그인된 아이디 있는지 읽기
        String id = (String)session.getAttribute("id");

        //로그인 상태면
        if(id != null){
            //요청 이어가기
            filterChain.doFilter(servletRequest, servletResponse);
        }else{
            //가려던 url 읽기
            String url = req.getRequestURI();
            //GET 방식 전송 파라미터를 query 문자열로 읽어오기 ( a=xxx&b=xxx&c=xxx )
            String query = req.getQueryString();
            //특수문자 인코딩
            String encodedUrl = null;
            if(query == null){//전송 파라미터가 없다면
                encodedUrl = URLEncoder.encode(url);
            }else{
                encodedUrl = URLEncoder.encode(url + "?" + query);
            }

            //로그인 상태가 아니면 로그인 폼으로 리다일렉트
            String cPath = req.getContextPath();
            HttpServletResponse res = (HttpServletResponse)servletResponse;
            res.sendRedirect(cPath + "/users/loginform.jsp?url=" + encodedUrl);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
}
