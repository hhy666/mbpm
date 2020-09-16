<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>侧滑导航菜单容器</title>
</head>
<body>
	<aside class="mui-off-canvas-left">
            <div class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <!-- 菜单具体展示内容 -->
                    <div class="user-info">
						<a href="javascript:;">
							<!-- <img class="mui-media-object mui-pull-left" src="/Public/assets/images/logo.png"> -->
							<div class="mui-media-body">
								协同办公
							</div>
						</a>
		
						<ul class="mui-table-view2 mui-table-view-chevron mui-table-view-inverted">	
							<li class="mui-table-view-cell">
								<a href="home.jsp" class="mui-navigate-right mui-ellipsis">首页 <span class="left-desc">Home</span></a>
							</li>
							<li class="mui-table-view-cell">
								<a id="signin" href="mobile/apply_query.action" class="mui-navigate-right mui-ellipsis">新建事项</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="flow" href="flow-list.jsp?type=readyTask" class="mui-navigate-right mui-ellipsis">任务中心</a>
							</li>					
							<li class="mui-table-view-cell">
								<a id="archive" href="archive-list.jsp?type=catalog&parentId=root" class="mui-navigate-right mui-ellipsis">文档中心</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="news" href="news-inlet.jsp?type=newslist" class="mui-navigate-right mui-ellipsis">新闻</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="notice" href="notice-inlet.jsp?type=noticelist" class="mui-navigate-right mui-ellipsis">公告</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="survery" href="survery-inlet.jsp?type=surverylist" class="mui-navigate-right mui-ellipsis">调查</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="discuss" href="discuss-inlet.jsp?type=discusslist" class="mui-navigate-right mui-ellipsis">讨论</a>
							</li>
						
							<li class="mui-table-view-cell">
								<a id="maintain" href="<%=request.getContextPath() %>/mobile/utilization_loadDataUtilization.action" class="mui-navigate-right mui-ellipsis">数据维护</a>
							</li>
							<li class="mui-table-view-cell">
								<a id="query" href="<%=request.getContextPath() %>/mobile/query_loadDataQuery.action" class="mui-navigate-right mui-ellipsis">数据查询</a>
							</li>							
						</ul>
					</div>
                </div>
            </div>
        </aside>
</body>
</html>