<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- Bootstrap -->
    <link
            href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>
<body>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <!-- 员工新增模态框Modal -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input"
                                       placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label" name="email">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_add_input"
                                       placeholder="email@rytong.com">
                                <span class="help-block"></span>

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_check" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_check" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="deptName_add_select">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="deptName_add_select">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
        <%-- 员工编辑模态框--%>
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_update_input"
                                       placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label" name="email">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_update_input"
                                       placeholder="email@rytong.com">
                                <span class="help-block"></span>

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_check" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_check" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="deptName_add_select">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="deptName_update_select">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>
    <%--按钮位置--%>
    <div class="row">
        <div class="col-md-4  col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <!-- 分页信息 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条 -->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<div class="row"></div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
        src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var totalRecord;
    $(function () {
        //去首页
        to_page(1);
    })

    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? '男' : '女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /***
             * <button type="button" class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true">新增
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append能链式调用的原因是元素
            $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");

        })
    }

    //解析分页信息方法
    function build_page_info(result) {
        //清空分页信息方法
        $("#page_info_area").empty();
        $("#page_info_area").append("当前页数：" + result.extend.pageInfo.pageNum + "，总共" + result.extend.pageInfo.pages + "页，总共" + result.extend.pageInfo.total + "条记录")
        totalRecord = result.extend.pageInfo.total;
    }

    //解析分页导航条
    function build_page_nav(result) {
        //清空分页导航条
        $("#page_nav_area").empty();
        //创建父元素 ul
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));

        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
        if (result.extend.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled")
            nextPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })

        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });

            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);
        //把拼接后的ul添加到对应的父元素中
        var nav = $("<nav></nav>").append(ul);


        nav.appendTo($("#page_nav_area"));
    }

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并展示员工数据
                build_emps_table(result);
                //2.解析并显示分页数据
                build_page_info(result);
                //3.解析并显示导航条
                build_page_nav(result);
            }
        })
    }

    //为用户名输入框添加onblur事件
    $("#empName_add_input").blur(function () {
        var empName = $("#empName_add_input").val();
        if ("" == empName) {
            $("#empName_add_input").parent().removeClass("has-success has-error");
            $("#empName_add_input").next("span").text("");
            return;
        }
        $.ajax({
            url: "${APP_PATH}/checkEmpName",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#empName_add_input").attr("ajax-vl", "success");
                } else if (result.code == 200) {
                    show_validate_msg("#empName_add_input", "error", result.extend.msg_vl);
                    $("#empName_add_input").attr("ajax-vl", "error");
                }
            }
        })
    });

    //为新增按钮绑定点击事件
    $("#emp_add_modal_btn").click(function () {
        $("#empAddModal form")[0].reset();
        $("#empName_add_input").parent().removeClass("has-success has-error");
        $("#empName_add_input").next("span").text("");
        $("#email_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").next("span").text("");
        //在弹出模态框之前发送ajax请求获取部门列表
        getDepts("#empAddModal select");

        //点击新增按钮弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"

        })
    });

    function validate_add_form() {
        //1.拿到要校验的数据使用正则表达式进行校验
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        var empNameFlag = true;
        var emailFlag = true;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error",);
            empNameFlag = false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        var email = $("#email_add_input").val();
        regName = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regName.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            emailFlag = false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        if (empNameFlag == false || emailFlag == false) {
            return false;
        } else {
            return true;
        }
    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }

    }

    //为保存按钮绑定点击事件
    $("#emp_save_btn").click(function () {
        var checkEmpName = $("#empName_add_input").attr("ajax-vl");
        if (checkEmpName == "error") {
            return;
        } else if (checkEmpName == "success") {

        }
        //在保存之前进行正则表达式的校验
        if (!validate_add_form()) {
            return;
        }

        //静态模板中保存的表单数据提交给服务器进行保存
        //发送ajax请求 新增员工信息
        $.ajax({
            url: "${APP_PATH}/emps",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code == 100) {
                    //关闭模态框
                    $("#empAddModal").modal("hide");
                    //跳转到最后一页
                    to_page(totalRecord);

                } else {
                    if (undefined != result.extend.errorFieldMap.email) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFieldMap.email);
                    }
                    if (undefined != result.extend.errorFieldMap.empName) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFieldMap.empName);
                    }
                }
            }
        })
    });

    function getDepts(ele) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result)
                $(ele).empty();
                $.each(result.extend.depts, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId)
                    optionEle.appendTo($(ele));
                })

            }
        })
    }

    //为编辑按钮添加点击事件
    //1.在创建按钮时添加点击事件，2.绑定点击。live()
    //3.jquery新版没有live 用 on 代替
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        //查出员工信息
        getDepts("#empUpdateModal select");
        //查出部门信息，并显示部门列表
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static",
        })
    })
</script>
</body>
</html>