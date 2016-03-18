<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>机型维护</title>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script src="${request.contextPath}/js/Calendar.js"></script>
	<script type="text/javascript">
		$(function() {
			//提交申请
			$(".button").click(function() {
				if($("#name").val() == ''){
					alert("请输入机型名称!");
					$("#name").focus();
					return;
				}else if($("#code").val() == ''){
					alert("请输入机型代码!");
					$("#code").focus();
					return;
				}else if($("#airplaneType").val() == ''){
					alert("请输入类型!");
					$("#airplaneType").focus();
					return;
				}else if($("#minSeats").val() == ''){
					alert("请输入最少座位数!");
					$("#minSeats").focus();
					return;
				}else if($("#minSeats").val() == 0){
					alert("最少座位数不能为0!");
					$("#minSeats").focus();
					return;
				}else if($("#maxSeats").val() == ''){
					alert("请输入最大座位数!");
					$("#maxSeats").focus();
					return;
				}else if($("#maxSeats").val() == 0){
					alert("最大座位数不能为0!");
					$("#maxSeats").focus();
					return;
				}else if(parseInt($("#maxSeats").val()) <= parseInt($("#minSeats").val())){
					alert("最大座位数必须多于最少座位数!");
					$("#maxSeats").focus();
					return;
				}
				$.ajax({
					url : "${request.contextPath}/maindata/airplane/saveOrUpdateAirPlane",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						airPlane : setAirPlaneForm()
					}),
					success : function(data) {
						alert(data.message);
						if(data.status == "SUCCESS"){
							opener.location.reload();
							window.close();
						}else{
							$("#code").focus();
						}
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据维护机型
			function setAirPlaneForm() {
				var airPlane = new Object;
				airPlane.id = $("#id").val();
				airPlane.name = $("#name").val();
				airPlane.code = $("#code").val();
				airPlane.airplaneType = $("#airplaneType").val();
				airPlane.minSeats = $("#minSeats").val();
				airPlane.maxSeats = $("#maxSeats").val();
				return airPlane;
			}
		})
	</script>
</head>
<body>
	<div class="content content1">
        <input type="hidden" name="search" value="false">
		<div class="infor1">
			<div class="product ms">
				<div class="main">
					<div class="title" style="text-align :center" ><h2>信息维护</h2></div>
					<div class="part" style="text-align :center">
						<input type="hidden" id="id" name="id" value="${(airPlaneForm.id)!''}" />
						<span>机型名称：</span><input type="text" id="name" name="name" value="${(airPlaneForm.name)!''}" maxlength="100"/>
						<span>机型代码：</span><input type="text" id="code" name="code" value="${(airPlaneForm.code)!''}" maxlength="10" style="IME-MODE: disabled;"/>
						<span>类型：</span><input type="text" id="airplaneType" name="airplaneType" value="${(airPlaneForm.airplaneType)!''}" maxlength="10"/>
					</div>
					<div class="part" style="text-align :center">
						<span>最少座位数：</span><input type="text" id="minSeats" name="minSeats" value="${(airPlaneForm.minSeats)!''}" maxlength="4" style="IME-MODE: disabled;" 
							onkeyup="value=value.replace(/[^\d]/g,'')" onafterpaste="value=value.replace(/[^\d]/g,'')"/>
						<span>最大座位数：</span><input type="text" id="maxSeats" name="maxSeats" value="${(airPlaneForm.maxSeats)!''}" maxlength="4" style="IME-MODE: disabled;" 
							onkeyup="value=value.replace(/[^\d]/g,'')" onafterpaste="value=value.replace(/[^\d]/g,'')"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</div>
			</div>
		</div>
		<div class="click">
			<a href="javascript:void();"><div class="button" id="queryBtn">提交</div></a>
		</div>
	</div>
</body>
</html>