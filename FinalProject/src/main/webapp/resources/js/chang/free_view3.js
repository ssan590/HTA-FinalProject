function getList(currentPage,state){
		option=state;
		
		$.ajax({
					type: "post",
					url: "../free_comm/list",
					data : {
						"free_num" : $("#free_num").val(),
						"page" : currentPage,
						"state" : state
					},
					dataType : "json",
					success : function(rdata){
						$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
						var red1='red';		var red2='red';
						if(option==1){  //등록순인 경우 등록순이 'red', 최신순이 'gray'로 글자색을 나타냅니다.
							red2='gray';
						}else if(option==2){ //최신순인 경우 등록순이 'gray', 최신순이 'red'로 글자색을 나타냅니다.
							red1='gray';
						}					
						var output="";
						$("#count").text(rdata.listcount);
							
							  output += '<li class="comment_tab_item ' +  red1 + '" >'
	                          + '   <a href="javascript:void(0);" onclick="getList(1,1);" class="comment_tab_button">최신순 </a>'
	                          + '</li>'
	                          + '<li class="comment_tab_item ' +  red2 + '" >'
	                          + '   <a href="javascript:getList(1,2)" class="comment_tab_button">등록순</a>'
	                          + '</li>'
				              + '<li class="comment_tab_item " >'
	                          + '   <a href="javascript:report()" class="comment_tab_button">신고하기</a>'
	                          + '</li>';
	                     $('.comment_tab_list').html(output);//댓글 수 등록순 최신순 출력
	                     if(rdata.listcount > 0){ 
					    output='';
						$(rdata.list).each(function(){
							var lev = this.free_comm_lev;
							var comment_reply='';
							//레벨에 따라 왼쪽 여백줍니다.
							if(lev>=1){
							comment_reply = ' CommentItem--reply lev1';//margin-left: 46px;
							}
							
						
							
							output += '<li id="' + this.free_comm_num + '" class="CommentItem' + comment_reply + '">'
								   + '   <div class="comment_area">'
								   + '    <div class="comment_box">'
								   + '      <div class="comment_nick_box">'
								   + '            <div class="comment_nick_info">'
								   + '               <div class="comment_nickname">' + this.nick + '</div>'
								   + '            </div>' //comment_nick_info                  
								   + '       </div>'  // comment_nick_box
								   + '     </div>'   //comment_box
								   + '    <div class="comment_text_box">'
								   + '       <p class="comment_text_view">'
								   + '         <span class="text_comment">' + this.free_comm_content + '</span>'
								   + '       </p>'
								   + '    </div>' //comment_text_box
								   + '    <div class="comment_info_box">'
								   + '      <span class="comment_info_date">' + this.free_comm_date + '</span>';
							
							   	  output += '  <a href="javascript:replyform(' + this.free_comm_num +',' 
							   	         + lev + ',' + this.free_comm_re_seq +',' 
							   	         + this.free_comm_re_ref +')"  class="comment_info_button">답글쓰기</a>'
							     
							output += '   </div>' //comment_info_box;
								   
							//글쓴이가 로그인한 경우 나타나는 더보기입니다.
	                        //수정과 삭제 기능이 있습니다.							
							if($("#Loginid").val()==this.id ||$("#Loginid").val()=='admin'){  
							 output +=  '<div class="comment_tool">'
								   + '    <div title="더보기" class="comment_tool_button">'
								   + '       <div>&#46;&#46;&#46;</div>' 
								   + '    </div>'
								   + '    <div id="commentItem' +  this.free_comm_num + '"  class="LayerMore">' //스타일에서 display:none; 설정함
								   + '     <ul class="layer_list">'							   
								   + '      <li class="layer_item">'
								   + '       <a href="javascript:updateForm(' + this.free_comm_num + ')"'
								   + '          class="layer_button">수정</a>&nbsp;&nbsp;'
								   + '       <a href="javascript:del(' + this.free_comm_num + ')"'
								   + '          class="layer_button">삭제</a></li></ul>'
								   + '     </div>'//LayerMore
								   + '   </div>'//comment_tool
							}
								   
							output += '</div>'// comment_area
								   + '</li>'//li
						})//each
						 $('.comment_list').html(output);
						
						if(rdata.listcount > rdata.list.length){
							$("#message").text("더보기");
						}else{
							$("#message").text("");
						}
				 }//if(rdata.boardlist.length>0)
					else{ //댓글 1개가 있었는데 삭제하는 경우 갯수는 0이라  if문을 수행하지 않고 이곳으로 옵니다.
					   //이곳에서 아래의 두 영역을 없앱니다.
					 $("#message").text("등록된 댓글이 없습니다.")
					 $('.comment_list').empty();  
					 $('.comment_tab_list').empty(); 
				 }
				}//success end
			});//ajax end
			
			 
		}//function(getList) end

