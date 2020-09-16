<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H5条件公式设置页面</title>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href="<%=path %>/css/themes/default/style.min.css" rel="stylesheet"/>
<link href='<%=path %>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/assets/toastr-master/toastr.min.css' rel="stylesheet"></link>

<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src='<%=path %>/resource/html5/js/icheck.min.js'></script>
<script src='<%=path %>/resource/html5/js/autosize.min.js'></script>
<script src="<%=path %>/resource/html5/js/matrix_runtime.js"></script>
<script src='<%=path %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<script src='<%=path %>/resource/html5/js/layer.min.js'></script>
<script src='<%=path %>/resource/html5/js/matrix_runtime.js'></script>
<style type="text/css">
	body, ul{
	    margin: 0;
	    padding: 0;
	    color: #333;
	    font-family: "Helvetica Neue", "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", 微软雅黑, Arial, sans-serif;
	    font-size: 12px;
	    list-style-type: none;
	}
	div, ul{
		box-sizing: border-box;
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	.title{
		width: 100%;
	    height: 30px;
	    background: #F8F8F8;
	}
	.font{
		font-size: 12px;
	    margin-left: 5px;
	    font-weight: bold;
	    line-height: 30px;
	}
	#container{
	    position: absolute;
	    height: 100%;
	    width: 100%;
	    padding: 10px 10px 0px 10px;
	}
	#head{
		height: 30px;
	}
	#content{
		position: absolute;
		height: calc(100% - 64px);
		width: calc(100% - 20px);
	}
	#left-content,#right-content{
	   position: absolute;
	   width: 160px;
	   height: 100%;  
	   border: 1px solid #cccccc;
	   border-bottom: 0px;
	}
	#left-content{
		left: 0px;
	}
	#right-content{
		right: 0px;
	}
	#center-content{
		margin:0px 160px;
		height: 100%;  
	}
	.field-list{
		height: calc(100% - 30px);
	}
	.field-category{
		list-style-type: none;
	}
	.field-title {
	    cursor: pointer;
	    height: 30px;
	    line-height: 30px;
	    background-color: #f3f1f1;
	    border: 1px solid #e6e4e4;
	}
	.field-children {
		height: calc(100% - 30px);
	    overflow: auto;
	    -webkit-transition: height 218ms ease-in-out;
	    -moz-transition: height 218ms ease-in-out;
	    -o-transition: height 218ms ease-in-out;
	    transition: height 218ms ease-in-out;
	}
	.formula-list{
		height: calc(100% - 30px);
		padding-left: 10px;
	    overflow: auto;
	}
	.field-item {
	    padding-left: 22px;
	    cursor: pointer;
	    white-space: nowrap;
	    height: 24px;
	    line-height: 24px;
	    list-style-type: none;
	}
	.formula-category{
		list-style-type: none;
	}
	.formula-title {
	    cursor: pointer;
	    -webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	    height: 24px;
	    line-height: 24px;
	}
	.formula-children {
	    overflow: hidden;
	    -webkit-transition: height 218ms ease-in-out;
	    -moz-transition: height 218ms ease-in-out;
	    -o-transition: height 218ms ease-in-out;
	    transition: height 218ms ease-in-out;
	}
	.formula-item {
	    padding-left: 22px;
	    cursor: pointer;
	    white-space: nowrap;
	    height: 24px;
	    line-height: 24px;
	    user-select: none;
	    list-style-type: none;
	}
	.code-area{
		height:calc(100% - 160px);
	}
	.compare-area{
		height: 80px;
		overflow: auto;
	}
	.explain-area{
		height: 80px;
		padding: 5px 10px 0px 10px;
		border-top: 1px solid #cccccc;
		overflow: auto;
	}
	.compare-btn{
		display: inline-block;
		margin-top: 5px;
	    color: #248AF9;
	    background: rgba(36,138,249,.1);
	    cursor: pointer;
	    text-align: center;
	    padding: 0 8px;
	    height: 30px;
	    line-height: 28px;
	    width: 40px;
	    -webkit-border-radius: 10px;
	    -moz-border-radius: 10px;
	    border-radius: 5px;
	}
	.compare-btn:hover {
	    background-color: #ebebeb;
	    border-color: #ccc;
	}
	.extend-btn{
		display: inline-block;
		margin-top: 5px;
	    color: #248AF9;
	    background: rgba(36,138,249,.1);
	    cursor: pointer;
	    text-align: center;
	    padding: 0 8px;
	    height: 30px;
	    line-height: 28px;
	    width: 40px;
	    -webkit-border-radius: 10px;
	    -moz-border-radius: 10px;
	    border-radius: 3px;
	}
	.extend-btn:hover {
	    background-color: #ebebeb;
	    border-color: #ccc;
	}
	.form-control {
	   	 border-radius: 0;
	} 	
	::-webkit-scrollbar {    
	     width:4px;  
	     height:5px;   
	}  
