<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>机场城市维护</title>
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
					alert("请输入机场名称!");
					$("#fullName").focus();
					return;
				}else if($("#name").val() == ''){
					alert("请输入机场简称!");
					$("#name").focus();
					return;
				}else if($("#code").val() == ''){
					alert("请输入机场代码!");
					$("#code").focus();
					return;
				}else if($("#cityName").val() == ''){
					alert("请输入机场城市!");
					$("#cityName").focus();
					return;
				}else if($("#cityCode").val() == ''){
					alert("请输入城市三字代码!");
					$("#cityCode").focus();
					return;
				}else if($("#pinYin").val() == ''){
					alert("请输入城市全拼!");
					$("#pinYin").focus();
					return;
				}else if($("#jianPin").val() == ''){
					alert("请输入城市简拼!");
					$("#jianPin").focus();
					return;
				}
				$.ajax({
					url : "${request.contextPath}/maindata/airport/addAirport",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						airport : setAirportForm()
					}),
					success : function(data) {
						alert(data.message);
						if(data.status == "SUCCESS"){
							opener.location.reload();
							window.close();
						}
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据维护机场城市
			function setAirportForm() {
				var airport = new Object;
				var city = new Object;
				city.id = $("#cityId").val();
				city.name = $("#cityName").val();
				city.code = $("#cityCode").val();
				city.cityCode = $("#cityCode").val();
				city.pinYin = $("#pinYin").val();
				city.jianPin = $("#jianPin").val();
				city.hot = $("#hot").val();
				airport.id = $("#id").val();
				airport.city = city;
				airport.fullName = $("#fullName").val();
				airport.name = $("#name").val();
				airport.code = $("#code").val();
				return airport;
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
						<input type="hidden" id="id" name="id" value="${(airportResult.id)!''}" />
						<span>机场名称：</span><input type="text" id="fullName" name="fullName" value="${(airportResult.fullName)!''}" maxlength="50"/>
						<span>简称：</span><input type="text" id="name" name="name" value="${(airportResult.name)!''}" maxlength="50"/>
						<span>机场三字代码：</span><input type="text" id="code" name="code" value="${(airportResult.code)!''}" maxlength="3" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
					</div>
					<div class="part" style="text-align :center">
						<input type="hidden" id="cityId" name="cityId" value="${(airportResult.city.id)!''}" />
						<span>机场城市：</span><input type="text" id="cityName" name="cityName" value="${(airportResult.city.name)!''}" maxlength="50"/>
						<span>城市三字代码：</span><input type="text" id="cityCode" name="cityCode" value="${(airportResult.city.cityCode)!''}" maxlength="3" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="part" style="text-align :center">
						<span>城市全拼：</span><input type="text" id="pinYin" name="pinYin" value="${(airportResult.city.pinYin)!''}" maxlength="50" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
						<span>城市简拼：</span><input type="text" id="jianPin" name="jianPin" value="${(airportResult.city.jianPin)!''}" maxlength="10" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
						<span>城市热度：</span><input type="text" id="hot" name="hot" value="${(airportResult.city.hot)!''}" maxlength="3" style="IME-MODE: disabled;" 
							onkeyup="value=value.replace(/[^\d]/g,'')" onafterpaste="value=value.replace(/[^\d]/g,'')"/>
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