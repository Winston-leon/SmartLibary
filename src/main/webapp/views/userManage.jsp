<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
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
    <script type="text/javascript">
        var url;

        function searchUser() {
            $("#dg").datagrid('load', {
                "userName": $("#s_userName").val()
            });
        }

        function deleteUser() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要删除的数据！");
                return;
            }
            var strIds = [];
            for (var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确认要删除这<font color=red>"
                    + selectedRows.length + "</font>条数据吗？", function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/user/delete.do", {
                        ids: ids
                    }, function (result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "数据已成功删除！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败！");
                        }
                    }, "json");
                }
            });

        }

        function openUserAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
            url = "${pageContext.request.contextPath}/user/save.do";
        }

        function saveUser() {
            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    $.messager.alert("系统提示", "保存成功");
                    resetValue();
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("reload");
                }
            });
        }

        function openUserModifyDialog() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
            $('#fm').form('load', row);
            $("#password").val("******");
            url = "${pageContext.request.contextPath}/user/save.do?id=" + row.id;
        }

        function resetValue() {
            $("#userName").val("");
            $("#password").val("");
            $("#name").val("");
            $("#email").val("");
            $("#mobile").val("");
            $("#role_id").val("");
            $("#role_priv_level").val("");
            $("#status").val("");
        }

        function closeUserDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }
    </script>
</head>
<body style="margin:1px;">
    <table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true"
           pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/user/list.do" fit="true"
           toolbar="#tb">
        <thead>
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <th field="id" width="50" align="center">编号</th>
                <th field="userName" width="80" align="center">用户名</th>
                <th field="password" width="250" align="center">密码</th>
                <th field="name" width="80" align="center">姓名</th>
                <th field="email" width="100" align="center">邮箱</th>
                <th field="mobile" width="100" align="center">电话</th>
                <th field="role_id" width="50" align="center">用户角色</th>
                <th field="role_priv_level" width="50" align="center">权限等级</th>
                <th field="status" width="200" align="center">用户状态</th>
            </tr>
        </thead>
    </table>
    <div id="tb">
        <div>
            <a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
               iconCls="icon-add" plain="true">添加</a> <a
                href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
                iconCls="icon-edit" plain="true">修改</a> <a
                href="javascript:deleteUser()" class="easyui-linkbutton"
                iconCls="icon-remove" plain="true">删除</a>
        </div>
        <div>
            &nbsp;用户名：&nbsp;<input type="text" id="s_userName" size="20"
                                   onkeydown="if(event.keyCode==13) searchUser()"/> <a
                href="javascript:searchUser()" class="easyui-linkbutton"
                iconCls="icon-search" plain="true">搜索</a>
        </div>
    </div>

    <div id="dlg" class="easyui-dialog"
         style="width: 620px;height:250px;padding: 10px 20px" closed="true"
         buttons="#dlg-buttons">
        <form id="fm" method="get">
            <table cellspacing="8px">
                <tr>
                    <td>用户名：</td>
                    <td><input type="text" id="userName" name="userName"
                               class="easyui-validatebox" required="true"/>&nbsp;<font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="text" id="password" name="password"
                               class="easyui-validatebox" required="true"/>&nbsp;<font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><input type="text" id="name" name="name"
                               class="easyui-validatebox" required="true"/> <font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>邮箱</td>
                    <td><input type="text" id="email" name="email"
                               class="easyui-validatebox" required="true"/> <font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td><input type="text" id="mobile" name="mobile"
                               class="easyui-validatebox" required="true"/> <font
                            color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>用户角色</td>
                    <td><input type="text" id="role_id" name="role_id"
                               class="easyui-validatebox"/>
                    </td>
                </tr>
                <tr>
                    <td>权限等级</td>
                    <td><input type="text" id="role_priv_level" name="role_priv_level"
                               class="easyui-validatebox"/>
                    </td>
                </tr>
                <tr>
                    <td>用户状态</td>
<%--                    <td><input type="text" id="status" name="status"--%>
<%--                               class="easyui-validatebox" required="true"/> <font--%>
<%--                            color="red">*</font>--%>
<%--                    </td>--%>
                    <td>
                        <select id="status" name="status" class="easyui-validatebox" required="true">
                            <option value="0" selected="selected">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                        </select> <font color="red">*</font>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:saveUser()" class="easyui-linkbutton"
           iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
                                       class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>
</body>
</html>