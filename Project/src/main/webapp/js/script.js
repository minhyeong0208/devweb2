/* 수입 지출 내역서(IE_statement.jsp) */
function downloadStatement() {
	let date = moment().format('YYYYMMDD');
	let filename = '수입지출내역서_' + date + '.xlsx';
	
	let wb = XLSX.utils.table_to_book(document.querySelector('#stateTable'), {sheet : '명세서', raw: true});
	XLSX.writeFile(wb, (filename));
}

function settingDate() {
	let sdate = dateForm.start_date.value;
	let edate = dateForm.end_date.value;
	
	if(sdate === "" || edate === "") {
		alert("날짜를 입력하시오.")
		return;
	}

	if(sdate > edate) {
		alert("시작일은 종료일 이전으로 설정할 수 없습니다.");
		return;
	}

	dateForm.action="statement.jsp?sdate=" + sdate + "&edate=" + edate;
	dateForm.method="post";
	dateForm.submit();
}

/* */