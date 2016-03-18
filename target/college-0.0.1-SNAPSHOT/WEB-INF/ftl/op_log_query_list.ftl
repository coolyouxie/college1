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
		}); 
	
		//查询列表信息   
		function query() {  
			$("#opLogList").jqGrid('setGridParam', {
				url : "${request.contextPath}/queryOpLogListByCondition",
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
				'startTime' : $("#startTime").val(),
				'endTime' : $("#endTime").val(),
				'businessType':$("#businessType").val(),
				'operType':$("#operType").val(),
				'search' : false
			}
		}
	
		function initGrid() {
			$("#opLogList").jqGrid({
				url : "${request.contextPath}/queryOpLogListByCondition",
				datatype : "json",
				mtype : "POST",
				colNames : ['操作时间','操作类型','操作人','业务类型','业务编号','操作详情','备注','操作结果'],
				colModel : [ {
					name : 'createTimeStr',
					index : 'createTimeStr',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'operTypeCnName',
					index : 'operTypeCnName',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'oper',
					index : 'oper',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'businessTypeCnName',
					index : 'businessTypeCnName',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'businessNo',
					index : 'businessNo',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'desc',
					index : 'desc',
					align : 'center',
					sortable:false
				}, {
					name : 'remark',
					index : 'remark',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'result',
					index : 'result',
					align : 'center',
					width :40,
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
			    sortname: 'createTimeStr',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "操作日志列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#opLogList").jqGrid('setGridParam', {
						postData : getParams()
					});
				}
			});
		} 
	</script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 操作日志列表</div>
	<form id="myForm">
		<div class="infor1">
			<div class="visitor message">
				<div class="main">
					<div class="part">
						<span>业务类型：</span>
						<select id="businessType" name="businessType">
							<option value="">全部</option>
							<#list businessTypeEnum as val>  
								<option value="${val}">${val.cnName}</option>
							</#list>
						</select>
						<span class="keyname">操作人类型：</span>
			    	   	<select name="operType" id="operType">
			    	   		<option value="">全部</option>
			    	   		<#list operTypeEnum as val>
						        <option value="${val}">${val.cnName}</option>
						    </#list> 
			    	   	</select>
						<span>起止时间：</span>
						<input type="text" id="startTime" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						 	class="Wdate" readonly="readonly"/>
					</div>
				</div>
			</div>
		</div>
		<div class="click">
				<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
		        <a href="javascript:;"><div class="button" onclick="clearForm()">清空</div></a>
		</div>
		</form>
		  <div class="content1" style="margin-top:50px;">
			<table id="opLogList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	
</body>
</html>