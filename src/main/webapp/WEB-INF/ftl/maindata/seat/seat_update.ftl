<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>舱位维护</title>
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
				if($("#code").val() == ''){
					alert("请输入舱位代码!");
					$("#code").focus();
					return;
				}else if($("#discount").val() == ''){
					alert("请输入舱位折扣!");
					$("#discount").focus();
					return;
				}
				$.ajax({
					url : "${request.contextPath}/maindata/seat/saveOrUpdateSeat",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						seatClassCarrier : setSeatForm()
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
			
			//组装数据维护舱位
			function setSeatForm() {
				var seatClassCarrier = new Object;
				var flightTicketPriceDto = new Object;
				flightTicketPriceDto.discount = $("#discount").val();
				seatClassCarrier.flightTicketPriceDto = flightTicketPriceDto;
				seatClassCarrier.id = $("#id").val();
				seatClassCarrier.name = $("#name").val();
				seatClassCarrier.code = $("#code").val();
				seatClassCarrier.carrierCode = $("#carrierCode").val();
				seatClassCarrier.seatClassType = $("#seatClassType").val();
				seatClassCarrier.ticketRule = $("#ticketRule").val();
				seatClassCarrier.seatRemark = $("#seatRemark").val();
				return seatClassCarrier;
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
						<input type="hidden" id="id" name="id" value="${(seatForm.id)!''}" />
						<span>航空公司：</span>
						<select name="carrierCode" id="carrierCode" style="width:90px">
							<#list carriers as carrier>
								<option value="${(carrier.code)!''}" <#if carrier.code == seatForm.carrierCode>selected </#if>>${(carrier.code)!''}</option>
							</#list>
						</select>
						<span>舱位代码：</span><input type="text" id="code" name="code" value="${(seatForm.code)!''}" maxlength="2" style="IME-MODE: disabled;" 
							onkeyup="value=value.trim().toUpperCase()" onafterpaste="value=value.trim().toUpperCase()"/>
						<span>舱位折扣：</span><input type="text" id="discount" name="discount" value="${(seatForm.flightTicketPriceDto.discount*100)!''}" maxlength="3" style="IME-MODE: disabled;" 
							onkeyup="value=value.replace(/[^\d]/g,'')" onafterpaste="value=value.replace(/[^\d]/g,'')"/>%
					</div>
					<div class="part" style="text-align :center">
						<span>舱位等级：</span>
						<select id="seatClassType" name="seatClassType" style="width:90px">
							<#list seatClassTypeEnum as val>  
								<option value="${(val)!''}" <#if val == seatForm.seatClassType>selected </#if>>${val.cnName}</option>
							</#list>
						</select>
						<span>舱位说明：</span><input type="text" id="name" name="name" value="${(seatForm.name)!''}" maxlength="50"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="part" style="text-align :center">
						<span style="vertical-align:top">退改签说明：</span><textarea id="ticketRule" name="ticketRule" style="resize: none;width: 500px;height: 100px;"  
							onpropertychange="if(value.length>1000) value=value.substr(0,1000)" oninput="if(value.length>1000) value=value.substr(0,1000)">${(seatForm.ticketRule)!''}</textarea>
						&nbsp;&nbsp;&nbsp;
					</div>
					<div class="part" style="text-align :center">
						<span style="vertical-align:top">备注说明：</span><textarea id="seatRemark" name="seatRemark" style="resize: none;width: 500px;height: 100px;"  
							onpropertychange="if(value.length>1000) value=value.substr(0,1000)" oninput="if(value.length>1000) value=value.substr(0,1000)">${(seatForm.seatRemark)!''}</textarea>
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