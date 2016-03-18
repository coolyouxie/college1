<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8", name="viewport" initial-scale=1 http-equiv="Content-Type" content="width=device-width, initial-scale=1" >
<title>学院管理系统</title>
<link rel="stylesheet" href="${request.contextPath}/jquery/jqueryui/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${request.contextPath}/bootstrap/css/bootstrap v3.3.5.min.css" type="text/css" />
<script src="${request.contextPath}/jquery/jQuery v1.11.3.min.js"></script>
<script src="${request.contextPath}/jquery/jqueryui/jquery-ui.js"></script>
<script src="${request.contextPath}/bootstrap/js/bootstrap v3.3.5.min.js"></script>
</head>

<script type="text/javascript">
//重新登录系统
function registerLogin(){
 top.location = "${request.contextPath}/userLogin";
}
//重新登录系统
function exitLogin(){
if(confirm('确定要退出系统？')){
window.close();
window.parent.close();
top.location = "${request.contextPath}/userLogin";
  }
}

</script>
<body>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Brand</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <li class="active"><a target="iframeMain"  href="${request.contextPath}/user/userManage">用户管理</a></li>
        <li><a target="iframeMain" href="${request.contextPath}/teacher/teacherManage">教师管理</a></li>
        <li><a target="iframeMain" href="${request.contextPath}/student/studentManage">学生管理</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">其他管理 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">其他功能</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">其他功能 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<!-- 工作区\\ -->
<div id="panel_main" class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" id="iframeMain" name="iframeMain" src="" frameborder="0" style=" height:100%; background:#fff"></iframe>
</div>
</body>
</html>
