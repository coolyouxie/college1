<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>人工投保</title>
	<script type="text/javascript" src="http://s2.lvjs.com.cn/js/new_v/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/baoxian_common.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/baoxianstyle.css">
	<link rel="stylesheet" href="${request.contextPath}/css/jquery-ui.css">
	
	
	<script>
		$(function (){
			getInsurance();
	    }); 
	    
	    //日期格式化
	    function formatDate(date) {
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			var day=date.getDate();
			return year+"-"+(month<10?("0"+month):month)+"-"+(day<10?("0"+day):day); 
		}
	    
	
		//根据票号查询乘机人及航班信息
		function queryByTicketNo() {
		    $.ajax({
				url : 'queryFlightOrderTicket/'+$("#ticketNo").val()+'/'+$("#orderNo").val(),
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				success: function(data){
					if(data.status == false){
						alert("订单号或票号错误，请重新输入！");
				    }else{
				    
					    var birthday = formatDate(new Date(data.flightOrderTicketInfoDto.flightOrderPassenger.passengerBirthday));
				    
				    	//$("#orderNo").val(data.orderMainDto.flightOrderNo.orderNo);
					    $("#insuredName").val(data.flightOrderTicketInfoDto.flightOrderPassenger.passengerName);
					    $("#gender").val(data.genderType);
					    $("#idCardType").val(data.idCardType);
					    $("#idCardNo").val(data.flightOrderTicketInfoDto.flightOrderPassenger.passengerIDCardNo);
					   	$("#birthday").val(birthday);
					    $("#effectDate").val(data.effectTime);
					    $("#expireDate").val(data.expireTime);
					    
					    $("#passengerGender").val(data.flightOrderTicketInfoDto.flightOrderPassenger.gender);
					    $("#passengerIDCardType").val(data.flightOrderTicketInfoDto.flightOrderPassenger.passengerIDCardType);
					    $("#flightNo").val(data.flightOrderFlightInfo.flightNo);
					    $("#departureTime").val(data.flightOrderFlightInfo.timeSegmentRange.departureTime);
					    $("#arrivalTime").val(data.flightOrderFlightInfo.timeSegmentRange.arrivalTime);
					    $("#orderMainId").val(data.flightOrderTicketInfoDto.flightOrderPassenger.orderMainId);
					    $("#passengerId").val(data.flightOrderTicketInfoDto.flightOrderPassenger.id);
					    $("#cellphone").val(data.flightOrderTicketInfoDto.flightOrderPassenger.cellphone);
					    $("#flightInfoId").val(data.flightOrderFlightInfo.id);
				    }
	   			}
		    });
		 }
		
		$(function() {
			//提交申请
			$(".rg_submit").click(function() {
				$.ajax({
					url : "saveArtificialInsured",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						flightOrderInsuranceDto : setflightOrderInsuranceDto()
					}),
					success : function(data) {
						alert(data.message);
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据请求投保
			function setflightOrderInsuranceDto() {
				// 设置订单明细对象
				var flightOrderInsuranceDto = new Object;
				flightOrderInsuranceDto.insuranceOrderDto = setInsuranceOrderDto();
				
				var insuranceClass = new Object;
				//insuranceClass.code = $('#insuranceName').val();
				//insuranceClass.name = $('#insuranceName').find("option:selected").text();
				flightOrderInsuranceDto.insuranceClass = insuranceClass;
				flightOrderInsuranceDto.orderMainId = $("#orderMainId").val();
				flightOrderInsuranceDto.orderPassengerId = $("#passengerId").val();
				flightOrderInsuranceDto.insuranceInfoId = $('#insuranceName').val();
				flightOrderInsuranceDto.flightNo = $('#flightNo').val();
				
				var flightOrderFlightInfo = new Object;
				flightOrderFlightInfo.id = $('#flightInfoId').val();
				
				flightOrderInsuranceDto.flightOrderFlightInfo = flightOrderFlightInfo;
				return flightOrderInsuranceDto;
			}
			
			//组装数据请求投保
			function setInsuranceOrderDto() {
				// 设置订单明细对象
			    var insuranceOrderDto = new Object;
			    var insuranceInfoDto = new Object;
				//var supp = new Object;
				//supp.name = $('#insuranceName').find("option:selected").text();
				//supp.id = $('#suppName').val();
				//var insuranceClass = new Object;
				//insuranceClass.code = $('#insuranceName').val();
				//insuranceClass.name = $('#insuranceName').find("option:selected").text();
				//insuranceInfoDto.supp = supp;
				insuranceInfoDto.id = $('#insuranceName').val();
				//insuranceInfoDto.insuranceClass = insuranceClass;
				insuranceOrderDto.insuranceInfoDto = insuranceInfoDto;
				
				insuranceOrderDto.orderNo = $('#orderNo').val();
				insuranceOrderDto.ticketNo = $('#ticketNo').val();
				insuranceOrderDto.flightNo = $('#flightNo').val();
				insuranceOrderDto.effectDate = $("#departureTime").val();
				insuranceOrderDto.expireDate = $("#arrivalTime").val();
				insuranceOrderDto.insuredName = $('#insuredName').val();
				insuranceOrderDto.gender = $("#passengerGender").val();
				insuranceOrderDto.idCardType = $("#passengerIDCardType").val();
				insuranceOrderDto.idCardNo = $('#idCardNo').val();
				insuranceOrderDto.birthday = $('#birthday').val();
				insuranceOrderDto.email = $('#email').val();
				insuranceOrderDto.cellphone = $('#cellphone').val();
		
				return insuranceOrderDto;
			}
			
			
		})
		
		//根据supp查询保险产品
		function getInsurance() {
			var str="";
		    $.ajax({
				url : 'getInsuranceBySupp/'+$("#suppName").val(),
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				success: function(data){
					$("#insuranceName option").remove();
					jQuery.each(data, function(i,item){    
						str+="<option value='"+item.id+"'>"+item.insuranceClass.name+"</option>"; 
			        }); 
			        
					$("#insuranceName").append(str);
				}	
		    });
		 }
		 
		//返回
		function back() {
		   	window.location.href = "${request.contextPath}/insurance/toArtificialInsuredPage";
		}
		
	</script>
	
</head>
<body>
	<div class="rengongtb">
		<!--<form>-->
			<div class="rg_border">
				<div class="title">基本信息</div>
				
				<input type="hidden" name="flightInfoId" id="flightInfoId"/>
				<div class="content">
					<div class="width">供应商：
						<select class="gongyingshang" name="suppName" id="suppName" onblur="getInsurance()">
							<#list supps as supp>
								<option value="${(supp.id)!''}">${(supp.name)!''}</option>
							</#list>
						</select>
					</div>
					<div class="width">产品名称：
						<select name="insuranceName" id="insuranceName">
							<#list insuranceInfos as insurance>
							
							</#list>
						</select>
					</div>
				</div>
			</div>
			<div class="rg_border">
				<div class="title">基本信息</div>
				<div class="content">
					<div class="width">订单号：
						<input type="text" id="orderNo" name="orderNo" onblur="queryByTicketNo()"/>
						<input type="hidden" id="orderMainId" name="orderMainId"/>
					</div>
					<div class="width">票号：<input type="text" id="ticketNo" name="ticketNo" onblur="queryByTicketNo()"></div>
				</div>
			</div>
			
			<input type="hidden" name="flightNo" id="flightNo"/>
			<div class="rg_border">
				<div class="title rg_bold">有效日期</div>
				<div class="content">
					<div class="width">生效时间：
						<input type="hidden" name="departureTime" id="departureTime"/>
						<input type="text" name="effectDate" id="effectDate"/>
					</div> 
					<div class="width">结束时间：
						<input type="hidden" name="arrivalTime" id="arrivalTime"/>
						<input type="text" name="expireDate" id="expireDate"/>
					</div>
				</div>
			</div>
			
			<div class="rg_border rg_height">
				<div class="title rg_bold">投/被保人信息</div>
				<div class="content">
					<input type="hidden" name="passengerId" id="passengerId"/>
					<div class="width">姓名：<input type="text" id="insuredName" name="insuredName"></div>
					<input type="hidden" name="passengerGender" id="passengerGender"/>
					<div class="width">性别：<input type="text" id="gender" name="gender"></div>
					<input type="hidden" name="passengerIDCardType" id="passengerIDCardType"/>
					<div class="width">证件类型：<input type="text" id="idCardType" name="idCardType"></div>
					<div class="width">证件号码：<input type="text" id="idCardNo" name="idCardNo"></div>
					<div class="width">出生日期：<input type="text" id="birthday" name="birthday"></div>
					<div class="width">联系人手机：<input type="text" id="cellphone" name="cellphone"></div>
					<div class="width">邮箱：<input type="text" id="email" name="email"></div>
				</div>
			</div>
			<div class="rg_button">
				<a href="javascript:;"><div class="rg_back" id="button" onclick="back()">返回</div></a>
				<a href="javascript:;"><div class="rg_submit" id="button">提交</div></a> 
			</div>
		<!--</form>-->
		<div id="datepicker-4"></div>
		<div id="datepicker-5"></div>
	</div>
</body>
</html>