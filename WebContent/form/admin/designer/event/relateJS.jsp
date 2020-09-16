<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                相关JS
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
            function typeChangedFun(typeValue){
        
                var asynJSFunc = Matrix.getMatrixComponentById("asynJSFunc");
                var callbackSuccFunc = Matrix.getMatrixComponentById("callbackSuccFunc");
                var callbackFailFunc = Matrix.getMatrixComponentById("callbackFailFunc");
            	if(typeValue=='custom'){
            	 	Mcondition.setCanEdit(true);
	            	asynJSFunc.setCanEdit(true);
	            	callbackSuccFunc.setCanEdit(true);
	            	callbackFailFunc.setCanEdit(true);
            	}else if(typeValue=='common'){//通用
            	    //清空输入值
            	   // asynJSFunc.clearValue();
            	    //callbackSuccFunc.clearValue();
            	   // callbackFailFunc.clearValue();
            	    Mcondition.setCanEdit(false);
            	    asynJSFunc.setCanEdit(false);
	            	callbackSuccFunc.setCanEdit(false);
	            	callbackFailFunc.setCanEdit(false);
            	}
            
            }
            //同步type值
            function synModelOnBlur(item){
            	var eventType = "${param.eventType}";
            	var ajaxEventType = "${param.ajaxEventType}";
                
            	item.attrName = item.name;
            	
            	item.attrName = "relateJS_"+item.attrName+"_"+eventType+"_"+ajaxEventType;
            	Matrix.resetComponentProperty(item);
            }
            
            
            
            function initPage(){
	            var type = "${requestScope.type}";
	            if("custom"==type){
	            	var asynJSFunc = Matrix.getMatrixComponentById("asynJSFunc");
                    var callbackSuccFunc = Matrix.getMatrixComponentById("callbackSuccFunc");
                	var callbackFailFunc = Matrix.getMatrixComponentById("callbackFailFunc");
                	Mcondition.setCanEdit(true);
                	asynJSFunc.setCanEdit(true);
	            	callbackSuccFunc.setCanEdit(true);
	            	callbackFailFunc.setCanEdit(true);
	            
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
                style="margin:0px;height:342px;" enctype="application/x-www-form-urlencoded">
                      <input type="hidden" name="Form0" value="Form0" />
                      <input type="hidden" name="ajaxEventType" id="ajaxEventType" value="${param.ajaxEventType}" />
                      <input type="hidden" name="eventType" id="eventType" value="${param.eventType}" />
                      
                    
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;">
                    </div>
                    
                    <div style="text-valign:center;position:relative">
                        <table id="j_id3" jsId="j_id3" class="maintain_form_content">
                            <tr id="j_id4" jsId="j_id4">
                                <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
                                    <label id="j_id6" name="j_id6" style="margin-left:10px">
                                        类型：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                    <div id="type_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var Mtype_VM = [];
                                        var type = isc.SelectItem.create({
                                            ID: "Mtype",
                                            name: "type",
                                            editorType: "SelectItem",
                                            displayId: "type_div",
                                            valueMap: [],
                                            value: "common",
                                            position: "relative",
                                            width:  290,
                                            
                                            changed:function(form, item, value){//重写changed方法
                                            	typeChangedFun(value);
                                            },
                                            editorExit:"synModelOnBlur(item)"
                                        });
                                        MForm0.addField(type);
                                        Mtype_VM = ['common', 'custom'];
                                        Mtype.displayValueMap = {
                                            'common': '通用',
                                            'custom': '自定义'
                                        };
                                        Mtype.setValueMap(Mtype_VM);
                                        var updateType = "${requestScope.type}";
                                        if(updateType!=null&&updateType.length>0){
		                                        Mtype.setValue(updateType);
                                        }else{
                                        	 Mtype.setValue('common');
                                        }
                                    </script>
                                </td>
                            </tr>
                            <tr id="j_id10" jsId="j_id10">
                                <td id="j_id11" jsId="j_id11" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id12" name="j_id12" style="margin-left:10px">
                                        条件判断方法：
                                    </label>
                                </td>
                                <td id="j_id13" jsId="j_id13" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="condition_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var condition = isc.TextItem.create({
                                            ID: "Mcondition",
                                            name: "condition",
                                            editorType: "TextItem",
                                            displayId: "condition_div",
                                            position: "relative",
                                            width:  290,
                                            canEdit:false,
                                            value:"${requestScope.condition}",
                                            editorExit:function(form, item, value){synModelOnBlur(item)}
                                        });
                                        MForm0.addField(condition);
                                    </script>
                                </td>
                            </tr>
                            
                            
                            <tr id="j_id10" jsId="j_id10">
                                <td id="j_id11" jsId="j_id11" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id12" name="j_id12" style="margin-left:10px">
                                        异步调用数据准备方法：
                                    </label>
                                </td>
                                <td id="j_id13" jsId="j_id13" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="asynJSFunc_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var asynJSFunc = isc.TextItem.create({
                                            ID: "MasynJSFunc",
                                            name: "asynJSFunc",
                                            editorType: "TextItem",
                                            displayId: "asynJSFunc_div",
                                            position: "relative",
                                            width:  290,
                                            canEdit:false,
                                            value:"${requestScope.asynJSFunc}",
                                            editorExit:function(form, item, value){synModelOnBlur(item)}
                                        });
                                        MForm0.addField(asynJSFunc);
                                    </script>
                                </td>
                            </tr>
                            <tr id="j_id14" jsId="j_id14">
                                <td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id16" name="j_id16" style="margin-left:10px">
                                        成功回调函数：
                                    </label>
                                </td>
                                <td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="callbackSuccFunc_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var callbackSuccFunc = isc.TextItem.create({
                                            ID: "McallbackSuccFunc",
                                            name: "callbackSuccFunc",
                                            editorType: "TextItem",
                                            displayId: "callbackSuccFunc_div",
                                            position: "relative",
                                            width: 290,
                                            canEdit:false,
                                             value:"${requestScope.callbackSuccFunc}",
                                            editorExit:"synModelOnBlur(item)"
                                        });
                                        MForm0.addField(callbackSuccFunc);
                                    </script>
                                </td>
                            </tr>
                            <tr id="j_id18" jsId="j_id18">
                                <td id="j_id19" jsId="j_id19" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id20" name="j_id20" style="margin-left:10px">
                                        失败回调函数：
                                    </label>
                                </td>
                                <td id="j_id21" jsId="j_id21" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="callbackFailFunc_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var callbackFailFunc = isc.TextItem.create({
                                            ID: "McallbackFailFunc",
                                            name: "callbackFailFunc",
                                            editorType: "TextItem",
                                            displayId: "callbackFailFunc_div",
                                            position: "relative",
                                            width:  290,
                                            canEdit:false,
                                              value:"${requestScope.callbackFailFunc}",
                                            editorExit:"synModelOnBlur(item)"
                                        });
                                        MForm0.addField(callbackFailFunc);
                                    </script>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input id="id2" type="hidden" name="id2" />
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                </script>
            </div>
        </body>
    
    </html>