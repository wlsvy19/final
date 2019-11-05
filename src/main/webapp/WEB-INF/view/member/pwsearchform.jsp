<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>비밀번호 찾기</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
.col-md-3{
	margin-left: 440px;
}

.page-header{
	margin-left : 440px;
}

.modal {
         display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
.modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 30%; /* Could be more or less, depending on screen size */                          
        }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('form').on('submit', function(){
			$('#myModal').show();
		});
	})
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="page-header">
				<h2>NANALAND 비밀번호 찾기</h2>
			</div>
			<div class="col-md-3">
				<div class="login-box well">
					<form accept-charset="UTF-8" role="form" method="post"
						action="pwsearchpro.do">

						<div class="form-group">

							<label for="username-email">아이디</label> <input name="mem_id"
								id="mem_id" placeholder="아이디" type="text" class="form-control" />
						</div>

						<div class="form-group">
							<label for="password">생년월일</label> <input name="mem_birth"
								id="mem_birth" placeholder="생년월일" type="text"
								class="form-control" />
						</div>

						<div class="form-group">
							<input type="submit"
								class="btn btn-default btn-login-submit btn-block m-t-md"
								value="비밀번호 찾기" />
						</div>
						
						<div id="myModal" class="modal">
							<div class = "modal-content">
							 <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">비밀번호 찾는중...</span></p>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

