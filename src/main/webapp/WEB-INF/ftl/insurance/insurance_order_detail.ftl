<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>保单详情</title>
	<link rel="stylesheet" href="${request.contextPath}/css/baoxianstyle.css">
</head>


<body>
<div class="baodan_detail">
		<div class="dingdan_detail">
			<div class="title">订单信息：</div>
			<div class="col_1">
				<div><span class="keyname">订单号：</span>
					<span class="valname">${(insuranceOrderDetail.orderNo)!''}</span></div>
				<div><span class="keyname">产品名称：</span>
					<span class="valname">${(insuranceOrderDetail.insuranceInfoDto.insuranceClass.name)!''}</span>
				</div>
				<div>
					<span class="keyname">投保时间：</span>
					<span class="valname">${insuranceOrderDetail.insureDate?string("yyyy-MM-dd")}</span>
				</div>
				<div>
					<span class="keyname">投保状态：</span>
					<span class="valname">${(insuranceOrderDetail.insuranceStatus.cnName)!''}</span>
				</div>
			</div>
			<div class="col_1">
				<div>
					<span class="keyname">票号：</span>
					<span class="valname">${(insuranceOrderDetail.ticketNo)!''}</span>
				</div>
				<div>
					<span class="keyname">供应商：</span>
					<span class="valname">${(insuranceOrderDetail.insuranceInfoDto.supp.name)!''}</span>
				</div>
				<div>
					<span class="keyname">生效时间：</span>
					<span class="valname">${insuranceOrderDetail.effectDate?string("yyyy-MM-dd")}</span>
				</div>
			</div>
			<div class="col_1">
				<div>
					<span class="keyname">保单号：</span>
					<span class="valname">${(insuranceOrderDetail.insuranceNo)!''}</span>
				</div>
				<div>
					<span class="keyname">保单价格：</span>
					<span class="valname">${(insuranceOrderDetail.insuranceInfoDto.insurancePrice)!''}<span>
				</div>
				<div>
					<span class="keyname">结束时间：</span>
					<span class="valname">${insuranceOrderDetail.expireDate?string("yyyy-MM-dd")}</span>
				</div>
			</div>
		</div>
		<div class="toubao_detail">
			<div class="title">投保人信息：</div>
			<div class="col_1">
				<div>
					<span class="keyname">投/被保人姓名：</span>
					<span class="valname">${(insuranceOrderDetail.insuredName)!''}</span>
				</div>
				<div>
					<span class="keyname">证件号码：</span>
					<span class="valname">${(insuranceOrderDetail.idCardNo)!''}</span>
				</div>
				<div>
					<span class="keyname">出生日期：</span>
					<span class="valname">${insuranceOrderDetail.birthday?string("yyyy-MM-dd")}</span>
				</div>
			</div>
			<div class="col_1">
				<div>
					<span class="keyname">证件类型：</span>
					<span class="valname">${(insuranceOrderDetail.idCardType)!''}</span>
				</div>
				<div>
					<span class="keyname">性别：</span>
					<span class="valname">${(insuranceOrderDetail.gender.cnName)!''}</span>
				</div>
			</div>
			<div class="col_1">
				<div>
					<span class="keyname">邮箱：</span>
					<span class="valname">${(insuranceOrderDetail.email)!''}</span>
				</div>
			</div>
		</div>
		<div class="close" onclick="window.close();">关闭</div>
	</div>
      
</body>
</html>