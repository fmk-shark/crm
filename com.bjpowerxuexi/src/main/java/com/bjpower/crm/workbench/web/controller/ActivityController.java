package com.bjpower.crm.workbench.web.controller;

import com.bjpower.crm.settings.domain.User;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.settings.service.impl.UserServiceImpl;
import com.bjpower.crm.utils.DateTimeUtil;
import com.bjpower.crm.utils.PrintJson;
import com.bjpower.crm.utils.ServiceFactory;
import com.bjpower.crm.utils.UUIDUtil;
import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityVO;
import com.bjpower.crm.workbench.service.ActivityService;
import com.bjpower.crm.workbench.service.impl.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("你进入了活动页面.....");
        String path = request.getServletPath();
        System.out.println(path);


        if("/workbench/user/userlist.do".equals(path)){
            getUserList(request,response);
        }else if("/workbench/user/save.do".equals(path)){
            save(request,response);
        }else if("/workbench/user/pagelist.do".equals(path)){
            getPageList(request,response);
        }

    }

    private void getPageList(HttpServletRequest request, HttpServletResponse response) {
        String owner = request.getParameter("owner");//获取前端数据
        String name = request.getParameter("name");//获取前端数据
        String startDate = request.getParameter("startDate");//获取前端数据
        String endDate = request.getParameter("endDate");//获取前端数据
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));//获取前端数据
        Integer pageSize = Integer.valueOf(request.getParameter("pageSize"));//获取前端数据
        Integer skipCount = (pageNo-1)*pageSize;//将页面页数转换，变成页码数据
        Map<String,Object> pageMap = new HashMap<String, Object>();
        pageMap.put("owner",owner);
        pageMap.put("name",name);
        pageMap.put("startDate",startDate);
        pageMap.put("endDate",endDate);
        pageMap.put("pageSize",pageSize);
        pageMap.put("skipCount",skipCount);
        ActivityService getPageList = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        ActivityVO<Activity> pageList = getPageList.getPageList(pageMap);
        //pageList里面有list<Activity数据和总条数total数据>
        PrintJson.printJsonObj(response,pageList);

    }


    private void save(HttpServletRequest request, HttpServletResponse response) {
        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        Activity activity = new Activity();
        activity.setId(id);
        activity.setOwner(owner);
        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = activityService.activitySave(activity);
        PrintJson.printJsonFlag(response,flag);

    }




    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = userService.getUserList();
        PrintJson.printJsonObj(response,userList);

    }


}