</style>
<script type="text/javascript">
	
	var explainMap = {};
	explainMap['int'] = '功能：取选中数的整数位<br>示例：getInt({[主表]数字框})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，再点击左侧表单数据域下要取整的数字框。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['mod'] = '功能：取公式算出后的余数<br>示例：getMod({[主表]数字框1},{[主表]数字框2})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置被除数（第一个参数）与除数（第二个参数），用逗号分割。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['square'] = '功能：取选中数开根号后的值<br>示例：getSquare({[主表]数字框})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，再点击左侧表单数据域下要开根号的数字框。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['log'] = '功能：取公式算出后的对数<br>示例： getLog({[主表]数字框1},{[主表]数字框2})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置真数（第一个参数）与对数的底（第二个参数），用逗号分割。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['pow'] = '功能：取公式经过幂运算后的值<br>示例：  getPow({[主表]数字框1},{[主表]数字框2})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置底数（第一个参数）与指数（第二个参数），用逗号分割。	若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['max'] = '功能：取各个数字中的最大值,参数可以多个<br>示例： getMax({[主表]数字框1},{[主表]数字框2})==100<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要从中选取最大值的数字框，用逗号分割，没有数量上限。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['min'] = '功能：取各个数字中的最小值,参数可以多个<br>示例： getMin({[主表]数字框1},{[主表]数字框2})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要从中选取最小值的数字框，用逗号分割，没有数量上限。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['aver'] = '功能：取各个数字的平均值,参数可以多个<br>示例： getAver({[主表]数字框1},{[主表]数字框2})==100<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要取平均数的数字框，用逗号分割，没有数量上限。若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['getConvertToLowNum'] = '功能：取文本框中的大写金额转成小写阿拉伯数字<br>示例： getConvertToLowNum({[主表]数字框})<br>操作：光标选中左侧表单数据域下要转小写的文本框，然后点击右侧函数列表的函数。';
	explainMap['getConvertToUpNum'] = '功能：取数字框中的小写阿拉伯数字转成大写金额，只能用于数据计算<br>示例： getMax({[主表]数字框})<br>操作：光标选中左侧表单数据域下要转大写的数字框，然后点击右侧函数列表的函数。';
	explainMap['containStr'] = '功能：判断某个文本框内的字符是否包含某字符串<br>示例： containStr({[主表]文本框},\'as\')<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要判断的文本框，然后再填写要判断是否包含的字符串，用逗号分割。';
	explainMap['strLength'] = '功能：判断某个文本框字符串的长度<br>示例： strLength({[主表]文本框})==1<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要判断的文本框，然后再填写要判断是否包含的字符串，用逗号分割。';
	explainMap['subStrStart'] = '功能：判断某个文本框字符串的头几位<br>示例：\'subStrStart({[主表]用途},3)\' == \'as\'<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要判断的文本框，然后再填写要判断的字符串，用逗号分割。在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['subStrEnd'] = '功能：判断某个文本框字符串的末几位<br>示例： \'subStrEnd({[主表]用途},2)\' == \'as\'<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要判断的文本框，然后再填写要判断的字符串，用逗号分割。在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['upperCase'] = '功能：取文本框中的小写英文字母转成大写英文字母，只能用于数据计算<br>示例： toUpperCase({[主表]文本框})<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要转换的文本框。';
	explainMap['lowerCase'] = '功能：取文本框中的大写英文字母转成小写英文字母，只能用于数据计算<br>示例： toLowerCase({[主表]文本框})<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要转换的文本框。';
	explainMap['multiDep'] = '功能：判断选择的部门是否符合条件<br>示例：{部门包含(\'发起人部门编码\',\'部门1\')}<br>操作：点击右侧函数列表的函数，弹出设置部门条件窗口，选择完毕确定之后，内容区生成公式。';
	explainMap['multiRole'] = '功能：判断选择的角色是否符合条件<br>示例： {角色包含(\'发起人角色编码\',\'系统管理员\')}<br>操作：点击右侧函数列表的函数，弹出设置角色条件窗口，选择完毕确定之后，内容区生成公式。';
	explainMap['currentDep'] = '功能：取任一部门的编码<br>示例：{部门(部门1)}<br>操作：点击右侧函数列表的函数，弹出设置部门条件窗口，选择想要获取编码的部门后，在内容区生成公式。';
	explainMap['singleRole'] = '功能：取任一角色的编码<br>示例： {角色(系统管理员)}<br>操作：点击右侧函数列表的函数，弹出设置角色条件窗口，选择想要获取编码的角色后，在内容区生成公式。';
	explainMap['singlePerson'] = '功能：取任一人员的编码<br>示例： {人员(用户1)}<br>操作：点击右侧函数列表的函数，弹出设置人员条件窗口，选择想要获取编码的人员后，在内容区生成公式。';
	explainMap['year'] = '功能：即取日期中的年份<br>示例： year([系统日期])==2020<br>操作：点击右侧函数列表的函数，弹出取年窗口，在表单域下拉框中，选择要取年的主表日期框或者其他日期变量，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['month'] = '功能：即取日期中的月份<br>示例： month([系统日期])==9<br>操作：点击右侧函数列表的函数，弹出取月窗口，在表单域下拉框中，选择要取月的主表日期框或者其他日期变量，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['day'] = '功能：即取日期中的日<br>示例：  day([系统日期])==27<br>操作：点击右侧函数列表的函数，弹出取日窗口，在表单域下拉框中，选择要取日的主表日期框或者其他日期变量，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['weekDay'] = '功能：取所选日期的星期数。<br>示例： weekDay([系统日期])==5<br>操作：点击右侧函数列表的函数，弹出取星期窗口，在表单域下拉框中，选择要取星期的主表日期框或者其他日期变量，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['season'] = '功能：取所选日期的季度数<br>示例： season([系统日期])==3<br>操作：点击右侧函数列表的函数，弹出取季窗口，在表单域下拉框中，选择要取季度数的主表日期框或者其他日期变量，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['date'] = '功能：取所选变量的日期<br>示例： \'date({[主表]日期框})\'==\'2019-09-27\'<br>操作：点击左侧可用变量中要取日期的字段，可以是表单数据域也可以是日期变量中的。然后在右侧点击函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['time'] = '功能：取所选变量的时间<br>示例： \'time({[主表]日期框})\'==\'20:00\'<br>操作：点击左侧可用变量中要取时间的字段，可以是表单数据域也可以是日期变量中的。然后在右侧点击函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['datediff'] = '功能：取两个日期之间差的天数<br>示例： differDate({[主表]日期框},[系统日期])==0<br>操作：点击右侧函数列表的函数，弹出日期差窗口，在两个表单域下拉框中，选择要计算日期差的两个日期，选择后确定在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['total'] = '功能：统计重复表某一项的合计<br>示例：  sum({[重复表]重复表数字框})==500<br>操作：点击选中左侧表单数据域下要合计的重复表的变量，然后点击右侧函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['avg'] = '功能：统计重复表某一项的平均值<br>示例： aver({[重复表]重复表数字框})==3<br>操作：点击选中左侧表单数据域下要计算平均数的重复表的变量，然后点击右侧函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['count'] = '功能：统计重复表项数<br>示例： count({[重复表]重复表数字框})==333<br>操作：点击选中左侧表单数据域下要计算项数的重复表的变量，然后点击右侧函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['maxRepeat'] = '功能：统计重复表某一项的最大值<br>示例： max({[重复表]重复表数字框})==100<br>操作：点击选中左侧表单数据域下要计算最大值的重复表的变量，然后点击右侧函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['minRepeat'] = '功能：统计重复表某一项的最小值<br>示例：  min({[重复表]重复表数字框})==50<br>操作：点击选中左侧表单数据域下要计算最小值的重复表的变量，然后点击右侧函数，在内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['sumif'] = '功能：统计重复表某一项符合某一条件的的合计<br>示例： sumif({[重复表]重复表数字框},$[{[重复表]重复表数字框}==100]$)==300<br>操作：点击选中左侧表单数据域下要统计的变量，然后点击右侧函数，弹出条件窗口，选择左侧表单数据域下要作为统计条件的变量，然后在公式后选择下侧工具栏区中运算符再手动键入条件即可，确定后内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['averif'] = '功能：统计重复表某一项符合某一条件的平均值<br>示例：  averif({[重复表]重复表数字框},$[{[重复表]重复表数字框}>100]$)==200<br>操作：点击选中左侧表单数据域下要统计的变量，然后点击右侧函数，弹出条件窗口，选择左侧表单数据域下要作为统计条件的变量，然后在公式后选择下侧工具栏区中运算符再手动键入条件即可，确定后内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['countif'] = '功能：统计重复表某一项符合某一条件的项数<br>示例：  countif({[重复表]重复表数字框},$[{[重复表]重复表数字框}==100]$)==3<br>操作：点击选中左侧表单数据域下要统计的变量，然后点击右侧函数，弹出条件窗口，选择左侧表单数据域下要作为统计条件的变量，然后在公式后选择下侧工具栏区中运算符再手动键入条件即可，确定后内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['maxif'] = '功能：统计重复表某一项符合某一条件的最大值<br>示例： maxif({[重复表]重复表数字框},$[{[重复表]重复表数字框}>100]$)==500<br>操作：点击选中左侧表单数据域下要统计的变量，然后点击右侧函数，弹出条件窗口,选择左侧表单数据域下要作为统计条件的变量，然后在公式后选择下侧工具栏区中运算符再手动键入条件即可，确定后内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动补充完成条件即可。';
	explainMap['minif'] = '功能：统计重复表某一项符合某一条件的最小值<br>示例：  maxif({[重复表]重复表数字框},$[{[重复表]重复表数字框}<100]$)==30<br>操作：点击选中左侧表单数据域下要统计的变量，然后点击右侧函数，弹出条件窗口,选择左侧表单数据域下要作为统计条件的变量，然后在公式后选择下侧工具栏区中运算符再手动键入条件即可，确定后内容区生成公式，若要用此公式做校验，可在公式后选择下侧工具栏区中运算符再手动补充完成条件即可。';
	explainMap['anyRow'] = '功能：判断重复表某一变量任一行是否符合条件<br>示例： ifAnyRow({[重复表]重复表数字框}==100)<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，再点击左侧表单数据域下要判断的重复表变量，然后在变量后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['allRow'] = '功能：判断重复表某一变量所有行是否符合条件<br>示例：  ifAllRow({[重复表]重复表数字框}==100)<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，再点击左侧表单数据域下要判断的重复表变量，然后在变量后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['currentProcess'] = '功能：判断当前流程编码是否符合条件<br>示例： getCurProcessId()==\'1568268064378004\'<br>操作：点击右侧函数列表的函数，在内容区生成公式，然后在变量后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['currentActivity'] = '功能：判断当前活动编码是否符合条件<br>示例： getCurActId()==\'mFlow030\'<br>操作：点击右侧函数列表的函数，在内容区生成公式，然后在变量后选择下侧工具栏区中运算符再手动键入条件即可。';
	explainMap['isNull'] = '功能：判断某一变量为空<br>示例：  isNull({[主表]文本框})<br>操作：点击选中左侧表单数据域下要合计的重复表的变量，然后点击右侧函数，在内容区生成公式。';
	explainMap['isNotNull'] = '功能：判断某一变量不为空<br>示例：  isNotNull({[主表]文本框})<br>操作：点击选中左侧表单数据域下要合计的重复表的变量，然后点击右侧函数，在内容区生成公式。';
	explainMap['serialNumbe'] = '功能：根据规则自动生成流水号，一般只用于触发事件<br>示例： getNextSeqNo({流水号(物品申领单号)})<br>操作：点击右侧函数列表的函数，弹出设置流水号窗口，选中想要生成的流水号，点击确定则在内容区生成。';
	explainMap['like'] = '功能：数据管理的系统查询条件时判断主表字段是否包含某个值<br>示例： {[主表]文本框} like \'%str%\' <br>操作：点击选中左侧表单数据域下文本类型的字段，然后点击右侧函数，弹出条件窗口，然后在再手动键入条件即可，确定在内容区生成公式';
	explainMap['not_like'] = '功能：数据管理的系统查询条件时判断主表字段是否不包含某个值<<br>示例： {[主表]文本框} not_like \'%str%\' <br>操作：点击选中左侧表单数据域下文本类型的字段，然后点击右侧函数，弹出条件窗口，然后在再手动键入条件即可，确定在内容区生成公式';
	explainMap['selectCount'] = '功能：判断复选框组或多选下拉框的选中项个数<br>示例： selectCount({[主表]复选框组})==2<br>操作：点击右侧函数列表的函数，在内容区生成公式，光标选中在公式括号中，然后在左侧表单数据域下设置要计算的变量字段。';
	
	var typeJsonObj;    //本身表单数据域+类型
	var optionJsonStr;  //本身表单数据域+下拉框基本代码
	var typeJsonObjTwo;    //关联表单数据域+类型
	var optionJsonStrTwo;  //关联表单数据域+下拉框基本代码
	var depVariable = [];
	var isRelation = false;   //是否带有b表的关联表单 默认false
	
	$(function(){ 
		$("#formulaStr").val("${firstCondition}");     //初始条件带入文本域
		
		var typeJsonStr = "${typeJsonStr}";     
		if(typeJsonStr != ''){
			typeJsonObj = eval("("+typeJsonStr+")");
		}
		optionJsonStr = "${optionJsonStr}";   
		
		for(var key in typeJsonObj){
			if(typeJsonObj[key]==25 ||typeJsonObj[key]==26){
				depVariable.push(key);
			}
		}
		
		var entrance = $("#entrance").val();   //哪个位置的条件入口  
		$("#head").hide();  //默认不显示头部普通设置和高级设置单选按钮组
		$(".tools").children().eq(3).hide();
		$(".tools").children().eq(4).hide();
		if(entrance == 'DataFilter' || entrance == 'DataCopyTextBox'){    //数据代入设置过滤条件     触发事件数据拷贝设置文本框弹出条件时有关联表单
			isRelation = true;
		}else if(entrance == 'RepeatTableClassify'){     //设置重复表分类条件 没有重复表  流程函数
			$(".repeat").parent().hide();
			$(".process").parent().hide();
		}else if(entrance == 'GeneralFormula'){    //数据计算计算公式普通设置入口
			$("#head").show();
			$("#content").css("height","calc(100% - 94px)");
		}else if(entrance == 'MessageTemplate' || entrance == 'FormProcessTitle'){    //触发事件选择消息模板入口  || 设置表单流程标题
			$('#right-content').hide();
			$(".compare-area").hide();
			$(".explain-area").hide();
			$('.code-area').css('height','100%');
			$('#center-content').css({"marginLeft":"150px","marginRight":"0px"});
		}else if(entrance == 'ManageSysCondition'){    //应用查询设置系统查询条件入口   只有工具函数且没有流水号
			$(".number").parent().hide();
			$(".char").parent().hide();
			$(".org").parent().hide();
			$(".date").parent().hide();
			$(".repeat").parent().hide();
			$(".process").parent().hide();
			
			$(".tools").children().eq(0).hide();
			$(".tools").children().eq(1).hide();
			$(".tools").children().eq(2).hide();
			$(".tools").children().eq(3).show();
			$(".tools").children().eq(4).show();
		}
		
		//默认不显示b表表单数据域(有关联表单功能的时候才显示)
		$("#b_title").parent().hide();
		if(isRelation){     //带关联表单
			var typeJsonStrTwo = "${typeJsonStrTwo}";	//关联表单数据域+类型
			if(typeJsonStrTwo != ''){
				typeJsonObjTwo = eval("("+typeJsonStrTwo+")");
			}
			optionJsonStrTwo = "${optionJsonStrTwo}";   //关联表单数据域+下拉框基本代码
			
			//隐藏掉重复表函数
			if(entrance == 'DataFilter'){   //数据带入时设置过滤条件隐藏掉重复表   其他情况都要显示重复表
				$(".repeat").parent().hide();
			}
			//修改标题为a表
			$("#a_title").html("<i class=\"glyphicon glyphicon-triangle-right\" style=\"color: #C9CED9;margin-right: 3px;\"></i>(简称a表)表单数据域");
			//显示b表表单数据域
			var operateType = $("#operateType").val();  //add为触发事件添加操作 update为修改操作  add时不显示b表数据域
			if(operateType != 'add'){
				$("#b_title").parent().show();
				$("#hasB").val('true');
			}else{
				$("#b_title").parent().hide();
			}
		}
		
		//初始默认不展开下拉列表子项
		$(".field-children").hide();
		$(".formula-children").hide();
	    
		//左侧数据域下拉列表
		$(".field-title").click(function(){
			var hasB = $("#hasB").val();
			//清空选中
			$(".changeColor").removeClass("changeColor");
			if($(this).next("ul").is(':hidden')){  //展开
				$('.glyphicon-triangle-right').removeClass("glyphicon-triangle-right");
				$('.glyphicon-triangle-bottom').removeClass("glyphicon-triangle-bottom");
				$('.glyphicon').addClass("glyphicon-triangle-right");
				$(this).children(":first").removeClass("glyphicon-triangle-right");
				$(this).children(":first").addClass("glyphicon-triangle-bottom");
				$(".field-children").hide();
				$(this).next("ul").show();
				$('.field-category').css("height","");
				if(hasB == 'true'){
					$(this).parent().css("height","calc(100% - 90px)");
				}else{
					$(this).parent().css("height","calc(100% - 60px)");
				}
			}else{   //收缩
				$('.glyphicon-triangle-right').removeClass("glyphicon-triangle-right");
				$('.glyphicon-triangle-bottom').removeClass("glyphicon-triangle-bottom");
				$('.glyphicon').addClass("glyphicon-triangle-right");
				$(this).children(":first").removeClass("glyphicon-triangle-bottom");
				$(this).children(":first").addClass("glyphicon-triangle-right");
				$(".field-children").hide();
				$(this).next("ul").hide();
				$(this).parent().css("height","");
			}
		});
		
		//右侧函数下拉列表
		$(".formula-title").click(function(){
			if($(this).next("ul").is(':hidden')){	 //展开
				$('.glyphicon-triangle-right').removeClass("glyphicon-triangle-right");
				$('.glyphicon-triangle-bottom').removeClass("glyphicon-triangle-bottom");
				$('.glyphicon').addClass("glyphicon-triangle-right");
				$(this).children(":first").removeClass("glyphicon-triangle-right");
				$(this).children(":first").addClass("glyphicon-triangle-bottom");
				$(".formula-children").hide();
				$(this).next("ul").show();
			}else{		//收缩
				$('.glyphicon-triangle-right').removeClass("glyphicon-triangle-right");
				$('.glyphicon-triangle-bottom').removeClass("glyphicon-triangle-bottom");
				$('.glyphicon').addClass("glyphicon-triangle-right");
				$(this).children(":first").removeClass("glyphicon-triangle-bottom");
				$(this).children(":first").addClass("glyphicon-triangle-right");
				$(".formula-children").hide();
				$(this).next("ul").hide();
			}
		});

		//监听高级设置,切换到高级设置模式
		$("input:radio[name='modelSet']").on('ifChecked', function(event){
			var value = $(this).val();  //1.普通设置。2.高级设置。
		    if(value == 2){
			   var formulaStr = document.getElementById("formulaStr").value;
			   var iframewindowid = $("#iframewindowid").val();
			   var suffixId = $("#suffixId").val();
			   var index = $("#index").val();
 		  	   if(formulaStr == "" || formulaStr == null){
 		  		  window.location.href="<%=request.getContextPath()%>/form/admin/custom/condition/advancedSet.jsp?iframewindowid="+iframewindowid+"&flag=${param.flag}&suffixId="+suffixId+"&index="+index+"";
 		  	   }else{
 		  		  layer.confirm("切换会使计算式丢失,是否继续？？", {
 				     btn: ['确定','取消'],  //按钮
 				     closeBtn:0
 		          },function(winId){
 		        	 window.location.href="<%=request.getContextPath()%>/form/admin/custom/condition/advancedSet.jsp?iframewindowid="+iframewindowid+"&flag=${param.flag}&suffixId="+suffixId+"&index="+index+"";		        	
 		          },function(winId){
 		        	  $("#nomalSet").iCheck('check');
 		        	  $("#advancedSet").iCheck('uncheck');      	
 		          })
 		  	  }
		    }	     
		});
		
		//监听操作符按钮点击事件
		$(".compare-btn").click(function(){
			var opration = $(this).children(":first").text();
			if(opration == '空值'){
				doit('null');
			}else{
				doit(opration);
			}
		});
		//监听扩展按钮点击事件
		$(".extend-btn").click(function(){
			showExtend();
		});
		
		//监听变量列表li
		$(".field-item").click(function(){
			$(this).addClass("changeColor").siblings().removeClass("changeColor");
		}).dblclick(function(){
			dblClickField($(this));
		});
		
		//函数列表li 鼠标指针悬停事件
		$(".formula-item").hover(function(){
			$(this).addClass("changeColor").siblings().removeClass("changeColor");
			var text = $(this).text();
			var type = $(this).attr("area-type");
			
			var explainStr;
			for(var key in explainMap){
				if(key == type){
					explainStr = explainMap[key]
					break; 
				}
			}
			$(".explain-area").html(explainStr);
		})
		//监听数字函数
		$(".number .formula-item").click(function(){
			var type = $(this).attr("area-type");
			if(type == 'toUpNum'){   //大写转小写
				getConvertToLowNum();
			}else if(type == 'toLowNum'){       //小写转大写
				getConvertToUpNum();
			}else{
				var value = $(this).attr("area-text");
				addSpace(value);
			}
		})
		//监听字符函数
		$(".char .formula-item").click(function(){
			var value = $(this).attr("area-text");
			addSpace(value);
		})
		//监听组织机构
		$(".org .formula-item").click(function(){
			openOrgWin($(this));
		})
		//监听日期函数
		$(".date .formula-item").click(function(){
			var type = $(this).attr("area-type");
			if(type == 'year'){   //取年
				var title = "取年";
				openGetWin(title);
				Matrix.setFormItemValue('type','year');
				
			}else if(type == 'month'){  //取月
				var title = "取月";
				openGetWin(title);
				Matrix.setFormItemValue('type','month');
				
			}else if(type == 'day'){   //取日
				var title = "取日";
				openGetWin(title);
				Matrix.setFormItemValue('type','day');
				
			}else if(type == 'weekDay'){  //取星期几
				var title = "取星期几";
				openGetWin(title);
				Matrix.setFormItemValue('type','weekDay');
				
			}else if(type == 'season'){   //取季
				var title = "取季";
				openGetWin(title);
				Matrix.setFormItemValue('type','season');
				
			}else if(type == 'date'){   //取日期
				getDate();
			
			}else if(type == 'time'){   //取时间
				getTime();
			
			}else if(type == 'datediff'){   //日期差
				showDaySub();
			}
		})
		//监听重复表
		$(".repeat .formula-item").click(function(){
			var type = $(this).attr("area-type");
			if(type == 'total'){   //重复表合计
				subTotal();
			}else if(type == 'avg'){   //重复表平均值
				subAvg();
			}else if(type == 'count'){  //重复表项数
				subCount();
			}else if(type == 'maxRepeat'){   //重复表最大值
				subMax();
			}else if(type == 'minRepeat'){   //重复表最小值
				subMin();
			}else if(type == 'sumif'){   //重复表分类合计
				subClassify(type);
			}else if(type == 'averif'){   //重复表分类平均值
				subClassify(type);
			}else if(type == 'countif'){   //重复表分类项数
				subClassify(type);
			}else if(type == 'maxif'){    //重复表分类最大值
				subClassify(type);
			}else if(type == 'minif'){    //重复表分类最小值
				subClassify(type);
			}else if(type == 'anyRow'){   //重复表任一行
				ifAnyRow();
			}else if(type == 'allRow'){   //重复表所有行
				ifAllRow();
			}
		})
		//监听流程函数
		$(".process .formula-item").click(function(){
			var type = $(this).attr("area-type");
			if(type == 'currentActivity'){   //当前活动
				addSpace("getCurActId()");
			}else if(type == 'currentProcess'){
				addSpace("getCurProcessId()");
			}
			
		})
		//监听工具函数
		$(".tools .formula-item").click(function(){
			var type = $(this).attr("area-type");
			if(type == 'isNull'){   //为空
				isNull();
			}else if(type == 'isNotNull'){  //不为空
				isNotNull();
			}else if(type == 'serialNumbe'){  //流水号
				showSerialNumber();
			}else if(type == 'like'){  //包含
				showIncluding(type);
			}else if(type == 'not_like'){  //不包含
				showIncluding(type);
			}else if(type == 'selectCount'){  //选中项数
				addSpace("selectCount()");
			}
		})
		
	});
	
	function getDepVariable(){
		return JSON.stringify(depVariable); ;
	}
	
	function getOptionJsonStr(){
		return optionJsonStr;
	 }
	
	 //选中的变量值
    function checkvalue(){
    	var value;
    	if($('#fieldSelect').is(':visible')){       
		   var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
		   value = select.attr("area-text");   //选中的表单数据域值
	    }
    	if($('#associatedSelect').is(':visible')){       
  		   var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
  		   value = select.attr("area-text");   //选中的表单数据域值
  	    }
	    return value;
    }
	 
	//双击左侧变量列表 或 点击右侧函数
	function dblClickField(element){
		debugger;
		var value;
		if(element.value){
			value = element.value
		}else{
			var type = element.attr("area-type");   //1.表单数据域  2.组织机构变量   3.日期变量
			value = element.attr("area-text");
			if(type == 1 || type == 4){
				value = "{" + value + "}";//防止编码与值互相转换时有包含字符替换错误
			}else if(type == 2 || type == 3){
				value = "[" + value + "]";
			}
		}
		addSpace(value);
	  }
	
	//操作符按钮点击
  	function doit(opration){   
	  	var obj = document.getElementById("formulaStr");
	  	if(document.selection){
	  		var sel = document.selection.createRange(); 
	  		sel.text = opration; 
	  	}else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number'){
	  		var startPos = obj.selectionStart, 
				endPos = obj.selectionEnd, 
				cursorPos = startPos, 
				tmpStr = obj.value; 
	  		if(tmpStr == ""){
	  			cursorPos += opration.length;
	  			obj.value = opration + tmpStr.substring(endPos, tmpStr.length); 
	  		}else{
	  			obj.value = tmpStr.substring(0, startPos) + " " + opration + tmpStr.substring(endPos, tmpStr.length); 
	  			cursorPos += opration.length+1; 
	  		}
	  		obj.selectionStart = obj.selectionEnd = cursorPos; 
	  	}else{
	  		obj.value += opration; 
	  	}
	  	obj.focus();
	 }
	
  	 //Extend选项(有关联表单的提示信息不一样)
	  function showExtend(){
		  if(isRelation){
			  if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				  if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						 Matrix.warn("请选择a表字段");
					  	 return;
					  }
					  var value = select.attr("area-text");   //选中的表单数据域
					  var editorType = typeJsonObj[value];    //表单数据类型
					  layer.open({
					    	id:'layer03',
							type : 2,
							
							title : ['扩展设置'],
							shadeClose: false, 
							area : [ '80%', '100%' ],
							content : "<%=path%>/editor/common/extend.jsp?iframewindowid=layer03&editorType="+editorType
					  });
					  
				  }
				  if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					  var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						 Matrix.warn("请选择b表字段");
					  	 return;
					  }
					  var value = select.attr("area-text");   //选中的表单数据域
					  var editorType = typeJsonObjTwo[value];    //表单数据类型
					  layer.open({
					    	id:'layer03',
							type : 2,
							
							title : ['扩展设置'],
							shadeClose: false, 
							area : [ '80%', '100%' ],
							content : "<%=path%>/editor/common/extend.jsp?iframewindowid=layer03&editorType="+editorType
					  });
					  
				  }
			  }else{
				  Matrix.warn("请选择字段");
				  return;
			  }		
		  }else{
			  if($('#fieldSelect').is(':visible')){     //选择表单数据域时
				  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
				  if(select==null || select.length==0){
					 Matrix.warn("请选择字段");
				  	 return;
				  }
				  var value = select.attr("area-text");   //选中的表单数据域
				  var editorType = typeJsonObj[value];    //表单数据类型
				  layer.open({
				    	id:'layer03',
						type : 2,
						
						title : ['扩展设置'],
						shadeClose: false, 
						area : [ '80%', '99%' ],
						content : "<%=path%>/editor/common/extend.jsp?iframewindowid=layer03&editorType="+editorType
				  });
				  
			  }else{
				  Matrix.warn("请选择字段");
				  return;
			  }			  
		  }
	  }
  	 
	  //Extend选中数据回调
	  function onlayer03Close(data){
		  if(data!=null){
			  var name=data.name;
			  var obj = document.getElementById("formulaStr");
  			  if(obj==null || obj==''){
  				 obj = "";
  			  }
  			  addSpace(name);
		  }
	  }
  	 
	//组织机构弹出窗口
	function openOrgWin(element){
		var type = element.attr("area-type"); 
		if(type == 'multiDep'){   //包含部门
			layer.open({
		    	id:'layer01',
				type : 2,
				
				title : ['设置部门条件'],			
				shadeClose: false, 
				area : [ '96%', '96%' ],
				content : "<%=path%>/editor/common/selectCondition.jsp?iframewindowid=layer01&condition=depCondition"
			});
		}else if(type == 'multiRole'){   //包含角色
			layer.open({
		    	id:'layer02',
				type : 2,
				
				title : ['设置角色条件'],
				shadeClose: false, //开启遮罩关闭
				area : [ '96%', '96%' ],
				content : "<%=path%>/editor/common/selectCondition.jsp?iframewindowid=layer02&condition=roleCondition"
			});
		}else if(type == 'singleDep'){   //取部门(已废弃)
			layer.open({
		    	id:'layer05',
				type : 2,
				
				title : ['设置部门条件'],
				shadeClose: false, 
				area : [ '80%', '80%' ],
				content : "<%=path%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer05"
			});
		}else if(type == 'singleRole'){   //取角色
			layer.open({
		    	id:'layer06',
				type : 2,
				
				title : ['设置角色条件'],
				shadeClose: false, 
				area : [ '80%', '80%' ],
				content : "<%=path%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer06"
			});
		}else if(type == 'singlePerson'){  //取人员
			 layer.open({
		    	id:'layer04',
				type : 2,
				
				title : ['设置人员条件'],
				shadeClose: false,
				area : [ '80%', '90%' ],
				content : "<%=path%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layer04"
			});
		}else if(type == 'currentDep'){  //当前部门
			 layer.open({
			    	id:'layer08',
					type : 2,
					
					title : ['设置部门条件'],
					shadeClose: false,
					area : [ '80%', '80%' ],
					content : "<%=path%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer08"
				});
			}
	}
	
	//包含部门部门角色弹出窗口回调
  	function MultiDepClose(result){
		if(result!=null){
			var name = result.name;
 			var obj = document.getElementById("formulaStr");
 			if(obj==null || obj==''){
 				obj = "";
 			}
 			addSpace(name);
		}
		var children = $("div[id^='layui-layer']");
		for(i = 0; i < children.length; i++){
	       children[i].style.display="none";
	    }
	 }
	
    //单选部门回调
    function onlayer05Close(data){
		if(data!=null){
			var name = data.names;
			var prefixName="";
			var obj = document.getElementById("formulaStr");
			if(obj==null || obj==''){
				obj = "";
			}
			prefixName=prefixName+"{部门(";
			prefixName=prefixName+name;
			prefixName=prefixName+")}";
			addSpace(prefixName)
		}
    }
    //单选角色回调
    function onlayer06Close(data){
		if(data!=null){
			var name = data.names;
			var prefixName="";
			var obj = document.getElementById("formulaStr");
			if(obj==null || obj==''){
				obj = "";
			}
			prefixName=prefixName+"{角色(";
			prefixName=prefixName+name;
			prefixName=prefixName+")}";
			
			addSpace(prefixName);
		}
   }
    //单选人员回调
    function onlayer04Close(data){
		if(data!=null){
			var name = data.names;
			var prefixName="";
			var obj = document.getElementById("formulaStr");
			if(obj==null || obj==''){
				obj = "";
			}
			prefixName=prefixName+"{人员(";
			prefixName=prefixName+name;
			prefixName=prefixName+")}"
			
			addSpace(prefixName);
		}
	 }
  	 //当前部门回调
	 function onlayer08Close(data){
		 if(data!=null){
			var name = data.names;
			var prefixName="";
			var obj = document.getElementById("formulaStr");
			if(obj==null || obj==''){
				obj = "";
			}
			prefixName=prefixName+"{部门(";
			prefixName=prefixName+name;
			prefixName=prefixName+")}";
			
			addSpace(prefixName);
		}
	 } 
	
    //弹出取年  取月 取日 取星期几 取季 选择窗口
    function openGetWin(title){
    	var entrance = $("#entrance").val();
    	layer.open({
	    	id:'get',
			type : 2,
			
			title : [title],			
			shadeClose: false, 
			area : [ '60%', '80%' ],
			content : "<%=path%>/condition/condition_getYMDW.action?iframewindowid=get&isYMDW=1&entrance="+entrance
		});
    }
    //选择窗口回调
    function ongetClose(data){
	  	var type = Matrix.getFormItemValue('type');
	  	if(data != null){
	  		data.value = type + data.value;
	  		dblClickField(data);
	  	}
	}
    
    //取日期
    function getDate(){		
		 if(isRelation){
			 if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				 if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
				  	 	Matrix.warn('请选择a表字段');
				  	 	return;
				  	 }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObj[value];    //表单数据类型
				  	 if(editorType == '' ||editorType != '2'){//|| editorType != 'DateItem'
				  		Matrix.warn('请选择日期类型的字段');
				  	 }else{
				  	 	var data = {};
				  	 	data.value = "date({";
				  	 	data.value += value;
				  	 	data.value += "})";
				  	 	dblClickField(data);
				  	 }
				 }
				 if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					 var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
				  	 	Matrix.warn('请选择b表字段');
				  	 	return;
				  	 }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObjTwo[value];    //表单数据类型
				  	 if(editorType == '' ||editorType != '2'){//|| editorType != 'DateItem'
				  		Matrix.warn('请选择日期类型的字段');
				  	 }else{
				  	 	var data = {};
				  	 	data.value = "date({";
				  	 	data.value += value;
				  	 	data.value += "})";
				  	 	dblClickField(data);
				  	 }
				 }
			 }else{
				 Matrix.warn("请选择字段");
				 return;
			 }	
		 }else{
			 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			 if(select==null || select.length==0){
		  	 	Matrix.warn('请选择字段');
		  	 	return;
		  	 }
			 var value = select.attr("area-text");   //选中的表单数据域
			 var editorType = typeJsonObj[value];    //表单数据类型
		  	 if(editorType == '' ||editorType != '2'){//|| editorType != 'DateItem'
		  		Matrix.warn('请选择日期类型的字段');
		  	 }else{
		  	 	var data = {};
		  	 	data.value = "date({";
		  	 	data.value += value;
		  	 	data.value += "})";
		  	 	dblClickField(data);
		  	 }
		 }
	  }
     //取时间
	  function getTime(){
		 if(isRelation){    //有关联表单
			 if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				 if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
						 Matrix.warn('请选择a表字段');
				  	 	return;
				  	 }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObj[value];    //表单数据类型
				  	 if(editorType == '' || editorType != '3'){// editorType != 'DateItem'||
				  		Matrix.warn('请选择时间类型的字段');
				  	 }else{
				  	 	var data = {};
				  	 	data.value = "time({";
				  	 	data.value += value;
				  	 	data.value += "})";
				  	 	dblClickField(data);
				  	 }
				 }
				 if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					 var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
						 Matrix.warn('请选择b表字段');
				  	 	return;
				  	 }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObjTwo[value];    //表单数据类型
				  	 if(editorType == '' || editorType != '3'){// editorType != 'DateItem'||
				  		Matrix.warn('请选择时间类型的字段');
				  	 }else{
				  	 	var data = {};
				  	 	data.value = "time({";
				  	 	data.value += value;
				  	 	data.value += "})";
				  	 	dblClickField(data);
				  	 }
				 }
			 }else{
				 Matrix.warn("请选择字段");
				 return;
			 }	
		 }else{
			 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			 if(select==null || select.length==0){
				Matrix.warn('请选择时间类型的字段');
		  	 	return;
		  	 }
			 var value = select.attr("area-text");   //选中的表单数据域
			 var editorType = typeJsonObj[value];    //表单数据类型
		  	 if(editorType == '' || editorType != '3'){// editorType != 'DateItem'||
		  		Matrix.warn('请选择时间类型的字段');
		  	 }else{
		  	 	var data = {};
		  	 	data.value = "time({";
		  	 	data.value += value;
		  	 	data.value += "})";
		  	 	dblClickField(data);
		  	 }
		 }
	  }
     //日期差
     function showDaySub(){
    	 var entrance = $("#entrance").val();
    	 layer.open({
 	    	id:'daySub',
 			type : 2,
 			
 			title : ['日期差'],			
 			shadeClose: false, 
 			area : [ '60%', '80%' ],
 			content : "<%=path%>/condition/condition_getYMDW.action?iframewindowid=daySub&isYMDW=0&entrance="+entrance
 		});
	  }
     function ondaySubClose(data){
	  	if(data != null){
		  	dblClickField(data);
	  	}
	  }
     
     //大写转小写
     function getConvertToUpNum(){
    	 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
		 if(select==null || select.length==0){
			Matrix.warn('请选择字段');
		 }else{
			var value = select.attr("area-text");   //选中的表单数据域
			var editorType = typeJsonObj[value];    //表单数据类型
		  	var data = {};
		  	data.value = "getConvertToUpNum({"+value+"})";
		  	dblClickField(data);
		 }
     }
     
     //小写转大写
     function getConvertToLowNum(){
    	 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
		 if(select==null || select.length==0){
			Matrix.warn('请选择字段');
		 }else{
			var value = select.attr("area-text");   //选中的表单数据域
			var editorType = typeJsonObj[value];    //表单数据类型
		  	var data = {};
		  	data.value = "getConvertToLowNum({"+value+"})";
		  	dblClickField(data);
		 }
     }
   
     //为空
     function isNull(){ 
		 if(isRelation){  //有关联表单
			 if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				 if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
						 Matrix.warn('请选择a表字段');
				  	 }else{
				  		 var value = select.attr("area-text");   //选中的表单数据域
						 var editorType = typeJsonObj[value];    //表单数据类型
					  	 var data = {};
					  	 data.value = "isNull({"+value+"})";
					  	 dblClickField(data);
				  	 }
				 }
				 if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					 var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					 if(select==null || select.length==0){
						 Matrix.warn('请选择b表字段');
				  	 }else{
				  		 var value = select.attr("area-text");   //选中的表单数据域
						 var editorType = typeJsonObjTwo[value];    //表单数据类型
					  	 var data = {};
					  	 data.value = "isNull({"+value+"})";
					  	 dblClickField(data);
				  	 }
				 }
			 }else{
				 Matrix.warn('请选择字段');
			 }
		 }else{
			 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			 if(select==null || select.length==0){
				 Matrix.warn('请选择字段');
		  	 }else{
		  		 var value = select.attr("area-text");   //选中的表单数据域
				 var editorType = typeJsonObj[value];    //表单数据类型
			  	 var data = {};
			  	 data.value = "isNull({"+value+"})";
			  	 dblClickField(data);
		  	 }
		 }
	  }
   		//不为空
	  function isNotNull(){ 
		  if(isRelation){  //有关联表单
			 if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				 if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						 Matrix.warn('请选择a表字段');
				  	  }else{
				  		 var value = select.attr("area-text");   //选中的表单数据域
						 var editorType = typeJsonObj[value];    //表单数据类型
					  	 var data = {};
					  	 data.value = "isNotNull({"+value+"})";
					  	 dblClickField(data);
				  	  }
				 }
				 if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					  var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						  Matrix.warn('请选择b表字段');
				  	  }else{
				  		 var value = select.attr("area-text");   //选中的表单数据域
						 var editorType = typeJsonObjTwo[value];    //表单数据类型
					  	 var data = {};
					  	 data.value = "isNotNull({"+value+"})";
					  	 dblClickField(data);
				  	  }
				 }
			 }else{
				 Matrix.warn('请选择字段');
			 }
		 }else{
			  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			  if(select==null || select.length==0){
				 Matrix.warn('请选择字段');
		  	  }else{
		  		 var value = select.attr("area-text");   //选中的表单数据域
				 var editorType = typeJsonObj[value];    //表单数据类型
			  	 var data = {};
			  	 data.value = "isNotNull({"+value+"})";
			  	 dblClickField(data);
		  	  }
		  }
	  }
      function showIncluding(type){ //显示包含或不包含窗口
		  if(isRelation){
			  if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				  if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						  Matrix.warn('请选择a表字段');
				  	 	  return;
				  	  }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObj[value];    //表单数据类型
				  	 if(editorType == '' || editorType != '1'){//editorType != 'Text'||
				  		Matrix.warn('请选择文本类型的字段');
				  	 }else{
				  		layer.open({
				 	    	id:'including',
				 			type : 2,
				 			
				 			title : ['条件'],			
				 			shadeClose: false, 
				 			area : [ '60%', '80%' ],
				 			content : "<%=path%>/form/admin/custom/condition/including.jsp?iframewindowid=including&type="+type+"&text="+value
				 		});
				  	 }
				  }
				  if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					  var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
						  Matrix.warn('请选择b表字段');
				  	 	  return;
				  	  }
					 var value = select.attr("area-text");   //选中的表单数据域
					 var editorType = typeJsonObjTwo[value];    //表单数据类型
				  	 if(editorType == '' || editorType != '1'){//editorType != 'Text'||
				  		Matrix.warn('请选择文本类型的字段');
				  	 }else{
				  		layer.open({
				 	    	id:'including',
				 			type : 2,
				 			
				 			title : ['条件'],			
				 			shadeClose: false, 
				 			area : [ '60%', '80%' ],
				 			content : "<%=path%>/form/admin/custom/condition/including.jsp?iframewindowid=including&type="+type+"&text="+value
				 		});
				  	 }
				  }
			  }else{
					 Matrix.warn('请选择字段');
			  }
		  }else{
			  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			  if(select==null || select.length==0){
				  Matrix.warn('请选择字段');
		  	 	  return;
		  	  }
			 var value = select.attr("area-text");   //选中的表单数据域
			 var editorType = typeJsonObj[value];    //表单数据类型
		  	 if(editorType == '' || editorType != '1'){//editorType != 'Text'||
		  		Matrix.warn('请选择文本类型的字段');
		  	 }else{
		  		layer.open({
		 	    	id:'including',
		 			type : 2,
		 			
		 			title : ['条件'],			
		 			shadeClose: false, 
		 			area : [ '60%', '80%' ],
		 			content : "<%=path%>/form/admin/custom/condition/including.jsp?iframewindowid=including&type="+type+"&text="+value
		 		});
		  	 }
		  }
	  }
	  function onincludingClose(data){
	  	if(data != null){
	  		dblClickField(data);
	  	}
	  }
	  //流水号
	  function showSerialNumber(){
		  layer.open({
		    	id:'layer07',
				type : 2,
				
				title : ['设置流水号'],
				shadeClose: false, //开启遮罩关闭
				area : [ '60%', '80%' ],
				content : "<%=path%>/office/html5/select/SelectSerialNumber.jsp?iframewindowid=layer07"
		  });
	  }
	  //流水号选中回调
	  function onlayer07Close(data){
		  if(data!=null){
			 var name=data.name;
		  }else{
			  return;
		  }
		  var obj = document.getElementById("formulaStr");
		  if(obj==null || obj==''){
			  obj = "";
		  }
		  addSpace(name);
	  }
	  
	  //重复表合计
	  function subTotal(){ 
		  if(isRelation){  //有关联表单
			 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
		  }else{
			 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
		  	 if(flag){
		  		 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			  	 var value = select.attr("area-text");   //选中的表单数据域
			  	 var data = {};
			  	 data.value = "sum({"+value+"})";
			  	 dblClickField(data);
		  	 }
		  }
	  	
	  }
	  
	//重复表平均值
	  function subAvg(){ 
	  	 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
	  	 if(flag){
	  		 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
		  	 var value = select.attr("area-text");   //选中的表单数据域
		  	 var data = {};
		  	 data.value = "aver({"+value+"})";
		  	 dblClickField(data);
	  	 }
	  }
	
	//重复表项数
	  function subCount(){
		 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
	  	 if(flag){
	  		 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
		  	 var value = select.attr("area-text");   //选中的表单数据域
		  	 var data = {};
		  	 data.value = "count({"+value+"})";
		  	 dblClickField(data);
	  	 }
	  }
	
	 //重复表最大值
	  function subMax(){ 
	  	 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
	  	 if(flag){
	  		 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
	  		 var value = select.attr("area-text");   //选中的表单数据域
		  	 var data = {};
		  	 data.value = "max({"+value+"})";
		  	 dblClickField(data);
	  	 }
	  }
	 //重复表最小值
	  function subMin(){ 
	 	 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
	  	 if(flag){
	  		 var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
	  		 var value = select.attr("area-text");   //选中的表单数据域
		  	 var data = {};
		  	 data.value = "min({"+value+"})";
		  	 dblClickField(data);
	  	 }
	  }	  
	 //重复表分类操作弹出窗口，type 有 sum aver max min
	  function subClassify(type){
		 var flag = checkFieldType("\\重复表\\]","\\重复节\\]",1);
	  	 if(flag){
	  		  Matrix.setFormItemValue("subClassifyType",type);
			  layer.open({
			     id:'condition',
				 type : 2,
				 
				 title : ['条件'],
				 shadeClose: false, //开启遮罩关闭
				 area : [ '80%', '90%' ],
				 content : "<%=path%>/condition/condition_loadConditionSet.action?iframewindowid=condition&formType=subForm&entrance=RepeatTableClassify"
			  });
	  	 }
	  }
	 //重复表设置条件窗口回调
	  function onconditionClose(result){
		   if(result!=null){
			   var type = Matrix.getFormItemValue("subClassifyType");
			   var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			   var value = select.attr("area-text");   //选中的表单数据域
			   var str = type +"({"+value+"},$["+result.conditionText+"]$)";
			   var obj = {};
			   obj.value = str;
			   dblClickField(obj);
		  }
     }
	  
	  //重复表任一行
	  function ifAnyRow(){ 
		  var data = {};
		  data.value = "ifAnyRow()";
		  dblClickField(data);
	  }
	  //重复表所有行
	  function ifAllRow(){ 
		  var data = {};
		  data.value = "ifAllRow()";
		  dblClickField(data);
	  }
	  
	 //检查字段是不是子表字段 （type=0 检查字段是不是主表字段 type = 1检查是否为子表字段）
	 //检查主表时格式为：checkFieldType("\\主表\\]","\\主表\\]",0);  检查子表时格式为：checkFieldType("\\重复表\\]","\\重复节\\]",1);   
	  function checkFieldType(str,str_2,type){  
		  debugger;
		  var isRelation = $("#isRelation").val();  //是否有关联表单 true为是
		  if(isRelation == 'true'){
			  if($('#fieldSelect').is(':visible') || $('#associatedSelect').is(':visible')){
				  if($('#fieldSelect').is(':visible')){     //选择a表单数据域时
					  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
				  	 	 if(type == 0){
				  	 		Matrix.warn('请选择a表字段');
				  	 	 }else{
				  	 		Matrix.warn("请选择a表字段");
				  	 	 }
				  	 	 return false;
					  }
					  var value = select.attr("area-text");   //选中的表单数据域
				  	  if(value.search(str) == -1){
				  	  	if(value.search(str_2) == -1){
				  	 		if(type == 0){
				  	 			Matrix.warn('请选择a主表字段');
				  	 		}else{
				  	 			Matrix.warn("请选择a子表字段");
				  	 		}
				  	 		return false;
				  	 	}else{
				  	 		return true;
				  	 	}
				  	 } 
					 return true;
				  }
				  if($('#associatedSelect').is(':visible')){     //选择b表单数据域时
					  var select = $('#associatedSelect').find('li.changeColor');   //获得选中行元素
					  if(select==null || select.length==0){
				  	 	 if(type == 0){
				  	 		Matrix.warn('请选择b表字段');
				  	 	 }else{
				  	 		Matrix.warn("请选择b表字段");
				  	 	 }
				  	 	 return false;
					  }
					  var value = select.attr("area-text");   //选中的表单数据域
				  	  if(value.search(str) == -1){
				  	  	if(value.search(str_2) == -1){
				  	 		if(type == 0){
				  	 			Matrix.warn('请选择b主表字段');
				  	 		}else{
				  	 			Matrix.warn("请选择b子表字段");
				  	 		}
				  	 		return false;
				  	 	}else{
				  	 		return true;
				  	 	}
				  	 } 
					 return true;
				  }
			  }else{
				  if(type == 0){
			  	 	 Matrix.warn('请选择字段');
			  	  }else{
			  	 	 Matrix.warn("请选择字段");
			  	  }
			  }
		  }else{
			  var select = $('#fieldSelect').find('li.changeColor');   //获得选中行元素
			  if(select==null || select.length==0){
		  	 	 if(type == 0){
		  	 		Matrix.warn('请选择字段');
		  	 	 }else{
		  	 		Matrix.warn("请选择字段");
		  	 	 }
		  	 	 return false;
			  }
			  var value = select.attr("area-text");   //选中的表单数据域
		  	  if(value.search(str) == -1){
		  	  	if(value.search(str_2) == -1){
		  	 		if(type == 0){
		  	 			Matrix.warn('请选择主表字段');
		  	 		}else{
		  	 			Matrix.warn("请选择子表字段");
		  	 		}
		  	 		return false;
		  	 	}else{
		  	 		return true;
		  	 	}
		  	 } 
			 return true;
		  }
	  }

      //选择后加空格
  	  function addSpace(value){  
    	  	debugger;
	  		var obj = document.getElementById("formulaStr");
		  	if(document.selection){
		  		var sel = document.selection.createRange(); 
		  		sel.text = value; 
		  	}else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number'){
		  		var startPos = obj.selectionStart, 
				endPos = obj.selectionEnd, 	
				cursorPos = startPos, 
				tmpStr = obj.value; 
		  		//初始输入前面没有条件或以单引号或逗号结束的不用加空格
		  		if(tmpStr == ""){
		  			cursorPos += value.length;
		  			obj.value = value + tmpStr.substring(endPos, tmpStr.length); 
		  		}else{
		  			if(tmpStr.substring(0, startPos).endWith("'") || tmpStr.substring(0, startPos).endWith(",")){   
		  				obj.value = tmpStr.substring(0, startPos) + value + tmpStr.substring(endPos, tmpStr.length); 
		  				cursorPos += value.length+1; 
		  			}else{
		  				obj.value = tmpStr.substring(0, startPos) + " " + value + " " + tmpStr.substring(endPos, tmpStr.length); 
			  			cursorPos += value.length+1; 
		  			}
		  		}
		  		obj.selectionStart = obj.selectionEnd = cursorPos; 
		  	}else{
		  		obj.value += value; 
		  	}
		  	obj.focus();
	  }
      
  	//确定
  	function evalValue(){
  		debugger;
  		var entrance = $("#entrance").val();  //哪个位置的条件入口
  		
		var condition = document.getElementById('formulaStr').value;
		//没有输入条件时置空
	  	if(condition == ''||condition==null){
			var result = {};
			result.conditionText = "";
			result.conditionVal = "";
			if(entrance == 'GeneralFormula'){     //普通设置时置空
				var suffixId = $("#suffixId").val();
				var index = $("#index").val();
				result.setType = 0;	 
				result.suffixId = suffixId;
				result.index = index;
			}
			Matrix.closeWindow(result);
	 		return;
	  	}
		
		//不校验条件运算符
		if(entrance!='GeneralFormula' && entrance!='IfFormula' && entrance!='ResultFormula' && entrance!='DataCopyTextBox' && entrance!='MessageTemplate' && entrance!='FormProcessTitle'){
			var x = ["+","-","*","/","==","<>",">",">=","<","=<","like","not_like","include","in","isNull(","isNotNull(","true","ifAnyRow","ifAllRow","{部门包含","{部门不包含","{角色包含","{角色不包含","部门包含","人员包含","角色包含"];
		  	var flag = true;
		  	for(var i=0; i<x.length&&flag; i++){
		  		if(condition.indexOf(x[i]) != -1){
		  			flag = false;
		  		}
		  	}
		  	if(flag){
		  		Matrix.warn("未包含条件运算符：(+|-|*|/|==|<>|>|>=|<|=<|like|not_like|include|in|ifAllRow|ifAnyRow|部门包含|部门不包含|角色包含|角色不包含|人员包含)");
		  		return;
		  	}
		}
		if(condition.indexOf('"') != -1 || condition.indexOf('“') != -1 || condition.indexOf('”') != -1){
	  		Matrix.warn('不能包含双引号');
	  		return;
	  	}
	  	if(condition.indexOf('‘') != -1 || condition.indexOf('’') != -1){
	  		Matrix.warn('不能包含中文单引号');
	  		return;
	  	}
	  	if(condition.indexOf('，') != -1){
	  		Matrix.warn('不能包含中文逗号');
	  		return;
	  	}
	  	if(condition.indexOf('；') != -1){
	  		Matrix.warn('不能包含中文分号');
	  		return;
	  	}
	  	


	    var regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】]/im;
	  	if(regCn.test(condition)) {
	  		Matrix.warn("不能含有特殊字符");
	  	    return false;
	  	}
		if(!isValidSmall(condition)){
			Matrix.warn("小括号不匹配"); 
		    return; 
		}
		if(!isValidIn(condition)){
			Matrix.warn("中括号不匹配"); 
		    return; 
		}
		if(!isValidLarge(condition)){
			Matrix.warn("大括号不匹配"); 
		    return; 
		}
		
		debugger;
		var url;
	  	if(entrance == 'DataCopyTextBox'){      //触发事件数据拷贝点击文本框弹出条件入口
	  		url = "<%=request.getContextPath()%>/trigger/dataCopy_outToIn.action?targetFormId=${param.associatedFormId}";
	  	}else{
	  		url = "<%=request.getContextPath()%>/trigger/conditionTrans_outToIn.action";
	  	}
		var param = '{"condition":"'+condition+'"}';
		var synJson = eval('(' + param + ')'); 
		Matrix.sendRequest(url,synJson,function(data){
			if(data.data){
				var result = eval('(' + data.data + ')');	
				if(entrance == 'GeneralFormula'){     //普通设置入口 (高级设置不是这个页面了 切换到了advancedSet.jsp)
					var suffixId = $("#suffixId").val();
					var index = $("#index").val();
					result.setType = 0;	 
					result.suffixId = suffixId;
					result.index = index;
				}
				Matrix.closeWindow(result);
			}
		});
	}
  	
  	//取消
  	function cancel(){
  	    Matrix.closeWindow();
  	}
  	
  	//校验小括号是否成对
  	var isValidSmall = function(s) {
        var a=[];//存储左括号出现的地方
        var l=s.length;
        var k=0;
        var flag=1;
        for(var i=0;i<l&&flag;i++){
            switch (s[i]){
                case '(':
                    a[k]=i;
                    k++;
                    break;
                case ')':
                    var j=a[k-1];
                    if(s[j]==='('){
                        a[k]=0;
                        k--;
                    }else {
                        flag=0;
                    }
                    break              
            }
        }
        if(k!==0){
            flag=0;
        }
        if(flag===0){
            return false;
        }else {
            return true;
        }
    }
  	
	//校验中括号是否成对
  	var isValidIn = function(s) {
        var a=[];//存储左括号出现的地方
        var l=s.length;
        var k=0;
        var flag=1;
        for(var i=0;i<l&&flag;i++){
            switch (s[i]){           
	            case '[':
	                a[k]=i;
	                k++;
	                break;
	            case ']':
	                var j=a[k-1];
	                if(s[j]==='['){
	                    a[k]=0;
	                    k--;
	                }else {
	                    flag=0;
	                }
	                break;    
            }
        }
        if(k!==0){
            flag=0;
        }
        if(flag===0){
            return false;
        }else {
            return true;
        }
    }
  	
    //校验大括号是否成对
  	var isValidLarge = function(s) {
        var a=[];//存储左括号出现的地方
        var l=s.length;
        var k=0;
        var flag=1;
        for(var i=0;i<l&&flag;i++){
            switch (s[i]){           
                case '{':
                    a[k]=i;
                    k++;
                    break;
                case '}':
                    var j=a[k-1];
                    if(s[j]==='{'){
                        a[k]=0;
                        k--;
                    }else {
                        flag=0;
                    }
                    break;             
            }
        }
        if(k!==0){
            flag=0;
        }
        if(flag===0){
            return false;
        }else {
            return true;
        }
    }
