package com.bjpower.crm.workbench.web.controller;

import com.bjpower.crm.settings.domain.User;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.settings.service.impl.UserServiceImpl;
import com.bjpower.crm.utils.DateTimeUtil;
import com.bjpower.crm.utils.PrintJson;
import com.bjpower.crm.utils.ServiceFactory;
import com.bjpower.crm.utils.UUIDUtil;
import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityRemark;
import com.bjpower.crm.workbench.domain.ActivityVO;
import com.bjpower.crm.workbench.service.ActivityService;
import com.bjpower.crm.workbench.service.impl.ActivityServiceImpl;

import javax.security.auth.login.LoginException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClueController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("你进入了线索控制器.....");
        String path = request.getServletPath();
        System.out.println(path);


        if("/workbench/xxx.do".equals(path)){
            //xxx(request,response);
        }else if("/workbench/clue/save.do".equals(path)){
            //xxx(request,response);
        }
    }


}
