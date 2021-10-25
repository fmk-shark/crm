package com.bjpower.crm.workbench.dao;

import com.bjpower.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActivityRemarkDao {

    int acactivityDeleteDate(String[] ids);

    int activityDeleteCount(String[] ids);

    List<ActivityRemark> showRemarkListByid(String activityRemarkId);

    int deleteRemark(String deleteRemarkById);

    int saveRemark(Map<String, String> saveRemarkMap);

    int updataRemark(ActivityRemark activityRemark);
}
