package com.bjpower.crm.settings.service.impl;

import com.bjpower.crm.settings.dao.UserDao;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.utils.SqlSessionUtil;
import org.apache.ibatis.session.SqlSession;

public class UserServiceImpl implements UserService {
   private UserDao userdao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);



}
