<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<jsp:include page="../../main/header.jsp" />
	<script src="../resources/js/chang/jik_writeform.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	.container{width:60%}
	label{font-wight:bold}
	#input_file{display:none}
	</style>
</head>
<body>
<br><br><br><br><br>
  <div class="container">
   <form name="jikform" id="jikform">
     <h1>직거래 장터 - 글쓰기</h1>
     <div class="form-group">
     	<label for="nick">글쓴이</label>
     	<input name="nick" id="nick" value="${nick}"
     		   readOnly
     		   type="text"	size="10" maxlength="30"
     		   class="form-control"
     		   placeholder="Enter nick">
     </div>

     <div class="form-group">
       <label for="jik_subject">제목</label>
       <input name="jik_subject" id="jik_subject" type="text" maxlength="100"
     			class="form-control"	placeholder="Enter jik_subject">
     </div>	
     
	<div class="form-group file">
  		<button id="btn-upload" type="button" style="border: 1px solid #ddd; outline: none;">파일 추가</button>
  		<input id="input_file" multiple="multiple" type="file" style="display:none;" accept="image/*">
  		<span style="font-size:10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
  		<div class="data_file_txt" id="data_file_txt" style="margin:40px;">
			<span>첨부 파일(클릭시 제외됩니다.)</span>
			<br />
			<div id="articlefileChange">
			</div>
	</div>
</div>
     
     <div class="form-group">
       <label for="jik_content">내용</label>
       <textarea name="jik_content" id="jik_content" 
     			rows="10" 	class="form-control"></textarea>
     </div>	
     <input type="hidden" name="jik_id" id="jik_id" value="${id}">
     <c:if test="${id !=null && id != ''}">
     <div class="form-group">
     	<button type=button class="btn btn-primary" id="submit">등록</button>
     	<button type=reset  class="btn btn-danger">취소</button>
     </div>
     </c:if>
     
   </form>
  </div>
  
  <script>
$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
		{
			$("#input_file").on("change", fileCheck);
		});

/**
 * 첨부파일로직
 */
$(function () {
	 $('#submit').click(function(e){
		 e.preventDefault();
		 registerAction();
	 })
	 
    $('#btn-upload').click(function (e) {
        e.preventDefault();
        $('#input_file').click();
    });
});

// 파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 10;
// 파일 고유넘버
var fileNum = 0;
// 첨부파일 배열
var content_files = new Array();

function fileCheck(e) {
    var files = e.target.files;
    
    // 파일 배열 담기
    var filesArr = Array.prototype.slice.call(files);
    
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > totalCount) {
      $.alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
      return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }
    
    // 각각의 파일 배열담기 및 기타
    filesArr.forEach(function (f) {
      var reader = new FileReader();
      reader.onload = function (e) {
        content_files.push(f);
        $('#articlefileChange').append(
       		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
       		+ '<font style="font-size:15px">' + f.name + " " + '</font>'
       		+ '<img src="../resources/image/chang/remove.png" style="width:12px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
       		+ '<div/>'
		);
        fileNum ++;
      };
      reader.readAsDataURL(f);
    });
    console.log(content_files);
    //초기화 한다.
    $("#input_file").val("");
  }

// 파일 부분 삭제 함수
function fileDelete(fileNum){
    var no = fileNum.replace(/[^0-9]/g, "");
    content_files[no].is_delete = true;
	$('#' + fileNum).remove();
	fileCount --;
    console.log(content_files);
}

/*
 * 폼 submit 로직
 */
	function registerAction(){
		
	var form = $("form")[0];
 	var formData = new FormData(form);
		for (var x = 0; x < content_files.length; x++) {
			// 삭제 안한것만 담아 준다. 
			if(!content_files[x].is_delete){
				 formData.append("article_file", content_files[x]);
			}
		}
   /*
   * 파일업로드 multiple ajax처리
   */  
	$.ajax({
   	      type: "POST",
   	   	  enctype: "multipart/form-data",
   	      url: "../jik/add",
       	  data : formData,
       	  processData: false,
   	      contentType: false,
   	   	  success: function(data){
   	   			  alert("글이 작성되었습니다.")
   	    		  location.replace("list"); 
   	      },
   	      error: function (error){
				 alert("죄송합니다. 글 작성에 실패했습니다.")
     	    	 location.replace("list");
   	      }
   	    });
}
</script>
</body>
</html>