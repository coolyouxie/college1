 <div class="sales" style="align:center;top:300px;" id="addSalesRuleDisable">
			<div class="o_title">
				添加<span class="o_close">X</span>	
			</div>
				<div class="o_content">
						<div class="sales_Info">
							<div class="select_Sales_Info">
									<span>航空公司：</span>
									<select id="carrierCode" name="carrierCode">
										<option value="">不限</option>	
										<#list carrierCodesEnum as val>
										   <option value="${val}">${val}</option>
										</#list>  
							     	</select>
							     	
							     	<span>提前起售时间：</span>
									<select id="leadTime" name="leadTime">
										<#list leadtimesEnum as val>
										   		<option value="${val}">${val}</option>
										</#list>  
							     	</select>小时
							     	
							     	
							     	<span>优先级：</span>
									<select id="priority" name="priority">
										<#list prioritiesEnum as val>
										   		<option value="${val}">${val}</option>
										</#list>  
							     	</select>
						    </div>
						    
						    <div class="selectSalesInfo2">		
								<span>始发地：</span>
								<input type="text" id="departureCityCode" name="departureCityCode" mod="address|notice" mod_address_source="hotel" 
									mod_address_suggest="" mod_address_reference="getcityid" placeholder="不限"/>
						     	<span>目的地：</span>
								<input type="text" id="arriveCityCode" name="arriveCityCode" mod="address|notice" mod_address_source="hotel" 
									mod_address_suggest="" mod_address_reference="getcityid" placeholder="不限"/>
								<span>是否有效：</span>
								<select id="add_status" name="add_status" >
									<#list statusEnum as val>
									   <option value="${val}">${val.cnName}</option>
									</#list>  
						     	</select>
						    </div>
							
							  <div class="selectSalesInfo3">		
								<span>航班号：</span>
								<input type="text" id="flightNo" name="flightNo" placeholder="不限"/>
						    </div>
					</div>
				</div>
				<div class="o_submit">
					<a href="#"><span class="sure" onclick="saveRuleDisable()">确定</span></a>
					<a href="#"><span class="cancle" onclick="cancelSaveRuleDisable()">取消</span></a>
				</div>
				</br>
				</br>
	</div>


	<div id="jsContainer" class="jsContainer" style="height: 0">
		<div id="tuna_alert"
			style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
		<div id="tuna_jmpinfo"
			style="visibility: hidden; position: absolute; z-index: 120;"></div>
	</div>  
	<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>		


	<script type="text/javascript">
		   //取消按钮
		   function cancelSaveRuleDisable(){
			   $(".sales").css("display","none");
		  }
		  
		  
		    //获取城市编码
    		function getCityCode()
    		{
    			var cityCodeAry = new Array(); 
    			
    			//设置出发城市和目的城市
        		var departureCityCode = $('#departureCityCode').val();
        		if($.trim(departureCityCode).length > 0)
        		{
        			var startIndex = departureCityCode.indexOf('(') + 1;
        			var endIndex = departureCityCode.indexOf(')');
        			departureCityCode = departureCityCode.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(departureCityCode);
        		
        		var arriveCityCode = $('#arriveCityCode').val();
        		if($.trim(arriveCityCode).length > 0)
        		{
        			var startIndex = arriveCityCode.indexOf('(') + 1;
        			var endIndex = arriveCityCode.indexOf(')');
        			arriveCityCode = arriveCityCode.substring(startIndex, endIndex);
        		}
        		cityCodeAry.push(arriveCityCode);
        		
        		return cityCodeAry;
    		}
    		

		  //保存
		  function saveRuleDisable(){
	  	     $.ajax({
				url : "${request.contextPath}/sales/saveSalesRuleDisable",
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : saveData(),
				success: function(data){
						if (data.status != "" && data.status == "SUCCESS") {
						 	$(".sales").css("display","none");
							alert("保存成功");
							query();
						}
	   			}
		    });
		  		
		  }
		  
		  function saveData(){
		  		var cityCodeAry = getCityCode(); 
		  		return JSON.stringify({
		  			id:$('#salesRuleDisableId').val(),
					carrierCode :$('#carrierCode').val(),
					leadTime : $("#leadTime").val(),
					priority : $("#priority").val(),
					departureCityCode :cityCodeAry[0],
					arriveCityCode:cityCodeAry[1],
					flightNo:$("#flightNo").val(),
					status:$("#add_status").val()
				})
		  }

	</script>
	
	<input id="salesRuleDisableId" type="hidden" >
