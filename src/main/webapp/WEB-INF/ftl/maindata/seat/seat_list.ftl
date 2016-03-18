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
			getSeatClasses();
		}); 
	
		//查询列表信息   
		function query() {  
			//var carrierCode=  $("#carrierCode").val();
			//var code=  $("#code").val();
			
			$("#seatList").jqGrid('setGridParam', {
				url : "${request.contextPath}/maindata/seat/querySeatList",
				datatype : "json",
				mtype : "POST",
				postData : getParams()
			}).trigger("reloadGrid");
		}
		
		//清空查询信息   
		function clearForm() { 
			document.getElementById("myForm").reset()
		}
	
		function getParams() {
			return {
				'carrierCode' : $("#carrierCode").val(),
				'code' : $("#code").val(),
				'search' : false
			}
		}
	
		function initGrid() {
			$("#seatList").jqGrid({
				url : "${request.contextPath}/maindata/seat/querySeatList",
				datatype : "json",
				mtype : "POST",
				colNames : ['序号','航空公司','舱位代码','基准舱位','舱位等级','舱位说明','舱位折扣','退改签说明','热度','备注说明','操作'],
				colModel : [ {
					name : 'id',
					index : 'id',
					align : 'center',
					
					sortable:false
				}, {
					name : 'carrierCode',
					index : 'carrierCode',
					align : 'center',
					
					sortable:false
				}, {
					name : 'code',
					index : 'code',
					align : 'center',
					sortable:false
				}, {
					name : 'seatClassType',
					index : 'seatClassType',
					align : 'center',
					sortable:false
				}, {
					name : 'seatClassTypeCnName',
					index : 'seatClassTypeCnName',
					align : 'center',
				
					sortable:false
				}, {
					name : 'name',
					index : 'name',
					align : 'center',
				
					sortable:false
				}, {
					name : 'flightTicketPriceDto.discount',
					index : 'flightTicketPriceDto.discount',
					align : 'center',
					
					sortable:false,
					formatter:function(v){
                         return (v*100).toFixed(0)+"%";
                   } 
				}, {
					name : 'ticketRule',
					index : 'ticketRule',
					align : 'center',
					sortable:false
				}, {
					name : 'hot',
					index : 'hot',
					align : 'center',
					sortable:false
				}, {
					name : 'seatRemark',
					index : 'seatRemark',
					align : 'center',
					sortable:false
				}, {
					name : 'operate',
					index : 'operate',
					align : 'center',
					
					sortable:false
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
			    sortname: 'discount',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "舱位列表",
				jsonReader : {
					root : "results",               // json中代表实际模型数据的入口  
					page : "pagination.page",       // json中代表当前页码的数据   
					records : "pagination.records", // json中代表数据行总数的数据   
					total:'pagination.total',       // json中代表页码总数的数据 
					repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#seatList").jqGrid('setGridParam', {
						postData : getParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改链接
                    var ids=jQuery("#seatList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                        operateClick= '<a href="#" style="color:blue" onclick="update('+id+')" >修改</a>';
                        jQuery("#seatList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		}
		
		//新增
		function add() {
		   	window.open("${request.contextPath}/maindata/seat/getSeat/0");
		}
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/maindata/seat/getSeat/"+id);
		}
		
		//根据carrierCode查询舱位
		function getSeatClasses() {
			$("#code option").remove();
			$("#code").append("<option value=''>不限</option>");
			if($("#carrierCode").val() != ""){
				var str="";
			    $.ajax({
					url : "${request.contextPath}/maindata/seat/getSeatsByCarrierCode/"+$("#carrierCode").val(),
					type:'post',
			        dataType : "json",
					contentType : "application/json;",
					success: function(data){
						jQuery.each(data, function(i,item){    
							str+="<option value='"+item.code+"'>"+item.code+"</option>"; 
				        }); 
						$("#code").append(str);
					}	
			    });
			}
		 }
	</script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 舱位</div>
	<form id="myForm">
		<div class="infor1">
			<div class="visitor message">
				<div class="main">
					<div class="part">
						<span>航空公司：</span>
						<select name="carrierCode" id="carrierCode" onChange="getSeatClasses()">
							<option value="">全部</option>
							<#list carriers as carrier>
								<option value="${(carrier.code)!''}">${(carrier.code)!''}</option>
							</#list>
						</select>
						<span>舱位代码：</span>
						<select name="code" id="code">
							
						</select>
						<div style="float:right;">
						<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		        		<a href="javascript:;"><div class="button" onclick="add()">新增</div></a> 
		        		</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="seatList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 
</body>
</html>