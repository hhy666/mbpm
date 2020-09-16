<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="com.matrix.app.api.Page" %>
<%@page import="java.util.ArrayList" %>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<link href="imageNewsStyle.css" rel="stylesheet" type="text/css"/>
<title>图片新闻</title>
</head>
<body  style="background-color:white;margin:0 auto;margin-top:5px;">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
<div style='width:100%;height:90%;margin:0 auto;margin-top:0px;'>
		 <div id="player">
			<ul class="Limg">
                   
	 <%
	 String hql = "from office.info.news.NewsQueryInfo where o.C_IMG_NEWS=1 and o.c_status=1 Order By o.c_deploy_time desc ";
		//String hql = "from office.info.news.NewsQueryInfo where o.c_status=1 "; //新闻表中是图片新闻的按发布时间升序排列
     	DataService ds = MFormContext.getService("DataService");
     	List<DataObject> imgNewsList = ds.queryList2(hql,null,0,5);//新闻图片集合
     	if(imgNewsList!=null && imgNewsList.size()>0){
			for(int i=0;i<imgNewsList.size();i++){
				if(i>4){//只显示5条图片新闻
					break;
				}
				
				
	 %>
					 <li>
                        <a  href="<%=request.getContextPath()%>/CustomerVelocityServlet?type=2&mBizId=<%=imgNewsList.get(i).getString("uuid")%>" target="_blank">
                            <!-- 新闻图片 --> 
							<div class="pic" style="width: 100%; height: 87%" align="center">
								<img id="img" src="<%=request.getContextPath()%>/ImageNewsServlet?args=<%=i%>&mBizId=<%=imgNewsList.get(i).getString("uuid")%>" height="90%" border="0" />
								
							</div>     
							<div class="title" style="width: 100%; height: 13%" align="center">
								<!-- 新闻标题-->
								<h3 id="h" style="color:#00659C;"><%=imgNewsList.get(i).getString("name")%></h3>
								<!-- 新闻内容 -->
								
							</div>
						
                        </a>
                    </li>
      			<%}%>
			</ul>
			<div align="center" >
            <cite class="Nubbt"  style="margin:0 auto; padding: auto 0; position: absolute; z-index: 4; left:1px; right: 1px; ">
            
            	<span class="on">1</span>
            <%
            if(imgNewsList.size()>1){
            	for(int i=1;i<imgNewsList.size();i++){
            		if(i>4){//只显示5条图片新闻
    					break;
    				}
            	%>	<span><%=i+1 %></span>
            	<% 
            	}
            
            }
            
            %>
         <!--  <span class="on">1</span><span>3</span><span>4</span><span>5</span> -->
             </cite>  
			</div>
			<%}%>
             
		</div>
      </div>
			<script language=javascript type="text/javascript">
			//*焦点切换
			(function(){
			if(!Function.prototype.bind){
			Function.prototype.bind = function(obj){
			var owner = this,args = Array.prototype.slice.call(arguments),callobj = Array.prototype.shift.call(args);
			return function(e){e=e||top.window.event||window.event;owner.apply(callobj,args.concat([e]));};
			};
			}
			})();
			var player = function(id){
			this.ctn = document.getElementById(id);
			this.adLis = null;
			this.btns = null;
			this.animStep = 0.1;//动画速度0.1～0.9
			this.switchSpeed = 3;//自动播放间隔(s)
			this.defOpacity = 1;
			this.tmpOpacity = 1;
			this.crtIndex = 0;
			this.crtLi = null;
			this.adLength = 0;
			this.timerAnim = null;
			this.timerSwitch = null;
			this.init();
			};
			player.prototype = {
			fnAnim:function(toIndex){
			if(this.timerAnim){window.clearTimeout(this.timerAnim);}
			if(this.tmpOpacity <= 0){
			this.crtLi.style.opacity = this.tmpOpacity = this.defOpacity;
			this.crtLi.style.filter = 'Alpha(Opacity=' + this.defOpacity*100 + ')';
			this.crtLi.style.zIndex = 0;
			this.crtIndex = toIndex;
			return;
			}
			this.crtLi.style.opacity = this.tmpOpacity = this.tmpOpacity - this.animStep;
			this.crtLi.style.filter = 'Alpha(Opacity=' + this.tmpOpacity*100 + ')';
			this.timerAnim = window.setTimeout(this.fnAnim.bind(this,toIndex),50);
			},
			fnNextIndex:function(){
			return (this.crtIndex >= this.adLength-1)?0:this.crtIndex+1;
			},
			fnSwitch:function(toIndex){
				if(this.crtIndex==toIndex){
					return;
				}
				this.crtLi = this.adLis[this.crtIndex];
				for(var i=0;i<this.adLength;i++){
					this.adLis[i].style.zIndex = 0;
				}
				this.crtLi.style.zIndex = 2;
				this.adLis[toIndex].style.zIndex = 1;
				for(var i=0;i<this.adLength;i++){
					this.btns[i].className = '';
				}
				hideOtherLi(this.adLis,toIndex);
				this.btns[toIndex].className = 'on'
				this.fnAnim(toIndex);
			},
			fnAutoPlay:function(){
			this.fnSwitch(this.fnNextIndex());
			},
			fnPlay:function(){
			this.timerSwitch = window.setInterval(this.fnAutoPlay.bind(this),this.switchSpeed*1000);
			},
			fnStopPlay:function(){
			window.clearTimeout(this.timerSwitch);
			},
			init:function(){
			this.adLis = this.ctn.getElementsByTagName('li');
			initLoadShowFirstLi(this.adLis);
			this.btns = this.ctn.getElementsByTagName('cite')[0].getElementsByTagName('span');
			this.adLength = this.adLis.length;
			for(var i=0,l=this.btns.length;i<l;i++){
			with({i:i}){
			this.btns[i].index = i;
			this.btns[i].onclick = this.fnSwitch.bind(this,i);
			this.btns[i].onclick = this.fnSwitch.bind(this,i);
			}
			}
			this.adLis[this.crtIndex].style.zIndex = 2;
			this.fnPlay();
			this.ctn.onmouseover = this.fnStopPlay.bind(this);
			this.ctn.onmouseout = this.fnPlay.bind(this);
			}
			};
			var player1 = new player('player');

			function hideOtherLi(items,index){
				for(var i = 0;i<items.length;i++){
					if(i==index){
						items[i].style.display="";
					}else{
						items[i].style.display="none";
					}
				}
			}
			function initLoadShowFirstLi(items){
				if(items!=null && items.length>0){
					items[0].style.display="";
					if(items.length>1){
						for(var i = 1;i<items.length;i++){
							items[i].style.display="none";
						}
					}
				}
				

											
			}
			</script>
</body>
</html>