<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>首页</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<!-- KindEditor -->
<link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />

</head>
<body>

<jsp:include page="/WEB-INF/jsp/header.jsp"/>

<div class="container">

	<h2 class="text-center">${post.title }</h2>
	<blockquote class="blockquote-reverse">
	  <p>作者： <a href="#">${post.userId }</a></p>
	</blockquote>
	<table class="table" frame="hsides" width="700px">
		<tr>
		<td>${post.content }</td>	
		</tr>
	</table>
	<c:if test="${post.userId == sessionScope.session_user.id }">
	<p class="text-right">
	<a href="/post/toEditPost/${post.id }" class="btn btn-primary">修改</a>
	<a href="javascript:void(0)" onclick="deletePost(${post.id})" id="btnDelete" class="btn btn-warning">删除</a>
	</p>
</c:if>

	<p class="text-center text-warning">${msg }</p>
	
	<jsp:include page="/WEB-INF/jsp/postComment.jsp"/>
	<%-- <iframe src ="/comment/getCommentList2?postid=${post.id }" frameborder="0" width="100%" id="myiframe" onload="changeFrameHeight()">
	  <p>Your browser does not support iframes.</p>
	</iframe> --%>
<br>
</div>
	
	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
	
	<!-- KindEditor -->
	<script charset="utf-8" src="/kindeditor/kindeditor-all-min.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh-CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
<script type="text/javascript">
function deletePost(postId){
	var i=confirm("确认删除？");
	if(i){
		$.post("/post/deletePost","postId="+postId,function(data){
			console.log(data);
			if(data==1){
				alert("删除成功！");
			}
			window.location.reload();
		},"json");
	}
}
function changeFrameHeight(){
    var ifm= document.getElementById("myiframe"); 
    ifm.height=ifm.contentWindow.document.body.scrollHeight+100;
}

window.onresize=function(){  
     changeFrameHeight();  

} 
</script>
</body>
</html>