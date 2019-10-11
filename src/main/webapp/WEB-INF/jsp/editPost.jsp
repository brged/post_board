<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>${pageTitle } - 帖子编辑页</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<!-- KindEditor -->
<link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />

</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>
	<div class="container">
	<form class="form-horizontal" id="editForm">
	  <div class="form-group">
	    <label for="inputTopic3" class="col-sm-2 control-label">话题</label>
	    <div class="col-sm-10">
	      <select class="form-control" id="inputTopic3" name="topicId">
	      	<option>-请选择-</option>
	      	<c:forEach items="${topicList }" var="topic">
	      		<option value="${topic.id }" 
	      		 <c:if test="${topic.id eq post.topicId }">selected</c:if>
	      		 >${topic.name }</option>
	      	</c:forEach>
	      </select>
	    </div>
	  </div>
	  <input type="hidden" name="id" value="${post.id }">
	  <div class="form-group">
	    <label for="inputTitle3" class="col-sm-2 control-label">标题</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="inputTitle3" placeholder="标题" name="title" value="${post.title }">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputContent3" class="col-sm-2 control-label">内容</label>
	    <div class="col-sm-10">
	      <textarea style="height:500px;" 
	      	class="form-control" id="inputContent3" placeholder="内容" name="content">${post.content }</textarea>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="button" class="btn btn-primary btn-lg" onclick="checkForm()">提交</button>
	    </div>
	  </div>
	</form>
	</div>
	
	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
	
<!-- KindEditor -->
<script charset="utf-8" src="/kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>

<script>
var editor1;
KindEditor.ready(function(K) {
	editor1 = K.create('#inputContent3', {
		items : [
	                'source', '|', 'undo', 'redo', '|', 'preview', 'code', 'cut', 'copy', 'paste',
	                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
	                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
	                'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
	                'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
	                'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
	                'table', 'hr', 'emoticons', 'baidumap', 'pagebreak', 'link', 'unlink', '|', 'about'
	    ],
		cssPath : '/kindeditor/plugins/code/prettify.css',
		allowImageUpload:false,
		allowFileManager : false
	});
	prettyPrint();
});
function checkForm(){
	editor1.sync();
	formData=$("#editForm").serialize();
	$.post("/post/editPost",formData,function(data){
		console.log(data);
		switch(data.state){
		case "noLogin":
			alert("你还没有登录！请登录后重试！");
			window.location="/login";
			break;
		case "illegal":
			alert("表单有字段不合法！");
			break;
		case "add":
			var r=confirm("添加成功！是否返回首页？");
			if(r){
				window.location="/index.jsp";
			}else{
				window.location.reload();
				$("#editForm #inputTitle3").text("");
				$("#editForm #inputContent3").text("");
			}
			break;
		case "update":
			alert("修改成功！");
			window.location="/index.jsp";
			break;
		case "fail":
			alert("操作失败！");
			break;
		}
	},"json");
}
</script>
</body>
</html>