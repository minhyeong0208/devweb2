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

function setDate() { // income_info 에서 사용
	let sdate = dateForm.start_date.value;// 시작일 가져오기
	let edate = dateForm.end_date.value;// 종료일 가져오기
	
	if(sdate === "" || edate === "") {// 시작일 또는 종료일이 비어 있는지 확인
		alert("날짜를 입력하시오.")
		return;
	}

	if(sdate > edate) {// 시작일이 종료일보다 이후인지 확인
		alert("시작일은 종료일 이전으로 설정할 수 없습니다.");
		return;
	}

	dateForm.action="income_info.jsp?sdate=" + sdate + "&edate=" + edate;// 폼의 action 속성 설정

	dateForm.method="post";// 폼의 메서드 설정
	dateForm.submit(); // 폼 제출
}

function incomeAdd() {
    window.open('incomeadd.jsp', '_blank', 'width=750,height=450,left=200,top=200'); // 새로운 창으로 incomeadd.jsp 열기
    
}

function closeWindow() {
    window.close();// 현재 창 닫기
}

function cancel() {
    window.close();// 현재 창 닫기
}

function editIncome(code) {
    window.open('incomeupdate.jsp?income_code=' + code, 'incomeUpdateWindow', 'width=700,height=850');// 특정 수입 내역을 수정하기 위해 새로운 창 열기
}

function deleteIncome(code) {
    window.open('incomedelete.jsp?income_code=' + code, 'incomeDeleteWindow', 'width=700,height=300');// 특정 수입 내역을 삭제하기 위해 새로운 창 열기
}


function filterData() {
    const filterOption = document.getElementById('filter_option').value;// 필터 옵션 가져오기
    const url = 'incomefilter.jsp?filter_option=' + encodeURIComponent(filterOption);// URL 설정
    window.open(url, 'filterResultWindow', 'width=800,height=600');// 필터 결과를 보여주기 위해 새로운 창 열기
}


/* */