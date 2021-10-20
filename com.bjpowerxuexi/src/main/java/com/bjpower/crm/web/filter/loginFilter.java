package com.bjpower.crm.web.filter;

import com.bjpower.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class loginFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain Chain) throws IOException, ServletException {
        System.out.println("验证用户有没有登录过的过滤器");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession getsession = request.getSession();
        User user = (User) getsession.getAttribute("user");
        String path = request.getServletPath();
        //不应该拦行登录页面和后台访问路径，其他需要拦截，，
        if( "/login.jsp".equals(path) || "/setting/user/save.do".equals(path)){
            Chain.doFilter(req,resp);
        }else{
            if(user != null){
                Chain.doFilter(req,resp);
            }else{
                response.sendRedirect(request.getContextPath()+"/login.jsp");
                System.out.println(request.getContextPath());
            }
        }

    }
}
