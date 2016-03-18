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
					url : "addInsurance",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						insuranceInfoDto : setInsuranceInfoDto()
					}),
					success : function(data) {
						alert(data.message);
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据请求投保
			function setInsuranceInfoDto() {
			
				var insuranceInfoDto = new Object;
				var supp = new Object;
				supp.id = $('#suppName').val();
				insuranceInfoDto.supp = supp;
				var insuranceClass = new Object;
				insuranceClass.code = $('#insuranceName').val();
				insuranceClass.name = $('#insuranceName').find("option:selected").text();
				insuranceInfoDto.insuranceClass = insuranceClass;
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
						<span style="margin-left:10px;">供应商：</span><select name="suppName" id="suppName">
								<#list supps as supp>
									<option value="${(supp.id)!''}">${(supp.name)!''}</option>
								</#list>
							</select>
						<span style="margin-left:10px;">产品名称：</span><select name="insuranceName" id="insuranceName">
								<#list insuranceClasses as insuranceClass>
									<option value="${(insuranceClass.code)!''}">${(insuranceClass.name)!''}</option>
								</#list>
							</select>
						<span style="margin-left:10px;">销售价格：</span><input type="text" id="insurancePrice" name="insurancePrice"/>
						<span style="margin-left:10px;">最多销售份数：</span><input type="text" id="maxInsureNum" name="maxInsureNum"/>
					</div>
					
					<div class="part" style="text-align :center">
						<span>保险说明：</span><textarea id="insuranceDesc" name="insuranceDesc" style="width:702px" rows="6" ></textarea>
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