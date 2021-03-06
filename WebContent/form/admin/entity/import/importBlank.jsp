<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>导入实体空白页</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//导入成功后 关闭弹出窗口 刷新树节点
	
	function initPage(){
	 	var isRepeat = ${requestScope.existRepeatTable};
	 	
		if(isRepeat){
			
			isc.warn("导入的表中生成的业务对象编码在系统中已经存在,请重新选择导入表和编码生成方式!",function(){
				Matrix.closeWindow();
			});
			
		}else{
			parent.Matrix.forceFreshTreeNode("Tree0", "${requestScope.parentNodeId}");
			isc.say("导入存储对象成功!",function(){
				Matrix.closeWindow();
			});
		
		}
	}
	
</script>

</head>


<body onload="initPage()">
    <jsp:include page="/form/admin/common/loading.jsp"/>
    <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
        <script>
            var MForm0 = isc.MatrixForm.create({
                ID: "MForm0",
                name: "MForm0",
                position: "absolute",
                action: "",
                fields: [{
                    name: 'Form0_hidden_text',
                    width: 0,
                    height: 0,
                    displayId: 'Form0_hidden_text_div'
                }]
            });
        </script>
        <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
        style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
            <input type="hidden" name="Form0" value="Form0" />
            <input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}" />
            <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
            style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;">
            </div>
            
            
            
            
            
            
           
        </form>
        <script>
            MForm0.initComplete = true;
            MForm0.redraw();
            isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
        </script>
    </div>
</body>

</html>