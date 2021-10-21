package com.bjpower.crm.workbench.domain;

import java.util.List;

public class ActivityVO<T> {
    private int total;
    private List<T> pageList;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }
}