function updateForm(free_comm_num){ //num : 수정할 댓글 글번호
	
	//선택한 내용을 구합니다.
	var content=$('#'+free_comm_num).find('.text_comment').text();
	
	var selector = '#'+comm_+'.comment_area'
	$(selector).hide(); //selector 영역  숨겨요 - 수정에서 취소를 선택하면 보여줄 예정입니다.
	
	//$('.comment_list+.CommentWriter').clone() : 기본 글쓰기 영역 복사합니다.
	//글이 있던 영역에 글을 수정할 수 있는 폼으로 바꿉니다.
	selector=$('#'+free_comm_num);
	selector.append($('.comment_list+.CommentWriter').clone());
	
	//댓글쓰기 영역 숨깁니다.
	$('.comment_list+.CommentWriter').hide();
	
	//수정 폼의 <textarea>에 내용을 나타냅니다.
	selector.find('textarea').val(content);
	
	
	//'.btn_register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가하며 등록을 수정완료
	selector.find('.btn_register').attr('data-id',free_comm_num).addClass('update').text('수정완료');
	
	//폼에서 취소를 사용할 수 있도록 보이게 합니다.
	selector.find('.btn_cancel').css('display','block').addClass('update_cancel');
	
	selector.find('.comment_inbox_count').text(content.length+"/200");
}//function(updateForm) end

//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(free_comm_num){//num : 댓글 번호
	if(!confirm('정말 삭제하시겠습니까')){
		return;
	}
	
	$.ajax({
		url:'ReplyDelete.freebo',
		data:{free_comm_num:free_comm_num},
		success:function(rdata){
			if(radata==1){
				getList(option);
			}
		}
	})
}//function(del) end
//답글 달기 폼
function replyform(free_comm_num,lev,seq,ref){
	//댓글달기 폼이 열려있다는 것은 다른 폼이 열려있지 않은 경우입니다.
	if($('.comment_list+.CommentWriter').css('display')=='block'){
		var output = '<li class="CommentItem CommentItem--reply lev'
				   +  lev 	+ ' CommentItem-form"></li>'
				   
		var selector = $('#'+free_comm_num);
		
		//선택한 글 뒤에 답글 폼을 추가합니다.
		selector.after(output);
		
		//글쓰기 영역 복사합니다.
		output=$('.comment_list+.CommentWriter').clone();
		
		//댓글쓰기 영역 숨깁니다.
		$('.comment_list+.CommentWriter').hide();
		
		
		//더보기를 누른 상태에서 답글 달기 폼을 연 경우 더보기의 영역 보이지 않게 합니다.
		$(".CommentBox .LayerMore").css('display','none');
		
		//선택한 글 뒤에 답글 폼 생성합니다.
		selector.next().html(output);
		
		//답글 폼의 <textarea>의 속성 'placeholder'를 '답글을 남겨보세요'로 바꾸어 줍니다.
		selector.next().find('textarea').attr('placeholder','답글을 남겨보세요');
		
		//답글 폼의 '.btn_cancel'을 보여주고 클래스 'reply_cancel'를 추가합니다.
		selector.next().find('.btn_cancel').css('display','block')
							.addClass('reply_cancel');
		
		//답글 폼의 '.btn_register'에 클래스 'reply' 추가합니다.
		//속성 'data-ref'에 ref, 'data-lev'에 lev, 'data-seq'에 seq값을 설정합니다.
		selector.next().find('.btn_register').addClass('reply').text('답글완료')
					.attr('data-ref',ref).attr('data-lev',lev).attr('data-seq',seq);
	}else{
		alert('다른 작업 완료 후 선택하세요')
	}
}//function(replyform) end




