<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>用户注册</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>
<div class="container" style="width:500px;height:auto">
	<form action="/register" method="post" id="registerForm">
		<div class="form-group " id="checkUserInput1">
			<label for="exampleInputUserId1">用户名</label> <input
				type="text" class="form-control" id="exampleInputUserId1"
				placeholder="用户名" name="id" required aria-describedby="helpBlock2">
			<span id="helpBlock2" class="help-block"></span>
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">密码</label> <input
				type="password" class="form-control" id="exampleInputPassword1"
				placeholder="密码" name="password" required>
		</div>
		<div class="form-group">
			<label for="exampleInputPassword2">确认密码</label> <input
				type="password" class="form-control" id="exampleInputPassword2"
				placeholder="确认密码" name="password2" required aria-describedby="helpBlock3">
			<span id="helpBlock3" class="help-block"></span>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">邮箱</label> <input
				type="email" class="form-control" id="exampleInputEmail1"
				placeholder="邮箱" name="email" required>
		</div>
		<div class="form-inline">
		<div class="form-group">
			<label for="exampleInputVerifyCode1">验证码</label> 
			<input type="text" maxlength="4" class="form-control" id="exampleInputVerifyCode1"
				placeholder="验证码" name="verifyCode" required>
		</div>
		<div class="form-group">
			<label >
				<img src="/verifyCode" alt="验证码图片" class="img-rounded" id="imgVerifyCode">
				<a href="javascript:void(0)" onclick="verifyCode_change()">换一张</a>
			</label> 
		</div>
		</div>
		<button type="submit" class="btn btn-default">注册</button>
		<span class="text-warning">${msg }</span>
	</form>
</div>

	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="/js/bootstrap.min.js"></script>
	
<script type="text/javascript">
$(function(){
	$("#exampleInputUserId1").focus(function(){
		$("#checkUserInput1").removeClass("has-error");
		$("#helpBlock2").text("");
	}).blur(function(){
		var $_userInput=$("#checkUserInput1");
		console.log($_userInput)
		$.get("/user/getUserName","userId="+$(this).val(),function(data){
				console.log(""==data)
			if(""==data){
				$_userInput.removeClass("has-error");
				$("#helpBlock2").text("");
			}else{
				$_userInput.addClass("has-error");
				$("#helpBlock2").text("该用户名已被使用！");
			}
		},"text");
	});
});

	//图片刷新
	function verifyCode_change(){
		document.getElementById("imgVerifyCode").src="/verifyCode?t="+new Date().getTime();
	}
	
	function checkForm(){
		alert(123)
		pwd1=$("exampleInputPassword1").val().trim();
		pwd2=$("exampleInputPassword2").val().trim();
		if(pwd1!=pwd2){
			alert("密码输入不一致！");
			return false;
		}
		return false;
	}
	

</script>
</body>

</html>