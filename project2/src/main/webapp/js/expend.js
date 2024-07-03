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

function setDate() { // expend_info 에서 사용
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

	dateForm.action="expend_info.jsp?sdate=" + sdate + "&edate=" + edate;
	dateForm.method="post";
	dateForm.submit();
}

function expendAdd() {
    window.open('expendadd.jsp', '_blank', 'width=750,height=450,left=200,top=200');
    
}

function closeWindow() {
    window.close();
}

function cancel() {
    window.close();
}

function editExpend(code) {
    window.open('expendupdate.jsp?expend_code=' + code, 'expendUpdateWindow', 'width=700,height=850');
}

function deleteExpend(code) {
    window.open('expenddelete.jsp?expend_code=' + code, 'expendDeleteWindow', 'width=700,height=300');
}


function filterData() {
    const filterOption = document.getElementById('filter_option').value;
    const url = 'expendfilter.jsp?filter_option=' + encodeURIComponent(filterOption);
    window.open(url, 'filterResultWindow', 'width=800,height=600');
}


/* */