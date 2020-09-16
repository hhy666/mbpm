<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<head>
	<meta charset="utf-8">
	<title>ECharts</title>
</head>
<body>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="main" style="height: 400px"></div>
	<!-- ECharts单文件引入 -->
	<script src="http://s1.bdstatic.com/r/www/cache/ecom/esl/1-6-10/esl.js"></script>
	<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                 'echarts' : 'http://echarts.baidu.com/build/echarts',
      			'echarts/chart/pie' : 'http://echarts.baidu.com/build/echarts'
            }
        });
        
        // 使用
        require(
            [
               'echarts',
  			'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
               
        		var	option = {
    	title : {
        	text: '超期统计',
        	//subtext: '纯属虚构',
        	x:'center'
    },

    legend: {
        orient : 'vertical',
        x : 'left',
        data:<%=request.getAttribute("legend")%>
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true, 
                type: ['pie', 'funnel'],
                option: {
                    funnel: {
                        x: '25%',
                        width: '50%',
                        funnelAlign: 'left',
                        max: 1548
                    }
                }
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    series : [
        {
            name:'当前已办',
            type:'pie',
            radius : '60%',
            center: ['50%', '60%'],
            data:<%=request.getAttribute("series")%>
        }
    ]
};
                    
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
</body>