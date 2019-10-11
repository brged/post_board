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
<title>页头</title>


</head>
<body>

<nav class="navbar navbar-default navbar-inverse navbar-static-top">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">留言板</a>
      <p class="navbar-text">欢迎来到本系统</p>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="/index">主页</a></li>
      </ul>
      <form class="navbar-form navbar-left" action="/post/searchPost" method="get">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="帖子标题" name="title">
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${session_user.id == null }">
      	<a href="/login" class="btn btn-primary navbar-btn">登录</a>
      	<a href="/register" class="btn btn-default navbar-btn">注册</a>
      </c:if>
      <c:if test="${session_user.id != null }">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${session_user.id } <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="/user/space/${session_user.id }">我的主页</a></li>
		    <li role="separator" class="divider"></li>
		    <li><a href="/logout">退出登录</a></li>
          </ul>
        </li>
      </c:if>
      </ul>
      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

</body>
</html>