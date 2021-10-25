package com.bjpower.crm.workbench.web.controller;

import com.bjpower.crm.settings.domain.User;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.settings.service.impl.UserServiceImpl;
import com.bjpower.crm.utils.*;
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
        }else if("/workbench/activity/delete.do".equals(path)) {
            delete(request, response);
        }else if("/workbench/activity/edit.do".equals(path)) {
            edit(request, response);
        }else if("/workbench/user/edituList.do".equals(path)) {
            edituList(request, response);
        }else if("/workbench/activity/detail.do".equals(path)){
            detailJump(request,response);
        }else if("/workbench/activityRemark/showRemarkList.do".equals(path)){
            showRemarkList(request,response);
        }else if("/workbench/activityRemark/deleteRemark.do".equals(path)){
            deleteRemark(request,response);
        }else if("/workbench/activityRemark/saveRemark.do".equals(path)){
            saveRemark(request,response);
        }else if("/workbench/activityRemark/updateRemark.do".equals(path)){
            updataRemark(request,response);
        }

    }

    private void updataRemark(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String noteContent = request.getParameter("noteContent");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = request.getParameter("editBy");
        String editFlag = "1";

        ActivityRemark activityRemark = new ActivityRemark();

        activityRemark.setId(id);
        activityRemark.setNoteContent(noteContent);
        activityRemark.setEditTime(editTime);
        activityRemark.setEditBy(editBy);
        activityRemark.setEditFlag(editFlag);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.updataRemark(activityRemark);

        Map<String,Object> noteContentMap = new HashMap<String, Object>();

        noteContentMap.put("success",flag);
        noteContentMap.put("activityRemark",activityRemark);

        PrintJson.printJsonObj(response,noteContentMap);


    }

    private void saveRemark(HttpServletRequest request, HttpServletResponse response) {
        String noteContent = request.getParameter("noteContent");
        String activityId = request.getParameter("activityId");
        String createTime = DateTimeUtil.getSysTime();
        String createBy = request.getParameter("createBy");
        String editFlag = "0";
        String id = UUIDUtil.getUUID();

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Map<String,String> saveRemarkMap = new HashMap<String, String>();

        saveRemarkMap.put("noteContent",noteContent);
        saveRemarkMap.put("activityId",activityId);
        saveRemarkMap.put("createTime",createTime);
        saveRemarkMap.put("createBy",createBy);
        saveRemarkMap.put("editFlag",editFlag);
        saveRemarkMap.put("id",id);


        boolean flag = activityService.saveRemark(saveRemarkMap);
        Map<String,Object> mapList = new HashMap<String, Object>();
        mapList.put("success",flag);
        mapList.put("saveRemarkMap",saveRemarkMap);
        PrintJson.printJsonObj(response,mapList);
    }

    private void deleteRemark(HttpServletRequest request, HttpServletResponse response) {
        String deleteRemarkById = request.getParameter("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.deleteRemark(deleteRemarkById);

        PrintJson.printJsonFlag(response,flag);
    }

    private void showRemarkList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("根据市场活动id，获取备注信息列表");
        String activityRemarkId = request.getParameter("activityId");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        List<ActivityRemark> activityRemark = activityService.showRemarkListByid(activityRemarkId);

        PrintJson.printJsonObj(response,activityRemark);
    }

    private void detailJump(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("跳转到详细信息页面");

        String activityId = request.getParameter("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Activity activityDetail = activityService.detailJump(activityId);

        request.setAttribute("a",activityDetail);

        request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request,response);
    }

    private void edituList(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Map<String,Object> activityMap = activityService.editacList(id);
        PrintJson.printJsonObj(response,activityMap);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("执行市场活动修改操作");
        String editBy = request.getParameter("owner");//获取前端传输过来的数据
        String activityId = request.getParameter("id");//获取前端传输过来的数据
        String name = request.getParameter("name");//获取前端传输过来的数据
        String startDate = request.getParameter("startDate");//获取前端传输过来的数据
        String endDate = request.getParameter("endDate");//获取前端传输过来的数据
        String cost = request.getParameter("cost");//获取前端传输过来的数据
        String description = request.getParameter("description");//获取前端传输过来的数据
        String editTime = DateTimeUtil.getSysTime();

        Map<String,String> activityMap = new HashMap<String, String>();
        activityMap.put("editBy",editBy);
        activityMap.put("id",activityId);
        activityMap.put("name",name);
        activityMap.put("startDate",startDate);
        activityMap.put("endDate",endDate);
        activityMap.put("cost",cost);
        activityMap.put("description",description);
        activityMap.put("editTime",editTime);
        //用接口方式解耦合
        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = activityService.activityEdit(activityMap);
        //向前台传输修改是否成功的数据
        PrintJson.printJsonFlag(response,flag);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)  {
        try {
            String ids[] = request.getParameterValues("param");//切记前端传过来时json对象的话拿不到id值
            ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
            boolean flag = activityService.delete(ids);
            //用封装好了的方法向前端传输数据
            PrintJson.printJsonFlag(response,flag);
        } catch (LoginException e) {
            e.printStackTrace();
            String msg = e.getMessage();//获取错误信息
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);//向前端返回错误信息数据
        }
    }

    private void getPageList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("获取用户信息");//根据页面页码和页面显示客户数
        String owner = request.getParameter("owner");//获取前端数据用来
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
        System.out.println("保存客户市场活动数据");
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
        System.out.println("获取用户名的下拉框");//获取用户id和姓名
        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = userService.getUserList();
        PrintJson.printJsonObj(response,userList);

    }


}
