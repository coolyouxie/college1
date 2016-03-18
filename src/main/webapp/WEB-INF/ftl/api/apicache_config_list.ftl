<!DOCTYPE html>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
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
		
	//查询列表信息   
	function searchApiCacheConfig() {  
		var startTime=  $("#startTime").val();
		var endTime=  $("#endTime").val();
		
		if(startTime ==''||endTime==''){
			alert("起止时间不能为空");
			return;
		}
		
		$("#apiCacheConfigList").jqGrid('setGridParam', {
			url : "${request.contextPath}/api/queryApiCacheConfig",
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
				'cacheKey' : $("#cachekey").val(),
				'search' : false
			}
		}
	

		function initGrid() {
			$("#apiCacheConfigList").jqGrid({
				url : "${request.contextPath}/api/queryApiCacheConfig",
				datatype : "json",
				mtype : "POST",
				colNames : ['Key','查询次数','查询cache次数','cache数量限制','cache时间限制','cacheKey','cache有效期限制',"最后查询时间",'查询cache时间','创建时间','操 作'],
				colModel : [ 
				 {
					name : 'queryKey',
					index : 'queryKey',
					align : 'center',
					width :40,
					sortable:false
				},
				{
					name : 'accCount',
					index : 'accCount',
					align : 'center',
					width :30,
					sortable:false
				}, 
				{
					name : 'apiCount',
					index : 'apiCount',
					align : 'center',
					width :30,
					sortable:false
				},  {
					name : 'queryApiCountLimit',
					index : 'queryApiCountLimit',
					align : 'center',
					width :30,
					sortable:false
				}, {
					name : 'queryApiTimeLimit',
					index : 'queryApiTimeLimit',
					align : 'center',
					width :40,
					sortable:false
				}, {
					name : 'cacheKey',
					index : 'cacheKey',
					align : 'cacheKey',
					width :30,
					sortable:false
				}, {
					name : 'queryApiPeriodTimeLimit',
					index : 'queryApiPeriodTimeLimit',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'lastQueryTime',
					index : 'lastQueryTime',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'lastQueryApiTime',
					index : 'lastQueryApiTime',
					align : 'center',
					width :50,
					sortable:false
				}, {
					name : 'createTime',
					index : 'createTime',
					align : 'center',
					width :50,
					sortable:false
				},{
					name :'operate',
					index:'operate',
					width:30,
					align:"center",
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
				multiselect : true,   //是否设置全选按钮
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
					$("#apiCacheConfigList").jqGrid('setGridParam', {
						postData : getParams()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加修改操作
                    var ids=jQuery("#apiCacheConfigList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                        operateClick= '<a href="#" style="color:blue" onclick="showUpdateCacheConfig('+id+')" >修改</a>';
                        jQuery("#apiCacheConfigList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		
   //打开修改配置窗口
   function showUpdateCacheConfig(id){
      $("#cacheId").val(id);
	  $("#showUpdateCache").css("display","block");
	}
	
	//取消修改操作
   function cancleUpdateCache(){
     $("#showUpdateCache").css("display","none");
   }
	
   //修改配置
   function updateApiCacheConfig(){
     var queryApiCountLimitVal=$.trim($("#queryApiCountLimit").val());
     var cacheIdVal=$("#cacheId").val();
     if (queryApiCountLimitVal=="") {
		alert("请输入cache数量限制！");
		return;
	   }
	   
     var queryApiPeriodTimeLimitVal = $("#queryApiPeriodTimeLimit").val();
     if (queryApiPeriodTimeLimitVal=="") {
		alert("请输入cache有效期限制！");
		return;
	   }
      
     $.ajax({
			url : "${request.contextPath}/api/updateApiCacheConfig",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
			    id:cacheIdVal,
				queryApiPeriodTimeLimit:queryApiPeriodTimeLimitVal,
				queryApiCountLimit:queryApiCountLimitVal
				}),
			success: function(data){
			   alert(data.message);
			   $(".office").css("display","none");
			   searchApiCacheConfig();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
   }
   
 
     //删除的对象
	function getCacheConfigIdList(rowDataVal){
		var apiCacheList = new Array();
		rowDataVal = rowDataVal + '';
		var result=rowDataVal.split(",");
		for(var i=0;i<result.length;i++){
		  var obj = new Object;
		  obj = result[i];
		  apiCacheList[i] = obj;
		}
		return apiCacheList;
	}
	
	
   //批量删除
   function batchRemoveCache(){
	   var rowData = jQuery('#apiCacheConfigList').jqGrid('getGridParam','selarrrow');
	   if(rowData==""){
	      alert("请选取需要删除的数据！");
	      return;
	   }

	    $.ajax({
			url : "${request.contextPath}/api/batchDeleteApiCacheConfig",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
			    apiCacheList:getCacheConfigIdList(rowData)
				}),
			success: function(data){
			   alert(data.message);
			   searchApiCacheConfig();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	   
	}
	
   //打开添加配置窗口
   function showAddCache(){
	  $("#showAddCache").css("display","block");
	  $("#add_queryKey").val("");
	  $("#add_cacheKey").val("");
	  $("#add_accCount").val("");
	  $("#add_apiCount").val("");
	 $("#add_queryApiCountLimit").val("");
	 $("#add_queryApiTimeLimit").val("");
	 $("#add_queryApiPeriodTimeLimit").val("");
	}
	
	//取消添加操作
   function cancleAddCache(){
     $("#showAddCache").css("display","none");
     
   }
   
   
    //添加缓存配置
   function addAipCacheConfig(){
   
    var queryKeyVal=$.trim($("#add_queryKey").val());
     if (queryKeyVal=="") {
		alert("请输入key值！");
		$('#add_queryKey').focus();
		return;
	   }
	   
	var cacheKeyVal=$.trim($("#add_cacheKey").val());
     if (cacheKeyVal=="") {
		alert("请输入cache的key值！");
		$('#add_cacheKey').focus();
		return;
	   }
	   
	var accCountVal=$.trim($("#add_accCount").val());
     if (accCountVal=="") {
		alert("请输入查询次数！");
		$('#add_accCount').focus();
		return;
	   }
	   
	 var apiCountVal=$.trim($("#add_apiCount").val());
     if (apiCountVal=="") {
		alert("请输入查询cache次数！");
		$('#add_apiCount').focus();
		return;
	   }
	   
	var queryApiCountLimitVal=$.trim($("#add_queryApiCountLimit").val());
     if (queryApiCountLimitVal=="") {
		alert("请输入cache数量限制！");
		$('#add_queryApiCountLimit').focus();
		return;
	   }
	   
	 var queryApiTimeLimitVal=$.trim($("#add_queryApiTimeLimit").val())+"";
     if (queryApiTimeLimitVal=="") {
		alert("请输入cache时间限制！！");
		$('#add_queryApiTimeLimit').focus();
		return;
	   }
	   
     var queryApiPeriodTimeLimitVal=$.trim($("#add_queryApiPeriodTimeLimit").val());
     if (queryApiCountLimitVal=="") {
		alert("请输入cache有效期限制！！");
		$('#departCity').focus();
		return;
	   }
      
     $.ajax({
			url : "${request.contextPath}/api/insertApiCacheConfig",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
			    queryKey:queryKeyVal,
			    cacheKey:cacheKeyVal,
			    accCount:accCountVal,
			    apiCount:apiCountVal,
			    queryApiCountLimit:queryApiCountLimitVal,
				queryApiPeriodTimeLimit:queryApiPeriodTimeLimitVal,
				queryApiTimeLimit:queryApiTimeLimitVal
				}),
			success: function(data){
			   alert(data.message);
			   $("#showAddCache").css("display","none");
			   searchApiCacheConfig();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
   }
   
   
  </script>
</head>
<body>
	<div class="content content1">
	<input type="hidden" name="cacheId" id="cacheId" />
	<div class="breadnav"><span>首页</span> > 缓存配置</div>
	 <form id="myForm">
		<div class="infor1">
			
			<div class="visitor message">
		
				<div class="main">
					<div class="part">
					   
						<span>起止时间：</span><input type="text" value="${startTime}" id="startTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						 - <input type="text" value="${endTime}" id="endTime" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						 </span>
						  &nbsp;&nbsp; Key：<input type="text" name="cachekey" id="cachekey" length="300px" />
					</div>
				</div>
			</div>
			
		</div>
		<div class="click">
				<a href="javascript:void(0);"><div class="button" onclick="searchApiCacheConfig()">查询</div></a> 
		        <a href="javascript:void(0);"><div class="button" onclick="showAddCache()">新增</div></a>
		</div>
	    </form>
	    
	    <div class="click" style="float:left;">
		    <a href="javascript:void(0);"><div class="button"  style="width:70px;" onclick="batchRemoveCache()">批量删除</div> </a>
		</div>	
		
		  <div class="content1" style="margin-top:50px;">
			<table id="apiCacheConfigList"></table>
	        <div id="pager"></div>
          </div>
        <br>
        <br>
	</div>
	
	<div class="office" style="align:center;top:300px;" id="showUpdateCache">
			<div class="o_title">
				缓存设置<span class="o_close">X</span>	
			</div>
			<div class="o_content">
				<div class="ticket_num">
				<div class="t_begin">*cache数量限制：<input type="text" name="queryApiCountLimit" id="queryApiCountLimit" /></div>
				<div class="t_end">*cache有效期限制：<input type="text" name="queryApiPeriodTimeLimit" id="queryApiPeriodTimeLimit" />秒</div>	
				</div>
			</div>
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="updateApiCacheConfig()">修改</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleUpdateCache()">取消</span></a>
			</div>
		</div>
	</div>
	
	
	<div class="office" style="align:center;top:300px;" id="showAddCache">
			<div class="o_title">
				添加缓存配置<span class="o_close">X</span>	
			</div>
			<div class="o_content">
		     <div class="ticket_num">
				<div class="t_begin">*Key：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="add_queryKey" id="add_queryKey" /></div>
				<div class="t_begin">*cacheKey：&nbsp;&nbsp;&nbsp;<input type="text" name="add_cacheKey" id="add_cacheKey" /></div>
				<div class="t_begin">*查询次数：&nbsp;&nbsp;&nbsp;<input type="text" name="add_accCount" id="add_accCount" /></div>
				<div class="t_begin">*查询cache次数：<input type="text" name="add_apiCount" id="add_apiCount" /></div>
				<div class="t_begin">*cache数量限制：<input type="text" name="add_queryApiCountLimit" id="add_queryApiCountLimit" /></div>
				<div class="t_begin">*cache时间限制：<input type="text" name="add_queryApiTimeLimit" id="add_queryApiTimeLimit" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/></div>
				<div class="t_begin">*cache有效期限制：<input type="text" name="add_queryApiPeriodTimeLimit" id="add_queryApiPeriodTimeLimit" /></div>
			 </div>
		  </div>
		  <div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="addAipCacheConfig()">添加</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleAddCache()">取消</span></a>
			</div>
		</div>
	</div>
	 
</body>
</html>
