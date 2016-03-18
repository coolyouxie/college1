<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script> 
    
    
    <script type="text/javascript">
    
	    $(function (){
			initGrid();
			getInsurance();
	    });    
		
		//查询列表信息   
		function query() { 
       		
			$("#insuranceOrderList").jqGrid('setGridParam', {
				url : "queryInsuranceOrderList",
				datatype : "json",
				mtype : "POST",
				postData : getInsuranceOrderParams()
			}).trigger("reloadGrid");
			conditionHtmlToExportCsvForm();
		}
		
		function getInsuranceOrderParams() {
			if($("#insuranceStatus").val() =='all'){
				return {
					'orderNo' : $("#orderNo").val(),
					'ticketNo' : $("#ticketNo").val(),
					'insuranceNo' : $("#insuranceNo").val(),
					'insuredName' : $("#insuredName").val(),
					'insuranceStatus' : "",
					'idCardNo' : $("#idCardNo").val(),
					'startEffectDate' : $("#startEffectDate").val(),
					'endEffectDate' : $("#endEffectDate").val(),
					'startInsureDate' : $("#startInsureDate").val(),
					'endInsureDate' : $("#endInsureDate").val(),
					'startHesitateDate' : $("#startHesitateDate").val(),
					'endHesitateDate' : $("#endHesitateDate").val(),
					'insuranceInfoDto.id' : $('#insuranceName').val(),
					'insuranceInfoDto.insuranceClass.name' : $('#insuranceName').find("option:selected").text(),
					'insuranceInfoDto.supp.id' : $('#suppName').val(),
					'search':false
				}
			}else{
				return {
					'orderNo' : $("#orderNo").val(),
					'ticketNo' : $("#ticketNo").val(),
					'insuranceNo' : $("#insuranceNo").val(),
					'insuredName' : $("#insuredName").val(),
					'insuranceStatus' : $("#insuranceStatus").val(),
					'idCardNo' : $("#idCardNo").val(),
					'startEffectDate' : $("#startEffectDate").val(),
					'endEffectDate' : $("#endEffectDate").val(),
					'startInsureDate' : $("#startInsureDate").val(),
					'endInsureDate' : $("#endInsureDate").val(),
					'startHesitateDate' : $("#startHesitateDate").val(),
					'endHesitateDate' : $("#endHesitateDate").val(),
					'insuranceInfoDto.id' : $('#insuranceName').val(),
					'insuranceInfoDto.insuranceClass.name' : $('#insuranceName').find("option:selected").text(),
					'insuranceInfoDto.supp.id' : $('#suppName').val(),
					'search':false
				}
			}
		}
		
		function initGrid() {
			$("#insuranceOrderList").jqGrid({
				url : "queryInsuranceOrderList",
				datatype : "json",
				mtype : "POST",
				colNames : ['订单号','票号','保单ID','保单号','产品名称','供应商','用户姓名','证件号码','创建时间','投保时间','投保时间','生效时间','废保时间','订单保险状态','投保状态','操作'],
				colModel : [ {
					name : 'orderNo',formatter:formatLink,
					index : 'orderNo',
					align : 'center',
					//width :220,
					sortable:false
				}, {
					name : 'ticketNo',
					index : 'ticketNo',
					align : 'center',
					sortable:false
				}, {
					name : 'insuranceOrderId',
					index : 'insuranceOrderId',
					align : 'center',
					sortable : false,
					hidden : true
				},{
					name : 'insuranceNo',
					index : 'insuranceNo',
					align : 'center',
					sortable:false
				}, {
					name : 'insuranceClassName',
					index : 'insuranceClassName',
					align : 'center',
					sortable:false
				}, {
					name : 'suppName',
					index : 'suppName',
					align : 'center',
					sortable:false
				}, {
					name : 'insuredName',
					index : 'insuredName',
					align : 'center',
					sortable:false
				}, {
					name : 'idCardNo',
					index : 'idCardNo',
					align : 'center',
					//width : 250,
					sortable:false
				}, {
					name : 'createDate',
					index : 'createDate',
					align : 'center',
					//width : 250,
					sortable:false
				}, {
					name : 'insureTime',
					index : 'insureTime',
					align : 'center',
					//width : 250,
					sortable : true
				},{
					name : 'insureDate',
					index : 'insureDate',
					align : 'center',
					//width : 250,
					sortable : false,
					hidden : true
				}, {
					name : 'effectTime',
					index : 'effectTime',
					align : 'center',
					sortable:false
				}, {
					name : 'hesitateTime',
					index : 'hesitateTime',
					align : 'center',
					sortable:false
				}, {
					name : 'orderStatus',
					index : 'orderStatus',
					align : 'center',
					sortable:false
				}, {
					name : 'insuranceType',
					index : 'insuranceType',
					align : 'center',
					sortable:false
				}, {
					name : 'operate',
					index : 'operate',
					align : 'center',
					sortable:false
				}],
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	   	rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    //autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'createDate',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "保险列表",
				jsonReader : {
					root : "results",               // json中代表实际模型数据的入口  
					page : "pagination.page",       // json中代表当前页码的数据   
					records : "pagination.records", // json中代表数据行总数的数据   
					total:'pagination.total',       // json中代表页码总数的数据 
					repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#insuranceOrderList").jqGrid('setGridParam', {
						postData : getInsuranceOrderParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#insuranceOrderList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#insuranceOrderList').jqGrid('getRowData',id);
                    	var insuranceNo = rowData.insuranceNo;
                    	var insureDate = rowData.insureDate;
                    	var insuranceId = rowData.insuranceOrderId;
                        operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+insuranceId+')" >日志</a> <a href="#" style="color:blue" onclick="hesitateCancel('+"'"+insuranceNo+"' ,'"+ insureDate +"'"+')" >废保</a> <a href="#" style="color:blue" onclick="checkDetail('+insuranceId+')" >查看</a>';
                        jQuery("#insuranceOrderList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		
		function formatLink(cellvalue, options, rowObject) {
			//主订单Id到后台自动查询
			var orderMainId = -1;
		    var url = "${request.contextPath}/order/queryOrderDetail/"+orderMainId+"/"+rowObject.orderId+"/NULL";
		    return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    	}
		
		//废保
		function hesitateCancel(insuranceNo, insureDate) {
		
			var gnl=confirm("确认废除保单？"); 
			var desc;
			if(gnl==true){
				desc = window.prompt("请输入废保原因","请输入废保原因");
				if(desc){
					$.ajax({
						url : 'hesitateCancel',
						type:'post',
				        dataType : "json",
						contentType : "application/json;",
						data : JSON.stringify({
							insuranceNo : insuranceNo,
							insureDate : insureDate,
							desc : desc
						 }),
						success: function(data){
							alert(data.message);
							window.location.reload();
			   			}
				    });
				}
				
				
			}
		 }
		 
		//查看操作日志
		function operateLog(insuranceId) {
		   	window.open("${request.contextPath}/toOpLogListPage/"+insuranceId+"/INSURANCE_ORDER");
		}
		 
		//查看保单详情
		function checkDetail(insuranceId) {
			window.open("${request.contextPath}/insurance/queryInsuranceOrderDetail/"+insuranceId);
		}
		 
		function artificialInsured() {
		   	window.open("${request.contextPath}/insurance/toArtificialInsuredPage");
		}
		 
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
		 
		 
		//将条件插入到导出exportCsvForm
		function conditionHtmlToExportCsvForm()
		{
			$('#exportCsvDiv').html($('#conditionDiv').html());
			//去除exportCsvDiv所有元素的id和tempName属性
			$('#exportCsvDiv').find('select').removeAttr('id');
			$('#exportCsvDiv').find('input').removeAttr('id');
			$('#exportCsvDiv').find('input').removeAttr('tempName');
			//元素赋值
			$.each($('#conditionDiv').find('input[type="text"]'), function(index, obj)
			{
				var objName = $(obj).attr('name');
				$('#exportCsvDiv').find('input[name="'+objName+'"]').attr('value', $(obj).val());
			});
			$.each($('#conditionDiv').find('input[type="checkbox"]'), function(index, obj)
			{
				var objName = $(obj).attr('name');
				if($(obj).attr('checked'))
					$('#exportCsvDiv').find('input[name="'+objName+'"]').attr('checked', true);
			});
			$.each($('#conditionDiv').find('select'), function(index, obj)
			{
				var objName = $(obj).attr('name');
				$('#exportCsvDiv').find('select[name="'+objName+'"]').attr('value', $(obj).val());
			});
		}
		
		//导出Csv
		function exportCsv()
		{
			$('#exportCsvForm').submit();
		}
		
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}
	
  </script>
    
  </head>
  <body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 保险列表</div>
	 <form id="myForm" autocomplete="off" >
		<div class="infor1">
			<div class="product message">
				<div class="main">
					<div class="part">
						<span>订单号：</span><input type="text" id="orderNo" name="orderNo">				       
						<span>供应商：</span><select name="suppName" id="suppName" onblur="getInsurance()">
						<#list supps as supp>
							<option value="${(supp.id)!''}">${(supp.name)!''}</option>
						</#list>
					</select>
						<span>投保时间：</span><input type="text" id="startInsureDate"  name="startInsureDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endInsureDate"  name="endInsureDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">
					    <span>保单号：</span><input type="text" id="insuranceNo" name="insuranceNo">	
						<span>投保状态：</span><select name="insuranceStatus" id="insuranceStatus">
						<option value="all">全部</option>
						<#list insuranceStatusEnum as val>
				        	<option value="${val}">${val.cnName}</option>
				        </#list> 
					</select>
						<span>生效时间：</span><input type="text" id="startEffectDate"  name="startEffectDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endEffectDate"  name="endEffectDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
				</div>
			</div>
			<div class="visitor message">
		
				<div class="main">
					<div class="part">
					    <span>票号：</span><input type="text" id="ticketNo"  name="ticketNo"/>
						<span>产品名称：</span><select name="insuranceName" id="insuranceName">
						</select>
						<span>废保时间：</span><input type="text" id="startHesitateDate"  name="startHesitateDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endHesitateDate"  name="endHesitateDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
					</div>
					<div class="part">
					   <span>姓名：</span><input type="text" id="insuredName"  name="insuredName"/>
					   <span>证件号码：</span><input type="text" id="idCardNo"  name="idCardNo"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		        <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>
		        <a href="javascript:;"><div class="button" onclick="exportCsv()">导出到Csv</div></a> 
		        <a href="javascript:;"><div class="button" onclick="artificialInsured()">人工投保</div></a>
		</div>
	</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="insuranceOrderList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
    <form id="exportCsvForm" action="${request.contextPath}/insurance/insOrderExportCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form>  
	</div>
</body>
</html>
