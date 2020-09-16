<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%@ page import="com.matrix.client.foundation.portal.model.PortletDisplayModel"  %>
<%@ page import="com.matrix.client.foundation.portal.model.PortalConverterHelper"  %>
<%@ page import="com.matrix.client.foundation.portal.model.PortalDisplayModel" %>
<%@ page import="com.matrix.client.foundation.portal.model.RowPortletDisplayModel" %>
<%@ page import="com.matrix.client.foundation.portal.model.ColPortletDisplayModel" %>
<%@ page import="com.matrix.client.foundation.portal.model.PortletInfo" %>
<%@ page import="com.matrix.client.foundation.portal.service.PortalHelper" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/css/style.css">
  	
  	<link href='<%=request.getContextPath()%>/resource/html5/css/style.min.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath()%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath()%>/resource/html5/css/custom.css' rel="stylesheet"></link>
	<style type="text/css">
		.portal-layout-cell {
		    width: 100%;
		    border: 0px #c7c7c7 solid;
		    margin-top: 0px;
		}
		.common_content_area, .common_content_area_tab {
    		 border: 0;
   			 text-align: left;
   			 margin-bottom: 8px;
   		}
   		.ibox {
		    clear: both;
		    margin-bottom: 8px;
		    margin-top: 0px;
		    padding: 0px;
		}
		.portal-layout-TwoColumns .column1 {
		    width: 49.5%;
		    float: left;
		}
		.ibox-title {
		    background-color: #fff;
		    border-color: #e7eaec;
		    -webkit-border-image: none;
		    -o-border-image: none;
		    border-image: none;
		    border-style: solid solid none;
		    border-width: 0px 1px 0;
		    color: inherit;
		    margin-bottom: 0;
		    padding: 14px 15px 7px;
		    min-height: 40px;
	   }
	   .ibox-content {
		    background-color: rgb(255, 255, 255);
		    color: inherit;
		    -webkit-border-image: none;
		    padding: 0px 3px 0px;
		    border-color: rgb(231, 234, 236);
		    border-image: none 100% / 1 / 0 stretch;
		    border-style: solid;
		    border-width: 1px;
		}
		.ibox-title h5 {
		    display: inline-block;
		    font-size: 14px;
		    text-overflow: ellipsis;
		    float: left;
		    margin: 0px 0px 7px;
		    padding: 0px;
		    font-weight: bold;
		}
	</style>
  </head>
  
  <script>
    function addClass(elements,value){   //addClass(元素，样式值)
        if(!elements.className){
            elements.className=value;
        }else{
            var newClass=elements.className;
            newClass+=" ";
            newClass+=value;
            elements.className=newClass;
            
        }
    }
    /*
    	打开链接时验证
    */
   function openLink(url){
 	   if(url!=null && url.length>0){
 	   //var bool = url.match(/(((^http:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)$/g);
 	   //if(bool){
 		   window.location.href="<%=basePath%>"+url;
 		   return true;
 	   //}
 	   }
 	   alert("链接无效!");
 	   return false;
   }
 </script>

  <body>
  <div class="main_div_center">
  <div class="right_div_center" style="margin-left:4px;background: #f3f3f4;">
  <div id="right_div_portal_sub" class="center_div_center">
  <div id="normalDiv" class="portal-layout  layout-top" style="padding: 10px 10px 10px 10px;">

  <%
  Object flag = request.getAttribute("flag");
  int defaultHeight=180;     //默认高度（在rowspan为0，height为null时，取默认高度）
  int cols = (Integer)request.getAttribute("layout");
  
  if(flag ==null ){
  
  List newPortlets = (List)request.getAttribute("portlets");
  Object isReview = request.getParameter("isView");//是否为预览模式
  boolean isView = false;
  if(isReview!=null&&"1".equals(isReview))
  isView = true;
  %>
  
  <script type="text/javascript">
  var element = document.getElementById("normalDiv");
  if(<%=cols%>==1){
     addClass(element,"portal-layout-OneColumn");
  }else if(<%=cols%>==2){
     addClass(element,"portal-layout-TwoColumns");
  }else if(<%=cols%>==3){
     addClass(element,"portal-layout-ThreeColumns");
  }
  </script>
  <%
  List lists = new ArrayList();
  for(Iterator it = newPortlets.iterator();it.hasNext();){
	  RowPortletDisplayModel rowPortlet = (RowPortletDisplayModel)it.next();
	  if(rowPortlet.isSingleRow())
	     lists.add(rowPortlet.getPortletId());
  }
  
for(Iterator it = newPortlets.iterator();it.hasNext();){
	RowPortletDisplayModel rowPortlet = (RowPortletDisplayModel)it.next();

	rowPortlet.setDisplay(true);		
	
	int rowSpan = rowPortlet.getRowSpan();
	String height = rowPortlet.getHeight();
	if(height==null||height.trim().length()==0)
		height="null";
	if(rowPortlet.isSingleRow()){

%>
<div id="banner<%=newPortlets.indexOf(rowPortlet) %>"  class="portal-layout-column ui-sortable banner">
<!--  设置banner高度-->
<script type="text/javascript">
var bannerElement = document.getElementById("banner"+<%=newPortlets.indexOf(rowPortlet)%>);
var rowSpan = <%=rowSpan%>;

var bannerContentHeight;
if(<%=height%>!=null){
	bannerContentHeight=<%=height%>;
}else{
	if(rowSpan==0)
		rowSpan=1;
		bannerContentHeight=(rowSpan*<%=defaultHeight%>+34+8)+"px";
	}
</script>
  
     <%
     if(!(rowPortlet.getUrl()!=null && rowPortlet.getUrl().indexOf("banner.jsp")>=0) ){
     %>
     <div class="portal-layout-cell">
       <div class="common_content_area">
 
       <div id="title<%=rowPortlet.getPortletId() %>" class="ibox-title">
       <h5><%=rowPortlet.getTitle() %></h5>
       <%
        if(rowPortlet.getMoreUrl()!=null&&rowPortlet.getMoreUrl().trim().length()>0){
        	 String moreUrl = rowPortlet.getMoreUrl();
        	 if(moreUrl.indexOf("?")>0){
        		 moreUrl = moreUrl+"&mHtml5Flag=true";
        	 }else{
        		 moreUrl = moreUrl+"?mHtml5Flag=true";
        	 }
       %>
       <a id="moreIco_section_div<%=rowPortlet.getPortletId() %>" class="sectionMoreIco" title="更多" style="float:right;z-index：99999" onclick="javascript:openLink('<%=moreUrl %>');">
                             更多
       </a>
       <%} %>
     </div>
     
       <!-- 判断more是否为空，显示更多 -->
      <div id="<%= rowPortlet.getPortletId()%>" class="ibox-content" style="overflow:hidden;width:100%; ">
      <script>
        document.getElementById('<%= rowPortlet.getPortletId()%>').style.height=bannerContentHeight;
       </script>
     <%
     if(rowPortlet.getUrl()!=null){
     	if(!isView){
    	  String contentUrl = rowPortlet.getUrl();
    	  if(contentUrl.indexOf("?")>0){
    		  contentUrl = contentUrl+"&mHtml5Flag=true&mIsPortal=true";
     	  }else{
     		  contentUrl = contentUrl+"?mHtml5Flag=true&mIsPortal=true";
     	  } 
     %>
      <iframe src="<%=request.getContextPath()%>/<%=contentUrl %>" sectionid="3474652838243681291" name="IframeSectionTemplete" frameborder="0" height="100%" width="100%" scrolling="no" marginwidth="0" >
      </iframe>
     <%
     }else{  
     }
     } 
     %>
   </div>
    </div>
     </div>
      <%}else{
      
       if(rowPortlet.getUrl()!=null){
     	  String contentUrl=rowPortlet.getUrl();
     	  if(contentUrl.indexOf("?")>0){
   		      contentUrl = contentUrl+"&mHtml5Flag=true&mIsPortal=true";
    	  }else{
    		  contentUrl = contentUrl+"?mHtml5Flag=true&mIsPortal=true";
    	  } 
     %>
     <script>
     	document.getElementById("banner"+<%=newPortlets.indexOf(rowPortlet)%>).style.height=bannerContentHeight;
     </script>
     <div class="portal-layout-cell" style="  margin-top: 0px;">
        <iframe src="<%=request.getContextPath()%>/<%=contentUrl %>" sectionid="3474652838243681291" name="IframeSectionTemplete" frameborder="0" height="100%" width="100%" scrolling="no" marginwidth="0" >
      </iframe>
       </div>
     <% 
     }
      } %>
   
    </div>
<%
}else{
%>
<script>
var normalWidth = document.getElementById("normalDiv").offsetWidth;//取内容包括边框宽度
</script>
<div id="row<%=newPortlets.indexOf(rowPortlet) %>" style="width:100%;">
<script type="text/javascript">
var cellElement = document.getElementById("row"+<%=newPortlets.indexOf(rowPortlet) %>);
var height = <%=height%>;
var rowSpan = <%=rowSpan%>;

var sumcols = 0;//总列数，判断一行的列数之和是不是等于列布局的列数
</script>
<%
int colcol = 1;
List colsPortlet = rowPortlet.getColPortlets();

for(int i=0;i<colsPortlet.size();i++){
	ColPortletDisplayModel colPorlet = (ColPortletDisplayModel)colsPortlet.get(i);
	List colPorlets  = colPorlet.getPortlets();
	colcol = colPorlet.getColNum();
	
	String width = colPorlet.getWidth();
	int j;
	for( j=0;j<colPorlets.size();j++){
		PortletDisplayModel portInfo = (PortletDisplayModel)colPorlets.get(j);
		if(portInfo.isDisplay())
			continue;
		portInfo.setDisplay(true);
		int rowSpan2 = portInfo.getRowSpan();
		height = portInfo.getHeight();
		width = portInfo.getWidth();
%>
<div id="column<%= portInfo.getPortletId()%>" class="portal-layout-column ui-sortable">

<script>
colcol = <%=colcol%>;
if('<%=width%>'!=null&&'<%=width%>'!=''){
   if(<%=cols%>==2){
      <%int intValue = PortalHelper.parseInt(width); %>	
      if(<%=intValue%> >normalWidth*0.48)
         colcol=2;
   }
   if(<%=cols%>==3){
      if(<%=intValue%>>normalWidth*0.32&&<%=intValue%><normalWidth*0.64)
         colcol=2;
     if(<%=intValue%>>normalWidth*0.64) 
         colcol=3;
   }
}
</script>

<script>
sumcols+=<%=colcol%>;
if(<%=i%>==<%=colsPortlet.size()%>-1&&<%=i%>!=0&&sumcols==<%=cols%>)
document.getElementById("column<%= portInfo.getPortletId()%>").style.float="right";
else {
if(<%=i%>!=0)
document.getElementById("column<%= portInfo.getPortletId()%>").style.marginLeft="20px";
}
document.getElementById("column<%= portInfo.getPortletId()%>").className += " column"+colcol;
</script>
<%
if(height!=null&&height.trim().length()>0&&width!=null&&width.trim().length()>0){
 %>
<div id="cell_col<%=colcol %>_<%= j%>" class="portal-layout-cell" style="width:<%=width%>;" >
<%}
if(height!=null&&height.trim().length()>0&&(width==null||width.trim().length()==0)){
 %>
 <div id="cell_col<%=colcol %>_<%= j%>" class="portal-layout-cell">
 <%}
if((height==null||height.trim().length()==0)&&(width==null||width.trim().length()==0)){
if(rowSpan2==0)
rowSpan2=1;
height = (rowSpan2*defaultHeight+34+8)+"px";
 %>
 <div id="cell_col<%=colcol %>_<%= j%>" class="portal-layout-cell">
 <%} %>
  <%
if((height==null||height.trim().length()==0)&&(width!=null&&width.trim().length()>0)){
if(rowSpan2==0)
rowSpan2=1;
height = (rowSpan2*defaultHeight+34+8)+"px";
 %>
 <div id="cell_col<%=colcol %>_<%= j%>" style="position:relative;padding-right: 1px;padding-left: 1px;width:<%=width%>" >
 <%} %>
 <div class="ibox float-e-margins" style="width:100%;">
    <div  id="title<%=portInfo.getPortletId() %>"  class="ibox-title">
       <h5><%=portInfo.getTitle() %></h5>
         <%
         if(portInfo.getMoreUrl()!=null&&portInfo.getMoreUrl().trim().length()>0){ 
        	 String moreUrl = portInfo.getMoreUrl();
        	if(moreUrl.indexOf("?")>0){
        		moreUrl = moreUrl+"&mHtml5Flag=true";
       	    }else{
       		    moreUrl = moreUrl+"?mHtml5Flag=true";
       	    } 
         %>
         <a id="moreIco_section_div<%=portInfo.getPortletId() %>" class="sectionMoreIco" title="更多" style="float:right;" onclick="javascript:openLink('<%=moreUrl %>')">
                                  更多
         </a>
    <%} %>
   </div>

  <div id="<%= portInfo.getPortletId()%>" class="ibox-content" style="overflow:hidden;width:100%;">
 <script>
    document.getElementById('<%=portInfo.getPortletId()%>').style.height='<%=height%>';
    </script>
  
     <%
   if(portInfo.getUrl()!=null){
   if(!isView){
	   String contentUrl=portInfo.getUrl();
	   if(contentUrl.indexOf("?")>0){
		   contentUrl = contentUrl+"&mHtml5Flag=true&mIsPortal=true";
 	   }else{
 		  contentUrl = contentUrl+"?mHtml5Flag=true&mIsPortal=true";
 	   } 
 	/*  if(url2!=null && url2.indexOf(".rform")>0){
 		  url2 = url2.replace(".rform",".mform");
 		  url2 = url2+"&mHtml5Flag=true";
 	}
 	*/
    %>
    <iframe src="<%=request.getContextPath()%>/<%=contentUrl %>" name="IframeSectionTemplete" frameborder="0" height="100%" width="100%" scrolling="no" marginwidth="0" >
  </iframe>
  <%
  }}else{
  %>
  
  <%
  }
   %>
   </div>
  </div>
 </div>
<%
}
%>

 </div>
<%
} 
%>
<!--  --></div>
<%
}}%>
<%} %>
    </div>
    </div>
    </div>
    </div>   
  </body>
</html>
