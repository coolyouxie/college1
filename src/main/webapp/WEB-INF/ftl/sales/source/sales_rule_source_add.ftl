<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>添加营销调控规则</title>
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

		//  调控比例：x%；“-”为减，录入比例限制-10%到10%；
		function getPriceFormulaScale(obj) {
			var priceFormulaScaleVal=$(obj).val();
			if(priceFormulaScaleVal!="" && parseInt(priceFormulaScaleVal)>10 ){
			 alert("调控比例在-10%到10%区间，请重新输入");
			 $(obj).val("");
			 return;
			}
		}
		  

         //  调控价格：x元；“-”为减，录入金额限制-100元到100元
		function getPriceFormulaFixed(obj) {
		  var priceFormulaFixedVal=$(obj).val();
			if(priceFormulaFixedVal!="" && parseInt(priceFormulaFixedVal)>100 ){
			 alert("调控价格在-100到100区间，请重新输入");
			 $(obj).val("");
			 return;
			}
		}
	
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
		 
    //添加营销调控规则信息
   function addSalesRuleSource(){
     $.ajax({
			url : "${request.contextPath}/sales/saveSalesRuleSource",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				salesRuleSourceRequest:getAddParams()
				}),
			success: function(data){
			    alert(data.message);
				location.href ="${request.contextPath}/sales/toSalesRuleSource";
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	  }
	    
		 //组装保存营销调控规则信息
		 function getAddParams() {
		        var bookingSourceStr="";
        		$("input[tempName='bookingSource']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		bookingSourceStr += $(this).val()+"/";
            		}
        		});
        		bookingSourceStr=bookingSourceStr.substring(0,bookingSourceStr.length-1); 
        		
        		var productCategoryStr="";
        		$("input[tempName='productCategory']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		productCategoryStr += $(this).val()+"/";
            		}
        		});
        		productCategoryStr=productCategoryStr.substring(0,productCategoryStr.length-1); 
        		
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
        		
        		var insuranceClassesStr="";
        		$("input[tempName='insuranceClasse']:checkbox").each(function(){ 
            		if($(this).attr("checked")){
                		insuranceClassesStr += $(this).val()+"/";
            		}
        		});
        		insuranceClassesStr=insuranceClassesStr.substring(0,insuranceClassesStr.length-1); 
        		
        		var salesRuleTd="";
	        	$('#salesRuleTab tr').each(function(){
					var parPriceRanges= $(this).find("[name='parPriceRange']").val();
					var formulaBases = $(this).find("[name='formulaBase']").val();
					var priceFormulaScales = $(this).find("[name='priceFormulaScale']").val();
					var priceFormulaFixeds = $(this).find("[name='priceFormulaFixed']").val();
					if(typeof(parPriceRanges)!="undefined"){
					   salesRuleTd+=parPriceRanges+","+formulaBases+","+priceFormulaScales+","+priceFormulaFixeds+";";
					}
				});
				
        	 var salesRuleStr=salesRuleTd.substring(0,salesRuleTd.length-1); 
        	 
        	 var salesRuleSourceRequest = new Object;
        	 salesRuleSourceRequest.departureStartTime=$.trim($('#departureStartTime').val());
        	 salesRuleSourceRequest.departureEndTime=$.trim($('#departureEndTime').val());
        	 salesRuleSourceRequest.updateStartTime=$.trim($('#updateStartTime').val());
        	 salesRuleSourceRequest.updateEndTime=$.trim($('#updateEndTime').val());
			 var salesRuleSourceDto = new Object;
			 salesRuleSourceDto.productCategorys=bookingSourceStr;
			 salesRuleSourceDto.bookingSources=productCategoryStr;
			 salesRuleSourceDto.insuranceClasses=insuranceClassesStr;
			 salesRuleSourceDto.salesRules=salesRuleStr;
			 
			 salesRuleSourceDto.departureAirportCodes=$("#departureAirportCodes").find("option:selected").val();
			 salesRuleSourceDto.arrivalAirportCodes=$("#arrivalAirportCodes").find("option:selected").val();
			 salesRuleSourceDto.carrierCodes=$("#carrierCodes").find("option:selected").val();
			 salesRuleSourceDto.seatCodes=seatCodeStr;
			 salesRuleSourceDto.includeFlightNos=$.trim($("#includeFlightNos").val());
			 salesRuleSourceDto.excludeFlightNos=$.trim($("#excludeFlightNos").val());
			 salesRuleSourceDto.weekDays=weekDayStr;
			 salesRuleSourceDto.priority=$("#priority").find("option:selected").val();
			 salesRuleSourceDto.status=$("#status").find("option:selected").val();
			 salesRuleSourceRequest.salesRuleSourceDto=salesRuleSourceDto;
			 
			 return salesRuleSourceRequest;
		}

	//返回
	function returnSalesRuleSourceList() {
	   	location.href ="${request.contextPath}/sales/toSalesRuleSource";
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
	    <div class="title" style="text-align :center" ><h3>添加营销调控规则</h3></div>
	    <form id="myForm">
	    	<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part part1">
							<span>适用渠道：</span>
							<span style="width:80%;text-align:left;vertical-align:top;"><input type="checkbox" class="choose" tempName="bookingSource" onclick="opeateClick('bookingSource',this.value)" id="bookingSource0" name="bookingSource0" checked="checked" value="ALL" />全部
							<#list bookingSourceEnum as bookingSource>
							   	<input type="checkbox" class="choose" tempName="bookingSource" onclick="opeateClick('bookingSource',this.value)" id="bookingSource${bookingSource_index+1}"  name="bookingSource${bookingSource_index+1}" 
							   		value="${bookingSource}" /> ${bookingSource.cnName}
							</#list>
							</span>
						 </div>
						 <div class="part part1">
					     	<span>适用场景：</span>
					     	<input type="checkbox" class="choose" tempName="productCategory" onclick="opeateClick('productCategory',this.value)" id="productCategory0" name="productCategory0" checked="checked" value="ALL" />全部
							<#list productCategoryEnum as productCategory>
							   	<input type="checkbox" class="choose" tempName="productCategory" onclick="opeateClick('productCategory',this.value)" id="productCategory${productCategory_index+1}" name="productCategory${productCategory_index+1}" 
							   		value="${productCategory}" /> ${productCategory.cnName}
							</#list>	
						</div>
						<div class="part part1">
					     <span>起飞机场：</span>
						 <select name="departureAirportCodes" id="departureAirportCodes">
								<option value="ALL"  selected="selected">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''}  ${(airport.name)!''}</option>
								</#list>
							</select>
				         <span>到达机场：</span>
						 <select name="arrivalAirportCodes" id="arrivalAirportCodes">
								<option value="ALL"  selected="selected">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''}  ${(airport.name)!''}</option>
								</#list>
							</select>
						</div>
						 <div class="part part1">
					     	<span>航空公司：</span>
							<select name="carrierCodes" id="carrierCodes" onblur="getSeatClasses()">
								<option value="ALL"  selected="selected">全部</option>
								<#list carriersList as carriers>
									<option value="${(carriers.code)!''}">${(carriers.code)!''}  ${(carriers.name)!''}</option>
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
					     	<input type="checkbox" class="choose" tempName="weekDay" onclick="opeateClick('weekDay',this.value)" id="weekDay0" name="weekDay0" value="ALL" checked="checked" />全部
							<#list weekDaysEnum as weekDay>
							   	<input type="checkbox" class="choose" tempName="weekDay" onclick="opeateClick('weekDay',this.value)" id="weekDay${weekDay_index+1}" name="weekDay${weekDay_index+1}" 
							   		value="${weekDay.cnName}"/> ${weekDay.desc}
							</#list>	
						</div>
						<div class="part part1">
					     	<span>航班日期：</span>
							<input type="text" id="departureStartTime" value="${departureStartTime}" name="departureStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 至<input type="text" id="departureEndTime" value="${departureEndTime}"  name="departureEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 </span>
						</div>
						<div class="part part1">
						    <span>营销调控：</span>
					     	<span style="width:500px;text-align:right;vertical-align:top;">
					     	<table id="salesRuleTab" style="text-align:center;border:1px solid #e4e4e4;cellpadding:0px;cellspacing:0px;">  
						       <tr>
								   <td width="20%">票面价区间</td>
								   <td width="40%">调控基准</td>
								   <td width="20%">调控比例</td>
								   <td width="25%">调控价格</td>
							   </tr>
						        <tr style="text-align:center;">
								<td width="20%"><input type="hidden" id="parPriceRange" name="parPriceRange" value="499以下" />499以下</td>
								<td width="40%">
								          调控基准:
								  <select name="formulaBase" id="formulaBase" style="width:100px;">
									<option value="ALL">全部</option>
									<#list formulaBaseEnum as formulaBase>
										<option value="${(formulaBase)!''}">${(formulaBase.cnName)!''}</option>
									</#list>
						           </select>
								</td>
						        <td width="20%"><input type="text" id="priceFormulaScale" name="priceFormulaScale" style="width:40px;" value="0" onblur="getPriceFormulaScale(this)" />%</td> 
						        <td width="20%"><input type="text" id="priceFormulaFixed" name="priceFormulaFixed" style="width:40px;" value="0" onblur="getPriceFormulaFixed(this)" />元</td>
						        </tr>  
						        <tr style="text-align:center;">
								<td width="20%"><input type="hidden" id="parPriceRange" name="parPriceRange" value="500-999" />500-999</td>
								<td width="40%">
								        调控基准：
								  <select name="formulaBase" id="formulaBase" style="width:100px;">
									<option value="ALL">全部</option>
									<#list formulaBaseEnum as formulaBase>
										<option value="${(formulaBase)!''}">${(formulaBase.cnName)!''}</option>
									</#list>
						           </select>
								</td>
						       <td width="20%"><input type="text" id="priceFormulaScale" name="priceFormulaScale" style="width:40px;" value="0" onblur="getPriceFormulaScale(this)" />%</td> 
						        <td width="20%"><input type="text" id="priceFormulaFixed" name="priceFormulaFixed" style="width:40px;" value="0" onblur="getPriceFormulaFixed(this)" />元</td>
						        </tr>  
						        <tr style="text-align:center;">
								<td width="20%"><input type="hidden" id="parPriceRange" name="parPriceRange" value="1000-1499" />1000-1499</td>
								<td width="40%">
								        调控基准：
								  <select name="formulaBase" id="formulaBase" style="width:100px;">
									<option value="ALL">全部</option>
									<#list formulaBaseEnum as formulaBase>
										<option value="${(formulaBase)!''}">${(formulaBase.cnName)!''}</option>
									</#list>
						           </select>
								</td>
						        <td width="20%"><input type="text" id="priceFormulaScale" name="priceFormulaScale" style="width:40px;" value="0" onblur="getPriceFormulaScale(this)" />%</td> 
						        <td width="20%"><input type="text" id="priceFormulaFixed" name="priceFormulaFixed" style="width:40px;" value="0" onblur="getPriceFormulaFixed(this)" />元</td>
						        </tr>  
						        <tr style="text-align:center;height=25px;">
								<td width="20%"><input type="hidden" id="parPriceRange" name="parPriceRange" value="1500以上" />1500以上</td>
								<td width="40%">
							   	  调控基准：
								  <select name="formulaBase" id="formulaBase" style="width:100px;">
									<option value="ALL">全部</option>
									<#list formulaBaseEnum as formulaBase>
										<option value="${(formulaBase)!''}">${(formulaBase.cnName)!''}</option>
									</#list>
						           </select>
								</td>
						       <td width="20%"><input type="text" id="priceFormulaScale" name="priceFormulaScale" style="width:40px;" value="0" onblur="getPriceFormulaScale(this)" />%</td> 
						        <td width="20%"><input type="text" id="priceFormulaFixed" name="priceFormulaFixed" style="width:40px;" value="0" onblur="getPriceFormulaFixed(this)" />元</td>
						        </tr>  
						    </table>  
						    </span>
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
						<input type="text" id="updateStartTime" value="${updateStartTime}" name="updateStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			        	 至<input type="text" id="updateEndTime" value="${updateEndTime}" name="updateEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</div> 
						
					   <div class="part part1">
				     	   <span>绑定险种：</span>
							<input type="checkbox" class="choose" tempName="insuranceClasse" name="insuranceClasses[0]" value="ALL" checked="checked" /> 不绑定
						    <#list insuranceList as insurance>
							   	<input type="checkbox" class="choose" tempName="insuranceClasse" name="insuranceClasses[${insurance_index}+1]" 
							   		value="${insurance.insuranceClass.name}" /> ${insurance.insuranceClass.name}
							</#list>
						  </div> 
						
						 </div>
			           </div>
					 </div>
					 
	         <div class="click">
				<a href="javascript:void(0);"><div class="button" id="button" onclick="returnSalesRuleSourceList()">返回</div></a>
				<a href="javascript:void(0);"><div class="button" id="button" onclick="addSalesRuleSource()">添加</div></a> 
			</div>
		
		 </form>
		<!--</form>-->
		<div id="datepicker-4"></div>
		<div id="datepicker-5"></div>
	</div>
</body>
</html>