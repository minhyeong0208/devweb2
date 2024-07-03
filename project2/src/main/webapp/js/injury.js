function addInjury() {
    const form = document.getElementById('addForm');
    form.action = "injuryadd.jsp";
    form.method = "post";
    form.submit();
}

function openAddInjuryForm() {
    window.open('injuryadd.jsp', 'AddInjury', 'width=600,height=750');
}


function editInjury(bn) {
    const url = `injuryupdate.jsp?injury_bn=${bn}`;
    window.open(url, 'editInjury', 'width=550,height=600');
}

function submitEditForm() {
    const form = document.getElementById('editForm');
    form.action = "injuryupdate.jsp";
    form.method = "post";
    form.submit();
}


function deleteInjury(bn) {
    const url = `injurydelete.jsp?injury_bn=${bn}`;
    window.open(url, 'deleteInjury', 'width=600,height=200');
}

function submitDeleteForm() {
    const form = document.getElementById('deleteForm');
    form.action = "injurydelete.jsp";
    form.method = "post";
    form.submit();
}



function closeWindow() {
    window.opener.location.reload(); // 부모 창 새로고침
    window.close();
}

