package com.bjpower.crm.workbench.service;

import com.bjpower.crm.workbench.domain.Activity;
import com.bjpower.crm.workbench.domain.ActivityRemark;
import com.bjpower.crm.workbench.domain.ActivityVO;

import javax.security.auth.login.LoginException;
import java.util.List;
import java.util.Map;

public interface ActivityService {

    boolean activitySave(Activity activity);

    ActivityVO getPageList(Map<String, Object> pageMap);

    boolean delete(String[] ids) throws LoginException;

    boolean activityEdit(Map activityId);

    Map<String, Object> editacList(String id);

    Activity detailJump(String activityId);

    List<ActivityRemark> showRemarkListByid(String activityRemarkId);

    boolean deleteRemark(String deleteRemarkById);

    boolean saveRemark(Map<String, String> saveRemarkMap);

    boolean updataRemark(ActivityRemark activityRemark);
}
