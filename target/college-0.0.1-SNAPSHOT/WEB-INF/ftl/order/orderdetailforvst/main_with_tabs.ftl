<!DOCTYPE html>
<html>
<head>
	<title>Document</title>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css">
   <script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
    <script type="text/javascript">
		function getOrderDetailAjax(orderMainId,orderId){
	   		//alert(orderMainId+","+orderId);
	   		$.ajax({
				url : '${request.contextPath}/order/getOrderDetailAjax',
				cache : false,
				async : false,
				data : {
					"orderId":orderId,
					"orderMainId":orderMainId
					},
				type : "POST",
				datatype : "json",
				success: function(data){
					fillData(data);
	   			}
		    });
	   }
	   
		//外部订单绑定机票主订单，通过主订单号
		function bindSalesOrder(){
		   		var orderMainNo = $("#orderMainNo").val();
		   		var salesMainOrderId = $("#salesMainOrderId").val();
				var salesOrderId = $("#salesOrderId").val();
				if(orderMainNo){
					$.ajax({
						type:"POST",
						url:'${request.contextPath}/order/bindingSalesOrder',
						datatype : "json",
						contentType:"application/json;",
						data:JSON.stringify({
						 lvfMainOrderNo:orderMainNo,
						 salesMainOrderId:salesMainOrderId,
						 salesOrderId:salesOrderId
						}),
						success:function(data){
							
							if(data.message){
								alert(data.message);
								window.location.href="${request.contextPath}/order/queryOrderDetailByVstOrderId/"+salesMainOrderId+"/"+salesOrderId;
							}else{
								alert("绑定成功");
								window.location.href="${request.contextPath}/order/queryOrderDetailByVstOrderId/"+salesMainOrderId+"/"+salesOrderId;
							}
							
						}
					});
				}else{
					alert("请输入订单号");
					return ;
				}
			}
	    
	    //外部订单解绑机票订单，通过机票主订单号
	    function unbindSalesOrder(){
			var orderMainNo = $("#orderMainNo").val();
			var salesMainOrderId = $("#salesMainOrderId").val();
			var salesOrderId = $("#salesOrderId").val();
			if(orderMainNo){
				$.ajax({
					type:"POST",
					url:'${request.contextPath}/order/unbindingSalesOrder',
					datatype : "json",
					contentType:"application/json;",
					data:JSON.stringify({
						 lvfMainOrderNo:orderMainNo,
						 salesMainOrderId:salesMainOrderId,
						 salesOrderId:salesOrderId
						}),
					success:function(data){
						if(data.message){
								alert(data.message);
								window.location.href="${request.contextPath}/order/queryOrderDetailByVstOrderId/"+salesMainOrderId+"/"+salesOrderId;
							}else{
								alert("解绑成功");
								window.location.href="${request.contextPath}/order/queryOrderDetailByVstOrderId/"+salesMainOrderId+"/"+salesOrderId;
							}
					}
				});
			}else{
				alert("请输入订单号");
				return ;
			}
		}
		
		function refreshOrderDetailViewIframe(orderMainId,orderId){
			var salesMainOrderId = $("#salesMainOrderId").val();
			var salesOrderId = $("#salesOrderId").val();
			window.location.href="${request.contextPath}/order/queryOrderDetailByVstOrderId/"+salesMainOrderId+"/"+salesOrderId+"/"+orderMainId+"/"+orderId;
		}
    </script>
    <style>
    	.head_container{
    		margin-top:5px;
    		height:30px;
    	}
    	.left_container{
    		float:left;
    	}
    	.right_container{
    		float:right;
    		width:400px;
    	}
    	.tab_button{
    		background-color: #999;
    		color: #fff;
    		height: 25px;
    		line-height: 25px;
    		margin-right: 10px;
    		margin-bottom:10px;
    		text-align: center;
    		width: 150px;
    		float:left;
    	}
    	.click_button{
    		background-color: #f2f2f2;
    		border: 1px solid #ccc;
    		color: #666;
    		float: right;
    		height: 25px;
    		line-height: 25px;
    		margin-bottom: 10px;
    		margin-right: 3%;
    		text-align: center;
    		width: 80px;
    	}
    </style>
</head>
<body>
<div class="head_container">
	<div class="left_container">
		<#list orderMains as orderMainDto>
			<#if orderMainDto?exists>
				<#if orderMainDto.flightOrders?exists>
					<#list orderMainDto.flightOrders as flightOrder>
						<a href="javascript:void(0);" onclick="refreshOrderDetailViewIframe(${orderMainDto.id},${flightOrder.id})"><div class="tab_button">${flightOrder.flightOrderNo.orderNo}</div></a>
					</#list>
				</#if>
			</#if>
		</#list>
	</div>
	<div class="right_container">
		 机票订单：<input type="text" id="orderMainNo" value="" />
		<input type="hidden" id="salesMainOrderId" value="${vstMainOrderId}"/>
		<input type="hidden" id="salesOrderId" value="${vstFlightOrderId}"/>
		<a href="javascript:void(0);" onclick="bindSalesOrder()"> <div class="click_button">绑定</div> </a>
		<a href="javascript:void(0);" onclick="unbindSalesOrder()"> <div class="click_button">解绑</div> </a>
	</div>
</div>
<br/>
	
	
	<#include "order/orderdetail/main.ftl">
	
	
</body>
</html>