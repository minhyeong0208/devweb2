/* 수입 지출 내역서(IE_statement.jsp) */

// 수입 지출 내역서를 다운로드하는 함수
function downloadStatement() {
    let date = moment().format('YYYYMMDD'); // 현재 날짜를 'YYYYMMDD' 형식으로 포맷팅
    let filename = '수입지출내역서_' + date + '.xlsx'; // 파일 이름 생성
    
    // 테이블을 엑셀 파일로 변환
    let wb = XLSX.utils.table_to_book(document.querySelector('#stateTable'), {sheet : '명세서', raw: true});
    XLSX.writeFile(wb, (filename)); // 엑셀 파일로 저장
}

// 날짜 설정 함수
function settingDate() {
    let sdate = dateForm.start_date.value; // 시작 날짜 가져오기
    let edate = dateForm.end_date.value; // 종료 날짜 가져오기
    
    if(sdate === "" || edate === "") { // 날짜가 입력되지 않은 경우
        alert("날짜를 입력하시오."); // 경고 메시지 출력
        return;
    }

    if(sdate > edate) { // 시작일이 종료일 이후인 경우
        alert("시작일은 종료일 이전으로 설정할 수 없습니다."); // 경고 메시지 출력
        return;
    }

    // 폼을 제출하여 날짜를 설정
    dateForm.action = "statement.jsp?sdate=" + sdate + "&edate=" + edate;
    dateForm.method = "post";
    dateForm.submit();
}

// 스태프 추가 함수
function staffInsert() {
    insertForm.action = "addstaffproc.jsp"; // 폼 액션 설정
    insertForm.flag.value = "insert"; // 삽입 플래그 설정
    insertForm.method = "get"; // 메서드 설정
    insertForm.submit(); // 폼 제출
}

// 스태프 수정 함수
function staffUpdate() {
    updateForm.action = "addstaffproc.jsp"; // 폼 액션 설정
    updateForm.flag.value = "update"; // 수정 플래그 설정
    updateForm.method = "post"; // 메서드 설정
    updateForm.submit(); // 폼 제출
}

// 스태프 수정 취소 함수
function staffUpdateCancel() {
    location.href = "addstaffinfo.jsp"; // 페이지 이동
    history.back(); // 이전 페이지로 이동
}

// 스태프 삭제 함수
function staffDeleteData(code) {
    console.log("staffDelete called with", code); // 디버깅용 메시지 출력
    const url = `addstaffdelete.jsp?code=${code}`; // 삭제 URL 생성
    window.open(url, 'deleteStaff', 'width=600,height=200'); // 새 창 열기
}
