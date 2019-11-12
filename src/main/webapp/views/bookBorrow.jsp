<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>allBooksManger</title>
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
        var url;

        <%--function openBookBorrowDialog() {--%>
        <%--    $("#dlg").dialog("open").dialog("setTitle", "借书");--%>
        <%--    url = "${pageContext.request.contextPath}/bookborrow/borrow.do";--%>
        <%--}--%>

        function borrow() {
            var selectedRows = $("#dg1").datagrid("getSelections");
            if(selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要借的图书！");
                return;
            }
            if(selectedRows.length > 10) {
                $.messager.alert("系统提示", "一次借书不能超过10本！");
                return;
            }
            var strIds = [];
            var strTitles = []; //保存已经被借出的图书书名
            for(var i=0; i<selectedRows.length; i++) {
                if(selectedRows[i].status == 1) {
                    strTitles.push(selectedRows[i].title);
                } else {
                    strIds.push(selectedRows[i].id);
                }
            }
            //如果被选中的图书中有已经被借出的，系统将给出提示
            if(strTitles.length != 0) {
                var titles = strTitles.join("\t\r");
                $.messager.alert("系统提示", "以下图书已被借出：\r\t<font color=red>"+titles+"</font>\r请重新选择！");
                return;
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确认要借这<font color=red>" + selectedRows.length + "</font>本书吗？",
                function(r) {
                    if(r) {
                        $.post("${pageContext.request.contextPath}/bookborrow/borrow.do", {
                            ids: ids,
                            user_id: ${currentUser.id}
                            }, function(result) {
                            if(result.success) {
                                $.messager.alert("系统提示", "借书成功！");
                                $("#dg1").datagrid("reload");
                            } else {
                                $.messager.alert("系统提示", "借书失败！");
                            }
                        }, "json");
                    }
                });
        }

        function formatProPic(val, row) {
            return "<img width=80 height=110 src='../" + val + "'>";
        }

        function formatStatus(val, row) {
            if(row.status == 1)
                return "<div style='color:red;'>已借出</div>";
            else
                return "<div style='color:green;'>在架</div>";
        }

    </script>
</head>

<body style="margin:1px;">
    <table id="dg1" title="图书借还" class="easyui-datagrid" fitColumns="true"
           pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/book/listAll.do" fit="true"
           toolbar="#tb">
        <thead>
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <th field="id" width="2%" align="center" hidden="true">编号</th>
                <th field="image_path" width="7%" align="center" formatter="formatProPic">图片</th>
                <th field="title" width="9%" align="center">书名</th>
                <th field="subtitle" width="9%" align="center" hidden="true">副标题</th>
                <th field="isbn" width="9%" align="center">ISBN码</th>
                <th field="author" width="9%" align="center">作者</th>
                <th field="translator" width="9%" align="center">译者</th>
                <th field="press" width="9%" align="center">出版社</th>
                <th field="price" width="5%" align="center">市场价</th>
                <th field="page" width="5%" align="center">页数</th>
                <th field="binding" width="5%" align="center">装订方式</th>
                <th field="status" width="5%" align="center"
                    formatter="formatStatus">借阅状态</th>
                <th field="description" width="15%" align="center">简介</th>
            </tr>
        </thead>
    </table>

    <div id="tb">
        <div>
            <a href="javascript:borrow()" class="easyui-linkbutton"
                iconCls="icon-add" plain="true">图书借阅</a>
        </div>
        <div>
            标题：<input type="text" id="search_title" size="20"
                    onkeydown="if(event.keyCode==13) searchBook()"/>;
            作者：<input type="text" id="search_author" size="20"
                    onkeydown="if(event.keyCode==13) searchBook()"/>
            ISBN码：<input type="text" id="search_isbn" size="20"
                     onkeydown="if(event.keyCode==13) searchBook()"/>
            <a href="javascript:searchBook()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
        </div>
    </div>


<%--    <div id="dlg" class="easyui-dialog"--%>
<%--        style="width:620px;height:250px;padding:10px 20px" closed="true" buttons="#dlg-buttons">--%>
<%--    </div>--%>

<%--    <div id="dlg-buttons">--%>
<%--        <button type="button" onclick="borrow()">借阅</button>--%>
<%--        <button type="button" onclick="closeBookBorrowDialog()">关闭</button>--%>
<%--    </div>--%>

</body>
</html>


















