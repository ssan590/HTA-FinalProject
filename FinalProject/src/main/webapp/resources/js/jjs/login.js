$(function(){
	$('#loginForm').submit(function(){
		if($.trim($('#id').val()) == ''){
			$('#id-message').text('아이디를 입력하세요').css('color', 'red');
			return false;
		}
		if($.trim($('#pass').val()) == ''){
			$('#pass-message').text('비밀번호를 입력하세요').css('color', 'red');
			return false;
		}
	});
	
	$('#id').keyup(function(){
		if($('#id-message').text() != ''){
			$('#id-message').text('');
		}
	});
	
	$('#pass').keyup(function(){
		if($('#pass-message').text() != ''){
			$('#pass-message').text('');
		}
	});
});