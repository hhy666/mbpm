<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                添加或更新业务日历
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
            	//提交前验证
            	function validateBeforeSubmit(){
            		var idReMsg = document.getElementById("idEchoMessage").value;
            		var nameReMsg = document.getElementById("nameEchoMessage").value;
            		//编码重复
	            	if((idReMsg!=null&&idReMsg.trim().length>0)||(nameReMsg!=null&&nameReMsg.trim().length>0)){
	            		return false;
	            	}
            		
            		return true;
            	}
            	
            	//转换提交的数据
            	function convertSubmitData(){
            		var operationType = document.getElementById('operationType').value;
            		var calendarId ;
            		var calendarName ;
            		var description;
            		
            		if("add"==operationType){//添加
            			 calendarId = Matrix.getMatrixComponentById("calendarIdDisplay").getValue();
            			 calendarName = Matrix.getMatrixComponentById("calendarName").getValue();
            			 description = Matrix.getMatrixComponentById("description").getValue();
            			
            		}else if("update"==operationType){
            			 calendarName = Matrix.getMatrixComponentById("calendarName").getValue();
            			 description = Matrix.getMatrixComponentById("description").getValue();
            			 calendarId = document.getElementById("calendarId").value;
            		}
            		var result = {'calendarId':calendarId,'calendarName':calendarName,'description':description,'operationType':operationType};
            		return result;
            	}
            	
            	
            	//验证id
            	function validateCalendarId(){
            		//清除重复消息
            		var idReMsg = document.getElementById("idEchoMessage");
					setDivValue(idReMsg, "");
            	
            	    //添加时 获取calendarIdDisplay的值
					var calendarId = Matrix.getMatrixComponentById("calendarIdDisplay").getValue();
					if(calendarId==null||calendarId.trim().length==0){
						return false;
					}
					
					if(!Matrix.getMatrixComponentById("calendarIdDisplay").validate()){
						var idReMsg = document.getElementById("idEchoMessage");
						setDivValue(idReMsg, "");
						return false;
					}
					
					var url = "<%=request.getContextPath()%>/calendar/calendarAction_isExistCalendarId.action?calendarId="+calendarId;
					
					dataSend(null,url,"POST",validateIdCallback);
					return true;
				}
				
				//验证id 回调
				function validateIdCallback(data){
					var result = data.data;
					var idReMsg = document.getElementById("idEchoMessage");
					if(result){//重复了
						setDivValue(idReMsg, "编码重复!");
					}else{
						setDivValue(idReMsg, "");
					
					}
				}
				
				//验证name
				function validateCalendarName(){
					//清除重复消息
					var nameReMsg = document.getElementById("nameEchoMessage");
					setDivValue(nameReMsg, "");
				
					var calendarId = document.getElementById("calendarId").value;
					var calendarName = Matrix.getMatrixComponentById("calendarName").getValue();
					if(calendarName==null||calendarName.trim().length==0){
						return false;
					}
					
					if(!Matrix.getMatrixComponentById("calendarName").validate()){
						var nameReMsg = document.getElementById("nameEchoMessage");
							setDivValue(nameReMsg, "");
						return false;
					}
					
					var url = "<%=request.getContextPath()%>/calendar/calendarAction_isExistCalendarName.action?calendarId="+calendarId+"&calendarName="+calendarName;
					
					dataSend(null,url,"POST",validateNameCallback);
					return true;
				}
            
            	function validateNameCallback(data){
            		var result = data.data;
					var nameReMsg = document.getElementById("nameEchoMessage");
					if(result){//重复
						setDivValue(nameReMsg, "名称重复!");
					}else{
						setDivValue(nameReMsg, "");
					
					}
            	}
            	
            	
            </script>
        </head>
       
        <body>
            <jsp:include page="/form/admin/common/loading.jsp" />
            <div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
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
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                    <input id="calendarId" type="hidden" name="calendarId" value="${calendar.calendarId}"/>
                    
                    <input id="operationType" type="hidden" name="operationType" value="${param.operationType}"/>
                    <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}"/>
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                    <table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px"
                    cellspacing="0px" style="width: 100%; height: 100%">
                        <tr id="j_id4" jsId="j_id4">
                            <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1"
                            style="width: '20%'">
                                <label id="j_id6" name="j_id6" style="margin-left: 10px">
                                    编&nbsp;&nbsp;码：
                                </label>
                            </td>
                            <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                <div id="calendarIdDisplay_div" eventProxy="MForm0" class="matrixInline" style="">
                                </div>
                                <script>
                                    var calendarIdDisplay = isc.TextItem.create({
                                        ID: "McalendarIdDisplay",
                                        name: "calendarIdDisplay",
                                        editorType: "TextItem",
                                        displayId: "calendarIdDisplay_div",
                                        position: "relative",
                                        value: "${calendar.calendarId}",
                                        width: 240,
                                        blur: function(form, item){
                                           validateCalendarId();
                                        },
                                        disabled:${not empty calendar.calendarId},
                                        validators: [{
                                            type: "custom",
                                            condition: function(item, validator, value, record) {
                                            	
                                                return componentIdValidate(item, validator, value, record);
                                            },
                                            errorMessage: "编码不能为空!"
                                        }]
                                        
                                        //required: true
                                    });
                                    MForm0.addField(calendarIdDisplay);
                                </script>
                                <span id="validateIdMsg" style="width: 50px; height: 20px; color: #FF0000">
                                    *
                                </span>
                                <span id="idEchoMessage" style="color: #FF0000">
                                </span>
                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9">
                            <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                    名&nbsp;&nbsp;称：
                                </label>
                            </td>
                            <td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
                            rowspan="1">
                                <div id="calendarName_div" eventProxy="MForm0" class="matrixInline" style="">
                                </div>
                                <script>
                                    var calendarName = isc.TextItem.create({
                                        ID: "McalendarName",
                                        name: "calendarName",
                                        editorType: "TextItem",
                                        displayId: "calendarName_div",
                                        position: "relative",
                                        value: "${calendar.calendarName}",
                                        width: 240,
                                        blur: function(form, item){
                                        	validateCalendarName();//失去焦点时验证
                                        },
                                        
                                        validators: [{
                                            type: "custom",
                                            condition: function(item, validator, value, record) {
                                                return inputNameValidate(item, validator, value, record);
                                            },
                                            errorMessage: "名称不能为空!"
                                        }]
                                    });
                                    MForm0.addField(calendarName);
                                </script>
                                <span id="validateNameMsg" style="width: 50px; height: 20px; color: #FF0000">
                                    *
                                </span>
                                <span id="nameEchoMessage" style="color: #FF0000">
                                </span>
                            </td>
                        </tr>
                        <tr id="j_id20" jsId="j_id20">
                            <td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id22" name="j_id22" style="margin-left: 10px">
                                    描&nbsp;&nbsp;述：
                                </label>
                            </td>
                            <td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
                            rowspan="1">
                                <div id="description_div" eventProxy="MForm0" class="matrixInline" style="">
                                </div>
                                <script>
                                    var description = isc.TextAreaItem.create({
                                        ID: "Mdescription",
                                        name: "description",
                                        editorType: "TextAreaItem",
                                        displayId: "description_div",
                                        position: "relative",
                                        value: "${calendar.description}",
                                        width: 280,
                                        height: 150
                                    });
                                    MForm0.addField(description);
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr id="j_id9ddd" jsId="j_id9ddd" >
                            <td id="j_id10" jsId="j_id10" colspan="2"
                            width="100%" height="20px">
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem3",
                                        icon: Matrix.getActionIcon("save"),
                                        title: "保存",

                                        showDisabledIcon: false,
                                        showDownIcon: false
                                    });
                                    MToolBarItem3.click = function() {
                                        Matrix.showMask();
                                        
                                        if(!validateBeforeSubmit()){
                                        	return false;
                                        }
                                        
                                       	if(!MForm0.validate()){
									    	Matrix.hideMask();
									  	    return false;
										}
										
										var data = convertSubmitData();
										Matrix.closeWindow(data);
										
                                        Matrix.hideMask();
                                    }
                                </script>
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem4",
                                        icon: Matrix.getActionIcon("exit"),
                                        title: "关闭",
                                        showDisabledIcon: false,
                                        showDownIcon: false
                                    });
                                    MToolBarItem4.click = function() {
                                        Matrix.showMask();
                                        Matrix.closeWindow(null, 0);
                                        Matrix.hideMask();
                                    }
                                </script>
                                <div id="ToolBar0_div" style="width:100%; overflow: hidden;">
                                    <script>
                                        isc.ToolStrip.create({
                                            ID: "MToolBar0",
                                            displayId: "ToolBar0_div",
                                            width: "100%",
                                            height: "*",
                                            position: "relative",
                                            align: "center",
                                            members: [MToolBarItem3, "separator", MToolBarItem4]
                                        });
                                        isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                    </script>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                </script>
            </div>
        </body>
    
    </html>
