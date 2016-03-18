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
			var remark=  $("#remark").val();
			
			if(remark != '' && remark.length < 4){
				alert("若要按手机号查询，请至少输入4位手机号!");
				return;
			}
			$("#smsLogList").jqGrid('setGridParam', {
				url : "${request.contextPath}/sms/querySmsLogList",
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
				'remark' : $("#remark").val(),
				'businessNo':$("#businessNo").val(),
				'result':$("#result").val(),
				'search' : false
			}
		}
	
		function initGrid() {
			$("#smsLogList").jqGrid({
				url : "${request.contextPath}/sms/querySmsLogList",
				datatype : "json",
				mtype : "POST",
				colNames : ['发送时间','发送状态','手机号','短信类型','短信内容'],
				colModel : [ {
					name : 'createTimeStr',
					index : 'createTimeStr',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'resultCnName',
					index : 'resultCnName',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'businessNo',
					index : 'businessNo',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'remark',
					index : 'remark',
					align : 'center',
					width :60,
					sortable:false
				}, {
					name : 'desc',
					index : 'desc',
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
			    sortname: 'createTimeStr',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : "短信日志列表",
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#smsLogList").jqGrid('setGridParam', {
						postData : getParams()
					});
				}
			});
		} 
	</script>
</head>
<body>
	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 短信列表</div>
	<form id="myForm">
		<div class="infor1">
			<div class="visitor message">
				<div class="main">
					<div class="part">
						<span>短信类型：</span>
						<select id="businessNo" name="businessNo">
							<option value="">全部</option>
							<#list businessNoEnum as val>  
							   <#if val !="NULL">
							       <option value="${val}">${val.cnName}</option>
							   </#if>
							</#list>
						</select>
						<span>发送状态：</span>
						<select id="result" name="result">
							<option value="">全部</option>
							<#list resultEnum as val>  
								<option value="${val}">${val.cnName}</option>
							</#list>
						</select>
						<span>起止时间：</span>
						<input type="text" id="startTime" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
						 - 
						<input type="text" id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						 	class="Wdate" readonly="readonly"/>
						   
						<span>手机号：</span>
						<input type="text" value="" id="remark" maxlength="11" />
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
			<table id="smsLogList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	 
</body>
</html>