<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

  </head>
  <style>
  div{
  font-family: Microsoft YaHei;
  }
  .margin_l_20{
  margin-left:20px;
  }
  .color_gray{
  color:#a3a3a3;
  }
  .font_size12{
  font-size:12px;
  }
  .left{
  float:left;
  }
  .margin_t_20{
  margin-top:20px;
  }
  .margin_l_10{
  margin-left:10px;
  }
  .margin_t_10{
  margin-top:10px;
  }
  .font_size14{
  font-size:14px;
  }
  </style>
  <body>
  <% 
  String count = request.getParameter("count"); 
   %>
  <div class="color_gray margin_l_20 " id="manual" style="display: block;">
              <div class="clearfix">
                <h2 class="left"><br></h2><h2 class="left">门户配置管理</h2>
                <div class="font_size12 left margin_t_20 margin_l_10">
                    <div class="margin_t_10 font_size14">
                        <span id="count"></span>
                    </div>
                </div>
              </div>
            </div>
  </body>
</html>
