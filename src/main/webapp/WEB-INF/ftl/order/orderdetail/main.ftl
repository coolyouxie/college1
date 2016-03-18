<!DOCTYPE html>
<html>
<head>
	<title>Document</title>
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
    <script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
    <script src="${request.contextPath}/js/ticketinfo/issue_ticketinfo_edit.js"> </script>
    <script src="${request.contextPath}/js/ticketinfo/ctmt_ticketinfo_edit.js"> </script>
    <script src="${request.contextPath}/js/order/orderDetailMain.js"> </script>
    <script src="${request.contextPath}/js/order/orderOpCommandBack.js"> </script>
    <script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>

</head>
<body>
	<div class="content content2">
  		 <input type="hidden" id="orderNo" value="${base.orderNo}"/> 
	    <input type="hidden" id="orderMainId" value="${base.orderMainId}"/>
		<input type="hidden" id="orderId" value="${base.orderId}"/>
		<input type="hidden" id="auditOpId" value="${base.auditOpId}"/>
        <input type="hidden" id="orderCustomerId" value="${(base.flightOrderCustomer.customerId)!''}"/>
        <input type="hidden" id="orderCustomerCode" value="${(base.flightOrderCustomer.customerCode)!''}"/>
        <input type="hidden" id="orderCustomerName" value="${(base.flightOrderCustomer.customerName)!''}"/>
        <input type="hidden" id="orderOpearName" value="admin"/>
		
		<div class="breadnav"><a href="javascript:;" target='_blank'>首页</a>： <span>订单管理</span> > 订单处理->${gmail}
		<#include "order/orderdetail/base.ftl">
		<#include "order/orderdetail/relation.ftl">
		<#include "order/orderdetail/info.ftl">
	</div>
</body>
</html>