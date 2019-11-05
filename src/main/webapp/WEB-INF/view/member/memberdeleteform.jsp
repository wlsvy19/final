<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">


.col-md-3{
	margin-left: 440px;
}

.page-header{
	margin-left : 440px;
}
</style>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="page-header">
				<h2>NANA LAND 회원탈퇴</h2>
			</div>
			<div class="col-md-3">
				<div class="login-box well">
					<form accept-charset="UTF-8" role="form" method="post" 
						action="memberdeletepro.do">

						<div class="form-group">

							<label for="username-email">아이디</label> <input name="mem_id"
								id="mem_id" placeholder="ID" type="text" class="form-control" />
						</div>

						<div class="form-group">
							<label for="password">비밀번호</label> <input name="mem_pw"
								id="mem_pw" placeholder="Password" type="password"
								class="form-control" />
						</div>

						<div class="form-group">
							<input type="submit"
								class="btn btn-default btn-login-submit btn-block m-t-md"
								value="회원탈퇴" />
								<div style="color: red; text-align:center;">${msg1}</div>
								<div style="color: red; text-align:center;">${msg2}</div>
								
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>