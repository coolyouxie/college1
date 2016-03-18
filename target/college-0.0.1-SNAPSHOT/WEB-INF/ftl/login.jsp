<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
</head>
<body>
	<form action="login/userLogin" method="post">
		<table>
			<tr>
				<td>用户名:</td>
				<td><input id="userAccount" name="account" type="text" /></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input id="userPassword" name="password" type="password" /></td>
			</tr>
			<tr>
				<td><input type="reset" value="重置" /></td>
				<td><input type="submit" value="登录" /></td>
			</tr>
		</table>
	</form>
</body>
</html>