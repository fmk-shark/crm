package com.bjpower.crm.settings.service;

import com.bjpower.crm.settings.domain.User;

import javax.security.auth.login.LoginException;
import java.util.List;

public interface UserService {

    User login(String loginuser, String loginpwd, String ip) throws LoginException;

    List<User> getUserList();
}
