<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>驴妈妈机票后台管理登录</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/login_admin.css" />

</head>
<script type="text/javascript">
//登录
function checkUserLogin(){
	 var loginName=$.trim($("#loginName").val());
	 var password=$.trim($("#password").val());
		if(loginName=='' || password==''){
			alert("请输入登录用户名和密码");
			return;
		}
	   $.ajax({
			url : "${request.contextPath}/checkUserLogin",
			cache : false,
			async : false,
			data : {
				"loginName" : loginName,
				"password" : password
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			 if(data!="" && data=="succees"){
			    	$("#userName").val(loginName);
		            $("#passwords").val(password);
		            document.form1.action = "searchUserLogin";
                    document.form1.submit(); 
			 }else{
			     alert("登录失败,请重新登录！");
			     window.location.reload(); 
			 }
   		  }
	    });
	}

</script>

<body>
	<div class="w800">
		<div class="logo">
			<a href="http://www.lvmama.com">驴妈妈旅游网</a>
		</div>
		<p class="link_help">
			<a href="">帮助中心</a>
		</p>
			<INPUT TYPE="HIDDEN" NAME="gsDm" value="00001" ID="gsDm" />
			 <form id="form1" method="post" name="form1" >
			 <INPUT type="hidden" NAME="userName" ID="userName" />
			 <INPUT type="hidden" NAME="passwords" ID="passwords" />
			 </form>
			<div class="login">
				<h2>后台管理登录</h2>
				<ul>
					<li>
						<label>账&nbsp;&nbsp;&nbsp;号：</label>
						<input type="text" class="txt" name="loginName" id="loginName"/>
					</li>
					<li>
						<label>密&nbsp;&nbsp;&nbsp;码：</label>
						<input type="password" class="txt" name="password" id="password" tabIndex="2"/>
					</li>
					<li>
						<a href="javascript:checkUserLogin()"><input class="btn" type="submit" value="登&nbsp;&nbsp;录" id="btlogin" name="btlogin"></input></a>
						<a href="#">忘记密码？</a>
					</li>
				</ul>
			</div>
		
		<div class="foot">
			<p>
					<a href="http://lvmama.com">关于我们@驴妈妈旅游网</a> |
					<a href="http://lvmama.com">联系我们</a>
			</p>
			<p>
				Copyright 2009-2011 沪ICP备09057645号
			</p>
		</div>
	</div>
</body>
</html>

