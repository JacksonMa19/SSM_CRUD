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
    <div class="container">
        <%--title行--%>
        <div class="row">
            <div class="col-md-12">
                <H1>SSM-CRUD</H1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 col-md-offset-8">
                <button type="button" class="btn btn-primary btn-sm">新增</button>
                <button  type="button" class="btn btn-danger btn-sm">删除</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button type="button" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页，共${pageInfo.pages}页，共${pageInfo.total}条记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">

                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        

                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>

        </div>
    </div>

</body>
</html>
