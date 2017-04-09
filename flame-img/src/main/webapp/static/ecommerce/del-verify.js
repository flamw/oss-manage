 if($('#J-yzmCodeBtn').attr('data-flag')){
		    var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
		    var randomCode = "";
		    //生成随机码
		    for(var i = 0; i < 8 ; i ++) {
		       var id = Math.ceil(Math.random()*35);
		       randomCode += chars[id];
		    }

		    $('#J-codeText').text(randomCode)
		   function yzmCodeBtn(){
		    	var s=$("#J-codeText").text();
		    	$("#J-input-code").val(s);			    	
		   	 }; 
		  }
	 
	  function validateYzm(){
		    var inputCodeVal = $('#J-input-code').val();
		    var codeTextVal = $('#J-codeText').text();
		    if(inputCodeVal == codeTextVal){
		      return true;
		    }else{
		      return false;
		    }
	  }
	  
	  
	  
  