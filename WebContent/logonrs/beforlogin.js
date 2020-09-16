"use strict";
$(function () {
    //初始化layer组件
  
    layui.use('form', function () {
        //setCookie
        //getCookie
        //判断是否登出
        if($.cookie('logout') === '1'){
            $.cookie('logout', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('acctId', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('idCard', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('limitCode', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('name', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('oInfoId', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('oInfoName', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('roleId', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('curTheme', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('preTheme', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('deptParentId', null, {
                expires: -1,
                path: '/'
            });
            $.cookie('deptParentName', null, {
                expires: -1,
                path: '/'
            });
            $.cookie("jzUserDeptId", null, {
                expires: 1,
                path: '/'
            });
            $.cookie("jzUserDeptName", null, {
                expires: 1,
                path: '/'
            });
            $.cookie("orgType", null, {
                expires: 1,
                path: '/'
            });
        }
        function getCookie() {
            var userName = decodeURI($.cookie('jzuserName')).replace(/\"/g, "") == "undefined"?"":decodeURI($.cookie('jzuserName')).replace(/\"/g, "");
            var pwd = decodeURI($.cookie('acctPassword')).replace(/\"/g, "") == "undefined"?"":decodeURI($.cookie('acctPassword')).replace(/\"/g, "");;
            if (pwd) {
                $('#isCookie').attr('checked', 'checked');
            }
            if (userName != "undefined") {
                $('#qtiUserName').val(userName);
            }
            if (pwd != "undefined") {
                $('#qtiUserPwd').val(pwd);
            }
        }
        getCookie();
        var form = layui.form;
        form.verify({
            user: function (value) {
                if (value === '') {
                    return '请输入用户名';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            content: function (value) {

            }
        });
        //监听提交
        form.on('submit(login)', function (logindata) {
            var useCookie = $('#isCookie').attr('checked');
            // var userTxt = JSON.stringify(data.field);
            console.log(logindata.field)
            getAjaxResult("/user/login", "post", logindata.field, function (data) {
                if (JSON.parse(data).retCode == "0000000") {
                    layer.msg(JSON.parse(data).retDesc);
                    if (useCookie) {
                        $.cookie('jzuserName', encodeURI(JSON.stringify( $('#qtiUserName').val())), {
                            expires: 7,
                            path: '/'
                        });
                        $.cookie('acctPassword', encodeURI(JSON.stringify( $('#qtiUserPwd').val())), {
                            expires: 7,
                            path: '/'
                        });
                    } else {
                        $.cookie('acctPassword', null);
                    }
                    var limitCodeArr = JSON.parse(data).rspBody.permissions
                    //登陆时，登陆成功后，把后台返回的权限集合存储在localStorage中
                    // setCookie("limitCode", JSON.stringify(limitCodeArr));
                    $.cookie("limitCode", JSON.stringify(limitCodeArr), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("roleId", JSON.stringify(JSON.parse(data).rspBody.roleId.split(';')), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("idCard", encodeURI(JSON.stringify(JSON.parse(data).rspBody.idCard)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("name", encodeURI(JSON.stringify(JSON.parse(data).rspBody.name)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("acctId", encodeURI(JSON.stringify(JSON.parse(data).rspBody.acctId)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("oInfoId", encodeURI(JSON.stringify(JSON.parse(data).rspBody.oInfoId)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("oInfoName", encodeURI(JSON.stringify(JSON.parse(data).rspBody.oInfoName)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("deptParentId", encodeURI(JSON.stringify(JSON.parse(data).rspBody.deptParentId)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("deptParentName", encodeURI(JSON.stringify(JSON.parse(data).rspBody.deptParentName)), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("jzUserDeptId", encodeURI(""), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("jzUserDeptName", encodeURI(""), {
                        expires: 1,
                        path: '/'
                    });
                    $.cookie("orgType", encodeURI(JSON.stringify(JSON.parse(data).rspBody.orgType)), {
                        expires: 1,
                        path: '/'
                    });
                    window.location.href='/sgjtQTI/pages/login/afterlogin/html-gulp-www/afterlogin.html';
                } else {
                    //报错分析
                    //layer.msg(JSON.parse(data).retDesc);
                    layer.msg('系统维护中请稍后再试...');
                }
            });
            return false;
        });
        $('body').keydown(function (e) {
            if (event.keyCode == 13) { //回车键的键值为13
                $('a[lay-filter="login"]').click();
            }
        });
    });


});