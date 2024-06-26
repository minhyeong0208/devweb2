function deletePlayer(bn) {
    console.log("deletePlayer called with", bn);
    const url = `playerdelete.jsp?bn=${bn}`;
    window.open(url, 'deletePlayer', 'width=600,height=200');
}

function editPlayer(bn, name, birth, nation, position, teamcode, pot, cts, cte, deb) {
    console.log("editPlayer called with", bn, name, birth, nation, position, teamcode, pot, cts, cte, deb);
    const url = `playerupdate.jsp?bn=${bn}&name=${encodeURIComponent(name)}&birth=${birth}&nation=${encodeURIComponent(nation)}&position=${position}&teamcode=${encodeURIComponent(teamcode)}&pot=${encodeURIComponent(pot)}&cts=${cts}&cte=${cte}&deb=${deb}`;
    window.open(url, 'editPlayer', 'width=600,height=400');
}

function submitEditForm() {
    var form = document.getElementById('editForm');
    var errorMsg = "";

    var bn = form.bn.value.trim();
    var name = form.name.value.trim();
    var birth = form.birth.value.trim();
    var nation = form.nation.value.trim();
    var teamcode = form.teamcode.value.trim();
    var pos = form.pos.value.trim();
    var cts = form.cts.value.trim();
    var cte = form.cte.value.trim();
    var deb = form.deb.value.trim();

    if (!bn) {
        errorMsg = "등번호를 입력해주세요.";
    } 
    else if (!name) {
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

    if (errorMsg) {
        alert(errorMsg);
    } else {
        form.submit();
    }
}

function addPlayer() {
    console.log("addPlayer called");
    const url = 'playeradd.jsp';
    window.open(url, 'addPlayer', 'width=600,height=400');
}

function submitAddForm() {
    var form = document.getElementById('addForm');
    var position = form.position.value;
    var bn = form.bn.value;
    var name = form.name.value;
    var birth = form.birth.value;
    var nation = form.nation.value;
    var teamcode = form.teamcode.value;
    var pot = form.pot.value;
    var cts = form.cts.value;
    var cte = form.cte.value;
    var deb = form.deb.value;

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

    return true;
}


function closeForm() {
    console.log("closeForm called");
    var editForm = document.getElementById('editForm');
    editForm.style.display = 'none';
}

function closeWindow() {
    window.opener.location.reload(); // 부모 창 새로고침
    window.close();
}

