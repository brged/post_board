<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta http-equiv="refresh" content="5;url=${url }"> 
<title>用户登录</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<div class="jumbotron">
	  <h2 class="text-info">${msg }</h2>
	  <p><em id="num">5</em>秒后 将自动跳转</p>
		<p>没有反应？<a href="${url }"><b>点此跳转</b></a></p>
	</div>

	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
	
<script type="text/javascript">
var i =5;
function djs() {
    var t=setTimeout("djs()",1000);
	document.getElementById("num").innerText=i;
    if(i==0){
    	clearTimeout(t);
    }
    i--;
}
djs();
</script>
</body>
</html>