function validateEmail(email) {
   var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
   return re.test(email);
}// function validateEmail(email)

function checkPhone(ele){
    var $errM = $("<div/>",{"class":"errM"});
    var $target = $(ele);
    var testMobile = isMobile($target.val());
    var testPhone = isPhone($target.val());
    if(testMobile || testPhone ){
      inputSucces($target);
      return true;
    }else{
      inputFail($target,$errM,"유효한 번호를 넣어주세요");
      return false;
    }
}


// http://webskills.kr/archives/310
function onlyNumber(event){
	event = event || window.event;
    $(event.target).val($(event.target).val().replace(/[^0-9]/g,""));
}


// http://holybell87.tistory.com/22#.W0RXUtVLiM8
function isMobile(phoneNum)   { 
  var regExp =/^(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/;  
  return regExp.test(phoneNum); 
}

function isPhone(phoneNum)   { 
  var regExp =/^(02|0[3-9]{1}[0-9]{1})[1-9]{1}[0-9]{2,3}[0-9]{4}$/;  
  return regExp.test(phoneNum); 
}