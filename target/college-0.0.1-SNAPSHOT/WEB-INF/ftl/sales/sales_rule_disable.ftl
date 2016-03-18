<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>禁售规则维护</title>
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script src="${request.contextPath}/js/Calendar.js"></script>
<script type="text/javascript">
    $(function (){
		initGrid();
			
		$(".o_close").click(function(){
			$(".office").css("display","none");
		});
		$(".o_submit .cancle").click(function(){
			$(".office").css("display","none");
		});
		
		//取消
		$(".o_close").click(function(){
			$(".pay").css("display","none");
		});
		
		$(".o_submit .cancle").click(function(){
			$(".pay").css("display","none");
		});
	});    
  
  	//初始化Grid控件
  	function initGrid() {
			$("#saleRuleDisableTable").jqGrid({
				url : "${request.contextPath}/sales/querySalesRuleDisable",
				datatype : "json",
				mtype : "POST",
				colNames : ['政策ID','航空公司','提前起售时间','起始地','目的地','航班号','优先级',"是否有效",'操作','是否删除','日志信息'],
				colModel : [ {
					name : 'id',
					index : 'id',
					align : 'center',
					sortable:false
				}, 
				{
					name : 'carrierCode',
					index : 'carrierCode',
					align : 'center',
					sortable:false
				},  {
					name : 'leadTime',
					index : 'leadTime',
					align : 'center',
					sortable:false,
					formatter : leadTimeformat
				}, {
					name : 'departureCityCode',
					index : 'departureCityCode',
					align : 'center',
					sortable:false
				}, {
					name : 'arriveCityCode',
					index : 'arriveCityCode',
					align : 'center',
					sortable:false
				}, {
					name : 'flightNo',
					index : 'flightNo',
					align : 'center',
					sortable:false
				}, {
					name : 'priority',
					index : 'priority',
					align : 'center',
					sortable:false
				}, {
					name : 'status',
					index : 'status',
					align : 'center',
					sortable:false
				}, {
					name : 'operation',
					index : 'operation',
					align : 'center',
					sortable:false
					/** ,formatter : formatLink**/
				}, {
					name : 'activeStatusEnum',
					index : 'activeStatusEnum',
					align : 'center',
					sortable:false,
					hidden : true
				}, {
					name : 'opLogs',
					index : 'opLogs',
					align : 'center',
					sortable:false,
					hidden : true
				}
				
				],
				rowNum:10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			    //autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'searchTime',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "流量列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#saleRuleDisableTable").jqGrid('setGridParam', {
						postData : getParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改和删除链接
                    var ids=jQuery("#saleRuleDisableTable").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var model = jQuery("#saleRuleDisableTable").jqGrid('getRowData', id);
                        jQuery("#saleRuleDisableTable").jqGrid('setRowData', id, {operation:getOperationLinks(id)});
                        
                    }
                },
             	loadComplete:function(data){ //完成服务器请求后，回调函数
				   var rowNum = parseInt($(this).getGridParam("records"), 10);  
        			if (rowNum <= 0) {  
            			alert("没有符合条件的记录！");  
        			}  
				}
				
			});
		}
		
		
		function leadTimeformat(cellvalue, options, rowObject){
			return cellvalue+"小时";
		}
		
		//操作链接
		function getOperationLinks(id){
		  	var model = jQuery("#saleRuleDisableTable").jqGrid('getRowData', id);
    		var logicDelete='删除';
            var modify='修改';
            var checkLogs='检查日志';
            var deleteLink="";
            var modifyLink="";
            var checkLogsLink="<a href='#' style='color:#f60' onclick=checkLogs('"+id+"')>"+checkLogs+"</a>";
            
            if(model.activeStatusEnum=='ACTIVE'){
            	deleteLink="<a href='#' style='color:#f60' onclick=logicDelete('"+id+"')>"+logicDelete+"</a> | ";
            	modifyLink="<a href='#' style='color:#f60' onclick=modify('"+id+"')>"+modify+"</a> | ";
            }
            var operateClick="<div>"+deleteLink+modifyLink+checkLogsLink+"</div>";
            return operateClick;
		}
		
		//逻辑删除
		function logicDelete(id){
			 var model = jQuery("#saleRuleDisableTable").jqGrid('getRowData', id);
			 
			 var activeStatus = new Object();
			 activeStatus.activeStatus = 'INACTIVE';
			 var status = 'INVALID';
			 
			 if(confirm("是否确认删除?")){
				 	$.ajax({
						url : "${request.contextPath}/sales/saveSalesRuleDisable",
						type:'post',
				        dataType : "json",
						contentType : "application/json;",
						data : JSON.stringify({
								id:id,
								status:status,
								activeStatus:activeStatus
						 }),
						success: function(data){
							alert("删除成功！");
						   	query();
			   			},
			   			error: function (data) {
			             	alert(eval('(' + data.responseText + ')').message);
			            }
		    		});
			 
			 }
			 
	    
		}
		
		//修改
		function modify(id){
				 	$.ajax({
						url : "${request.contextPath}/sales/getSalesRuleDisable",
						type:'post',
				        dataType : "json",
						contentType : "application/json;",
						data : JSON.stringify({
								id:id
						 }),
						success: function(data){
							if (data.status != "" && data.status == "SUCCESS") {
								$("#priority").val(data.result.priority);
								$("#leadTime").val(data.result.leadTime);
								$("#carrierCode").val(data.result.carrierCode);
								$("#departureCityCode").val(data.result.departureCityCode);
								$("#arriveCityCode").val(data.result.arriveCityCode);
								$("#flightNo").val(data.result.flightNo);
								$("#salesRuleDisableId").val(data.result.id);
								$("#add_status").val(data.result.status);
								
								alert($("#add_status").val());
								$(".sales").css("display","block");
								
							}
			   			},
			   			error: function (data) {
			             	alert(eval('(' + data.responseText + ')').message);
			            }
		    		});
		
		}
		
		//查看日志
		function checkLogs(id){
			var tr = $("#salesRuleDisableCloneTr");
			$.ajax({
						url : "${request.contextPath}/sales/queryOpLogs",
						type:'post',
				        dataType : "json",
						contentType : "application/json;",
						data : JSON.stringify({
								id:id
						 }),
						success: function(data){
							if (data.status != "" && data.status == "SUCCESS") {
								$("#salesRuleDisableOpLog").css("display", "block");
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
										case (4)://操作时间
											$(this).html(item.id);
											break;	
										}// end switch
									});// end children.each
			
									// 把克隆好的tr追加原来的tr后面
									clonedTr.insertAfter(tr);
								});// end $each
								$("#salesRuleDisableCloneTr").hide();// 隐藏id=clone的tr，因为该tr中的td没有数据，不隐藏起来会在生成的table第一行显示一个空行
								$("#salesRuleDisableTable").show();
								
							}
			   			}
		    		});
			 
		}
		 
		
		
		//查询
		function getParams() {
				return {
				'startCreateDate' : $("#startCreateDate").val(),
				'endCreateDate' : $("#endCreateDate").val(),
				'startUpdateDate' : $("#startUpdateDate").val(),
				'endUpdateDate' : $("#endUpdateDate").val(),
				'status' : $("#status").val(),
				'activeStatus.activeStatus' : $("#activeStatus").val(),
				
			}	
		}

		
		//查询列表信息   
		function query() {  
			$("#saleRuleDisableTable").jqGrid('setGridParam', {
				url : "${request.contextPath}/sales/querySalesRuleDisable",
				datatype : "json",
				mtype : "POST",
				postData : getParams()
			}).trigger("reloadGrid");
		}


	    //清空表单
		function clearForm()
		{
			$('input[type=text]').val('');
			$('select').val('');
		}
		
		//新增禁售规则
		function addSalesRuleDisable(){
	  		$("#addSalesRuleDisable").css("display","block");
		}
		
		
		
		function cancelSalesRuleDisableOpLog(){
			$("#salesRuleDisableOpLog").css("display","none");
			removeTableData();
			//query();
		}
		
		//当table关闭时删除掉数据
		function removeTableData(){
			var startIndex = 2;
			var endIndex = $("#salesRuleDisableTable tr").length;
			if(endIndex>2){
				/**for(i=2;i<endIndex;i++){
					var tab = $('#salesRuleDisableTable');
					tab.find("tr").eq(i-1).remove();
				} */
				
				for(var i=endIndex;i>=2;i--) //保留最前面两行！
				{
				$("#salesRuleDisableTable").find("tr").eq(i).remove();
				}
			}
	
		}
		
	
