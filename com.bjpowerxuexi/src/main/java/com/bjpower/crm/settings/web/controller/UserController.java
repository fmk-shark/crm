package com.bjpower.crm.settings.web.controller;

import com.bjpower.crm.settings.domain.User;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.settings.service.impl.UserServiceImpl;
import com.bjpower.crm.utils.MD5Util;
import com.bjpower.crm.utils.PrintJson;
import com.bjpower.crm.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("欢迎进入管理员控制台");
        login(req,resp);



    }

    protected void login(HttpServletRequest request, HttpServletResponse response){
        String loginuser = request.getParameter("loginuser");
        String loginpwd = request.getParameter("loginpwd");
        System.out.println(loginuser+"------"+loginpwd);
        loginpwd = MD5Util.getMD5(loginpwd);
        String ip = request.getLocalAddr();
        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
        try {
            //登录成功后，根据用户名，密码，以及ip地址获取用户对象。
            User user =  userService.login(loginuser,loginpwd,ip);
            //异常被其他拦截了，所以程序会继续往下执行  imp被invoke方法调用了，并且把异常给拦截了，catch模块把异常处理了
            //如果user为空，直接转入catch语句内，并往上抛异常。
            //将登录用户设为当前用户user

            request.getSession().setAttribute("user",user);


            PrintJson.printJsonFlag(response,true);

        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage();//获取错误信息
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);//向前端返回错误信息数据
        }finally {

        }
    }
}
