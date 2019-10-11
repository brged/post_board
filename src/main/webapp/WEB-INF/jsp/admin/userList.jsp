<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Dashboard</title>

  <!-- Custom fonts for this template-->
  <link href="/sb-admin-2/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/sb-admin-2/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

  
<%@ include file="/WEB-INF/jsp/admin/header.txt" %>

<div class="container">
	<p class="text-center text-warning">${msg }</p>
	<table class="table table-hover" frame="below">
	  <tr>
	  	<th>用户名</th>
	  	<th>邮箱</th>
	  	<th>创建时间</th>
	  	<th>状态</th>
	  	<th>解封时间</th>
	  	<th>备注</th>
	  	<th>操作</th>
	  </tr>
	  <c:forEach items="${userList }" var="user">
	  <tr>
	  	<td>${user.id }</td>
	  	<td>${user.email }</td>
	  	<td><fmt:formatDate value="${user.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	  	<td>
	  	<c:if test="${user.state == 1 }"><span class="text-success">正常</span></c:if>
	  	<c:if test="${user.state == 0 }"><span class="text-warning">限制</span></c:if>
	  	</td>
	  	<td><fmt:formatDate value="${user.limitendtime }" pattern="yyyy-MM-dd"/></td>
	  	<td>${user.note }</td>
	  	<td>
	  		
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" onclick="editUserState('${user.id}')">
  封禁
</button>
	  		
	  	</td>
	  </tr>
	  </c:forEach>
	</table>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">封禁用户</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="banUserForm">
		  <div class="form-group row">
		    <label for="limitUserId" class="col-sm-2 col-form-label">用户名</label>
		    <div class="col-sm-10">
		      <input type="text" readonly class="form-control-plaintext" id="limitUserId" name="userId">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="limitEndTime" class="col-sm-2 col-form-label">解封时间</label>
		    <div class="col-sm-10">
		      <input type="date" class="form-control" id="limitEndTime" name="limitEndTime">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="limitNote" class="col-sm-2 col-form-label">备注</label>
		    <div class="col-sm-10">
		      <textarea class="form-control" id="limitNote" name="note"></textarea>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-primary" onclick="banUser()">封禁</button>
      </div>
    </div>
  </div>
</div>

      <%@ include file="/WEB-INF/jsp/admin/footer.txt" %>

  <!-- Bootstrap core JavaScript-->
  <script src="/sb-admin-2/vendor/jquery/jquery.min.js"></script>
  <script src="/sb-admin-2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/sb-admin-2/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/sb-admin-2/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="/sb-admin-2/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/sb-admin-2/js/demo/chart-area-demo.js"></script>
  <script src="/sb-admin-2/js/demo/chart-pie-demo.js"></script>

<script type="text/javascript">
Date.prototype.format = function(fmt) { 
    var o = { 
       "M+" : this.getMonth()+1,                 //月份 
       "d+" : this.getDate(),                    //日 
       "H+" : this.getHours(),                   //小时 
       "m+" : this.getMinutes(),                 //分 
       "s+" : this.getSeconds(),                 //秒 
       "q+" : Math.floor((this.getMonth()+3)/3), //季度 
       "S"  : this.getMilliseconds()             //毫秒 
   }; 
   if(/(y+)/.test(fmt)) {
           fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
   }
    for(var k in o) {
       if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
   return fmt; 
}  
function editUserState(userId){
	$.get("/admin/getUserById","userId="+userId,function(data){
		$("#limitUserId").val(data.id);
		var t=new Date();
		$("#limitEndTime").val(t.format("yyyy-MM-dd"));
		$("#limitNote").val(data.note);
	},"json");
}
function banUser(){
	var date=$("#limitEndTime").val();
	if(new Date(date)<new Date()){
		alert("请选择未来的时间！");
		return;
	}
	formData=$("#banUserForm").serialize();
	$.post("/admin/banUser",formData,function(data){
		if(data=="success"){
			alert("操作成功！");
			location.reload();
		}
		if(data=="fail"){
			alert("操作失败！");
		}
	},"text");
}
</script>
</body>

</html>
