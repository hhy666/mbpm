"use strict";
$(function(){
    var titleJson = {
        "users": {
            /******************************************************************************
             * 采购端
             ***************************************************************************/
            //login 登陆
            "login":{
                "beforlogin.html": '登 录',
                "afterlogin.html": "首 页"
            },
            "declare":{  //declare 我要申报
                "brightSpot.html":"改善亮点",
                "proposal.html":"改善提案",
                "topic.html":"改善课题"
            },
            "integral":{ //integral  积分明细
                "departmentRank.html":"部门排行",
                "eprizes.html":"兑换奖品",
                "pplIntegral.html":"个人积分",
                "intcollartable.html":"积分领用表",
                "employeeRatings.html":"员工评分",
                "departmentalScore.html":"部门评分"
            },
            "listOfQuestion":{ //listOfQuestion  问题清单
                "department.html":"部门级",
                "operationArea.html":"作业区级"
            },
            "resourceSharing":{//resourceSharing   资源共享
                "rSharing.html":"资源共享"
            },
            "standbyCenter":{//standbyCenter 统一待办中心
                "standby.html":"统一代办中心"
            }
        },
        "admin": {
            /******************************************************************************
             * 管理端
             ***************************************************************************/
        }
    };
    function titleEval(titleJson) {//赋值每一个页面的title
        var urlText = document.location.href;
        var titleVar = {};
        if (urlText.indexOf("/pages/") != -1) {//客户端
            titleVar = titleJson.users;
        } else if (urlText.indexOf("/purchaser/") == -1 && urlText.indexOf("/meetingCenter/") != -1) {//管理端
            titleVar = titleJson.admin;
        }
        for (var key in titleVar) {
            if (urlText.indexOf(key) != -1) {
                console.log(urlText.indexOf(key));
                var titleVarJson = titleVar[key];
                console.log(titleVarJson,'titleVarJson');
                for (var key2 in titleVarJson) {
                    if (urlText.indexOf(key2) != -1) {
                        // $("title").eq(0).html(titleVarJson[key2]);ie8及一下不支持用这种方法给title赋值
                        document.title = titleVarJson[key2];
                    }
                }
            }
        }
    }
    titleEval(titleJson);
        
});