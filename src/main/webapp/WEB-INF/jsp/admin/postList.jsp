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
	  	<th>帖子ID</th>
	  	<th>标题</th>
	  	<th>创建时间</th>
	  	<th>最后修改时间</th>
	  	<th>状态</th>
	  	<th>限制终止时间</th>
	  	<th>备注</th>
	  	<th>操作</th>
	  </tr>
	  <c:forEach items="${postList }" var="post">
	  <tr>
	  	<td>${post.id }</td>
	  	<td>${post.title }</td>
	  	<td><fmt:formatDate value="${post.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	  	<td><fmt:formatDate value="${post.updatetime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	  	<td>
	  	<c:if test="${post.state == 1 }"><span class="text-success">正常</span></c:if>
	  	<c:if test="${post.state == 0 }"><span class="text-warning">限制</span></c:if>
	  	</td>
	  	<td><fmt:formatDate value="${post.limitendtime }" pattern="yyyy-MM-dd"/></td>
	  	<td>${post.note }</td>
	  	<td>
	  		
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" onclick="editPostState('${post.id}')">
  更改状态
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
        <h5 class="modal-title" id="exampleModalLabel">更改状态</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="editPostForm">
		  <div class="form-group row">
		    <label for="limitPostId" class="col-sm-2 col-form-label">帖子ID</label>
		    <div class="col-sm-10">
		      <input type="text" readonly class="form-control-plaintext" id="limitPostId" name="postId">
		    </div>
		  </div>
		  
		<div class="form-group row">
	      <label for=limitPostState class="col-sm-2 col-form-label">状态</label>
	      <select id="limitPostState" class="col-sm-10 form-control" name="state">
	        <option value="1">正常</option>
	        <option value="0">封禁</option>
	      </select>
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
        <button type="submit" class="btn btn-primary" onclick="editPost()">确定</button>
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
function editPostState(postId){
	$.get("/admin/getPostById","postId="+postId,function(data){
		$("#limitPostId").val(data.id);
		$("#limitPostState").val(data.state);
		$("#limitNote").val(data.note);
	},"json");
}
function editPost(){
	formData=$("#editPostForm").serialize();
	$.post("/admin/editPost",formData,function(data){
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
