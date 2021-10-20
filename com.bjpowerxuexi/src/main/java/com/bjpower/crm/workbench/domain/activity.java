package com.bjpower.crm.workbench.domain;

public class activity {
    private static String id;
    private static String noteContent;
    private static String createTime;
    private static String createBy;
    private static String editTime;
    private static String editBy;
    private static String editFlag ;
    private static String activityId;


    public static String getId() {
        return id;
    }

    public static void setId(String id) {
        activity.id = id;
    }

    public static String getNoteContent() {
        return noteContent;
    }

    public static void setNoteContent(String noteContent) {
        activity.noteContent = noteContent;
    }

    public static String getCreateTime() {
        return createTime;
    }

    public static void setCreateTime(String createTime) {
        activity.createTime = createTime;
    }

    public static String getCreateBy() {
        return createBy;
    }

    public static void setCreateBy(String createBy) {
        activity.createBy = createBy;
    }

    public static String getEditTime() {
        return editTime;
    }

    public static void setEditTime(String editTime) {
        activity.editTime = editTime;
    }

    public static String getEditBy() {
        return editBy;
    }

    public static void setEditBy(String editBy) {
        activity.editBy = editBy;
    }

    public static String getEditFlag() {
        return editFlag;
    }

    public static void setEditFlag(String editFlag) {
        activity.editFlag = editFlag;
    }

    public static String getActivityId() {
        return activityId;
    }

    public static void setActivityId(String activityId) {
        activity.activityId = activityId;
    }


}
