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
	<script src="${request.contextPath}/js/Calendar.js"></script>
 	
    <script type="text/javascript">
    
	    $(function (){
			initGrid();
	    });    
		
		//查询列表信息   
		function query() {  
		var startTime=  $("#startTime").val();
		var endTime=  $("#endTime").val();
		
		if(startTime ==''||endTime==''){
			alert("起止时间不能为空");
			return;
		}
		
		
			$("#apiFlowList").jqGrid('setGridParam', {
				url : "${request.contextPath}/apiFlow/queryApiFlowListCount",
				datatype : "json",
				mtype : "POST",
				postData : getParams()
			}).trigger("reloadGrid");
		}
		
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}
	
		function getParams() {
			return {
				'startTime' : $("#startTime").val(),
				'endTime' : $("#endTime").val(),
				'interfaceKey' : $("#interfaceKey").val(),
				'search' : false
			}
		}
	
/* 		function formatLink(cellvalue, options, rowObject) {
		      var url = "${request.contextPath}/order/queryOrderDetail/"+rowObject.orderMainId+"/"+rowObject.orderId+"/"+rowObject.opType;
	          return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
    	}
    	 */
		function initGrid() {
			$("#apiFlowList").jqGrid({
				url : "${request.contextPath}/apiFlow/queryApiFlowListCount",
				datatype : "json",
				mtype : "POST",
				colNames : ['开始日期','截至日期','调用次数','接口'],
				colModel : [ {
					name : 'startTime',
					index : 'startTime',
					align : 'center',
					width :100,
					sortable:false
				}, 
				{
					name : 'endTime',
					index : 'endTime',
					align : 'center',
					width :100,
					sortable:false
				}, {
					name : 'count',
					index : 'count',
					align : 'center',
					sortable:false
				},  {
					name : 'interfaceKeyCnName',
					index : 'interfaceKeyCnName',
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
			    sortname: 'count',  //排序字段名
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
					$("#apiFlowList").jqGrid('setGridParam', {
						postData : getParams()
					});
				}
			});
		} 
	
  </script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 流量明细</div>
	 <form id="myForm">
		<div class="infor1">
			
			<div class="visitor message">
		
				<div class="main">
					<div class="part">
					   
						<span>起止时间：</span><input type="text" value="${startTime}" id="startTime" onClick="new Calendar().show(this);" readonly/>
						 - <input type="text" value="${endTime}" id="endTime" onClick="new Calendar().show(this);" readonly/></span>
						 
						 		<span>接口类型：</span>
						<select id="interfaceKey">
							<#list interfaceKeyEnum as val>  
							   <#if val !="NULL">
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
		       <!-- <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>-->
		</div>
	</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="apiFlowList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 
</body>
</html>