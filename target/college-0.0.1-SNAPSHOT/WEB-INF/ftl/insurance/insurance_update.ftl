<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>保险产品维护</title>
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
				$.ajax({
					url : "${request.contextPath}/insurance/saveInsuranceInfo",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						insuranceInfoDto : setInsuranceInfoDto()
					}),
					success : function(data) {
						alert(data.message);
						window.close();
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据请求投保
			function setInsuranceInfoDto() {
			
				var insuranceInfoDto = new Object;
				insuranceInfoDto.id = $("#id").val();
				insuranceInfoDto.insurancePrice = $("#insurancePrice").val();
				insuranceInfoDto.maxInsureNum = $("#maxInsureNum").val();
				insuranceInfoDto.insuranceDesc = $("#insuranceDesc").val();
				return insuranceInfoDto;
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
					<div class="title" style="text-align :center" ><h2>产品维护</h2></div>
					<div class="part" style="text-align :center">
						<input type="hidden" id="id" name="id" value="${(insuranceInfo.id)!''}" />
						<span style="color:#FF3030;margin-left:10px;">供应商：</span><span style="margin-left:10px;">${(insuranceInfo.supp.name)!''}</span>
						<span style="color:#FF3030;margin-left:10px;">产品名称：</span><span style="margin-left:10px;">${(insuranceInfo.insuranceClass.name)!''}</span>
						<span style="color:#FF3030;margin-left:10px;">销售价格：</span><input type="text" id="insurancePrice" name="insurancePrice" value="${(insuranceInfo.insurancePrice)!''}" />
						<span style="color:#FF3030;margin-left:10px;">最多销售份数：</span><input type="text" id="maxInsureNum" name="maxInsureNum" value="${(insuranceInfo.maxInsureNum)!''}" />
					</div>
					
					<div class="part" style="text-align :center">
						<span style="color:#FF3030;margin-right:10px;">保险说明：</span><textarea id="insuranceDesc" name="insuranceDesc" style="width:660px" rows="10">${(insuranceInfo.insuranceDesc)!''}</textarea>
					</div>
					
				</div>
			</div>
			
			
		</div>
		<div class="click">
			<a href="javascript:void();"><div class="button" id="queryBtn">保存</div></a>
		</div>
	</div>


</body>
</html>