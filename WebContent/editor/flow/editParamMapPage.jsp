<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>编辑参数映射</title>
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
			var data = parent.data;
			if(data){
				var structId = data.structId;
				var type = data.type;
				var value = data.value;
				if(type!=null && type.length>0 && type!='undefined'){
					$('#structId').val(structId);
					if(type=='2'){  //静态值
						$('#input301').attr('readonly',false);
						$('#input002').attr('readonly',true);
						$('#popupSelectDialog001_button').addClass('notclickn');
						if(value!=null && value.length>0){
							$('#input301').val(value);
						}
					}else if(type=='1'){   //流程变量
						$('#input301').attr('readonly',true);
						$('#input002').attr('readonly',true);
						$('#popupSelectDialog001_button').removeClass('notclickn');
						if(value!=null && value.length>0){
							$('#input002').val(value);
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
		
		//弹出流程变量窗口
		function openpopupSelectDialog001(){
			parent.openMappingVariables(this);  
		}
		
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="structId" name="structId" value="${param.structId }"/>
	<input type="hidden" id="ysType" name="ysType" value="${param.ysType }"/>
	<input type="hidden" id="ysValue" name="ysValue" value="${param.ysValue }"/>
	<input type="hidden" id="oldValue" name="oldValue" value="${param.oldValue }"/>
	<input type="hidden" id="newValue" name="newValue" value="${param.oldValue }"/>
	<input type="hidden" id="flowType" name="flowType" value="${param.flowType} }" />
	<table id="table301" class="tableLayout" style="width:100%;">
		<tr id="tr308">
			<td id="td003" class="tdLabelCls" style="width:20%;"><label id="label002" name="label002" style="font-weight: 700;">
					设定值：
				</label></td>
			<td id="td373" class="tdLabelCls" style="width:80%;text-align:left;">
				<div style="float:left;line-height: 35px;width:90px;">
					<div id="radio302_div" style="display: inline-table;" >
						<input type="radio" class="box" name="type" id="type_0" value="2" ${param.ysType=='2'?'checked':''}/>
					</div>
					<label name="label0032" id="label0032" class="control-label">
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
						<input type="radio" class="box" name="type" id="type_1" value="1" ${param.ysType=='1'?'checked':''}/>
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
							newData.structId = jsonObj.structId;
							newData.ysType = jsonObj.type;
							if(jsonObj.type == '2'){     //静态值
								newData.typeName = '静态值';
								newData.ysValue = jsonObj.input301;
							}else if(jsonObj.type == '1'){   //流程变量
								newData.typeName = '流程变量';
								newData.ysValue = jsonObj.input002;
								var newValue = Matrix.getFormItemValue('newValue');
								newData.newValue = newValue;
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