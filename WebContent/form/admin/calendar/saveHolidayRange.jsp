<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                添加或更新特殊工作日
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
            	//验证输入是否合法
            	function  valiadateTimeDuration(){
            		var fromDur = MfromDate.getValue();
            		var toDur = MtoDate.getValue();
            		
            		if(fromDur>toDur){
            			return false;
            		}
            		return true;
            	}
            	
            	//转换提交的数据
            	function convertSubmitData(){
            		var operationType = document.getElementById('operationType').value;
            		var fromDate= Matrix.getMatrixComponentById("fromDate").getValue();
            		var toDate = Matrix.getMatrixComponentById("toDate").getValue(); 
            		
            		var result = {'fromDate':fromDate,'toDate':toDate};
            		
            		if("update"==operationType){
            			result.holidayRangeId  = document.getElementById('holidayRangeId').value;
            			result.calendarId  = document.getElementById('calendarId').value;
            		}
            		return result;
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
                    <input id="holidayRangeId" type="hidden" name="holidayRangeId" value="${holidayRangeObj.id}"/>
                    <input id="calendarId" type="hidden" name="calendarId" value="${holidayRangeObj.calendarId}"/>
                     
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
                                    开始日期：
                                </label>
                            </td>
                            <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                               <div id="fromDate_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var MfromDate_value = null;
                                var fromDate = isc.DateItem.create({
                                    ID: "MfromDate",
                                    name: "fromDate",
                                    //value: MfromDate_value,
                                    value:"${holidayRangeObj.fromDate}",
                                    type: "date",
                                    displayId: "fromDate_div",
                                    paseDateFun: function(value, formatPattern) {
                                        return Matrix.parseDate(value, formatPattern);
                                    },
                                    dateFormatter: function(_1) {
                                        return Matrix.formatDate(this, MfromDate.formatPattern);
                                    },
                                    formatPattern: "yyyy年MM月dd日",
                                    useTextField: true,
                                    enforceDate: true,
                                    position: "relative",
                                    width: 228,
                                    validators: [{
                                        type: "custom",
                                        condition: function(item, validator, value, record) {
                                            return item.validateDateValue(value);
                                        },
                                        errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
                                    }]
                                });
                                MForm0.addField(fromDate);
                            </script>
                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9">
                            <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                    结束日期：
                                </label>
                            </td>
                            <td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
                            rowspan="1">
                          		<div id="toDate_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var MtoDate_value = null;
                                var toDate = isc.DateItem.create({
                                    ID: "MtoDate",
                                    name: "toDate",
                                    //value: MtoDate_value,
                                    type: "date",
                                    displayId: "toDate_div",
                                    paseDateFun: function(value, formatPattern) {
                                        return Matrix.parseDate(value, formatPattern);
                                    },
                                    dateFormatter: function(_1) {
                                        return Matrix.formatDate(this, MtoDate.formatPattern);
                                    },
                                    formatPattern: "yyyy年MM月dd日",
                                    useTextField: true,
                                    enforceDate: true,
                                    position: "relative",
                                    value:"${holidayRangeObj.toDate}",
                                    width: 228,
                                    validators: [{
                                        type: "custom",
                                        condition: function(item, validator, value, record) {
                                            return item.validateDateValue(value);
                                        },
                                        errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
                                    }]
                                });
                                MForm0.addField(toDate);
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
                                        
                                       	if(!MForm0.validate()){
									    	Matrix.hideMask();
									  	    return false;
										}
                                        
                                        if(!valiadateTimeDuration()){
                                        	parent.isc.warn('开始日期应该早于结束日期！');
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