</script>

</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 禁售规则维护 </div>
		<form id="myForm">
			<div class="infor1">
				<div class="visitor message">
					<div class="main">
							<div class="part part1">
							<span>录入时间：</span><input type="text" name="startCreateDate" id="startCreateDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="endCreateDate" id="endCreateDate" onClick="new Calendar().show(this);" readonly />
							<span>最后维护日期：</span><input type="text" name="startUpdateDate" id="startUpdateDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="endUpdateDate" id="endUpdateDate" onClick="new Calendar().show(this);" readonly />
						    </div>
						    <div class="part part2">		
							<span>是否有效：</span>
							<select id="status" name="status" >
								<#list statusEnum as val>
								   <option value="${val}">${val.cnName}</option>
								</#list>  
					     	</select>
					     	
					     	<span>是否删除：</span>
							<select id="activeStatus" name="activeStatus" >
								<#list activeStatusEnum as val>
									<#if val=='ACTIVE' || val=='INACTIVE'>
								   		<option value="${val}">${val.cnName}</option>
									</#if>
								</#list>  
					     	</select>

									
						    </div>
					</div>
				</div>
			</div>
			<div class="click">
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
				<a href="javascript:;"><div class="button" onclick="addSalesRuleDisable()">新增</div></a>
				<a href="javascript:;"><div class="button" onclick="clearForm()">清空</div></a>
			</div>
			</br>
			</br>
		</form>

		<div class="content1">
			<table id="saleRuleDisableTable"></table>
			<div id="pager"></div>
		</div>
	</div>
	
	
	<div id="jsContainer" class="jsContainer" style="height: 0">
		<div id="tuna_alert"
			style="display: none; position: absolute; z-index: 999; overflow: hidden;"></div>
		<div id="tuna_jmpinfo"
			style="visibility: hidden; position: absolute; z-index: 120;"></div>
	</div>     
	<script type="text/javascript" src="${request.contextPath}/js/fixdiv.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/address.js"></script>
	


	 <!--禁售规则日志table-->
	  <div class="office" id="salesRuleDisableOpLog" style="width:500px;align:center;top:200px; border:1px solid #e6e6e6;">
			<div class="o_title">
				日志<span class="o_close" id="closeRePay" >X</span>	
			</div>
			
			<table id="salesRuleDisableTable" style ="border=2; display: block;">  
	            <thead>  
	                <tr>  
	                    <th style='width:20%;'>操作类型</th>  
	                    <th style='width:20%;'>操作人</th>
	                 	<th style='width:30%;'>操作内容</th>
	                    <th style='width:20%;'>操作时间</th>
	                    <th style='width:10%;'>id</th>
	                </tr>  
	            </thead>  
	            <tbody>  
	                <tr id="salesRuleDisableCloneTr">  
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>  
	                   <td align=center></td>
	                   <td align=center></td>
	                 </tr>  
	             </tbody>  
		 	</table> 
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="cancle" onclick="cancelSalesRuleDisableOpLog()">关闭</span></a>
			</div>
		</div>
				
     <br>
     <br>
	<#include "sales/sales_rule_disable_add.ftl">


</div>
</body>
</html>
