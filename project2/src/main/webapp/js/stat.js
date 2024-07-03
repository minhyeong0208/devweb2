function addStatData() {
	insertStatFrm.flag.value="insert";
	insertStatFrm.submit();
}

function updateStatData() {
	if(confirm("정말 수정할까요?")){
		updateStatFrm.action="statproc.jsp";
		updateStatFrm.flag.value="update";
		updateStatFrm.method="post";
		
		updateStatFrm.submit();
	}
	
}

function deleteStatData(code) {
    if (confirm("정말 삭제할까요?")) {
        deleteStatFrm.action = "statproc.jsp";
        deleteStatFrm.flag.value = "delete";
        deleteStatFrm.code.value = code;  // code 값을 설정
        deleteStatFrm.method = "post";
        deleteStatFrm.submit();
    }
}

function backStat() {
	window.close();
}

/* 값 변경 시 실행 */
function changeValue() {
	let sDate = document.getElementById("start_date").value;
	let eDate = document.getElementById("end_date").value;
	
	if(sDate === "" || eDate === "") {
		alert("날짜를 입력하시오.")
		return;
	}

	if(sDate > eDate) {
		alert("시작일은 종료일 이전으로 설정할 수 없습니다.");
		return;
	}
	
	let sort = document.querySelector("#sortOrder");
	let selectValue = sort.options[sort.selectedIndex].text;
	//alert(selectValue);
	
	let column = document.querySelector("#columnOrder");
	let selectValue2 = column.options[column.selectedIndex].text;
	
	let filterSort = document.forms["filterSort"];
	filterSort.action = "statistic.jsp?sort=" + selectValue + "&column=" + selectValue2 + "&sdate=" + sDate + "&eDate=" + eDate;
	filterSort.submit();
	
}


