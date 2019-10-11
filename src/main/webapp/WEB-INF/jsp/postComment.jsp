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

</head>

<body>

<hr>

<h3 class="text-info">最新评论</h3>

<div id="commentList">
</div>

<br>
<c:if test="${sessionScope.session_user == null }">
<p>游客无法发言，请<a href="/login">登录</a></p>
</c:if>
<c:if test="${sessionScope.session_user != null }">
<form id="addCommentForm">
	<input type="hidden" name="postid" value="${post.id }">
  <div class="form-group">
    <label for="exampleInputContent1">添加评论</label>
    <textarea class="form-control" id="exampleInputContent1" placeholder="输入你的评论" maxlength="250" name="content"></textarea>
  </div>
  
  <button type="button" class="btn btn-default" onclick="addComment()">提交</button>
</form>
</c:if>

	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(function(){
	getCommentList();
});
function addComment(){
	var formData=$("#addCommentForm").serialize();
	$.post("/comment/addComment",formData,function(data){
		switch (data.msg) {
		case "login":
			alert("请先登录后再操作！");
			break;
		case "success":
			alert("添加成功！");
			$("#exampleInputContent1").val("");
			getCommentList();
			break;
		case "fail":
			alert("添加失败！");
			break;

		default:
			break;
		}
	},"json");
}
function getCommentList(){
	$.get("/comment/getCommentList","postid="+"${post.id }",function(data){
		if(data.length==0){
			$("#commentList").append("<p class='text-warning'>目前还没有评论</p>");
			return;
		}
		$("#commentList").html("");
		$(data).each(function(i,v){
			var createtime=new Date(v.createtime).Format("yyyy-MM-dd HH:mm");
			console.log(i,v);
			$("#commentList").append($("<div class=\"media\">"
					  +"<div class=\"media-body\">"
		    +"<h4 class=\"media-heading\"><strong>"+v.userid+"</strong> <small>• "+createtime+"</small></h4>"
		    +v.content
		  +"</div>"
		+"</div>"
		+"</div>"));
		});
	},"json");
}
//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt)   
{ //author: meizz   
var o = {   
 "M+" : this.getMonth()+1,                 //月份   
 "d+" : this.getDate(),                    //日   
 "H+" : this.getHours(),                   //小时   
 "m+" : this.getMinutes(),                 //分   
 "s+" : this.getSeconds(),                 //秒   
 "q+" : Math.floor((this.getMonth()+3)/3), //季度   
 "S"  : this.getMilliseconds()             //毫秒   
};   
if(/(y+)/.test(fmt))   
 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
for(var k in o)   
 if(new RegExp("("+ k +")").test(fmt))   
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
return fmt;   
}
</script>
</body>
</html>