var str = '';
var copyright="山东省临沂市沂水县安全生产监督管理局[专用];V5.0S0xGAAEAAAAAAAAAEAAAAI8BAACQAQAALAAAAJJ3VQhx0onXtjpLK3X1a3sTUuVSlBqO+pxFoKGCtk6LP6/9yGqPM/p7QX15Q2ZuyOMNJpru6bVwz8Pp8bhYlYvHd8/x0e/d7tRD/oLqJpdu5o4XcWLMPOKDRF77GeiSTT5AzkiJt3CMeqy32IV24I1MqcbWDo1u2F4d0Dqz8WgJgi8yue33q4cRxgvLyLjbVctMw34akX4QBHsNuQSIy3pZDMoDo9Ld4WpZVmj972IOqlpnGv8Ios5HhSZGRM1u1t44zSCoFuiJA17u6O5lNVcYgSs48eBpkkPfsNSPMy5MnExOHq8YYH+7FkDi/1jZ0oQTtvZtxcPc1VvpXAyFZ/zEyjrLNzxixVcy2iaUSlYvgfBQNcVu5i2v4n59TG0qO+re2TnhBOmOMbbG+qmNJ7W+C1yBgj/mcgR8bLxFThkoq+WB10lpo4hwxap2DfMQxrHCERgpXcrAsnX9Pca2ovN9zecU/wEy23K6m/poldVrtTIoFH7V7xIbzmken76HX7XR5//cBD8XiVKOljIrH7+Y7NTq9wozeMyqCRxBDl1W";
str += '<object id="WebOffice2015" ';

str += ' width="100%"';
str += ' height="100%"';

if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window)
{
	str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"  codebase="'+webContextPath+'/office/cab/iWebOffice2015.cab#version="';
	str += '>';
	str += '<param name="Copyright" value="' + copyright + '">';
}
else
{
	str += ' progid="Kinggrid.iWebOffice"';
	str += ' type="application/iwebplugin"';
	str += ' OnCommand="OnCommand"';
	str += ' OnReady="OnReady"';
	str += ' OnOLECommand="OnOLECommand"';
	str += ' OnExecuteScripted="OnExecuteScripted"';
	str += ' OnQuit="OnQuit"';
	str += ' OnSendStart="OnSendStart"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';	
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
str += '</object>';
document.write(str); 
//谷歌中加载插件
function OnControlCreated()
{
	if (browser == "chrome") 
	{
		KGChromePlugin = document.getElementById('WebOffice2015');
		iWebOffice = KGChromePlugin.obj;
		WebOffice.setObj(iWebOffice);
		Load();
	}
}