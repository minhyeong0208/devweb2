<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<link href="../css/style.css" rel="stylesheet" type="text/css">
<div class="top_bar">
	<img src="../images/k_emblem02.png" alt="K LEAGUE" class="logo">
</div>
<div class="side_bar">
<!-- <span><//%=get.Name() %></span> -->
<div>
	<a href="editProfile.jsp" style= "color: gray; margin-left: 20px" style= "text-align: center">회원 정보 수정</a>
</div>
	<details open>
		<summary>재정관리</summary>
		<ul>
			<li class="list"><a href="#">수입정보</a></li>
			<li class="list"><a href="#">지출정보</a></li>
			<li class="list"><a href="IE_statement.jsp">수입지출내역서</a></li>
		</ul>
	</details>
	<details open>
		<summary>인적/물적자원</summary>
		<ul>
			<li class="list"><a href="#">경기정보</a></li>
			<li class="list"><a href="#">선수정보</a></li>
			<li class="list"><a href="#">코치정보</a></li>
			<li class="list"><a href="#">부상현황</a></li>
			<li class="list"><a href="#">시설</a></li>
			<li class="list"><a href="#">훈련</a></li>
		</ul>
	</details>
	<details open>
		<summary>통계</summary>
		<ul>
			<li class="list"><a href="#">통계정보</a></li>
			<li class="list"><a href="#">경기정보</a></li>
		</ul>
	</details>
	<div></div>
</div>