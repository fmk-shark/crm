package com.bjpower.crm.workbench.dao;

import com.bjpower.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityDao {

    int activitySave(Activity activity);

    int getPageCount();

    List<Activity> getPageUserList(Map<String, Object> pageMap);

    int activityDeleteTotal(String[] ids);

    int activityEdit(Map activityId);

    Activity editacList(String s);

    Activity detailJump(String activityId);
}
