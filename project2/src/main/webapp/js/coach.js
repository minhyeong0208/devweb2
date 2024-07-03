// coach.js

function closeWindow() {
    window.opener.location.reload();
    window.close();
}

function addCoach() {
    console.log("addCoach called");
    const url = 'coachadd.jsp';
    window.open(url, 'addCoach', 'width=600,height=800');
}

function submitAddForm() {
    var form = document.getElementById('addForm');
    var teamcode = form.coachTeamcode.value;
    var name = form.coachName.value;
    var pos = form.coachPos.value;
    var lic = form.coachLic.value;
    var ibdan = form.coachIbdan.value;

    if (teamcode === "") {
        alert("팀 코드를 입력해주세요.");
        return false;
    }
    if (name === "") {
        alert("이름을 입력해주세요.");
        return false;
    }
    if (pos === "") {
        alert("포지션을 선택해주세요.");
        return false;
    }
    if (lic === "") {
        alert("라이선스를 입력해주세요.");
        return false;
    }
    if (ibdan === "") {
        alert("입단 날짜를 선택해주세요.");
        return false;
    }

    return true;
}

function editCoach(code, teamcode, name, pos, lic, ibdan) {
    console.log("editCoach called with", code, teamcode, name, pos, lic, ibdan);
    const url = `coachupdate.jsp?code=${code}&teamcode=${teamcode}&name=${name}&pos=${pos}&lic=${lic}&ibdan=${ibdan}`;
    window.open(url, 'editCoach', 'width=600,height=800');
}

function submitEditForm() {
    var form = document.getElementById('editForm');
    var errorMsg = "";

    var teamcode = form.teamcode.value.trim();
    var name = form.name.value.trim();
    var pos = form.pos.value.trim();
    var lic = form.lic.value.trim();
    var ibdan = form.ibdan.value.trim();

    if (!teamcode) {
        errorMsg = "팀 코드를 입력해주세요.";
    } else if (!name) {
        errorMsg = "이름을 입력해주세요.";
    } else if (!pos) {
        errorMsg = "포지션을 선택해주세요.";
    } else if (!lic) {
        errorMsg = "라이선스를 입력해주세요.";
    } else if (!ibdan) {
        errorMsg = "입단일을 입력해주세요.";
    }

    if (errorMsg) {
        alert(errorMsg);
    } else {
        form.submit();
    }
}

function deleteCoach(code) {
    console.log("deleteCoach called with", code);
    const url = `coachdelete.jsp?code=${code}`;
    window.open(url, 'deleteCoach', 'width=600,height=400');
}
