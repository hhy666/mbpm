<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
   </head>
   <body style="height: 100%; margin: 0">
       <div id="container" style="height: 100%"></div>
       <script src="<%=path %>/js/echarts.js"></script>
       <script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};
option = null;
app.title = '折柱混合';

option = {
    tooltip: {
        trigger: 'axis'
    },
    toolbox: {
        feature: {
            dataView: {show: true, readOnly: false},
            magicType: {show: true, type: ['line', 'bar','stack','tiled']},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    legend: {
        data:<%=request.getAttribute("legend")%>
    },
    xAxis: [
        {
            type: 'category',
            data: <%=request.getAttribute("xAxis")%>
        }
    ],
    yAxis: [
        {
            type: 'value',
            name: '',
            min: 0,
            axisLabel: {
                formatter: '{value} min'
            }
        },
        {
            type: 'value',
            name: '',
            axisLabel: {
                formatter: '{value} %'
            }
        }
    ],
    series: [
        {
            name:'运行时长',
            type:'bar',
            data:<%=request.getAttribute("series_1")%>
        },
        {
            name:'平均效率',
            type:'line',
            yAxisIndex: 1,
            data:<%=request.getAttribute("series_2")%>
        }
    ]
};
;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
       </script>
   </body>
</html>