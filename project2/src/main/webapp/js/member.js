// 아이디 유효성 검사 - 중복 체크
function idCheck(){
	//alert("id Check");
	if(registerFrm.id.value === ""){
		alert("Id를 입력하세요!");
		registerFrm.id.focus();
	} else {
		url = "idCheck.jsp?id=" + registerFrm.id.value;
		window.open(url, "id", "width=400, height=200,top=250, left=500");
	}
}

// 회원가입 자료 유효성 검사 : 비밀번호 - 규칙 체크, 이메일 - 형식(~@~) 체크
function validCheck(){
    //alert("validCheck");
    //event.preventDefault();

	var id = document.querySelector("#id").value;
	var passwd = document.querySelector("#passwd").value;
	var passwdCheck = document.querySelector("#passwdCheck").value;
	var name = document.querySelector("#name").value;
	var birth = document.querySelector("#birth").value;
	var email = document.querySelector("#email").value;
	var teamcode = document.querySelector("#teamcode").value;
	
	if(id === ""){
	    alert("아이디를 입력하세요");
	    return false;
	} else if(passwd === ""){
	    alert("비밀번호를 입력하세요");
	    return false;
	} else if(passwdCheck === ""){
	    alert("비밀번호를 한번 더 입력하세요");
	    return false;
	} else if(name === ""){
	    alert("이름을 입력하세요");
	    return false;
	} else if(birth === ""){
	    alert("생일을 선택하세요");
	    return false;
	} else if(email === ""){
	    alert("이메일을 입력하세요");
	    return false;
	} else if(teamcode === "0"){
	    alert("팀을 선택하세요");
	    return false;
	}

	// 비밀번호 유효성 검사	
	// 2~6자, 영문자, 숫자 각각 최소 하나씩
	const passwdRegEx = /^(?=.*[a-zA-Z])(?=.*[0-9]).{2,6}$/;
	
	if(passwdRegEx.test(passwd)){
		if(passwd === passwdCheck){
			//alert("비밀번호 일치 & 유효");
		} else {
			alert("비밀번호가 일치하지 않습니다");
			//passwdCheck = "";
			document.querySelector("#passwdCheck").focus();
            return false;
		}
	} else {
		alert("비밀번호는 2~6자, 영문자, 숫자 각각 최소 하나씩");
		//passwd = "";
		//passwdCheck = "";
		document.querySelector("#passwd").focus();
		return false;
	};
	
	//alert("비번 유효성 검사 완");
	
	// 이메일 유효성 검사	
	// [...]@[...].[..] 형식
	const emailRegEx = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	
	if(emailRegEx.test(email)){
		//alert("유효한 이메일 주소");
		registerFrm.submit();
	} else {
		alert("유효하지 않은 이메일 주소입니다");
		email = "";
		document.querySelector("#email").focus();
		return false;
	};
	
	
	
}



function memberUpdate(){
	if(confirm("정말 수정할까요?")){
		if(editFrm.passwd_re.value === ""){
			alert("비밀번호를 입력하세요");
		} else if(editFrm.passwd.value !== editFrm.passwd_re.value){
			alert("비밀번호가 일치하지 않습니다");
		} else {
		    editFrm.edit.value = "update";
			editFrm.submit();
			
		}
	}
}

function memberDelete(){
	if(confirm("정말 삭제할까요?")){
		if(editFrm.passwd_re.value === ""){
			alert("비밀번호를 입력하세요");
		} else if(editFrm.passwd.value !== editFrm.passwd_re.value){
			alert("비밀번호가 일치하지 않습니다");
		} else {
		    editFrm.edit.value = "delete";
			editFrm.submit();
			
		}
	}
}

