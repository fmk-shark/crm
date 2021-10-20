package com.bjpower.crm.settings.service.impl;

import com.bjpower.crm.settings.dao.UserDao;
import com.bjpower.crm.settings.domain.User;
import com.bjpower.crm.settings.service.UserService;
import com.bjpower.crm.utils.DateTimeUtil;
import com.bjpower.crm.utils.SqlSessionUtil;
import org.apache.ibatis.session.SqlSession;

import javax.security.auth.login.LoginException;
import java.util.HashMap;
import java.util.Map;

public class UserServiceImpl implements UserService {
   private  UserDao userdao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);


   public  User login(String loginuser, String loginpwd, String ip) throws LoginException {
      Map<String,String> map = new HashMap<String, String>();
      map.put("loginAct",loginuser);
      map.put("loginPwd",loginpwd);
      User user = userdao.login(map);
      if(user == null){

         throw new LoginException("账号密码错误");

      }
      //判断失效时间
      String expireTime = user.getExpireTime();
      String currentTime = DateTimeUtil.getSysTime();
      if(expireTime.compareTo(currentTime)<0){
         throw new LoginException("账号已经失效");
      }
      String locktime = user.getLockState();;
      if("0".equals(locktime)){
         throw new LoginException("账号被锁，请联系管理员进行解封");
      }
      String allowips = user.getAllowIps();
         if(!allowips.contains(ip)){
            throw new LoginException("访问地址有误，请更换ip");
         }


      return user;
   }
}
