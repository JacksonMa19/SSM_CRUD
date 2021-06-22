<%--
  Created by IntelliJ IDEA.
  User: Jackson
  Date: 2021/5/23
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%--不以/开头的相对路径。以当前路径为基准，经常容易出问题--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.3.min.js"></script>
    <link  href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal 添加员工模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input" placeholder="员工姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--title行--%>
    <div class="row">
        <div class="col-md-12">
            <H1>SSM-CRUD</H1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 col-md-offset-8">
            <button id="emp_add_modal_btn" type="button" class="btn btn-primary btn-sm">新增</button>
            <button id="emp_delete_all_btn" type="button" class="btn btn-danger btn-sm">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"></th>
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
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">


        </div>

    </div>
</div>

<script type="text/javascript">

    var totalRecord;
    var currentPage;
<%--    页面加载成功之后直接发起一个ajax请求--%>
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function (result){
                /*
                    解析和显示员工数据
                */
                build_emps_table(result)
                build_page_info(result)
                build_page_nav(result)
            }
        })
    }

    function build_emps_table(result) {
        //清空区域数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBox = $("<td><input type='checkbox' class='check_item'></input></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            editBtn.attr("edit-id", item.empId)

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            delBtn.attr("delete-id", item.empId)

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBox)
                        .append(empIdTd)
                          .append(empNameTd)
                            .append(genderTd)
                         .append(emailTd)
                        .append(deptNameTd)
                        .append(btnTd)

                .appendTo("#emps_table tbody")
        })

    }
    function build_page_info(result) {

        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页，共"+result.extend.pageInfo.pages
            +"页，共"+result.extend.pageInfo.total+"条记录")

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;

    }
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination")
        var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"))
        //添加单击事件

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPage.addClass("disabled");
            prePage.addClass("disabled")
        } else {
            firstPage.click(function () {
                to_page(1)
            })
            prePage.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var num = $("<li></li>").append($("<a></a>").append(item).attr("href","#"))
        })

        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"))
        var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"))


        if (result.extend.pageInfo.hasNextPage == false) {
            nextPage.addClass("disabled");
            lastPage.addClass("disabled")
        } else {
            nextPage.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            })
            lastPage.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }
        ul.append(firstPage).append(prePage)
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var num = $("<li></li>").append($("<a></a>").append(item).attr("href","#"))
            if (result.extend.pageInfo.pageNum == item) {
                num.addClass("active")
            } else {

            }
            num.click(function () {
                to_page(item)
            })
            ul.append(num)
        })
        ul.append(nextPage).append(lastPage);
        var nav = $("<nav></nav>").append(ul)
        nav.appendTo("#page_nav_area")
    }

    function reset_form(element) {
        $(element)[0].reset();
        $(element).find("*").removeClass("has-error has-success")
        $(element).find(".help-block").text("")
    }

    $("#emp_add_modal_btn").click(function () {

        //清楚表单数据
        reset_form("#empAddModal form");

        getDepts("#empAddModal select");
        $('#empAddModal').modal({
            backdrop:"static",
            keyboard: true
        })
    })

    function getDepts (element) {
        $(element).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {

                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(element);
                })
            }

        })
    }

    //前端校验表单
    function validate_form() {
        let empName = $("#empName_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {

            shou_validateMsg("#empName_input", "error", "格式错误：用户名可以2-5个中文或6-16个英文和数字的组合")

            return false;
        } else {
            shou_validateMsg("#empName_input", "success", "格式正确")
        }
        let email = $("#email_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (! regEmail.test(email)) {

            shou_validateMsg("#email_input", "error", "邮箱格式错误")

            return false;
        } else {
            shou_validateMsg("#email_input", "success", "格式正确")
        }
        return true;
    }

    function shou_validateMsg(element, status, msg) {

        //清样式
        $(element).parent().removeClass("has-success has-error");
        $(element).next("span").text("")
        if ("success" == status) {
            $(element).parent().addClass("has-success");
            $(element).next("span").text(msg)
        } else if ("error" == status) {
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg)
        }

    }

    $("#empName_input").change(function () {
        var name = this.value;
        $.ajax({
            url: "${APP_PATH}/checkEmployee",
            data: "empName="+name,
            type:"POST",
            success:function (result) {
                if (result.code == 100) {
                    shou_validateMsg("#empName_input", "success", "用户名可用");
                    $("#emp_save").attr("ajax-va","success")
                } else {
                    shou_validateMsg("#empName_input", "error", result.extend.va_msg);
                    $("#emp_save").attr("ajax-va","error")
                }
            }

        })
    })
    $("#emp_save").click(function () {
        // alert($("#empAddModal formm").serialize())

        if (!validate_form()) {
            return false;
        }

        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                if (result.code == 100) {
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //来到最后一页
                    //发送AJAX来显示最后一页
                    to_page(totalRecord);
                } else {
                    if (result.extend.errorFields.email != undefined) {
                        shou_validateMsg("#email_input", "error", result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName != undefined) {
                        shou_validateMsg("#empName_input", "error", result.extend.errorFields.empName);
                    }
                }


            }
        })
    })


    $(document).on("click", ".edit_btn", function () {

        getDepts("#empUpdateModal select")
        getEmp($(this).attr("edit-id"))
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit-id"))
        $('#empUpdateModal').modal({
            backdrop:"static",
            keyboard: true
        })
    })

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                let empdata = result.extend.emp;
                $("#empName_update_static").text(empdata.empName);
                $("#email_update").val(empdata.email);
                $("#empUpdateModal input[name=gender]").val([empdata.gender])
                $("#empUpdateModal select").val([empdata.dId])
            }
        })
    }

    $("#emp_update_btn").click(function () {
        //邮箱验证
        let email = $("#email_update").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (! regEmail.test(email)) {
            shou_validateMsg("#email_upadate", "error", "邮箱格式错误")
            return false;
        } else {
            shou_validateMsg("#email_update", "success", "格式正确")
        }

        var id = $(this).attr("edit_id")
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                $("#empUpdateModal").modal('hide');
                to_page(currentPage);
            }

        })
    })

    $(document).on("click", ".delete_btn", function () {
        var depName = $(this).parents("tr").find("td:eq(2)").text()
        if (confirm("确认删除【"+depName+"】")) {
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("delete-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })

    $("#check_all").click(function () {

        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    $(document).on("click", ".check_item" ,function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);

    })

    $("#emp_delete_all_btn").click(function () {
        var empNames = " "
        var del_idstr = ""
        $.each($(".check_item:checked") , function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+"，"
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-"
        })
        empNames = empNames.substring(0, empNames.length-1)
        del_idstr = del_idstr.substring(0, del_idstr.length-1)

        if (confirm("确认删除【"+empNames+"】吗？")) {
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function () {
                    to_page(currentPage)
                }

            })
        }
    })
</script>

</body>
</html>