</script>
</head>
<body>
	<input id="iframewindowid" name="iframewindowid" type="hidden" value="${param.iframewindowid}"/>  <!-- 弹出窗口编码 -->
	<input id="entrance" name="entrance" type="hidden" value="${param.entrance}"/>  <!-- 哪个位置的条件入口 -->
	<input id="operateType" name="operateType" type="hidden" value="${param.operateType}"/>  <!-- add为触发事件添加操作,update为修改操作  add时不显示b表数据域 -->
	<input id="type" name="type" type="hidden"/> <!-- 区分是取年 还是取日 还是取月 还是取星期几 还是取季 -->
	<input id="subClassifyType" name="subClassifyType" type="hidden"/> <!-- 重复表分类类型 -->
  	<input id="including" name="including" type="hidden"/> <!-- 区分是包含还是不包含 -->
  	<input id="suffixId" name="suffixId" type="hidden" value="${param.suffixId}"/>  <!-- 计算普通和高级设置时记录的选中行字段编码 -->
  	<input id="index" name="index" type="hidden" value="${param.index}"/>  <!-- 计算普通和高级设置时记录的table选中行索引 -->
  	<input id="hasB" name="hasB" type="hidden" value="false"/> <!-- 当前页面是否有b表单数据域 -->
	<div id="container">
		<div id="head">
			<input id="nomalSet" name="modelSet" type="radio" value="1" class="box" checked="checked"><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;">普通设置</label>
			<input id="advancedSet" name="modelSet" type="radio" value="2" class="box"/><label style="vertical-align: -webkit-baseline-middle;">高级设置</label>
		</div>
		<div id="content">
			<div id="left-content">
				<ul>
					<li class="title"><font class="font">可用变量</font></li>
				</ul>
				<ul class="field-list">
					<li class="field-category">
						<div class="field-title" id="a_title">
							<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>表单数据域
						</div>
						<ul class="field-children" id="fieldSelect">
							<c:forEach var="text" items="${entVal}">
								<li class="field-item" area-text="${text}" area-type="1" title="${text}">${text}</li>
							</c:forEach>
		  				</ul>
		  			</li>
		  			<li class="field-category">
						<div class="field-title" id="b_title">
							<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>(简称b表)表单数据域
						</div>
						<ul class="field-children" id="associatedSelect">
							<c:forEach var="text" items="${entValB}">
								<li class="field-item" area-text="${text}" area-type="4" title="${text}">${text}</li>
							</c:forEach>
		  				</ul>
		  			</li>
		  			<li class="field-category">
		  				<div class="field-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>组织机构变量
		  				</div>
		  				<ul class="field-children" id="orgSelect">
		  					<c:forEach var="orgVar" items="${orgVars}">
		  						<li class="field-item" area-text="${orgVar}" area-type="2" title="${text}">${orgVar}</li>
							</c:forEach>
		  				</ul>
		  			</li>
		  			<li class="field-category">
		  				<div class="field-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>日期变量
		  				</div>
		  				<ul class="field-children" id="dateSelect">
		  					<c:forEach var="dateVar" items="${dateVars}">
		  						<li class="field-item" area-text="${dateVar}" area-type="3" title="${text}">${dateVar}</li>				
							</c:forEach>		  				
		  				</ul>
		  			</li>
		  		</ul>
			</div>
			<div id="right-content">
				<ul>
					<li class="title"><font class="font">函数列表</font></li>
				</ul>
				<ul class="formula-list">
					<li class="formula-category">
						<div class="formula-title">
							<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>数字函数
						</div>
						<ul class="formula-children number">
		  					<li class="formula-item" area-text="getInt()" area-type="int" >取整数</li>
		  					<li class="formula-item" area-text="getMod()" area-type="mod">取余数</li>
		  					<li class="formula-item" area-text="getSquare()" area-type="square">开根号</li>
		  					<li class="formula-item" area-text="getLog()" area-type="log">计算对数</li>
		  					<li class="formula-item" area-text="getPow()" area-type="pow">计算幂</li>
		  					<li class="formula-item" area-text="getMax()" area-type="max">最大值</li>
		  					<li class="formula-item" area-text="getMin()" area-type="min">最小值</li>
		  					<li class="formula-item" area-text="getAver()" area-type="aver">平均值</li>
		  					<li class="formula-item" area-text="getConvertToLowNum()" area-type="toUpNum">金额大写转小写</li>
		  					<li class="formula-item" area-text="getConvertToUpNum()" area-type="toLowNum">金额小写转大写</li>
		  				</ul>
		  			</li>
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>字符函数
		  				</div>
		  				<ul class="formula-children char">
		  					<li class="formula-item" area-text="containStr()" area-type="containStr">包含字符串</li>
		  					<li class="formula-item" area-text="strLength()" area-type="strLength">字符长度</li>
		  					<li class="formula-item" area-text="subStrStart()" area-type="subStrStart">字符头几位</li>
		  					<li class="formula-item" area-text="subStrEnd()" area-type="subStrEnd">字符末几位</li>
		  					<li class="formula-item" area-text="toUpperCase()" area-type="upperCase">小写转换为大写</li>
		  					<li class="formula-item" area-text="toLowerCase()" area-type="lowerCase">大写转换为小写</li>
		  				</ul>
		  			</li>
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>组织机构
		  				</div>	  			
		  				<ul class="formula-children org">
		  					<li class="formula-item" area-type="multiDep">包含部门</li>
		  					<li class="formula-item" area-type="multiRole">包含角色</li>
		  					<li class="formula-item" area-type="currentDep">取部门编码</li>
		  					<li class="formula-item" area-type="singleRole">取角色编码</li>
		  					<li class="formula-item" area-type="singlePerson">取人员编码</li>
		  					
		  				</ul>
		  			</li>
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>日期函数
		  				</div>	  			
		  				<ul class="formula-children date">
		  					<li class="formula-item" area-type="year">取年</li>
		  					<li class="formula-item" area-type="month">取月</li>
		  					<li class="formula-item" area-type="day">取日</li>
		  					<li class="formula-item" area-type="weekDay">取星期几</li>
		  					<li class="formula-item" area-type="season">取季</li>
		  					<li class="formula-item" area-type="date">取日期</li>
		  					<li class="formula-item" area-type="time">取时间</li>
		  					<li class="formula-item" area-type="datediff">日期差</li>
		  				</ul>
		  			</li> 
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>重复表
		  				</div>	  			
		  				<ul class="formula-children repeat">
		  					<li class="formula-item" area-type="total">重复表合计</li>
		  					<li class="formula-item" area-type="avg">重复表平均值</li>
		  					<li class="formula-item" area-type="count">重复表项数</li>
		  					<li class="formula-item" area-type="maxRepeat">重复表最大值</li>
		  					<li class="formula-item" area-type="minRepeat">重复表最小值</li>
		  					<li class="formula-item" area-type="sumif">重复表分类合计</li>
		  					<li class="formula-item" area-type="averif">重复表分类平均值</li>
		  					<li class="formula-item" area-type="countif">重复表分类项数</li>
		  					<li class="formula-item" area-type="maxif">重复表分类最大值</li>
		  					<li class="formula-item" area-type="minif">重复表分类最小值</li>
		  					<li class="formula-item" area-type="anyRow">重复表任一行</li>
		  					<li class="formula-item" area-type="allRow">重复表所有行</li>
		  				</ul>
		  			</li>
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>流程函数
		  				</div>	  			
		  				<ul class="formula-children process">
		  					<li class="formula-item" area-type="currentProcess">当前流程编码</li>
		  					<li class="formula-item" area-type="currentActivity">当前活动编码</li>
		  				</ul>
		  			</li>
		  			<li class="formula-category">
		  				<div class="formula-title">
		  					<i class="glyphicon glyphicon-triangle-right" style="color: #C9CED9;margin-right: 3px;"></i>工具函数
		  				</div>	  			
		  				<ul class="formula-children tools">
		  					<li class="formula-item" area-type="isNull">为空</li>
		  					<li class="formula-item" area-type="isNotNull">不为空</li>
		  					<li class="formula-item" area-type="serialNumbe">流水号</li>
		  					<li class="formula-item" area-type="like">包含</li>
		  					<li class="formula-item" area-type="not_like">不包含</li>
		  					<li class="formula-item" area-type="selectCount">选中项数</li>
		  				</ul>
		  			</li>
		  		</ul>
			</div>
			<div id="center-content">
				<div class="code-area">
					<textarea class="form-control" id="formulaStr" name="formulaStr" style="height:100%;resize:none;"></textarea>
				</div>
				<div class="compare-area">
					<div class="compare-btn">
						<span>+</span>
					</div>
					<div class="compare-btn">
						<span>-</span>
					</div>
					<div class="compare-btn">
						<span>*</span>
					</div>
					<div class="compare-btn">
						<span>/</span>
					</div>
					<div class="compare-btn">
						<span>(</span>
					</div>
					<div class="compare-btn">
						<span>)</span>
					</div>
					<div class="compare-btn">
						<span>></span>
					</div>
					<div class="compare-btn">
						<span>>=</span>
					</div>
					<div class="compare-btn">
						<span><</span>
					</div>
					<div class="compare-btn">
						<span><=</span>
					</div>
					<div class="compare-btn">
						<span>==</span>
					</div>
					<div class="compare-btn">
						<span><></span>
					</div>
					<div class="compare-btn">
						<span>and</span>
					</div>
					<div class="compare-btn">
						<span>or</span>
					</div>
					<div class="compare-btn">
						<span>not</span>
					</div>
					<div class="compare-btn">
						<span>in</span>
					</div>
					<div class="compare-btn">
						<span>空值</span>
					</div>
					<div class="extend-btn">
						<span>扩展</span>
					</div>
				</div>
				<div class="explain-area">
					请参考具体函数说明进行配置
				</div>
			</div>
		</div>
		<div class="cmdLayout">
			<div class="x-btn ok-btn" onclick="evalValue();">
				<span>确定</span>
			</div>
			<div class="x-btn cancel-btn" onclick="cancel();">
				<span>取消</span>
			</div>
		</div>
	</div>
</body>
</html>