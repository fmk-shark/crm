package com.bjpower.crm.workbench.service;

import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityVO;

import java.util.Map;

public interface ActivityService {

    boolean activitySave(Activity activity);

    ActivityVO getPageList(Map<String, Object> pageMap);
}
