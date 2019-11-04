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
        var myurl;

        function searchBook() {
            $("#dg").datagrid('load', {
                "title": $("#search_title").val(),
                "author": $("#search_author").val(),
                "isbn": $("#search_isbn").val(),
            });
        }

        function openBookAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加图书");
            myurl = "${pageContext.request.contextPath}/book/save.do";
        }

        function openBookModifyDialog() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if(selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "修改图书信息");
            $("#fm").form("load", row);
            myurl = "${pageContext.request.contextPath}/book/save.do";
        }

        function save() {
            // $("#fm").form("submit", {
            //     url: url,
            //     onSubmit: function () {
            //         return $(this).form("validate");
            //     },
            //     success: function (result) {
            //         $.messager.alert("系统提示", "保存成功");
            //         resetValue();
            //         $("#dlg").dialog("close");
            //         $("#dg").datagrid("reload");
            //     }
            // });

                var formData = {
                    isbn : $("#isbn").val(),
                    title : $("#title").val(),
                    subtitle : $("#subtitle").val(),
                    version : $("#version").val(),
                    author : $("#author").val(),
                    translator : $("#translator").val(),
                    publishing_year : $("#publishing_year").val(),
                    price : $("#price").val(),
                    press : $("#press").val(),
                    page : $("#page").val(),
                    binding : $("#binding").val(),
                    description : $("#description").val(),
                    status : $("#status").val(),
                    image_path : $("#image_path").val()
                };
                $.ajax({
                    type: "post",
                    url: myurl,
                    contentType: "application/x-www-form-urlencoded",
                    data: formData,
                    dataType: "json",
                    success: function (result) {
                        $.messager.alert("系统提示","保存成功");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    }
                });
        }

        function closeBookDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }

        function resetValue() {
            $("#isbn").val("");
            $("#title").val("");
            $("#subtitle").val("");
            $("#version").val("");
            $("#author").val("");
            $("#translator").val("");
            $("#publishing_year").val("");
            $("#press").val("");
            $("#price").val("");
            $("#page").val("");
            $("#binding").val("");
            $("#description").val("");
            $("#status").val("");
            $("#image_path").val("");
        }


        function deleteBook() {
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
                    $.post("${pageContext.request.contextPath}/book/deleteBook.do", {
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


        function openBookInfoPage(id) {
            window.parent.openTab('书籍摆放信息', 'storeInfo.jsp?id=' + id,
                'icon-shujias');
        }

        function formatProPic(val, row) {
            return "<img width=80 height=110 src='../" + val + "'>";
        }

        function formatStatus(val, row) {
            if (row.status == 1)
                return "<div style='color:red;'>已上架</div>";
            else
                return "<div style='color:gray;'>未上架</div>";
        }
    </script>
</head>

<body style="margin:1px;" id="ff">
    <table id="dg" title="书籍信息管理" class="easyui-datagrid" fitColumns="true"
           pagination="true" rownumbers="true"
<%--           data-options="pageSize:10"--%>
           url="${pageContext.request.contextPath}/book/listAll.do" fit="true"
<%--           style="table-layout: fixed; width: 100%;"--%>
           toolbar="#tb">
        <thead data-options="frozen:true">
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <th field="id" width="10" align="center" hidden="true">编号</th>
                <th field="image_path" width="100" align="center" formatter="formatProPic">图片</th>
                <th field="title" width="120" align="center">书名</th>
                <th field="subtitle" width="120" align="center" hidden="true">副标题</th>
                <th field="isbn" width="120" align="center">ISBN码</th>
                <th field="author" width="120" align="center">作者</th>
                <th field="translator" width="120" align="center">译者</th>
                <th field="press" width="120" align="center">出版社</th>
                <th field="price" width="70" align="center">市场价</th>
                <th field="page" width="70" align="center">页数</th>
                <th field="binding" width="70" align="center">装订方式</th>
                <th field="status" width="70" align="center"
                    formatter="formatStatus">上架状态</th>
                <th field="description" width="200" align="center">简介</th>
            </tr>
        </thead>
    </table>

    <div id="tb">
        <div>
            <a href="javascript:openBookAddDialog()" class="easyui-linkbutton"
               iconCls="icon-add" plain="true">添加</a> <a
                href="javascript:openBookModifyDialog()" class="easyui-linkbutton"
                iconCls="icon-edit" plain="true">修改</a> <a
                href="javascript:deleteBook()" class="easyui-linkbutton"
                iconCls="icon-remove" plain="true">删除</a>
        </div>
        <div>
            &nbsp;标题：&nbsp;<input type="text" id="search_title" size="20"
                                  onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp;
            &nbsp;作者：&nbsp;<input type="text" id="search_author" size="20"
                onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp;
            &nbsp;ISBN码：&nbsp;<input type="text" id="search_isbn" size="20"
                                     onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp;
            <a href="javascript:searchBook()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
        </div>
    </div>

    <div id="dlg" class="easyui-dialog"
         style="width: 620px;height:250px;padding: 10px 20px" closed="true"
         buttons="#dlg-buttons">
        <form id="fm" method="post">
            <table cellspacing="8px">
                <tr>
                    <td>ISBN：</td>
                    <td><input type="text" id="isbn" name="isbn"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>书名：</td>
                    <td><input type="text" id="title" name="title"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>副标题：</td>
                    <td><input type="text" id="subtitle" name="subtitle"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>版本：</td>
                    <td><input type="text" id="version" name="version"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>作者：</td>
                    <td><input type="text" id="author" name="author"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>译者：</td>
                    <td><input type="text" id="translator" name="translator"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>出版年份：</td>
                    <td><input type="text" id="publishing_year" name="publishing_year"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>出版社：</td>
                    <td><input type="text" id="press" name="press"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>价格：</td>
                    <td><input type="text" id="price" name="price"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>页数：</td>
                    <td><input type="text" id="page" name="page"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>装帧：</td>
                    <td><input type="text" id="binding" name="binding"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>状态：</td>
                    <td><input type="text" id="status" name="status"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>简介：</td>
                    <td style="overflow: hidden; white-space:nowrap; text-overflow: ellipsis" >
                        <input type="text" id="description" name="description"
                               class="easyui-validatebox" required="true"/>
                        <font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <td>封面图片：</td>
                    <td><input type="text" id="image_path" name="image_path"
                               class="easyui-validatebox"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
<%--        <a href="javascript:save()" class="easyui-linkbutton"--%>
<%--           iconCls="icon-ok">保存</a>--%>
<%--    <a href="javascript:closeBookDialog()" class="easyui-linkbutton"--%>
<%--       iconCls="icon-cancel">关闭</a>--%>
        <button type="button" onclick="save()">保存</button>
        <button type="button" onclick="closeBookDialog()">关闭</button>
    </div>

    <div id="dlg_c" class="easyui-dialog"
         style="width: 300px;height:450px;padding: 10px 20px; position: relative; z-index:1000;"
         closed="true" buttons="#dlg_c-buttons">
        <form id="fm_c" method="get">
            <table cellspacing="8px" id="tab">
            </table>
        </form>
    </div>

</body>
</html>