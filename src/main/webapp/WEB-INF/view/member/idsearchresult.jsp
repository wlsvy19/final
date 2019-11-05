<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 로그인폼 부트스트랩 -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<style type="text/css">


.col-md-3{
	margin-left: 440px;
}

.page-header{
	margin-left : 440px;
}
.form-control{
	text-align: center;
}
#text-sm{
	text-align: center;
}
</style>

<body>
	<div class="container">
		<div class="row">
			<div class="page-header">
				<h2>NANALAND 아이디찾기 결과</h2>
			</div>
			<div class="col-md-3">
				<div class="login-box well">
					<form accept-charset="UTF-8" role="form" method="post" action="idsearchpro.do">

						<div class="form-group">

							<input value="${mem_id}" type="text" class="form-control" readonly="readonly" />
						</div>

					<span class='text-center'>
					<a href="pwsearch.do" class="text-sm">비밀번호 찾기</a></span>

					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>