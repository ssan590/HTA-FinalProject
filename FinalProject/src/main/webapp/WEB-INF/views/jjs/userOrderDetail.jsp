<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../main/header.jsp" />
<title>주말농장 - 주문 상세</title>
<style>
hr, footer {
	clear: both;
}

.product {
	width: 48%;
	height: 200px;
	border: 1px dotted gray;
}

.product>p {
	font-size: 30px;
	text-align: left;
	margin: 0;
}

.product>p>span {
	font-size: 20px;
}

.table {
	width: 102%;
}

.products {
	display: flex;
	flex-wrap: wrap;
}
</style>
</head>
<body>
	<input type="hidden" value="-1" class="search_field">
	<div class="container text-center">
		<h1 class="mt-3 mb-3">주문 상세</h1>
		<table class="table table-striped table-bordered text-center mb-5">
			<thead>
				<tr>
					<th>주문 번호</th>
					<th>수령인</th>
					<th>수령인 연락처</th>
					<th>주소</th>
				</tr>
				<tr>
					<td>${orderdetail.order_num}</td>
					<td>${orderdetail.order_name}</td>
					<td>${orderdetail.order_phone}</td>
					<td>(${orderdetail.user_address1}) ${orderdetail.user_address2}</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>주문 가격</th>
					<th>걸제방식</th>
					<th>배송상태</th>
					<th>결제일</th>
				</tr>
				<tr>
					<fmt:formatNumber var="totalPrice" value="${orderdetail.order_totalprice}" pattern="###,###,###" />
					<td>${totalPrice}원</td>
					<td>${orderdetail.order_payment}</td>
					<td>${orderdetail.order_delivery}</td>
					<td>${orderdetail.order_date}</td>
				</tr>
			</tbody>
		</table>
		<div class="products">
			<c:forEach var="ol" items="${orderlist}">
				<fmt:formatNumber var="price" value="${ol.product_price}" pattern="###,###,###" />
				<div class="mb-2 ml-2 product">
					<img class="img-fluid float-right" src="${pageContext.request.contextPath}/resources/upload${ol.product_img}" alt="productImg" width="200px" height="200px">
					<p class="mt-5 ml-2">
						상품명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href="#">${ol.product_name}</a></span>
					</p>
					<p class="ml-2">
						가격&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${price}원</span>
					</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<hr>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>