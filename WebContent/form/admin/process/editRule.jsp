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
            	var isValidated = true;
            
            	//提交前验证
            	function validateBeforeSubmit(){
            		var nameReMsgItem = document.getElementById("nameRepeatMsg");
            		var nameReMsg = getDivValue(nameReMsgItem);
            		//编码重复
	            	if(nameReMsg!=null&&nameReMsg.trim().length>0){
	            		return false;
	            	}
            		
            		return true;
            	}
            	
            	//转换提交的数据
            	function convertSubmitData(){
            		var operationType = document.getElementById('operationType').value;
            		var ruleId ;
            		var ruleName ;
            		var ruleType;
            		var ruleDesc;
            		var processId;
            		ruleName = Matrix.getMatrixComponentById("ruleName").getValue();
            		ruleType = Matrix.getMatrixComponentById("ruleType").getValue();
            		ruleDesc = Matrix.getMatrixComponentById("ruleDesc").getValue();
            		processId = document.getElementById("processId").value;
            		if("update"==operationType){
            			ruleId = document.getElementById("ruleId").value;
            		}
            		var result = {'ruleId':ruleId,'ruleName':ruleName,'ruleType':ruleType,'ruleDesc':ruleDesc,'processId':processId};
            		return result;
            	}
            	
            	
            	//验证ruleName
            	function validateRuleName(){
            		//清除重复消息
            		var idReMsg = document.getElementById("nameRepeatMsg");
					setDivValue(idReMsg, "");
            	
            	    //添加时 获取ruleName的值
					var ruleName = Matrix.getMatrixComponentById("ruleName").getValue();
					if(ruleName==null||ruleName.trim().length==0){
						return false;
					}
					
					if(!Matrix.getMatrixComponentById("ruleName").validate()){
						var nameReMsg = document.getElementById("nameRepeatMsg");
						setDivValue(nameReMsg, "");
						return false;
					}
					var processId = document.getElementById("processId").value;
					var ruleId = document.getElementById("ruleId").value;
					var vData = {'ruleName':ruleName,'ruleId':ruleId,'processId':processId};
					
					var url = "<%=request.getContextPath()%>/process/ruleAction_checkRuleName.action";
					dataSend(vData,url,"POST",validateRuleNameCallback);
					isValidated = false;
					return true;
				}
				
				
				//验证id 回调
				function validateRuleNameCallback(data){
					var result = data.data;
					var idReMsg = document.getElementById("nameRepeatMsg");
					if(result){//重复了
						setDivValue(idReMsg, "编码重复!");
					}else{
						setDivValue(idReMsg, "");
					
					}
					isValidated = true;
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
                    <input id="processId" type="hidden" name="processId" value="${rule.processId}"/>
                    <input id="ruleId" type="hidden" name="ruleId" value="${rule.id}"/>
                    <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}"/>
                    <input id="operationType" type="hidden" name="operationType" value="${param.operationType}"/>
                   
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                    <table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px"
                    cellspacing="0px" style="width: 100%; height: 100%">
                        <tr id="j_id4" jsId="j_id4">
                            <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1"
                            style="width: '20%'">
                                <label id="j_id6" name="j_id6" style="margin-left: 10px">
                                    名&nbsp;&nbsp;称：
                                </label>
                            </td>
                            <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                <div id="ruleName_div" eventProxy="MForm0" class="matrixInline" style="">
                                </div>
                                <script>
                                    var ruleName = isc.TextItem.create({
                                        ID: "MruleName",
                                        name: "ruleName",
                                        editorType: "TextItem",
                                        displayId: "ruleName_div",
                                        position: "relative",
                                        value: "${rule.name}",
                                        width: 240,
                                        blur: function(form, item){
                                           validateRuleName();
                                        },
                                       
                                        validators: [{
                                            type: "custom",
                                            condition: function(item, validator, value, record) {
                                            	
                                                return componentIdValidate(item, validator, value, record);
                                            },
                                            errorMessage: "名称不能为空!"
                                        }]
                                        
                                        //required: true
                                    });
                                    MForm0.addField(ruleName);
                                </script>
                                <span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                                    *
                                </span>
                                <span id="nameRepeatMsg" style="color: #FF0000">
                                </span>
                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9">
                            <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                    类&nbsp;&nbsp;型：
                                </label>
                            </td>
                            <td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
                            rowspan="1">
                                <div id="ruleType_div" eventProxy="MForm0" class="matrixInline" ></div>
								<script>
								 	var MruleType_VM=[];
								    var ruleType=isc.SelectItem.create({
								    		ID:"MruleType",
								    		name:"ruleType",
								    		editorType:"SelectItem",
								    		displayId:"ruleType_div",
								    		valueMap:[],
								    		value:"${rule.type}"=="0"?"1":"${rule.type}",
								    		position:"relative",
								    		width:240
								    });
								    MForm0.addField(ruleType);
								    MruleType_VM=['1','2'];
								    MruleType.displayValueMap={'1':'表达式','2':'自定义求值'};
								    MruleType.setValueMap(MruleType_VM);
								   
								</script>
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
                                <div id="ruleDesc_div" eventProxy="MForm0" class="matrixInline" style="">
                                </div>
                                <script>
                                    var ruleDesc = isc.TextAreaItem.create({
                                        ID: "MruleDesc",
                                        name: "ruleDesc",
                                        editorType: "TextAreaItem",
                                        displayId: "ruleDesc_div",
                                        position: "relative",
                                        value: "${rule.desc}",
                                        width: 280,
                                        height: 150
                                    });
                                    MForm0.addField(ruleDesc);
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
                                        if(!isValidated){
                                        	parent.isc.warn("未完成名称校验！");
                                        	Matrix.hideMask();
									  	    return false;
                                        }
                                        
                                        if(!validateBeforeSubmit()){
                                       		 Matrix.hideMask();
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
