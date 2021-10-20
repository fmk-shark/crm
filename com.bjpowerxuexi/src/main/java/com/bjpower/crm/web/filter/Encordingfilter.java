package com.bjpower.crm.web.filter;

import javax.servlet.*;
import java.io.IOException;

public class Encordingfilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        System.out.println("你已经进入filter过滤器");
        req.setCharacterEncoding("utf-8");
      resp.setContentType("text/html;charset=utf-8");
//      jsp文件自己已经过滤过了所以不用设置
        chain.doFilter(req,resp);
    }
}
