<%--
  Created by IntelliJ IDEA.
  User: CYH
  Date: 2019/11/12
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PersonalBookBorrowRecord</title>
    <link href="${pageContext.request.contextPath}/css/base.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tab.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item_do.css"
          type="text/css" rel="stylesheet">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/uploadify.css"
          type="text/css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.uploadify.v2.0.3.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/swfobject.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
    <script type="text/javascript">
        function renewBook(index) {
            $("#dg").datagrid("selectRow", index);
            var row = $("#dg").datagrid("getSelected");
            if(row) {
                if(row.renewTimes == 1) {
                    $.messager.alert("系统提示", "您已经续借过此书，不能再续借！");
                    return;
                }
                $.messager.confirm("系统提示", "您确认要续借吗？",
                    function(r) {
                        if(r) {
                            $.post("${pageContext.request.contextPath}/bookborrow/renewBook.do", {
                                id: row.id
                            }, function(result) {
                                if(result.success) {
                                    $.messager.alert("系统提示", "续借成功！");
                                    $("#dg").datagrid("reload");
                                } else {
                                    $.messager.alert("系统提示", "续借失败！");
                                }
                            }, "json");
                        }
                    })
            }
        }

        function operate_formatter(value, row, index) {
            var renewBtnObj = '<button type="button" onclick="renewBook('+index+')">续借</button>';
            return renewBtnObj;
        }

        function returnBook() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if(selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要还的图书！");
                return;
            }
            var strIds = [];
            for(var i=0; i<selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示","您确认要还这<font color=red>" + selectedRows.length + "</font>本书吗？",
                function(r) {
                    if(r) {
                        $.post("${pageContext.request.contextPath}/bookborrow/returnBook.do", {
                            ids: ids
                        }, function(result) {
                            if(result.success) {
                                $.messager.alert("系统提示", "还书成功！");
                                $("#dg").datagrid("reload");
                            } else {
                                $.messager.alert("系统提示", "还书失败！");
                            }
                        }, "json");
                    }
                });
        }

        function formatStatus(val, row) {
            if(row.status == 1)
                return "<div style='color:red;'>已归还</div>";
            else
                return "<div style='color:green;'>在借</div>";
        }

        function formatDate(val, type) {
            if(val==null || val=="") return '';

            var year = parseInt(val.year)+1900;
            var month = parseInt(val.month)+1;
            month = month>9?month:('0'+month);
            var date = parseInt(val.date);
            date = date>9?date:('0'+date);
            var hours = parseInt(val.hours);
            month = hours>9?hours:('0'+hours);
            var minutes = parseInt(val.minutes);
            minutes = minutes>9?minutes:('0'+minutes);
            var seconds = parseInt(val.seconds);
            seconds = seconds>9?seconds:('0'+seconds);

            var time = year+'-'+month+'-'+date+' '+hours+':'+minutes+':'+seconds;

            return time;
        }

        function formatDateUtil(value, row, index) {
            return formatDate(value, 'timestamp');
        }
    </script>
</head>

<body>
<table id="dg" title="个人图书借阅记录" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/bookborrow/listRecordsByUserID.do?user_id=${currentUser.id}"  fit="true"
       toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="2%" align="center" hidden="true">编号</th>
        <th field="bookId" width="15%" align="center">图书ID</th>
        <th field="userId" width="15%" align="center">用户ID</th>
        <th field="BRTime" width="25%" align="center" formatter="formatDateUtil">借阅时间</th>
        <th field="allowedKeepLength" width="15%" align="center">允许借阅时间</th>
        <th field="isDone" width="6%" align="center" formatter="formatStatus">状态</th>
        <th field="arrearage" width="6%" align="center">欠费</th>
        <th field="renewTimes" width="6%" align="center">续借次数</th>
        <th field="operate" width="6%" align="center" formatter="operate_formatter">操作</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:returnBook()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">图书归还</a>
    </div>
</div>
</body>
</html>












