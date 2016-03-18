<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	</head>
	<body>
	    <div class="title">
			<p>备注信息:</p>
		</div>
		<div class="module3">
			<div class="kpinfor lot">
				<table style="line-height:25px" width="100%">
					<tr>
						<th width="25%">备注类型</th>
						<th width="35%">内容</th>
						<th width="40%">创建时间</th>
					</tr>
					<#if orderRemarkLastResult?? && orderRemarkLastResult.results??>
						<#list orderRemarkLastResult.results as orderRemarkLast>
							<tr>
							    <td>${(orderRemarkLast.remarkType)!''}</td>
								<td>${(orderRemarkLast.remark)!''}</td>
								<td>${orderRemarkLast.createTime?string("yyyy-MM-dd HH:mm:ss")}</td>
							</tr>
						</#list>
					</#if>
				</table>
		 	</div>
		</div>
	</body>
</html>