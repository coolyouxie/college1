<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>政策不适用航班</title>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
	<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/common.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
	
	<script type="text/javascript">
		$(function() {
			// 全选
			$("#checkedAll").click(function() {
				// 如果当前点击的多选框被选中
				if ($(this).attr('checked')) {
					$('.check-sub').each(function(i, obj) {
						if (!$(obj).attr('disabled')) {
							$(obj).attr('checked', true);
						}
					});
				} else {
					$(".check-sub").attr('checked', false);
				}
			});
			
			// 选择子项点击事件
			$('.check-sub').click(function() {
				var flag = true;
				$('.check-sub').each(function(i, obj) {
					if(!$(this).attr('checked') && !$(this).attr("disabled")) {
						flag = false;
						return;
					}
				});
				if (flag) {
					$('#checkedAll').attr('checked', true);
				} else {
					$('#checkedAll').attr('checked', false);
				}
			});
			
			// 提交申请
			$(".button").click(function() {
				if ($(".button").css('cursor') == 'no-drop')
					return;
		
				var index = 0;
				$('.check-sub').each(function(i, obj) {
					if ($(this).attr('checked')) {
						index++;
						return;
					}
				});
				if (index == 0) {
					alert('请选择需要适用该政策的航班');
					return;
				}
				
				if (confirm('确认')) {
					// 锁住
					$(".button").css('cursor', 'no-drop');
					
					//var id = $('#excludeId').val();
					//var policyId = $(".policyId").html(); 
					
					$.ajax({
						url : "${request.contextPath}/order/deletePolicyExclude",
						dataType : "json",
						contentType : "application/json;",
						type : "POST",
						data : JSON.stringify({
							flightPolicyExcludeDtos : setFlightPolicyExcludeDtos()
						}),
						success : function(data) {
							if (data) {
								alert('政策适用成功');
								//刷新页面
								window.location.reload();
							} else {
							    alert('政策不能适用于航班');
							    window.location.reload();
							}
						}
					}); // ajax-end
				}
			});// .button-end
			
			
			//数据组装
			function setFlightPolicyExcludeDtos() {
				var arrays = new Array();
				var index = 0;
				$('#flightPolicyExcludeDtos tr').each(function() {
				
					var $TypeFake = $(this).find('td').eq(0).find('input').val();
					if (typeof ($TypeFake) == "undefined") {
						return true;
					}
					if ($(this).find('td').eq(0).find('input[type=checkbox]').attr("checked") == "checked") {
						arrays[index++] = setFlightPolicyExcludeDto($(this));
					}
				});
				return arrays;
			}
			
			
			// 组装数据请求退票信息
			function setFlightPolicyExcludeDto(obj) {
				// 设置订单明细对象
				var flightPolicyExcludeDto = new Object;
				flightPolicyExcludeDto.id = $(obj).find("[id='excludeId']").val(); 
				flightPolicyExcludeDto.policyId = $(".policyId").html(); 
				return flightPolicyExcludeDto;
			}
			
		})
	</script>

</head>
<body>
	<div class="content content4">
		<div class="flight-infor">
			<div class="title">政策不适用航班</div>
			<table id="flightPolicyExcludeDtos">
				<tr>
					<th><input type="checkbox" class="checkAll"  id="checkedAll"/></th>
					<th>政策ID</th>
					<th>航班号</th>
					<th>航班时间</th>
				</tr>
				<#list policyExcludes as policyExclude>
					<tr>
						<td><input type="checkbox" id="excludeId" name="${policyExclude_index}" class="check-sub" value="${policyExclude.id}" /></td>
						<td class="policyId">${(policyExclude.policyId)!''}</td>
						<td>${(policyExclude.flightNo)!''}</td>
						<td>${policyExclude.depDate?string("yyyy-MM-dd")}</td>
					</tr>
				</#list>
			</table>			
		</div>
		
		<div class="remark">
			<div class="click">
				<a href="javascript:;"><div class="button" id="button">确认</div></a> 
			</div>
			
		</div>
	</div>	
</body>
</html>
