<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>航空公司新增</title>
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
				if($("#fullName").val() == ''){
					alert("请输入航空公司!");
					$("#fullName").focus();
					return;
				}else if($("#name").val() == ''){
					alert("请输入简称!");
					$("#name").focus();
					return;
				}else if($("#code").val() == ''){
					alert("请输入二字代码!");
					$("#code").focus();
					return;
				}
				$.ajax({
					url : "${request.contextPath}/maindata/carrier/addCarrier",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						carrier : setCarrierForm()
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
			
			//组装数据新增航空公司
			function setCarrierForm() {
				var carrier = new Object;
				carrier.fullName = $("#fullName").val();
				carrier.name = $("#name").val();
				carrier.code = $("#code").val();
				carrier.website = $("#website").val();
				carrier.hotline = $("#hotline").val();
				carrier.remark = $("#remark").val();
				return carrier;
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
						<span>航空公司：</span><input type="text" id="fullName" name="fullName" maxlength="50"/>
						<span>简称：</span><input type="text" id="name" name="name" maxlength="50"/>
						<span>二字代码：</span><input type="text" id="code" name="code" maxlength="2" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
					</div>
					<div class="part" style="text-align :center">
						<span>官网地址：</span><input type="text" id="website" name="website" maxlength="50"/>
						<span>客服电话：</span><input type="text" id="hotline" name="hotline" maxlength="50"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="part" style="text-align :center">
						<span style="vertical-align:top">备注说明：</span><textarea id="remark" name="remark" style="resize: none;width: 560px;height: 100px;"  
							onpropertychange="if(value.length>250) value=value.substr(0,250)" oninput="if(value.length>250) value=value.substr(0,250)"></textarea>
					</div>
					<!--
					<div class="part" style="text-align :center">
						<span>上传图标：</span><input type="file" id="icon" name="icon"/>
						<a href="javascript:;"><div class="button" onclick="">浏览</div></a>
					</div>
					-->
				</div>
			</div>
		</div>
		<div class="click">
			<a href="javascript:void();"><div class="button" id="queryBtn">提交</div></a>
		</div>
	</div>
</body>
</html>