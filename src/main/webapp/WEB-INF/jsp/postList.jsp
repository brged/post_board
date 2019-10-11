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
<title>搜索</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header.jsp"/>
	<div class="container">
	<form class="navbar-form navbar-left" action="/post/searchPost">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="帖子标题" name="title" value="${title2 }">
        </div>
        <select class="form-control" id="inputTopic3" name="topicId">
	      	<option value="">全部</option>
	      	<c:forEach items="${topicList }" var="topic">
	      		<option value="${topic.id }" 
	      		 <c:if test="${topic.id eq topicId2 }">selected</c:if>
	      		 >${topic.name }</option>
	      	</c:forEach>
	      </select>
        <button type="submit" class="btn btn-default">搜索</button>
    </form>
	
	<table class="table table-hover" frame="below">
	  <tr>
	  	<th>类型</th>
	  	<th>标题</th>
	  	<th>时间</th>
	  	<th>作者</th>
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
	  	<td><a href="/user/space/${post.userId }">${post.userId }</a></td>
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

</script>
</body>
</html>