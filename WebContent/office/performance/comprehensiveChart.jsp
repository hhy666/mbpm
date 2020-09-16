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
            data: <%=request.getAttribute("xAxis")%>,
            axisLabel:{  
                         interval:0 ,  
                         formatter:function(val){  
                          return val.split("").join("\n");  
                         }  
                       }  
        }
    ],
    yAxis: [
        {
            type: 'value',
            name: '',
            axisLabel: {
                formatter: '{value}'
            }
        },
        {
            type: 'value',
            name: '',
            interval: 500,
            axisLabel: {
                formatter: '{value}'
            }
        }
    ],
    series: [
        {
            name:'运行效率',
            type:'bar',
            data:<%=request.getAttribute("series_1")%>
        },
        {
            name:'超时率',
            type:'bar',
            data:<%=request.getAttribute("series_2")%>
        },
        {
            name:'调用次数',
            type:'line',
            yAxisIndex: 1,
            data:<%=request.getAttribute("series_3")%>
        },
        {
            name:'超时次数',
            type:'line',
            yAxisIndex: 1,
            data:<%=request.getAttribute("series_4")%>
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