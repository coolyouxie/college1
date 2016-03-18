
$(function(){
	$("#opPass").click(function(){
		var orderId=$("#orderId").val();
		 $.ajax({
			url : "/ticketVTRT/opPass",
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				orderId :parseInt(orderId) ,
				flightOrderDetails : getFlightOrderDetails(orderId)
			}),
			type : "POST",
			success : function(data) {
			
				if(data.status=='SUCCESS'){
					alert("成功!");
				}else{
					alert("失败!");
				}
			}
		}); //ajax-end
	});//.button-end
	$("#opReject").click(function(){
		var orderId=$("#orderId").val();
		$.ajax({
			url : "/ticketVTRT/opReject",
			dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				orderId :parseInt(orderId) ,
				flightOrderDetails : getFlightOrderDetails(orderId)
			}),
			type : "POST",
			success : function(data) {
				
				if(data.status=='SUCCESS'){
					alert("成功!");
				}else{
					alert("失败!");
				}
			}
		}); //ajax-end
	});//.button-end
	
	
	 function getFlightOrderDetails(orderId){
		 var arrays = new Array();
		 var index = 0;
 	    $('#orderDetails tr').each(function(){
			var $TypeFake = $(this).find('td').eq(0).find('input').val();
		    	if(typeof($TypeFake) == "undefined"){
		    		 return true;
		    	}
		     	var detailId= $(this).find('input').val();
		    	var parPrice = $(this).find('td').eq(0).find('input').val();//票面价
		    	var discountAmount = $(this).find('td').eq(1).find('input').val();//优惠金额
		    	var fee = $(this).find('td').eq(2).find('input').val();//手续费
		    	var surcharge = $(this).find('td').eq(3).find('input').val();//服务费
		    	var supplierRefundAmount = $(this).find('td').eq(4).find('input').val();//供应商退款
		    	var supplierActualRefundAmount = $(this).find('td').eq(5).find('input').val();//供应商退款
		    	alert(detailId +"-"+parPrice+"-"+discountAmount+"-"+fee+"-"+surcharge+"-"+supplierRefundAmount+"-"+supplierActualRefundAmount);
		 	    arrays[index++] = getRtvtParam(parseInt(detailId),parseInt(orderId),parPrice,discountAmount,fee,surcharge,supplierRefundAmount,supplierActualRefundAmount);
		});
		return arrays;	
	}
	  
		function getRtvtParam(detailId,orderId,parPrice,discountAmount,fee,surcharge,supplierRefundAmount,supplierActualRefundAmount){
			var detail = new Object;
 	    	detail.id = detailId;
 	    	detail.orderId=orderId;
 	    	detail.flightOrderDetailRTVTs=initRTVTs(parPrice,discountAmount,fee,surcharge,supplierRefundAmount,supplierActualRefundAmount);
 	    	return detail
			
		}
		function initRTVTs(parPrice,discountAmount,fee,surcharge,supplierRefundAmount,supplierActualRefundAmount){
			 var arrays = new Array();
				var vtrtRequest = new Object;
				vtrtRequest.parPrice=parPrice;
				vtrtRequest.discountAmount=discountAmount;
				vtrtRequest.fee=fee;
				vtrtRequest.surcharge=surcharge;
				vtrtRequest.supplierRefundAmount=supplierRefundAmount;
				vtrtRequest.supplierActualRefundAmount=supplierActualRefundAmount;
				arrays[0]=vtrtRequest;
				return arrays;	
		}
	
})