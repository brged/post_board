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

<title>${pageInfo.list[0].userId } - 帖子列表</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>

<div class="container">
	<c:if test="${pageInfo.list[0].userId == sessionScope.session_user.id }">
	<a href="/post/toEditPost" class="btn btn-primary">发布新帖</a>
	</c:if>
	<table class="table table-hover" frame="below">
	  <tr>
	  	<th>类型</th>
	  	<th>标题</th>
	  	<th>时间</th>
	  	<c:if test="${pageInfo.list[0].userId == sessionScope.session_user.id }">
	  	<th colspan="2">操作</th>
	  	</c:if>
	  </tr>
	  <c:forEach items="${pageInfo.list }" var="post">
	  <tr>
	  	<td>
	  		<a href="/post/searchPost?topicId=${post.topicId }">
		  		<c:forEach items="${topicList }" var="topic">
		  		<c:if test="${post.topicId eq topic.id }">${topic.name }</c:if>
		  		</c:forEach>
	  		</a>
	  	</td>
	  	<td><a href="/post/${post.id }">${post.title }</a></td>
	  	<td><fmt:formatDate value="${post.updatetime }" pattern="yyyy-MM-dd HH:mm"/></td>
	  	<c:if test="${post.userId == sessionScope.session_user.id }">
	  	<td><a href="/post/toEditPost/${post.id }">修改</a></td>
	  	<td><a href="javascript:void(0)" onclick="deletePost(${post.id})" id="btnDelete" class="text-warning">删除</a></td>
	  	</c:if>
	  </tr>
	  </c:forEach>
	</table>
	<p class="text-center text-warning">${msg }</p>
	
<jsp:include page="/WEB-INF/jsp/pagination.jsp"/>

</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
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
</script>
</body>
</html>