$(function(){
	var page=1; //더 보기에서 보여줄 페이지를 기억할 변수
	count = parseInt($("#count").text());
	option=1;
	if(count !=0){ //댓글 갯수가 0이 아니면
		getList(1,option) // 첫 페이지의 댓글을 구해 옵니다. ( 한 페이지에 3개씩 가져옵니다.)
	}else { //댓글이 없는 경우 
		$("#message").text("등록된 댓글이 없습니다.")
	}
	
	$('.CommentBox').on('click','.reply',function(){
		 
		 var content=$(this).parent().parent().find('.comment_inbox_text').val();
		 if(!content){
			 alert('답변 내용을 입력하세요');
			 return
		 }
		 
		 //댓글쓰기 영역 보이도록 합니다.
		 $('.comment_list+.CommentWriter').show();
		 
		 $.ajax({
			 url : 'ReplyComment.freebo',
			 data : {
				 mem_nickname : $("#mem_nickname").val(),
				 reply_content : content,
				 reply_board_idx : $("#reply_board_idx").val(),
				 reply_re_lev : $(this).attr('data-lev'),
				 reply_re_ref : $(this).attr('data-ref'),
				 reply_re_seq : $(this).attr('data-seq')
			 },
			 type : 'post',
			 success : function(rdata){
				 if(rdata == 1){
					 getList(option);
				 }
			 }
		 })//ajax
	})//답변 달기 등록 버튼을 클릭한 경우

	//답변달기 후 취소 버튼을 클릭한 경우
	$('.CommentBox').on('click','.reply_cancel',function(){
		$(this).parent().parent().parent().remove();
			
		//댓글쓰기 영역 보이도록 합니다.
		$('.comment_list+.CommentWriter').show();
	})//수정 후 취소 버튼을 클릭한 경우	
	
	
	// 글자수 50개 제한하는 이벤트
	$(".comment_inbox_text").on('keyup',function(){
		free_comm_content = $(this).val();
		length = $(this).val().length;
		if(length > 200){
			length = 200;
			free_comm_content = free_comm_content.substring(0, length);
		}
		$(".comment_inbox_count").text(length + "/200")
	})
	
	
	//더 보기를 클릭하면 page 내용이 추가로 보여집니다.
	$("#message").click(function(){
		getList(++page,1);
	}); // click end
	
	
	
	
	// 등록 또는 수정완료 버튼을 클릭한 경우
	// 버튼의 라벨이 '등록'인 경우는 댓글을 추가하는 경우
	// 버튼의 라벨이 '수정완료'인 경우는 댓글을 수정하는 경우
	$("#write").click(function(){
		buttonText = $("#write").text(); // 버튼의 라벨로 add할지 update할지 결정
		
		var content=$('.comment_inbox_text').val();
		if(!content){//내용없이 등록 클릭한 경우
			alert("댓글을 입력하세요");
			return;
		}
		
		if(buttonText == "등록"){ // 댓글을 추가하는 경우
			url = "../free_comm/add";
			data = {
					"free_comm_content" : $(".comment_inbox_text").val(),
					"id" : $("#Loginid").val(),
					"nick" : $("#Loginnick").val(),
					"free_board_num" : $("#free_num").val(),
					"free_comm_re_lev" : 0,
					"free_comm_re_seq" : 0
			};
		}else { //댓글을 수정하는 경우
			url = "../free_comm/update";
			data = {
					"free_comm_num" : free_comm_num,
					"free_comm_content" : free_comm_content
			};
			$("#write").text("등록"); // 다시 등록으로 변경
		}
		
		$.ajax({
			type : "post",
			url : url,
			data : data,
			success : function(result){
				$(".comment_inbox_text").val('');
				$('.comment_inbox_count').text('');
				if (result == 1){
					//page=1
					getList(page,1); // 등록, 수정완료 후 해당 페이지 보여줍니다.
				}//if
			}//success
		})//ajax end
	})// $("#write") end
	
	
	// pencil2.png를 클릭하는 경우(수정)
	$("#comment").on('click','.update', function(){
		before = $(this).parent().prev().text(); // 선택한 내용을 가져옵니다.
		$("#content").focus().val(before); // textarea에 수정전 내용을 보여줍니다.
		free_comm_num = $(this).next().next().val(); // 수정할 댓글번호를 저장합니다.
		$("#write").text("수정완료"); // 등록버튼의 라벨을 '수정완료'로 변경합니다.
		
		//$("#comment .update").parent().parent()
		//#comment영역의 update클래스를 가진 엘리먼트의 부모의 부모 => <tr>
		//not(this) : 테이블의 <tr>중에서 현재 선택한 <tr>을 제외한 <tr>에 배경색을 흰색으로 설정합니다.
		//즉, 선택한 수정(.update)만 'lightgray'의 배경색이 나타나도록 하고
		//선택하지 않은 수정의 <tr>엘리먼트는 흰색으로 설정합니다.
		//$("#comment .update").parent().parent().not(this).css('background', 'white');
		$(this).parent().parent().css("background","lightgray");
		//수정할 행의 배경색을 변경합니다.
		$(this).parent().parent().siblings().css("background","white");
		
	})
	
		$("#comment").on('click','.remove', function(){
			
		if(!confirm('정말 삭제하시겠습니까?')){
			return;
		}
		free_comm_num = $(this).next().val(); // 댓글번호
		
		$.ajax({
			type : "post",
			url : "../free_comm/delete",
			data : {
				"free_comm_num" : free_comm_num
				},
			success : function(result){
				if (result == 1){
					//page=1;
					getList(page,1); // 삭제 후 해당 페이지 보여줍니다.
				}//if
			}//success
		})//ajax end
		
	})
	
			//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라져요-toggle()이용
	 $('.comment_list').on('click','.comment_tool_button',function(){
		 var selector = $(this).next();
		 
		 //댓글쓰기 폼이 나타난 경우에만 더보기를 선택할 수 있도록 합니다.
		 if($('.comment_list+.CommentWriter').css('display')=='block'){
			 selector.toggle();
			 
			 //더보기를 여러개 선택하더라도 최종 선택한 더보기 한개만 보이도록 합니다.
			 if(selector.css('display')=='block'){//현재 더보기가 열린 경우
				 //$(".LayerMore")중에서 selector가 아닌 객체들의 display 속성을 none으로 설정합니다.
				 $(".LayerMore").not(selector).css('display','none'); 
			 }
		 }else{
			 //답글쓰기 폼이나 수정 폼이 열려있는 상황에서 더보기를 클릭한 경우
			 alert('작업 완료 후 선택해 주세요')
		 }
	 })//'.comment_tool_button' click end
	 
})
