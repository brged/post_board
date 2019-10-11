<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav aria-label="Page navigation">
  <ul class="pagination">
    <li class="<c:if test="${! pageInfo.hasPreviousPage }">disabled</c:if>">
      <a href="${requestUri}&page=${pageInfo.prePage }" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <c:forEach items="${pageInfo.navigatepageNums }" var="pageNum1">
    	<c:if test="${-2*pageInfo.pageSize <= pageNum1*pageInfo.pageSize-pageInfo.startRow && pageNum1*pageInfo.pageSize-pageInfo.startRow <=2*pageInfo.pageSize }">
    		<li <c:if test="${pageInfo.pageNum == pageNum1 }">class="active"</c:if>><a href="${requestUri}&page=${pageNum1 }">${pageNum1 }</a></li>
    	</c:if>
    </c:forEach>
    <!-- <li><a href="#">1</a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li> -->
    <li class="<c:if test="${! pageInfo.hasNextPage }">disabled</c:if>">
      <a href="${requestUri}&page=${pageInfo.nextPage }" aria-label="Next" <c:if test="${! pageInfo.hasNextPage }">class="disabled"</c:if>>
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>

<script type="text/javascript">
$(function(){
	var $disa=$("ul.pagination li.disabled a");
	$disa.attr("href","javascript:void(0)");
	$disa.click(function(){
		return false;
	});
});
</script>
</body>
</html>