<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<SCRIPT>var isomorphicDir="/moffice/matrix/resource/isomorphic/";</SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Core11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Foundation11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Containers11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Grids11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Forms11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_DataBinding11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_RichTextEditor11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/matrixSmartClient11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/matrix11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/date11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/common_property11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/formcatalog11.56.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/skins/Enterprise/load_skin11.56.js"></SCRIPT>
<link rel="stylesheet" href="/moffice/matrix/resource/isomorphic/skins/Enterprise/matrix_runtime11.56.css" type="text/css"/>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/locales/frameworkMessages_zh_CN11.56.properties"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/locales/matrixMessages_zh_CN11.56.properties"></SCRIPT>
  
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'leftright.jsp' starting page</title>
      </head>
  <script language=javascript>
 var bOpen=true;
 function metsky_switch()
  {
         if (bOpen)
           {
                   document.all("frmleft").style.display="none";
                   bOpen=false;
          }
          else
          {        
                   document.all("frmleft").style.display="";                
                   bOpen=true;
          }
 }
 </script>
 
<table width="100%" height="100%" border=0 cellpadding=0 cellspacing=0>
   <tbody>
     <tr> 
      <td align="middle" valign="center" nowrap id="frmleft"> 
                 <iframe frameBorder=0 name="frame1" scrolling="auto" src="left.html" style="height:100%;visibility:inherit;width:160px;z-index:2"></iframe> 
      </td>
       <td bgcolor="#e0e0e0" onClick="metsky_switch()" title="打开/关闭左边导航栏" style="height:100%;cursor:hand;"> &nbsp;</td>
       <td style="width:100%;padding-left:6px;"> 
                 <iframe frameBorder=0 id="frame2" name="frame2" scrolling="auto" style="height:100%;visibility:inherit;width:100%;z-index:1"></iframe>
    </td>
     </tr>
   </tbody>
 </table>
 

  
</html>
