<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>业务日历预览</title>
		 <!-- dojo info -->
		 <jsp:include page="/form/html5/admin/html5Head.jsp"/>
		 <jsp:include page="/form/admin/common/taglib.jsp" />
         <jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
			function showTimeAreaClick(ele){
				if(ele.checked)
					document.forms[0].showTimeArea.value='02';
				else
					document.forms[0].showTimeArea.value='01';
					
				document.forms[0].action="<%=request.getContextPath()%>/calendar/calendarAction_previewContentOfCalendar.action";
				document.forms[0].submit();
			}
			function calendarSelectChange(){
				document.forms[0].action="<%=request.getContextPath()%>/calendar/calendarAction_previewContentOfCalendar.action";
				document.forms[0].tag.value="change";
				document.forms[0].submit();
			}
			function monthchange(tag){
				document.forms[0].tag.value=tag;
				document.forms[0].action="<%=request.getContextPath()%>/calendar/calendarAction_previewContentOfCalendar.action";
				document.forms[0].submit();
			}
			
			function backToList(){
				document.forms[0].action="<%=request.getContextPath()%>/calendar/calendarAction_getBusinessCalendars.action";
				document.forms[0].submit();
			}
		</script>
		<style type="text/css">
			body {
				font-family:verdana,tahoma,helvetica;
				padding:20px;
				padding-top:5px;
				font-size:12px;
				margin:0px auto;
				text-align:center;
			}
		</style>
	</head>
	<body class="claro">
			<form action="" method="post">
		<table width="784px" height="auto" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<br>
			<td>
	     		<table width="96%" align="center" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="10" align="center">
	                  <a href="javascript:monthchange('month_minus');" class="see" title="上一月">&lt;&lt;</a>
					</td>
	                <td height="10" align="center" style="font-size:14px">
	                	业务日历:
	                	<c:choose>
	                		<c:when test="${fromPlace=='list'}">
	                			<c:forEach items="${calendars}" var="calendars">
									<c:if test="${calendarId==calendars.calendarId }" >
										<c:out value="${calendars.calendarName }"/>
										<input type="hidden" name="calendarId" value="<c:out value='${calendarId }' />">
									</c:if>
								</c:forEach>
	                		</c:when>
	                		<c:otherwise>
	                			<select name="calendarId" onchange="calendarSelectChange();">
									<option></option>
									<c:forEach items="${calendars}" var="calendars">
										<option value="<c:out value="${calendars.calendarId }"/>" <c:if test="${calendarId==calendars.calendarId }" >selected</c:if>>
											<c:out value="${calendars.calendarName }"/>
										</option>
									</c:forEach>
			                	</select>
	                		</c:otherwise>
	                	</c:choose>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                	<select name="year" onchange="calendarSelectChange();">
							<c:forEach begin="${currentYear-5}" end="${currentYear+5}" step="1" var="y">
								<option value="<c:out value="${y}"/>" <c:if test="${currentYear==y}">selected</c:if> ><c:out value="${y}"/></option>
							</c:forEach>
	                	</select> 年
						<select name="month" onchange="calendarSelectChange();">
							<c:forEach begin="0" end="11" step="1" var="m">
								<option value="<c:out value="${m}"/>" <c:if test="${currentMonth==m}">selected</c:if> ><c:out value="${m+1}"/></option>
							</c:forEach>
						</select> 月 &nbsp;&nbsp;
						<input type="checkBox" id="showTimeArea_page" name="showTimeArea_page" <c:if test="${showTimeArea=='02'}">checked</c:if> onclick="javasript:showTimeAreaClick(this)" > 显示时间
						<input type="hidden" name="showTimeArea" value="<c:out value="${showTimeArea}"/>">
					</td>
	                <td height="10" align="center"><a href="javascript:monthchange('month_add');" title="下一月" class="see">&gt;&gt;</a></td>
	           	  </tr>
	           </table>
			</td>
		</tr>
		<tr height="5px"><td colspan="7"></td></tr>
		<tr>
			<td >
				<TABLE cellSpacing=1 cellPadding=0 width="100%" bgColor=#EFEFEF border=0 class="table1">
					<TR class=left_td valign=middle align="center" class="title3">
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周日</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周一</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周二</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周三</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周四</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周五</font></TD>
						<TD height="25" bgcolor="#b5dbeb"><font color="#FFFFFF" style="font-size:15px;font-weight:bold">周六</font></TD>
					</TR>
					<TR height="50" align="right" bgColor="#ffffff" style="font-size:14px;font-weight:bold;text-indent:5px;">
					<c:forEach items="${previewList}" var="previewItem" varStatus="status">
						<c:if test="${status.index%7==0}">
						</tr>
							
						<TR height="50" align="right" bgColor="#ffffff" style="font-size:14px;font-weight:bold;text-indent:5px;">
						</c:if>
					
						<td height="50" 
							<c:choose>
								<c:when test="${(status.index%7==0||status.index%7==6)&&previewItem.dayType!='01'&& previewItem.dayType!='02'}">bgColor=#fcfee4</c:when>
								<c:when test="${previewItem.dayType=='01'}">bgColor=ebf2fe</c:when>
								<c:when test="${previewItem.dayType=='02'}">bgColor=ff8955</c:when>
							</c:choose>
							<c:if test="${status.index%7==0||status.index%7==6}"> style="color:red"</c:if> 
							<c:if test="${(previewItem.dayType=='02' || previewItem.dayType=='03')&&showTimeArea!='02'}"> title="<fmt:message key="calendar.workTime"/>：<c:forEach items="${previewItem.dayTimeRangeList}" var="timeItem" varStatus="statuss"><c:out value="${timeItem }" /> </c:forEach>"</c:if> 
							valign="top" width="112px">
							<div align="left"><b>
								<c:choose>
									<c:when test="${previewItem.day==0}">&nbsp;</c:when>
									<c:otherwise><c:out value="${previewItem.day}"/></c:otherwise>
								</c:choose>
							</b>
							<c:if test="${(previewItem.dayType=='02' || previewItem.dayType=='03')&&showTimeArea=='02'}">
								<table height="45" cellSpacing=1 cellPadding=0 width="99%"  border=0
									 class="calendar_am_1" style="font-size:11px;font-weight:100" ><TBODY>
									<tr>
										<td height="2px"></td>
									</tr>
									<c:forEach items="${previewItem.dayTimeRangeList}" var="timeItem_" varStatus="statuss_">
										<tr>
											<td width="80%" align="center" valign="top">
												<c:out value="${timeItem_ }" />
											</td>
										</tr>
									</c:forEach>
									</TBODY>
								</table>
							</c:if>
							</div>
						</td>
					</c:forEach>
					</TR>	
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="7" align="center">
				<table width="45%" border="0" style="font-size:12px">
					<tr>
						<td><div style="background:#ebf2fe;width:15px;height:10px;margin:3px auto;"></div></td>
						<td>公共假日</td>
						<td><div style="background:#ff8955;width:15px;height:10px;margin:3px auto;"></div></td>
						<td>特殊工作日</td>
						<td><div style="background:#fcfac9;width:15px;height:10px;margin:3px auto;"></div></td>
						<td>周末</td>
						<td align="right">注:普通工作日为白色></td>
					</tr>
				</table>
			</td>
		</tr>			
	</table>
	<!-- 标识上一个月 下一个月 -->
	<input type="hidden" name="tag"> 
	<!-- 标识业务日历预览入口 -->
	<input type="hidden" name="fromPlace" value="${fromPlace }">
		<c:if test="${fromPlace=='list'}">
			<center>
				<br/>
				<input type="button" class="x-btn ok-btn" dojoType="dijit.form.Button" 
						title="<fmt:message key="calendar.returnListInfo"/>"
						onclick="backToList();" value="返回">
			</center>
		</c:if>
	 </form>
	<br>
	</body>
</html>
