/* 수입 지출 내역서(statement.jsp) */
function downloadStatement() {
	let date = moment().format('YYYYMMDD');
	let filename = '수입지출내역서_' + date + '.xlsx';

	let wb = XLSX.utils.table_to_book(document.querySelector('#stateTable'), { sheet: '명세서', raw: true });
	XLSX.writeFile(wb, (filename));
}

function settingDate() {
	let sdate = dateForm.start_date.value;
	let edate = dateForm.end_date.value;

	if (sdate === "" || edate === "") {
		alert("날짜를 입력하시오.")
		return;
	}

	if (sdate > edate) {
		alert("시작일은 종료일 이전으로 설정할 수 없습니다.");
		return;
	}

	dateForm.action = "statement.jsp";
	dateForm.method = "post";
	dateForm.submit();
}
/* 통계 시즌 구하는 함수*/
function selectSeason() {
	var currentYear = new Date().getFullYear();
	var selectYear = document.querySelector("#selectYear");
	
	for(var i = currentYear; i >= 1940; i--) {
		var option = document.createElement("option");
		option.value = i;
		option.text = i;
		selectYear.appendChild(option);
	}
	
	selectDate.action = "statistic.jsp?season=" + selectYear;
	selectDate.method = "post";
	selectDate.submit();
}



function changeValue() {
	let sel = document.querySelector("#selectbox");
	let selectValue = sel.options[sel.selectedIndex].text;
	//alert(sel);

	selectForm.action = "statistic.jsp?select=" + selectValue;
	selectForm.method = "get";
	selectForm.submit();
}

function changeValue2() {
	let sort = document.querySelector("#sortOrder");
	let selectValue2 = sort.options[sort.selectedIndex].text;
	
	selectForm.action = "statistic.jsp?select=" + + "&sort=" + selectValue2;
	selectForm.method = "get";
	selectForm.submit();
}



function backStat() {
	window.close();
}