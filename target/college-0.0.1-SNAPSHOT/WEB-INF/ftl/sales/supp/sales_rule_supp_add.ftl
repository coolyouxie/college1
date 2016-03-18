<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>添加虚拟调控规则</title>
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css" />
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	 $(function(){
		getSeatClasses();
	}); 
		
		//根据carrierCode查询舱位
		function getSeatClasses() {
		    var carrierCodes=$("#carrierCodes").find("option:selected").val();
			$("#seatCodeList").html("");
			var str="<span>适用舱位：</span><input type='checkbox' class='choose' tempName='seatCode' onclick='opeateClick(\"seatCode\",this.value)' id='seatCode0' name='seatCode0' value='ALL' checked='checked' >全部 </input>";
			if(carrierCodes!= ""){
			    $.ajax({
					url : "${request.contextPath}/maindata/seat/getSeatsByCarrierCode/"+carrierCodes,
					type:'post',
			        dataType : "json",
					contentType : "application/json;",
					success: function(data){
						jQuery.each(data, function(i,item){  
						    var index=parseInt(i)+1;
							str+="<input type='checkbox' class='choose' tempName='seatCode' onclick='opeateClick(\"seatCode\",this.value)' id='seatCode"+index+"' name='seatCode"+index+"' value='"+item.code+"' />"+item.code; 	  
				        }); 
				        $("#seatCodeList").html(str);
					}	
			    });	
		    }
		 } 
		 
	 //添加虚拟调控规则信息
   function addSalesRuleSupp(){
     $.ajax({
			url : "${request.contextPath}/sales/saveSalesRuleSupp",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				salesRuleSuppRequest:getAddParams()
				}),
			success: function(data){
			    alert(data.message);
				location.href ="${request.contextPath}/sales/toSalesRuleSupp";
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	  }	 
   
		 //组装保存虚拟调控规则信息
		 function getAddParams() {
		        var suppCodeStr="";
        		$("input[tempName='suppCode']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		suppCodeStr += $(this).val()+"/"
            		}
        		});
        		suppCodeStr=suppCodeStr.substring(0,suppCodeStr.length-1); 
        		
        		var seatCodeStr="";
        		$("input[tempName='seatCode']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		seatCodeStr += $(this).val()+"/";
            		}
        		});
        		seatCodeStr=seatCodeStr.substring(0,seatCodeStr.length-1); 
        		
        		var weekDayStr="";
        		$("input[tempName='weekDay']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		weekDayStr += $(this).val()+"/";
            		}
        		});
        		weekDayStr=weekDayStr.substring(0,weekDayStr.length-1); 
			  
             var salesRuleSuppRequest = new Object;
        	 salesRuleSuppRequest.departureStartTime=$.trim($('#departureStartTime').val());
        	 salesRuleSuppRequest.departureEndTime=$.trim($('#departureEndTime').val());
        	 salesRuleSuppRequest.updateStartTime=$.trim($('#updateStartTime').val());
        	 salesRuleSuppRequest.updateEndTime=$.trim($('#updateEndTime').val());	
			
			 var salesRuleSuppDto = new Object;
			 salesRuleSuppDto.suppCodes=suppCodeStr;
			 salesRuleSuppDto.departureAirportCodes=$("#departureAirportCodes").find("option:selected").val();
			 salesRuleSuppDto.arrivalAirportCodes=$("#arrivalAirportCodes").find("option:selected").val();
			 salesRuleSuppDto.carrierCodes=$("#carrierCodes").find("option:selected").val();
			 salesRuleSuppDto.seatCodes=seatCodeStr;
			 salesRuleSuppDto.includeFlightNos=$.trim($("#includeFlightNos").val());
			 salesRuleSuppDto.excludeFlightNos=$.trim($("#excludeFlightNos").val());
			 salesRuleSuppDto.weekDays=weekDayStr;
			 salesRuleSuppDto.priority=$("#priority").find("option:selected").val();
			 salesRuleSuppDto.status=$("#status").find("option:selected").val();
			 var priceFormula = new Object;
			 priceFormula.scale=$.trim($('#priceFormulaScale').val());
			 priceFormula.fixed=$.trim($('#priceFormulaFixed').val());
			 salesRuleSuppDto.priceFormula=priceFormula;
			 
			 salesRuleSuppRequest.salesRuleSuppDto=salesRuleSuppDto;
			 
			 return salesRuleSuppRequest;
		}

	//返回
	function returnSalesRuleSuppList() {
	   	location.href ="${request.contextPath}/sales/toSalesRuleSupp";
	}
	
	//判断如果选择全部，则取消其他选择
	function opeateClick(opeateName,opeateVal){
	     if(opeateVal!="" &&　opeateVal=="ALL"){
		     $("input[tempName='"+opeateName+"']:checkbox").each(function(id) {
		         var index=parseInt(id)+1;
				$("#"+opeateName+index).attr("checked",false);
			});
	     }else{
             $("#"+opeateName+"0").attr("checked",false);;
	     }
	}
			 
