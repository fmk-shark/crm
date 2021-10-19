<%--
  Created by IntelliJ IDEA.
  User: shuai
  Date: 2021/10/19
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>niubi</title>
</head>
<body>
         $.ajax({
         url:"/setting/user/save.do",
         type:"",
         data:{},
         dataType:"json",
         success:function (data) {

         }
         })
</body>
</html>
