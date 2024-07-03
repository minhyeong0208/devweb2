function settingDate() {
	let sdate = dateForm.start_date.value;
	let edate = dateForm.end_date.value;
	console.log(sdate);
	if(sdate === "" || edate === "") {
		alert("날짜를 입력하시오.")
		return;
	}

	if(sdate > edate) {
		alert("시작일은 종료일 이전으로 설정할 수 없습니다.");
		return;
	}

	dateForm.action="game.jsp?sdate=" + sdate + "&edate=" + edate;
	dateForm.method="post";
	dateForm.submit();
}

function addGame() {
	window.open('insertgame.jsp', '', 'width=700,height=400,left=200,top=200');
	//var frm = document.forms['frm'];  // insertgame.jsp에서 폼을 가져옴
   /*
   if(document.frm.away.value==""){
		alert("원정팀을 입력하세요");
		frm.away.focus();
	}else if(frm.date.value ==""){
		alert("경기날짜를 입력하세요");
		frm.date.focus();
	}else if(frm.homesc.value ==""){
		alert("득점을 입력하세요");
		frm.homesc.focus();
	}else if(frm.awaysc.value ==""){
		alert("실점을 입력하세요");
		frm.titlawaysce.focus();
	}else if(frm.stadium.value ==""){
		alert("경기장을 입력하세요");
		frm.stadium.focus();
	}else if(frm.poss.value ==""){
		alert("점유율을 입력하세요");
		frm.poss.focus();
	}else if(frm.sot.value ==""){
		alert("유효슈팅율을 입력하세요");
		frm.sot.focus();
	}else if(frm.tac.value ==""){
		alert("태클성공률을 입력하세요");
		frm.tac.focus();
	}else
		frm.submit();
    */
}

function backGame() {
    window.close();
}


function editGame(code) {
	window.open('updategame.jsp?mat_code=' + code, 'GameUpdateWindow', 'width=600,height=400');
}