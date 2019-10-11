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
<title>帖子评论页</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>


<hr>

<h3 class="text-info">最新评论</h3>

<div id="commentList">

<div class="media">
  <div class="media-left">
    <a href="#">
      <img class="media-object" src="..." alt="...">
    </a>
  </div>
  <div class="media-body">
    <h4 class="media-heading">Media heading</h4>
    ................................................................................................................................
  </div>
</div>
<div class="media">
  <div class="media-left">
    <a href="#">
      <img class="media-object" src="..." alt="...">
    </a>
  </div>
  <div class="media-body">
    <h4 class="media-heading">Media heading</h4>
    .......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
  </div>
</div>

</div>
<br>
<c:if test="${sessionScope.session_user == null }">
<p>游客无法发言，请<a href="/login">登录</a></p>
</c:if>
<c:if test="${sessionScope.session_user != null }">
<form id="addCommentForm">
	<input type="hidden" name="postid" value="${post.id }">
  <div class="form-group">
    <label for="exampleInputComment1">添加评论</label>
    <textarea class="form-control" id="exampleInputComment1" placeholder="输入你的评论" name="content"></textarea>
  </div>
  
  <button type="button" class="btn btn-default" onclick="addComment()">提交</button>
</form>
</c:if>


	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript">
function addComment(){
	var formData=$("#addCommentForm").serialize();
	$.post("/comment/addComment",formData,function(data){
		switch (data.msg) {
		case "login":
			alert("请先登录后再操作！");
			break;
		case "success":
			alert("添加成功！");
			alert(location.href);
			break;
		case "fail":
			alert("添加失败！");
			break;

		default:
			break;
		}
	},"json");
}
</script>
</body>
</html>