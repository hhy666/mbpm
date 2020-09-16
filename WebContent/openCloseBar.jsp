<%@ page contentType="text/html;charset=UTF-8"%>
<html>
	<head>
		<title>华创动力流程管理系统</title>
		<link href="/resource/default.css" rel="stylesheet" type="text/css">
		<script language=javascript type=text/javascript>
		function changeLeft()
		{    
			frmElem=window.parent.document.getElementById("fmain");
			if (frmElem.cols != "0, 9, *") 
			{	
				frmElem.cols = "0, 9, *";
				Elem=document.getElementById('menuSwitch')
				Elem.innerHTML="<img src=\"/moffice/resource/images/fopen.jpg\">";
			} 
			else 
			{	
				frmElem.cols = "150, 9, *";
				Elem=document.getElementById('menuSwitch')
				Elem.innerHTML="<img src=\"/moffice/resource/images/fclose.jpg\">";
			}
		}
		</script>
	</head>

	<body id="midbar" background="/moffice/resource/images/f5_bg.jpg">
		<table style="CURSOR: pointer" height="100%" cellSpacing=0 cellPadding=0 width="100%" border="0">
			<tbody>
				<tr>
					<td id="menuSwitch" onclick="changeLeft()" height="100%">
						<IMG src="/moffice/resource/images/fclose.jpg" width="9" height="48">
					</td>
				</tr>
			</tbody>
		</table>
	</body>
</html>
