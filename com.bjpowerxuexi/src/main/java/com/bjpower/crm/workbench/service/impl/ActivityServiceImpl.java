package com.bjpower.crm.workbench.service.impl;


import com.bjpower.crm.utils.SqlSessionUtil;
import com.bjpower.crm.workbench.dao.ActivityDao;
import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityVO;
import com.bjpower.crm.workbench.service.ActivityService;

import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);

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
}
