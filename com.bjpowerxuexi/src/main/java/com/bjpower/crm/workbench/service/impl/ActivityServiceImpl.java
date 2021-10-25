package com.bjpower.crm.workbench.service.impl;


import com.bjpower.crm.settings.dao.UserDao;
import com.bjpower.crm.utils.SqlSessionUtil;
import com.bjpower.crm.workbench.dao.ActivityDao;
import com.bjpower.crm.workbench.dao.ActivityRemarkDao;
import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityRemark;
import com.bjpower.crm.workbench.domain.ActivityVO;
import com.bjpower.crm.workbench.service.ActivityService;

import javax.security.auth.login.LoginException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    private ActivityRemarkDao activityRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    public boolean activitySave(Activity activity) {
        boolean flag = true;
        int count = activityDao.activitySave(activity);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    public ActivityVO<Activity> getPageList(Map<String, Object> pageMap) {
        ActivityVO a = new ActivityVO();
        int count = activityDao.getPageCount();
        List<Activity> activity = activityDao.getPageUserList(pageMap);
        a.setTotal(count);
        a.setPageList(activity);
        return a;
    }

    public boolean delete(String[] ids) throws LoginException {
        boolean flag = true;
        //因为有两张表要删除，所以要对比数据才能够删除
        int count1 = activityRemarkDao.acactivityDeleteDate(ids);//根据id查询到需要删除的数据条数
        int count2 = activityRemarkDao.activityDeleteCount(ids);//删除成功后返回的条数
        if(count1 != count2){
            flag = false;
            throw new LoginException("执行删除失败，事务回滚");
        }

        int count3 = activityDao.activityDeleteTotal(ids);

        if(count3 != ids.length){
            flag = false;
            throw new LoginException("执行删除失败，事务回滚");
        }
        return flag;
    }

    public boolean activityEdit(Map activityId) {
        boolean flag = true;
        int count = activityDao.activityEdit(activityId);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    public Map<String, Object> editacList(String id) {
        Activity activity = activityDao.editacList(id);
        List uList = userDao.getUserList();
        Map<String, Object> editActivityMap = new HashMap<String, Object>();
        editActivityMap.put("uList",uList);
        editActivityMap.put("activity",activity);
        return editActivityMap;
    }

    public Activity detailJump(String activityId) {
        Activity activityDetail = activityDao.detailJump(activityId);
        return activityDetail;
    }

    public List<ActivityRemark> showRemarkListByid(String activityRemarkId) {
        List<ActivityRemark> activityRemarks = activityRemarkDao.showRemarkListByid(activityRemarkId);
        return activityRemarks;
    }

    public boolean deleteRemark(String deleteRemarkById) {
        boolean flag = true;
        int count = activityRemarkDao.deleteRemark(deleteRemarkById);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    public boolean saveRemark(Map<String, String> saveRemarkMap) {
        boolean flag = true;
        int count = activityRemarkDao.saveRemark(saveRemarkMap);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    public boolean updataRemark(ActivityRemark activityRemark) {
        boolean flag = true;
        int count = activityRemarkDao.updataRemark(activityRemark);
        return flag;
    }


}
