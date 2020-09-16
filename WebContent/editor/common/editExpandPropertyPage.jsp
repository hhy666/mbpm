<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>编辑扩展属性</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style>
		#font2{
			font-size:16px;
			margin-left:10px;
			font-weight:bold;
		}
		#td107{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
	</style>
	<script type="text/javascript">
		//页面加载初始
		window.onload=function(){
			debugger;
			var data = parent.data;
			if(data){
				var propertyName = data.propertyName;
				var expandProperty = convertExpandProperty(data.expandProperty);
				var propertyType = convertPropertyType(data.propertyType);
				var propertyValue = data.propertyValue;
				
				if(propertyName!=null && propertyName.length>0 && propertyName!='undefined'){
					Matrix.setFormItemValue('input001',propertyName);
				}
				if(propertyType!=null && propertyType.length>0 && propertyType!='undefined'){
					if(propertyType=='2'){     //静态值
						$('#input301').attr('readonly',false);
						$('#input002').attr('readonly',true);
						$('#popupSelectDialog001_button').addClass('notclickn');
						if(propertyValue!=null && propertyValue.length>0){
							$('#input301').val(propertyValue);
						}
					}else if(propertyType=='1'){     //流程变量
						$('#input301').attr('readonly',true);
						$('#input002').attr('readonly',true);
						$('#popupSelectDialog001_button').removeClass('notclickn');
						if(propertyValue!=null && propertyValue.length>0){
							$('#input002').val(propertyValue);
					    }
					}
				}
			}
			//监听单选按钮的选择状态
			$("input:radio[name='type']").on('ifChecked', function(event){
			      var value = $(this).val();  //1.流程变量。2.静态值。
			      if(value == 2){   //静态值
			    	  $('#input301').attr('readonly',false);
					  $('#input002').attr('readonly',true);
					  $('#popupSelectDialog001_button').addClass('notclickn');
					  $('#input002').val('');
				  }else if(value == 1){   //流程变量
					  $('#input301').attr('readonly',true);
					  $('#input002').attr('readonly',true);
					  $('#popupSelectDialog001_button').removeClass('notclickn');
					  $('#input301').val('');
			      }	     
			      window.focus();
			});
		}
		
		function convertExpandProperty(expandProperty){
			if(expandProperty == '扩展属性A'){
				return 'exttributeA';
			}else if(expandProperty == '扩展属性B'){
				return 'exttributeB';
			}else if(expandProperty == '扩展属性C'){
				return 'exttributeC';
			}else if(expandProperty == '扩展属性D'){
				return 'exttributeD';
			}else if(expandProperty == '扩展属性E'){
				return 'exttributeE';
			}else if(expandProperty == '扩展属性F'){
				return 'exttributeF';
			}else if(expandProperty == '扩展属性G'){
				return 'exttributeG';
			}else if(expandProperty == '扩展属性H'){
				return 'exttributeH';
			}
		}
		
		function convertPropertyType(propertyType){
			if(propertyType == '流程变量'){
				return '1';
			}else if(propertyType == '静态'){
				return '2';
			}
		}
		
		function restoreExpandProperty(expandProperty){
			if(expandProperty == 'exttributeA'){
				return '扩展属性A';
			}else if(expandProperty == 'exttributeB'){
				return '扩展属性B';
			}else if(expandProperty == 'exttributeC'){
				return '扩展属性C';
			}else if(expandProperty == 'exttributeD'){
				return '扩展属性D';
			}else if(expandProperty == 'exttributeE'){
				return '扩展属性E';
			}else if(expandProperty == 'exttributeF'){
				return '扩展属性F';
			}else if(expandProperty == 'exttributeG'){
				return '扩展属性G';
			}else if(expandProperty == 'exttributeH'){
				return '扩展属性H';
			}
		}
		
		function restorePropertyType(propertyType){
			if(propertyType == '1'){
				return '流程变量';
			}else if(propertyType == '2'){
				return '静态';
			}
		}
		
		//弹出流程变量窗口
		function openpopupSelectDialog001(){
			parent.openVariables9(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="propertyValue" name="propertyValue" value="${param.propertyValue }"/>
	<input type="hidden" id="propertyType" name="propertyType" value="${param.propertyType }"/>
	<input name="propertyName" id="propertyName" type="hidden" value="${param.propertyName }"/>
	<input name="expandProperty" id="expandProperty" type="hidden" value="${param.expandProperty }"/>
	<table id="table301" class="tableLayout" style="width:100%;">
		<tr>
			<td id="td001" class="tdLabelCls" style="width:20%;text-align:center;">
				<label id="label001" name="label001" id="label001">
					名称：
				</label>
			</td>
			<td id="td002" class="tdLabelCls" style="width:80%">
				<div id="input001_div" class="input-group" style="width:100%;">
					 <input type="text" id="input001" name="input001" value=""  class="form-control">
				</div>
			</td>
		</tr>
		<tr id="tr308">
			<td id="td003" class="tdLabelCls" style="width:20%;"><label id="label002" name="label002" style="font-weight: 700;">
					设定值：</td>
			<td id="td373" class="tdLabelCls" style="width:80%;text-align:left;">
				<div style="float:left;line-height: 35px;width:90px;">
					<div id="radio302_div" style="display: inline-table;" >
						<input type="radio" class="box" name="type" id="type_0" value="2" ${param.propertyType=='2'?'checked':''}/>
					</div>
					<label name="label0032" id="label0032" class="control-label ">
						静态值
					</label>	
				</div>	
				<div id="input301_div" class="input-group" style="display: inline-table;width:calc(100% - 90px);vertical-align: middle;">
					 <input type="text" id="input301" name="input301" value=""  class="form-control">
				</div>
			</td>
		</tr>
		<tr id="tr309">
			<td id="td005" class="tdLabelCls" style="width:20%;"></td>
			<td id="td383" class="tdLabelCls" style="width:80%;text-align:left;">
				<div style="float:left;line-height: 35px;width:90px;">
					<div id="radio303_div" style="display: inline-table;" >
						<input type="radio" class="box" name="type" id="type_1" value="1" ${param.propertyType=='1'?'checked':''}/>
					</div>
					<label name="label0032" id="label0032" class="control-label ">
						流程变量
					</label>	
				</div>	
				<div id="radio303_div" class="input-group" style="width:calc(100% - 90px);">
					 <input type="text" id="input002" name="input002" value=""  class="form-control" readonly="readonly">
					 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();" id="popupSelectDialog001_button"><i class="fa fa-search"></i></span>
				</div>		
			</td>
		</tr>
		<tr>
			<td class="cmdLayout" colspan="2">
				<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
				<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
				<script type="text/javascript">
			        $(".ok-btn").on("click",function(){
			        	debugger;
						var jsonObj = Matrix.formToObject('form0');
						if(jsonObj!=null){
							var newData = {};
							newData.expandProperty = restoreExpandProperty(jsonObj.expandProperty);
							newData.propertyName = jsonObj.input001;
							newData.propertyType = restorePropertyType(jsonObj.type);
							if(jsonObj.type == '2'){    //静态值
								newData.propertyValue = jsonObj.input301;
							}else if(jsonObj.type == '1'){      //流程变量
								newData.propertyValue = jsonObj.input002;
							}
							Matrix.closeWindow(newData);
						}
			        });
			        
			        $(".cancel-btn").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>
			</td>
		</tr>
   </table>
  </form>
 </div>
</body>
</html>