</script>
</head>

<body>
	<div class="content content1">
	    <div class="title" style="text-align :center" ><h3>添加虚拟调控规则</h3></div>
	    <form id="myForm">
	    	<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part part1">
							<span>供应商：</span>
							<input type="checkbox" class="choose" tempName="suppCode" onclick="opeateClick('suppCode',this.value)" id="suppCode0" name="suppCode0"  checked="checked" value="ALL" />全部
							<#list suppList as supp>
							   	<input type="checkbox" class="choose" tempName="suppCode" onclick="opeateClick('suppCode',this.value)" id="suppCode${suppCode_index+1}" name="suppCode${suppCode_index+1}" 
							   		value="${(supp.code)!''}" /> ${(supp.code)!''}
							</#list>
						 </div>
						
						<div class="part part1">
					     <span>起飞机场：</span>
						 <select name="departureAirportCodes" id="departureAirportCodes">
								<option value="ALL">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''} ${(airport.name)!''}</option>
								</#list>
							</select>
				         <span>到达机场：</span>
						 <select name="arrivalAirportCodes" id="arrivalAirportCodes">
								<option value="ALL">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''} ${(airport.name)!''}</option>
								</#list>
							</select>
						</div>
						 <div class="part part1">
					     	<span>航空公司：</span>
							<select name="carrierCodes" id="carrierCodes" onblur="getSeatClasses()">
								<option value="ALL">全部</option>
								<#list carriersList as carriers>
									<option value="${(carriers.code)!''}">${(carriers.code)!''} ${(carriers.name)!''}</option>
								</#list>
							</select>
						</div>
						<div class="part part1" id="seatCodeList" >
						</div>
						<div class="part part1">
					     	<span>适用航班：</span>
					     	<input type="radio" class="choose" name="flightNos" id="flightNos" checked="checked" value="ALL">没有限制</input>
					     	<input type="radio" class="choose" name="flightNos" id="flightNos" value="1">适用以下航班<input type="text" name="includeFlightNos" id="includeFlightNos"></input></input>
					     	<input type="radio" class="choose" name="flightNos" id="flightNos" value="2">不适用以下航班<input type="text" name="excludeFlightNos" id="excludeFlightNos"></input></input>
						</div>
						<div class="part part1">
					     	<span>适用班期：</span>
					     	<input type="checkbox" class="choose" tempName="weekDay" onclick="opeateClick('weekDay',this.value)" id="weekDay0" name="weekDay0" checked="checked" value="ALL" />全部
							<#list weekDaysEnum as weekDay>
							   	<input type="checkbox" class="choose" tempName="weekDay" onclick="opeateClick('weekDay',this.value)" id="weekDay${weekDay_index+1}" name="weekDay${weekDay_index+1}" 
							   		value="${weekDay}" /> ${weekDay.desc}
							</#list>	
						</div>
						<div class="part part1">
					     	<span>航班日期：</span>
							<input type="text" id="departureStartTime" name="departureStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 至<input type="text" id="departureEndTime" name="departureEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 </span>
						</div>
						<div class="part part1">
						    <span>虚拟调控：</span>
							<span>调控比例：</span><input type="text" id="priceFormulaScale" name="priceFormulaScale" />%
							<span>调控价格：</span><input type="text" id="priceFormulaFixed" name="priceFormulaFixed" />元
						</div>
					<div class="part part1">
						<span>优先级别：</span>
						<select id="priority" name="priority">
							<option value="0">0</option>	
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
				     	</select>
				     	</div>
				     	<div class="part part1">
				     	  <span>是否有效：</span>
						  <select id="status" name="status" >
								<#list statusEnum as val>
								   <option value="${val}">${val.cnName}</option>
								</#list>  
					     	</select>
					
						</div> 
						<div class="part part1">
				     	<span>有效日期:</span>
						<input type="text" id="updateStartTime" name="updateStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			        	 至<input type="text" id="updateEndTime" name="updateEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</div> 
						
						 </div>
			           </div>
					 </div>
					 
	         <div class="click">
				<a href="javascript:void(0);"><div class="button" id="button" onclick="returnSalesRuleSuppList()">返回</div></a>
				<a href="javascript:void(0);"><div class="button" id="button" onclick="addSalesRuleSupp()">添加</div></a> 
			</div>
		
		 </form>
		<!--</form>-->
		<div id="datepicker-4"></div>
		<div id="datepicker-5"></div>
	</div>
</body>
</html>