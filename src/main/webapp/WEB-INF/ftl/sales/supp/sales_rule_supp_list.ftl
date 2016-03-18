<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>虚拟调控规则维护列表</title>
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
    $(function (){
		initGrid();
		
		$(".o_close").click(function(){
			$(".office").css("display","none");
		});
		$(".o_submit .cancle").click(function(){
			$(".office").css("display","none");
		});
	
	});    
    
	//组装查询参数
	function getQueryParams() {
			return {
			'suppCodes':$("#suppCodes").find("option:selected").val(),
			'departureAirportCodes':$("#departureAirportCodes").find("option:selected").val(),
			'arrivalAirportCodes':$("#arrivalAirportCodes").find("option:selected").val(),
			'departureStartTime' : $("#departureStartTime").val(),
			'departureEndTime' : $("#departureEndTime").val(),
			'updateStartTime' : $("#updateStartTime").val(),
			'updateEndTime' : $("#updateEndTime").val(),
			'status' : $("#status").val()
		}	
	}
	
	//查询列表信息   
	function querySalesRuleSupp() {  
		$("#salesRuleSuppList").jqGrid('setGridParam', {
			url : "${request.contextPath}/sales/querySalesRuleSupp",
			datatype : "json",
			mtype : "POST",
			postData : getQueryParams()
		}).trigger("reloadGrid");
	}

    //清空表单
	function clearSalesRuleSupp(){
		$('input[type=text]').val('');
		$('select').val('');
	}
	
  	//初始化Grid控件
  	function initGrid() {
  	    var colNames =['规则ID','供应商','航空公司','起飞机场','到达机场','航班日期','优先级别','有效日期','维护时间','状态','操作'];
		$("#salesRuleSuppList").jqGrid({
				url : "${request.contextPath}/sales/querySalesRuleSupp",
				datatype : "json",
				mtype : "POST",
				colNames : colNames,
				colModel : [{
					name : 'id',formatter:formatLink,
					index : 'id',
					align : 'center',
					width :30,
					sortable:false
				},{
					name : 'suppCodes',
					index : 'suppCodes',
					align : 'center',
					width :40,
					sortable:false
				},{
					name : 'carrierCodes',
					index : 'carrierCodes',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'departureAirportCodes',
					index : 'departureAirportCodes',
					align : 'center',
					width :50,
					sortable:false
				},  {
					name : 'arrivalAirportCodes',
					index : 'arrivalAirportCodes',
					align : 'center',
					width :50,
					sortable:false
				},  {
					name : 'departureDateTime',
					index : 'departureDateTime',
					align : 'center',
					width :50,
					sortable:false
				},{
					name : 'priority',
					index : 'priority',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'effectDateTime',
					index : 'effectDateTime',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'updateTime',
					index : 'updateTime',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'status',
					index : 'status',
					align : 'center',
					width :50,
					sortable:false
				},{
					name : 'operation',
					index : 'operation',
					align : 'center',
					width :20,
					sortable:false
				}
			    ],
			    rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : true,   //是否设置全选按钮
				sortable:true,        //可以排序
			    sortname: 'searchTime',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "虚拟调控列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#salesRuleSuppList").jqGrid('setGridParam', {
						postData : getParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改和删除链接
                    var ids=jQuery("#salesRuleSuppList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var model = jQuery("#salesRuleSuppList").jqGrid('getRowData', id);
                        var operateClick= "<a href='javascript:void(0);'  style='color:#f60' onclick='querySalesRuleSuppOpLogs("+id+")' >查看log</a>";
                        jQuery("#salesRuleSuppList").jqGrid('setRowData', id, {operation:operateClick});
                        
                    }
                },
                loadComplete:function(data){ //完成服务器请求后，回调函数
					if(data.records==0){ //如果没有记录返回，追加提示信息，删除按钮不可用
						$("p").appendTo($("#list")).addClass("nodata").html('找不到相关数据！');
					}else{ //否则，删除提示，删除按钮可用
						$("p.nodata").remove();
					}
			    }
			});
		}
	
		function formatLink(cellvalue, options, rowObject) {
		    var url = "${request.contextPath}/sales/getSalesRuleSupp/"+cellvalue;
		    return  "<a href='"+url+"' style='color:blue;'>" + cellvalue + "</a>";
    	}
    	
	function getSalesRuleSuppList(rowDataVal){
		var salesRuleSuppDelList = new Array();
		rowDataVal = rowDataVal + '';
		var result=rowDataVal.split(",");
		for(var i=0;i<result.length;i++){
		  var obj = new Object;
		  obj = result[i];
		  salesRuleSuppDelList[i] = obj;
		}
		return salesRuleSuppDelList;
	}
	
	//修改虚拟调控的状态
	function updateSalesRuleSupp(statusType){
		   var rowData = jQuery('#salesRuleSuppList').jqGrid('getGridParam','selarrrow');
		   if(rowData==""){
		      alert("请选取需要修改的数据！");
		      return;
		   }
		   
		    var setStatus = new Object();
		    setStatus.status = statusType;
		    
		    if(confirm("是否确认修改?")){
			 $.ajax({
				url : "${request.contextPath}/sales/updateSalesRuleSupp",
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
					ids:getSalesRuleSuppList(rowData),
					status:statusType
				 }),
				success: function(data){
						 alert(data.message);
						 querySalesRuleSupp();
	   			},
	   			error: function (data) {
	             	alert(eval('(' + data.responseText + ')').message);
	            }
    		});
    	  }
		}
		
     //批量删除
   function batchDelSalesRuleSupp(){
	   var rowData = jQuery('#salesRuleSuppList').jqGrid('getGridParam','selarrrow');
	   if(rowData==""){
	      alert("请选取需要删除的数据！");
	      return;
	   }
      if(confirm("是否确认批量删除?")){
	    $.ajax({
			url : "${request.contextPath}/sales/batchDeleteSalesRuleSupp",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
			   ids:getSalesRuleSuppList(rowData)
				}),
			success: function(data){
			   alert(data.message);
			    querySalesRuleSupp();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	    }
	  }
		
		//查看日志
		function querySalesRuleSuppOpLogs(id){
			var tr = $("#salesRuleSuppOpLogTr");
			$.ajax({
						url : "${request.contextPath}/sales/querySalesRuleSuppOpLogs",
						type:'post',
				        dataType : "json",
						contentType : "application/json;",
						data : JSON.stringify({
								id:id
						 }),
						success: function(data){
							if (data.status != "" && data.status == "SUCCESS") {
								$("#showSalesRuleSuppOpLog").css("display", "block");
								$.each(data.results, function(index, item) {
									// 克隆tr，每次遍历都可以产生新的tr
									var clonedTr = tr.clone();
									var _index = index;
			
									// 循环遍历cloneTr的每一个td元素，并赋值
									clonedTr.children("td").each(function(inner_index) {
										// 根据索引为每一个td赋值
										switch (inner_index) {
										case (0)://操作类型
											$(this).html(item.businessType);
											break;
										case (1)://操作人
											$(this).html(item.oper);
											break;
										case (2)://操作内容
											$(this).html(item.remark+item.result);
											break;
										case (3)://操作时间
											$(this).html(item.createDate);
											break;
										case (4)://操作Id
											$(this).html(item.id);
											break;	
										}// end switch
									});
			
									// 把克隆好的tr追加原来的tr后面
									clonedTr.insertAfter(tr);
								});// end $each
								$("#salesRuleSuppOpLogTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
								$("#salesRuleSuppOpLogTable").show();
							}
			   			}
		    		});
			 
		}
		
		function cancleSalesRuleSuppOpLog(){
			$("#showSalesRuleSuppOpLog").css("display","none");
		}
		
		//添加虚拟调控规则
		function addSaleRuleSupp(){
	  		location.href ="${request.contextPath}/sales/toAddSalesRuleSupp";
		}
	
</script>

</head>
<body>
	<div class="content content1">
	    <div class="breadnav"><span>首页</span> > 虚拟调控规则维护 </div>
	    <form id="myForm">
	    	<div class="infor1">
				<div class="visitor message">
					<div class="main">
						<div class="part part1">
							<span>供应商：</span>
							<select id="suppCodes" name="suppCodes" >
							    <option value=""></option>
						     	<option value="ALL">全部</option>
								<#list suppList as supp>
									<option value="${(supp.code)!''}">${(supp.code)!''}</option>
								</#list>
					     	</select>
					     
					     	<span>航班日期：</span>
							<input type="text" id="departureStartTime" name="departureStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 至<input type="text" id="departureEndTime" name="departureEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 </span>
						 </div>
						 
						 <div class="part part1">
					     	<span>起飞机场：</span>
					     	<select name="departureAirportCodes" id="departureAirportCodes">
								<option value=""></option>
								<option value="ALL">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''}  ${(airport.name)!''}</option>
								</#list>
							</select>
				            <span>到达机场：</span>
					     	<select name="arrivalAirportCodes" id="arrivalAirportCodes">
					        	<option value=""></option>
								<option value="ALL">全部</option>
								<#list airportList as airport>
									<option value="${(airport.code)!''}">${(airport.code)!''}  ${(airport.name)!''}</option>
								</#list>
							</select>
							 <span>维护时间：</span>
							<input type="text" id="updateStartTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 至<input type="text"  id="updateEndTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							 </span>
						 </div>
							
						 <div class="part part1">
				            <span>状态：</span>
							<select id="status" name="status" >
								<#list statusEnum as val>
								   <option value="${val}">${val.cnName}</option>
								</#list>  
					     	</select>			
						   </div>
						   
						 </div>
			           </div>
					 </div>
					<div class="click">
						<a href="javascript:void(0);"><div class="button" onclick="querySalesRuleSupp()" >查询</div></a>
					    <a href="javascript:void(0);"><div class="button" onclick="addSaleRuleSupp()">新增</div></a>
					    <a href="javascript:void(0);"><div class="button" onclick="clearSalesRuleSupp()">清空</div></a>
					</div>
	          </form>
	  
	  <div class="click" style="float:left;">
	      <a href="javascript:void(0);"><div class="button"  style="width:70px;" onclick="updateSalesRuleSupp('INVALID')">设为无效</div> </a>
	      <a href="javascript:void(0);"><div class="button"  style="width:70px;" onclick="updateSalesRuleSupp('VALID')">设为有效</div> </a>
	      <a href="javascript:void(0);"><div class="button"  style="width:70px;" onclick="batchDelSalesRuleSupp()">批量删除</div> </a>		 
		</div>	
		
	<div class="content1" style="margin-top:50px;">
     <table id="salesRuleSuppList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
	</div>
	
	  <!--查看虚拟调控维护操作Log-->
	  <div class="office" id="showSalesRuleSuppOpLog" style="width:500px;align:center;top:200px; border:1px solid #e6e6e6;">
			<div class="o_title">
				日志<span class="o_close" id="closeSalesRuleSuppOpLog" >X</span>	
			</div>
			
			<table id="salesRuleSuppOpLogTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                    <th style='width:30%;'>操作类型</th>  
	                    <th style='width:10%;'>操作人</th>
	                    <th style='width:30%;'>操作内容</th>
	                    <th style='width:20%;'>操作时间</th>
	                    <th style='width:10%;'>id</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="salesRuleSuppOpLogTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                 </tr>  
	             </tbody>  
		 	</table> 
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleSalesRuleSuppOpLog()">关闭</span></a>
			</div>
		</div>		
     <br>
     <br>
     	
</div>
</body>
</html>
