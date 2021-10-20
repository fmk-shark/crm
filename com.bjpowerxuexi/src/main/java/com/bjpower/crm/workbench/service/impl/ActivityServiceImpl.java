package com.bjpower.crm.workbench.service.impl;


import com.bjpower.crm.utils.SqlSessionUtil;
import com.bjpower.crm.workbench.dao.ActivityDao;
import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.service.ActivityService;

public class ActivityServiceImpl implements ActivityService {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);


    public void activityCreate(Activity activity) {

    }
}
