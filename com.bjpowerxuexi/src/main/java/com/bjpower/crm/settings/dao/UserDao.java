package com.bjpower.crm.settings.dao;

import com.bjpower.crm.settings.domain.User;

import java.util.HashMap;
import java.util.Map;

public interface UserDao {


    User login(Map<String, String> map);
}
