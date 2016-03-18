<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>导入excel数据</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<script type="text/javascript">
	function importExcelData(){
		var path = document.getElementById("selectFileBtn").value;
		if(path){
			document.getElementById("file").submit();
		}else{
			alert("请选择文件");
			return;
		}
	}
</script>
</head>
<body>
	<form id="file" action="/importFile.do" method="POST" enctype="multipart/form-data">
		<div>
			<input type="file" name="uploadFile" id="selectFileBtn"/>
			<input type="button" onclick="importExcelData()" value="导入数据"/>
		</div>
	</form>
</body>
</html>