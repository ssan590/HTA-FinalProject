<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
 <jsp:include page="../main/header.jsp" />
<style>
   select.form-control{
         width:auto;margin-bottom:2em;display:inline-block}
   .rows{text-align:right;}
   .gray{color:gray}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:8%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(2){width:40%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(3){width:14%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(4){width:17%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(5){width:11%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(6){width:10%}
form{margin: 0 auto; width:80%; text-align: center}
select{
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border : 1px solid #ced4da;
	border-radius: .25rem;
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
	outline:none;
}
 </style>
</head>
 <title>주말농장 - 작성한 댓글보기</title>
</head>
<body>
<br><br><br><br><br><br><br>
<div class="container">
<input type="hidden" id="Loginid" value="${id}" name="loginid">
<%-- 게시글이 있는 경우--%> 
<c:if test="${listcount > 0 }">

  <table class="table table-striped">
   <thead>
	<tr>
	   <th colspan="3">작성한 댓글</th>
	   <th></th>
	   <th colspan="2">
			<font size=3>글 개수 : ${listcount}</font>
	   </th>
	</tr>
	<tr>
		<th><div>번호</div></th>
		<th><div>원글 제목</div></th>
		<th><div>원글 내용</div></th>
		<th><div>내가 쓴 댓글</div></th>
		<th><div>날짜</div></th>
		<th><div>삭제하기</div></th>
	</tr>	
   </thead>
   <tbody>
	<c:set var="num" value="${listcount-(page-1)*limit}"/>	
	<c:forEach var="b" items="${freelist}">
	<tr>
	  <td><%--번호 --%>
		<c:out value="${num}"/><%-- num 출력 --%>		
		<c:set var="num" value="${num-1}"/>	<%-- num=num-1; 의미--%>	
	  </td>
	  <td><%--제목 --%>
	     <div>			
			<a href="detail?num=${b.free_num}&id=${b.free_id}" >
				 <c:out value="${b.free_subject}" escapeXml="true"/>  
			<span class="gray small">[<c:out value="${b.cnt}" />]</span>
			</a>
		  </div>
		</td>
		<td><div>${b.nick}</div></td>
		<td><div>${b.free_date}</div></td>	
		<td><div>${b.free_readcount}</div></td>
		<td><div>${b.free_like}</div></td>
	   </tr>
	  </c:forEach>
	 </tbody>	
	</table>
		<br>
	<div class="center-block">
		  <ul class="pagination justify-content-center">		
			 <c:if test="${page <= 1 }">
				<li class="page-item">
				  <a class="page-link gray">이전&nbsp;</a>
				</li>
			 </c:if>
			 <c:if test="${page > 1 }">			
				<li class="page-item">
				   <a href="list?page=${page-1}" 
				      class="page-link">이전&nbsp;</a>
				</li> 
			 </c:if>
					
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					<li class="page-item " >
					   <a class="page-link gray">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page }">
				    <li class="page-item">
					   <a href="list?page=${a}" 
					      class="page-link">${a}</a>
				    </li>	
				</c:if>
			</c:forEach>
			
			<c:if test="${page >= maxpage }">
				<li class="page-item">
				   <a class="page-link gray">&nbsp;다음</a> 
				</li>
			</c:if>
			<c:if test="${page < maxpage }">
			  <li class="page-item">
				<a href="list?page=${page+1}" 
				   class="page-link">&nbsp;다음</a>
			  </li>	
			</c:if>
		 </ul>
		</div>
     </c:if><%-- <c:if test="${listcount > 0 }"> end --%>
	
<%-- 게시글이 없는 경우--%>
<c:if test="${listcount == 0 }">
	<font size=5>작성한 글이 없습니다.</font>
</c:if>

</div>
</body>
</html>