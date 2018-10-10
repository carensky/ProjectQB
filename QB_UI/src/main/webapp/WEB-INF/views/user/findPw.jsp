<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword"
	content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>Dashio - Bootstrap Admin Template</title>

<!-- Favicons -->
<link href="img/favicon.png" rel="icon">
<link href="img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet">
<link href="css/style-responsive.css" rel="stylesheet">

<!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
</head>

<body>
	<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
	<div id="login-page">
		<div class="container">
			<form class="form-login2" action="index.html">
				<h2 class="form-login-heading">password Search</h2>
				<div class="login-wrap">
					<input type="text" class="form-control" placeholder="ID" autofocus>
					<br> <input type="text" class="form-control"
						placeholder="Email"> <br>
					<div align="right">
						<span id="">인증번호 유효기간 &nbsp; &nbsp;</span>
						<button class="btn btn-theme" id="auth">Authorization
							Code Send</button>
					</div>
					<br> <input type="text" class="form-control"
						placeholder="Authorization Code"> <br> <a
						data-toggle="modal" href="login.html#myModal"
						class="btn btn-theme" id="modal_confirm"> Confirm</a>
					<hr>

					<div id="remember">
						<a class="" href="#"> 정보 기억남? 그럼 이거 클릭 Login </a> <br> <a
							class="" href="idSearch.do"> id모름? 그럼 이거 클릭 pw </a>
					</div>
					<br>
				</div>
				<!-- Modal -->
				<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
					tabindex="-1" id="myModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title">Alert</h4>
							</div>
							<div class="modal-body">
								<p>입력하신 이메일로 임시 비밀번호가 전송 되었습니다. 확인 후 로그인 해 주세요.</p>
							</div>
							<div class="modal-footer">
								<button class="btn btn-theme" type="button">LOGIN</button>
							</div>
						</div>
					</div>
				</div>
				<!-- modal -->
			</form>
		</div>
	</div>
	<!-- js placed at the end of the document so the pages load faster -->
	
	<script>
		$.backstretch("${pageContext.request.contextPath}/img/login-bg.jpg", {
			speed : 500
		});
	</script>
</body>

</html>
