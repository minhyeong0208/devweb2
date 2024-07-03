// 선수 삭제 함수
function deletePlayer(bn) {
    console.log("deletePlayer called with", bn);
    const url = `playerdelete.jsp?bn=${bn}`;
    window.open(url, 'deletePlayer', 'width=600,height=400');
}

// 선수 수정 함수
function editPlayer(bn, name, birth, nation, position, teamcode, pot, cts, cte, deb) {
    console.log("editPlayer called with", bn, name, birth, nation, position, teamcode, pot, cts, cte, deb);
    const url = `playerupdate.jsp?bn=${bn}&name=${encodeURIComponent(name)}&birth=${birth}&nation=${encodeURIComponent(nation)}&position=${position}&teamcode=${encodeURIComponent(teamcode)}&pot=${encodeURIComponent(pot)}&cts=${cts}&cte=${cte}&deb=${deb}`;
    window.open(url, 'editPlayer', 'width=600,height=1200');
}

// 선수 수정 폼 제출 함수
function submitEditForm() {
    let form = document.getElementById('editForm');
    let errorMsg = "";

    let bn = form.bn.value.trim();
    let name = form.name.value.trim();
    let birth = form.birth.value.trim();
    let nation = form.nation.value.trim();
    let teamcode = form.teamcode.value.trim();
    let pos = form.pos.value.trim();
    let cts = form.cts.value.trim();
    let cte = form.cte.value.trim();
    let deb = form.deb.value.trim();

    // 필수 입력값 검증
    if (!bn) {
        errorMsg = "등번호를 입력해주세요.";
    } else if (!name) {
        errorMsg = "이름을 입력해주세요.";
    } else if (!birth) {
        errorMsg = "생년월일을 입력해주세요.";
    } else if (!nation) {
        errorMsg = "국가를 입력해주세요.";
    } else if (!teamcode) {
        errorMsg = "팀 코드를 입력해주세요.";
    } else if (!pos) {
        errorMsg = "포지션을 선택해주세요.";
    } else if (!cts) {
        errorMsg = "계약 시작일을 입력해주세요.";
    } else if (!cte) {
        errorMsg = "계약 종료일을 입력해주세요.";
    } else if (!deb) {
        errorMsg = "데뷔일을 입력해주세요.";
    }

    // 에러 메시지가 있는 경우 경고창 표시
    if (errorMsg) {
        alert(errorMsg);
    } else {
        form.submit(); // 폼 제출
    }
}

// 선수 추가 함수
function addPlayer() {
    console.log("addPlayer called");
    const url = 'playeradd.jsp';
    window.open(url, 'addPlayer', 'width=600,height=1200');
}

// 선수 추가 폼 제출 함수
function submitAddForm() {
    let form = document.getElementById('addForm');
    let position = form.position.value;
    let bn = form.bn.value;
    let name = form.name.value;
    let birth = form.birth.value;
    let nation = form.nation.value;
    let teamcode = form.teamcode.value;
    let pot = form.pot.value;
    let cts = form.cts.value;
    let cte = form.cte.value;
    let deb = form.deb.value;

    // 필수 입력값 검증
    if (position === "") {
        alert("포지션을 선택해주세요.");
        return false;
    }
    if (bn === "") {
        alert("등번호를 입력해주세요.");
        return false;
    } else if (bn < 1 || bn > 99) {
        alert("등번호는 1에서 99 사이여야 합니다.");
        return false;
    }
    if (name === "") {
        alert("이름을 입력해주세요.");
        return false;
    }
    if (birth === "") {
        alert("생년월일을 선택해주세요.");
        return false;
    }
    if (nation === "") {
        alert("국가를 입력해주세요.");
        return false;
    }
    if (teamcode === "") {
        alert("팀 코드를 입력해주세요.");
        return false;
    }
    if (pot === "") {
        alert("잠재력을 입력해주세요.");
        return false;
    }
    if (cts === "") {
        alert("계약 시작일을 선택해주세요.");
        return false;
    }
    if (cte === "") {
        alert("계약 종료일을 선택해주세요.");
        return false;
    }
    if (deb === "") {
        alert("데뷔일을 선택해주세요.");
        return false;
    }

    return true; // 검증 통과 시 true 반환
}

// 폼 닫기 함수
function closeForm() {
    console.log("closeForm called");
    let editForm = document.getElementById('editForm');
    editForm.style.display = 'none';
}

// 창 닫기 함수
function closeWindow() {
    window.opener.location.reload(); // 부모 창 새로고침
    window.close();
}
