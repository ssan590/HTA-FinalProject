<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원삭제 모달창 -->
<div class="modal hide fade" id="userDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">
      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 삭제</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
        
			<!-- Modal body -->
			<div class="modal-body">
				<h6>javas님을 삭제하시겠습니까??</h6>
			</div>
        
			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-danger" href="#">삭제</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
        
		</div>
	</div>
</div>

<!-- 상품삭제 모달창 -->
<div class="modal hide fade" id="productDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">
      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품 삭제</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
        
			<!-- Modal body -->
			<div class="modal-body">
				<h6>상품이름을 삭제하시겠습니까??</h6>
			</div>
        
			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-danger" href="#">삭제</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
        
		</div>
	</div>
</div>

<!-- 공지사항 쓰기 모달창 -->
<div class="modal hide fade" id="noticeAddModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">공지사항 쓰기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
        
			<!-- Modal body -->
			<div class="modal-body">
				<form action="#">
					<div class="form-group">
						<label for="notice_subject">제목</label>
						<input type="text" class="form-control" id="notice_subject" name="notice_subject">
					</div>
					
					<div class="form-group">
						<label for="notice_content">내용</label>
						<textarea class="form-control" id="notice_content" 
						name="notice_content"></textarea>
					</div>
					
					<div class="form-group">
						<input type="checkbox" name="fix">&nbsp;공지사항 고정
					</div>
					
					<!-- 버튼 -->
					<div class="text-right">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
        
		</div>
	</div>
</div>

<!-- 상품등록 모달창 -->
<div class="modal hide fade" id="productAddModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품등록</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
        
			<!-- Modal body -->
			<div class="modal-body">
				<form action="#">
					<!-- 상품코드 -->
					<div class="form-group">
	              		<label for="product_code">상품코드</label>
	              		<input class="form-control" id="product_code" name="product_code">
	              	</div>
	              	
	              	<!-- 상품이름 -->
	              	<div class="form-group">
	              		<label for="product_name">상품이름</label>
	              		<input class="form-control" id="product_name" name="product_name">
	              	</div>
	              	
	              	<!-- 카테고리 -->
	              	<div class="form-group">
	              		<label for="category_name">카테고리</label>
	              		<select class="form-control">
	              			<option value="0">퍼스나콘</option>
	              			<option value="1">굿즈</option>
	              			<option value="2">농기구</option>
	              		</select>
	              	</div>
	              	
	              	<!-- 상세정보 -->
	              	<div class="form-group">
	              		<label for="product_detail">상품상세정보</label>
	              		<textarea class="form-control" id="product_detail" name="product_detail"></textarea>
	              	</div>
	              	
	              	<!-- 가격 -->
	              	<div class="form-group">
	              		<label for="product_price">가격</label>
	              		<input class="form-control" id="product_price" name="product_price">
	              	</div>
	              	
	              	<!-- 이미지 -->
					<div class="form-group text-left">
			 			<button class="btn btn-primary" id="imgUploadbtn">이미지 첨부</button>
						<input class="form-control" type="file" id="imgUpload" name="imgUpload" accept="image/*">
						<span id="imgvalue"></span>
						<img src="${pageContext.request.contextPath}/resources/image/jjs/remove.png" alt="이미지삭제" width="30px" class="remove">
					</div>
					
					<!-- 버튼 -->
					<div class="text-right">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 상품수정 모달창 -->
<div class="modal hide fade" id="productModifyModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품수정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
        
			<!-- Modal body -->
			<div class="modal-body">
				<div class="row">
					<div class="col-12 col-sm-6">
						<div class="col-12">
							<img src="${pageContext.request.contextPath}/resources/image/jjs/among us.png" style="width : 380px; height : 300px;">
						</div>
					</div>
					
					<div class="col-12 col-sm-6">
						<div class="col-12">
							<form action="#">
								<!-- 상품코드 -->
								<div class="form-group">
				              		<label for="product_code">상품코드</label>
				              		<input class="form-control" id="product_code" name="product_code" value="A001" disabled>
				              	</div>
				              	
				              	<!-- 상품이름 -->
				              	<div class="form-group">
				              		<label for="product_name">상품이름</label>
				              		<input class="form-control" id="product_name" name="product_name" value="상품이름">
				              	</div>
				              	
				              	<!-- 카테고리 -->
				              	<div class="form-group">
				              		<label for="category_name">카테고리</label>
				              		<select class="form-control" disabled>
				              			<option value="0">퍼스나콘</option>
				              			<option value="1" selected>굿즈</option>
				              			<option value="2">농기구</option>
				              		</select>
				              	</div>
				              	
				              	<!-- 상세정보 -->
				              	<div class="form-group">
				              		<label for="product_detail">상품상세정보</label>
				              		<textarea class="form-control" id="product_detail" name="product_detail">상세정보</textarea>
				              	</div>
				              	
				              	<!-- 가격 -->
				              	<div class="form-group">
				              		<label for="product_price">가격</label>
				              		<input class="form-control" id="product_price" name="product_price" value="1,000원">
				              	</div>
				              	
				              	<!-- 상품등록일 -->
				              	<div class="form-group">
				              		<label for="product_date">상품등록일</label>
				              		<input class="form-control" id="product_date" name="product_date" value="21-09-24" disabled>
				              	</div>
				              	
				              	<!-- 이미지 -->
								<div class="form-group text-left">
						 			<button class="btn btn-primary" id="imgUploadbtn">이미지 첨부</button>
									<input class="form-control" type="file" id="imgUpload" name="imgUpload" accept="image/*">
									<span id="imgvalue"></span>
									<img src="${pageContext.request.contextPath}/resources/image/jjs/remove.png" alt="이미지삭제" width="30px" class="remove">
								</div>
								
								<!-- 버튼 -->
								<div class="text-right">
									<button type="submit" class="btn btn-primary">수정</button>
									<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>