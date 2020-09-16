<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1" id="context">
  	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:hidden;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
		<input name="type" id="type" type="hidden" value=""/>
		<input name="id" id="id" type="hidden" value=""/>
		<input name="authId" id="authId" type="hidden" value=""/>
		
		<div class="select-menu">
			<div class="select-btn select" id="process">流程属性</div>
			<div class="select-btn" id="activity">活动属性</div>
			
		</div>
		<div class="select-pane">
			<!-- 流程属性标签页 -->
			<div class="process-pane">
				<table id="table002" style="width:100%;">
					<tr id="tr101">
						<td id="td101" style="width:100%;height:30px;">
							<label id="label101" name="label101" style="font-size:12px;font-weight:700;">
								编码：
							</label>
						</td>
					</tr>
					<tr id="tr102">
						<td id="td102" style="width:100%;">
							<div id="processCode_div" style="vertical-align: middle;">
								<input id="processCode" name="processCode" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
							</div>
						</td>
					</tr>
					<tr id="tr103">
						<td id="td103" style="width:100%;height:30px;">
							<label id="label102" name="label102" style="font-size:12px;font-weight:700;">
								名称：
							</label>
						</td>
					</tr>
					<tr id="tr104">
						<td id="td104" style="width:100%;">
							<div id="processName_div" style="vertical-align: middle;">
								<input id="processName" name="processName" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updateBasicInfoByType(this);"/>
							</div>
						</td>
					</tr>
					<tr id="tr105">
						<td id="td105" style="width:100%;height:30px;">
							<label id="label003" name="label003" style="font-size:12px;font-weight:700;">
								优先级：
							</label>
						</td>
					</tr>
					<tr id="tr106">
						<td id="td106" style="width:100%;">
							<div id="processPriority_div" style="vertical-align: middle;">
								<select id="processPriority" name="processPriority" value="" class="form-control" style="height:100%;width:100%;" onchange="updateBasicInfoByType(this);">
			                       <option value="0">普通</option>
			                       <option value="1">中级</option>
			                       <option value="2">高级</option>
			                       <option value="3">特级</option>
			                    </select>
							</div>
						</td>
					</tr>
					<tr id="tr107">
						<td id="td107" style="width:100%;height:30px;">
							<label id="label104" name="label104" style="font-size:12px;font-weight:700;">
								作者：
							</label>
						</td>
					</tr>
					<tr id="tr108">
						<td id="td108" style="width:100%;">
							<div id="author_div" style="vertical-align: middle;">
								<input id="author" name="author" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" onblur="updateBasicInfoByType(this);"/>
							</div>
						</td>
					</tr>
					<tr id="tr109">
						<td id="td109" style="width:100%;height:30px;">
							<label id="label105" name="label105" style="font-size:12px;font-weight:700;">
								版本：
							</label>
						</td>
					</tr>
					<tr id="tr110">
						<td id="td100" style="width:100%;">
							<div id="version_div" style="vertical-align: middle;">
								<input id="version" name="version" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" onblur="updateBasicInfoByType(this);" readonly="readonly"/>
							</div>
						</td>
					</tr>
					<tr id="tr111">
						<td id="td111" style="width:100%;height:30px;">
							<label id="label106" name="label106" style="font-size:12px;font-weight:700;">
								有效期限：
							</label>
						</td>
					</tr>
					<tr id="tr112">
						<td id="td112" style="width:100%;">
							<span id="label107" name="label107" style="font-size:12px;">自</span>
							<div id="fromDate_div" class="date-default-width col-md-12  input-prepend input-group" style="display: inline-table; vertical-align: middle;height:100%;width:calc(100% - 20px);">
								<input id="fromDate" name="fromDate" value="" class="form-control layer-date" autocomplete="off" 
								style="width:100%;height:100%;padding-left: 5px;">
								<span class="input-group-addon addon-udSelect udSelect" id="fromDate_button"><i class="fa fa-calendar"></i>
								</span>
							</div>
						</td>
					</tr>
					<tr id="tr113">
						<td id="tr113" style="width:100%;">
							<label id="label108" name="label108" style="font-size:12px;">至</label>
							<div id="toDate_div" class="date-default-width col-md-12  input-prepend input-group" style="display: inline-table; vertical-align: middle;height:100%;width:calc(100% - 20px);">
								<input id="toDate" name="toDate" value="" class="form-control layer-date" autocomplete="off" 
								style="width:100%;height:100%;padding-left: 5px;">
								<span class="input-group-addon addon-udSelect udSelect" id="toDate_button"><i class="fa fa-calendar"></i>
								</span>
							</div>
						</td>
					</tr>
					<tr id="tr114">
						<td id="td114" style="width:100%;height:30px;">
							<label id="label109" name="label109" style="font-size:12px;font-weight:700;">
								描述：
							</label>
						</td>
					</tr>
					<tr id="tr115">
						<td id="td115" style="width:100%;">
							<div id="processDesc_div">
								<textarea class="form-control" rows="3" id="processDesc" name="processDesc" style="resize: none;" autocomplete="off" onblur="updateBasicInfoByType(this);"></textarea>
							</div>
						</td>
					</tr>
					<tr id="tr116">
						<td id="td116" style="width:100%;">
							<div class="x-btn" style="height: 30px;line-height: 28px;font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;" onclick="openMoreAttributes();"><span>更多属性</span></div>
						</td>
					</tr>
				</table>
			</div>
			<!-- 活动 连线  泳道属性标签页 -->
			<div class="activity-pane" style="display: none;">
				<div id="emptyMessage" class="empty-message" style="display: none;">请选择节点</div>
				<table id="table001" style="width:100%;" >
					<tr id="tr001">
						<td id="td001" style="width:100%;height:30px;">
							<label id="label001" name="label001" style="font-size:12px;font-weight:700;">
								编码：
							</label>
						</td>
					</tr>
					<tr id="tr002">
						<td id="td002" style="width:100%;">
							<div id="code_div" style="vertical-align: middle;">
								<input id="code" name="code" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
							</div>
						</td>
					</tr>
					<tr id="tr003">
						<td id="td003" style="width:100%;height:30px;">
							<label id="label002" name="label002" style="font-size:12px;font-weight:700;">
								名称：
							</label>
						</td>
					</tr>
					<tr id="tr004">
						<td id="td004" style="width:100%;">
							<div id="name_div" style="vertical-align: middle;">
								<input id="name" name="name" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updateBasicInfoByType(this);"/>
							</div>
						</td>
					</tr>
					<tr id="tr005">
						<td id="td005" style="width:100%;height:30px;">
							<label id="label003" name="label003" style="font-size:12px;font-weight:700;">
								描述：
							</label>
						</td>
					</tr>
					<tr id="tr006">
						<td id="td006" style="width:100%;">
							<div id="desc_div">
								<textarea class="form-control" rows="3" id="desc" name="desc" style="resize: none;" autocomplete="off" onblur="updateBasicInfoByType(this);"></textarea>
							</div>
						</td>
					</tr>
					<tr id="tr007" style="display:none;">
						<td id="td007" style="width:100%;height:30px;">
							<label id="label004" name="label004" style="font-size:12px;font-weight:700;">
								优先级：
							</label>
						</td>
					</tr>
					<tr id="tr008" style="display:none;">
						<td id="td008" style="width:100%;">
							<div id="priority_div" style="vertical-align: middle;">
								<select id="priority" name="priority" value="" class="form-control" style="height:100%;width:100%;" onchange="updateBasicInfoByType(this);">
			                       <option value="0">普通</option>
			                       <option value="1">中级</option>
			                       <option value="2">高级</option>
			                       <option value="3">特级</option>
			                    </select>
							</div>
						</td>
					</tr>
					<tr id="tr009" style="display:none;">
						<td id="td009" style="width:100%;height:30px;">
							<label id="label005" name="label005" style="font-size:12px;font-weight:700;">
								授权类型：
							</label>
						</td>
					</tr>
					<tr id="tr010" style="display:none;">
						<td id="td010" style="width:100%;">
							<div id="authName_div" class="input-group">
								 <input type="text" id="authName" name="authName" value=""  class="form-control">
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialogSec();"><i class="fa fa-search"></i></span>
							</div>
						</td>
					</tr>
					<tr id="tr011">
						<td id="td011" style="width:100%;">
							<div class="x-btn" style="height: 30px;line-height: 28px;font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;" onclick="openSecScope();"><span>数据权限</span></div>
						</td>
					</tr>
					<tr id="tr012">
						<td id="td012" style="width:100%;">
							<div class="x-btn" style="height: 30px;line-height: 28px;font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;" onclick="openMoreAttributes();"><span>更多属性</span></div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	 </form>
  </div>