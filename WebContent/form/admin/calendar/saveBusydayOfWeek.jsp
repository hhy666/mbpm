<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                添加或更工作日
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
            	//验证输入是否合法
            	function  valiadateTimeDuration(){
            		var fromDur = MfromTime.getDuration();
            		var toDur = MtoTime.getDuration();
            		
            		if(fromDur>=toDur){
            			return false;
            		}
            		return true;
            	}
            	
            	//转换提交的数据
            	function convertSubmitData(){
            		var operationType = document.getElementById('operationType').value;
            		var busyDayOfWeekId;
            		var calendarId;
            		var dayOfWeek = Matrix.getMatrixComponentById("dayOfWeek").getValue();
            		var fromTime= Matrix.getMatrixComponentById("fromTime").getValue();
            		var toTime= Matrix.getMatrixComponentById("toTime").getValue(); 
            		//时间格式处理
            		fromTime = fromTime.toShortDateTime();
            		fromTime = fromTime.match(/\d{2}:\d{2}$/);
            		
            		toTime = toTime.toShortDateTime();
            		toTime = toTime.match(/\d{2}:\d{2}$/);
                   
            		var result = {'dayOfWeek':dayOfWeek,'fromTime':fromTime,'toTime':toTime};
            		
            		if("update"==operationType){
            			result.busyDayOfWeekId  = document.getElementById('busyDayOfWeekId').value;
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
                    
                     <input id="calendarId" type="hidden" name="calendarId" value="${busyDayOfWeek.calendarId}"/>
                     <input id="busyDayOfWeekId" type="hidden" name="busyDayOfWeekId" value="${busyDayOfWeek.id}"/>
                     
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
                                    周&nbsp;&nbsp;几：
                                </label>
                            </td>
                            <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                <div id="dayOfWeek_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var MdayOfWeek_VM = [];
                                var dayOfWeek = isc.ComboBoxItem.create({
                                    ID: "MdayOfWeek",
                                    name: "dayOfWeek",
                                    editorType: "ComboBoxItem",
                                    displayId: "dayOfWeek_div",
                                    valueMap: [],
                                    position: "relative",
                                    value:'${busyDayOfWeek.dayOfWeek}'==''?'1':'${busyDayOfWeek.dayOfWeek}',
                                    width: 170
                                });
                                MForm0.addField(dayOfWeek);
                                MdayOfWeek_VM = ['2', '3','4', '5','6', '7','1'];
                                MdayOfWeek.displayValueMap = {
                                    '2':'周一','3':'周二',
						     	    '4':'周三','5':'周四',
						     	    '6':'周五','7':'周六','1':'周日'
                                };
                                MdayOfWeek.setValueMap(MdayOfWeek_VM);
                                //MdayOfWeek.setValue(2);
                            </script>
                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9">
                            <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                    开始时间：
                                </label>
                            </td>
                            <td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
                            rowspan="1">
                          
                            
                             <div id="fromTime_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var fromTime = isc.TimeItem.create({
                                    ID: "MfromTime",
                                    name: "fromTime",
                                    editorType: "TimeItem",
                                    displayId: "fromTime_div",
                                    dateFormatter: "to24HourTime",
                                    position: "relative",
                                    hint: "",
                                    width: 170,
                                    useTextField:false,
                                    showSecondItem:false,
                                    value:"${busyDayOfWeek.fromTime}"
                                   
                                   
                                });
                                MForm0.addField(fromTime);
                            </script>
                            </td>
                        </tr>
                        <tr id="j_id20" jsId="j_id20">
                            <td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1"
                            rowspan="1" style="width: '20%'">
                                <label id="j_id22" name="j_id22" style="margin-left: 10px">
                                    结束时间：
                                </label>
                            </td>
                            <td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
                            rowspan="1">
                                <div id="toTime_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var toTime = isc.TimeItem.create({
                                    ID: "MtoTime",
                                    name: "toTime",
                                    editorType: "TimeItem",
                                    displayId: "toTime_div",
                                    dateFormatter: "to24HourTime",
                                    position: "relative",
                                    showSecondItem:false,
                                    hint: "",
                                    width: 170,
                                    useTextField:false,
                                     value:"${busyDayOfWeek.toTime}"
                                });
                                MForm0.addField(toTime);
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
                                        	parent.isc.warn('开始时间应该早于结束时间！');
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
                <script type="text/javascript">
                	//开始时间 变化
                	function fromTimeChanged(value){
                		var fromTime = value;
                		var fhour = 
                	
                	
                	}
                	
                	
                	//结束时间 变化
                	function toTimeChanged(value){
                		
                	
                	}
                
                
                
                </script>
            </div>
        </body>
    
    </html>