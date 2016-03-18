<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>馿妈妈机票后台管理系统</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
</head>
<body>
	>首页>填写订单（会员：jacuqeline）
	<table>
		<th>${resultDto.routeType.cnName}&nbsp;&nbsp;${resultDto.deptCity}-${resultDto.arrvCity}</th>
		<#list resultDto.flightSegInfos?sort_by('segNo') as seg>
		<tr>
			<td><#if (resultDto.flightSegInfos?size > 1) && (seg.segNo == 1)>
				去程
				<#elseif (resultDto.flightSegInfos?size > 1) && (seg.segNo == 2)>
				 返程
				 </#if>
				${seg.carrierNameCn}${seg.flightNoAll}&nbsp;&nbsp;${seg.deptTime}
				<#if seg.stopCount == 1>
					 — 经停 —
				<#else>
					—
				</#if>${seg.arrvTime}${seg.crossDayInfo}&nbsp;&nbsp;${seg.cabinName}&nbsp;&nbsp;${seg.cabinCode}
				<#list seg.airportFees?keys as k> 
					<#assign item = seg.airportFees[k]>
					<#assign aa = 'ADULT'>
					${k}---${k.getName()}
					机建：${seg.airportFees['ADULT']}
				</#list>
				dsss${amap['ADULT']}ttt
				<#list seg.airportFees?keys as testKey>
				     ${testKey}== ${seg.airportFees[testKey].intValue()}
				</#list>
				---${amap['ADULT'].name()}
			</td>
		</tr>
		</#list>
	</table>
</body>
</html>