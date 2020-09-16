"use strict";
 //初始化layer组件
 //用户的部门id、部门名称
var jzUserDeptId = decodeURI($.cookie('jzUserDeptId')).replace(/\"/g, "");
var jzUserDeptName = decodeURI($.cookie('jzUserDeptName')).replace(/\"/g, "");
var getUserDeptId = function(){
    layui.use(['form', 'layer', 'element'], function () {
        var layer = layui.layer;
        var orgtype = parseInt(decodeURI($.cookie('orgType')).replace(/\"/g, ""));
        if(jzUserDeptId == "" || jzUserDeptName == ""){
            if(orgtype > 3){
                var deptData = {
                    "deptid": decodeURI($.cookie('oInfoId')).replace(/\"/g, "")
                };
                getAjaxResult("/deptInfo/getDeptInfo", "POST", deptData, function (data) {
                    if (JSON.parse(data).retCode == "0000000") {
                        //赋值
                        $.cookie("jzUserDeptId", encodeURI(JSON.parse(data).rspBody.deptid), {
                            expires: 1,
                            path: '/'
                        });
                        $.cookie("jzUserDeptName", encodeURI(JSON.parse(data).rspBody.deptname.replace('北京华创动力科技有限公司',"")), {
                            expires: 1,
                            path: '/'
                        });
                        setTimeout(function(){
                            jzUserDeptId = decodeURI($.cookie('jzUserDeptId')).replace(/\"/g, "");
                            jzUserDeptName = decodeURI($.cookie('jzUserDeptName')).replace(/\"/g, "");
                        },0);
    
                    } else {
                        layer.msg(JSON.parse(data).retDesc);
                    }
                });
            }else{
                setTimeout(function(){
                    jzUserDeptId = decodeURI($.cookie('oInfoId')).replace(/\"/g, "");
                    jzUserDeptName = decodeURI($.cookie('oInfoName')).replace(/\"/g, "");
                    $.cookie("jzUserDeptId", encodeURI(jzUserDeptId), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("jzUserDeptName", encodeURI(jzUserDeptName.replace('北京华创动力科技有限公司',"")), {
                        expires: 1,
                        path: '/'
    
                    });
                },0)
            }
        }
    })
};
$(function () {
    layui.use(['form', 'layer', 'element'], function () {
        var element = layui.element;
        var form = layui.form;
        var layer = layui.layer;
    
    });
    //判断浏览器内核
    function getBrowser (){
        var urlText = document.location.href;
        if(urlText.indexOf("/download/") != -1){
            return false;
        }
        var browser = navigator.appName
        var b_version = navigator.appVersion
        var version = b_version.split(";");
        var trim_Version = version[1].replace(/[ ]/g, "");
        // if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE6.0") {
        //     alert("IE 6.0");
        // } else if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE7.0") {
        //     alert("IE 7.0");
        // } 
        //ie8谷歌跳转
        if (browser == "Microsoft Internet Explorer") {
            window.location.href="/sgjtQTI/pages/login/download/gulp-www/download.html";
        }
    } 
//    getBrowser();
});