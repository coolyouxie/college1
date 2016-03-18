<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
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
			
		//清空查询信息   
	   $("#cleanRemark").click(function() {
			document.getElementById("myForm").reset()
	   });
	    });    
		
		//查询列表信息   
		function query() { 
       		
			$("#insuranceInfoList").jqGrid('setGridParam', {
				url : "queryinsuranceInfoList",
				datatype : "json",
				mtype : "POST",
				postData : getInsuranceInfoParams()
			}).trigger("reloadGrid");
		}
		
		function getInsuranceInfoParams() {
			return {
				'insuranceClass.name' : $('#insuranceName').find("option:selected").text(),
				'supp.id' : $('#suppName').val(),
				'startUpdateTime' : $("#startUpdateTime").val(),
				'endUpdateTime' : $("#endUpdateTime").val(),
				'search':false
			}
		}
		
		function initGrid() {
			$("#insuranceInfoList").jqGrid({
				url : "queryinsuranceInfoList",
				datatype : "json",
				mtype : "POST",
				colNames : ['供应商','产品名称','修改时间','操作'],
				colModel : [ {
					name : 'supp.name',
					index : 'suppName',
					align : 'center',
					width :200,
					sortable:false
				}, {
					name : 'insuranceClass.name',
					index : 'insuranceName',
					align : 'center',
					sortable:false
				}, {
					name : 'updateDate',
					index : 'updateDate',
					align : 'center',
					sortable:false
				}, {
					name : 'operate',
					index : 'operate',
					align : 'center',
					sortable:false
				}],
				rowNum: 10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			   // autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'updateDate',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '保险产品列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#insuranceInfoList").jqGrid('setGridParam', {
						postData : getInsuranceInfoParams ()
					});
				},
				gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#insuranceInfoList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                        operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a> <a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="deleteInsurance('+id+')" >删除</a>';
                        jQuery("#insuranceInfoList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		
		//查看操作日志
		function operateLog(id) {
		   	window.open("${request.contextPath}/toOpLogListPage/"+id+"/INSURANCE_PRO");
		}
		
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/insurance/queryInsuranceInfoDetail/"+id);
		}
		 
		//删除
		function deleteInsurance(id) {
		   	$.ajax({
				url : 'deleteInsurance/'+id,
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
					id : id
				}),
				success: function(data){
					if(data.status == 'INVALID'){
						alert("保险产品删除成功");
						window.location.reload();
					}
	   			}
		    });
		    
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
	
  </script>
    
  </head>
  <body>
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 保险产品列表</div>
	  <form id="myForm" autocomplete="off" >
		<div class="cheak">
			<div class="part part1">
				<span>供应商：</span><select name="suppName" id="suppName" onblur="getInsurance()">
						<#list supps as supp>
							<option value="${(supp.id)!''}">${(supp.name)!''}</option>
						</#list>
					</select>
				<span>产品名称：</span><select name="insuranceName" id="insuranceName">
					</select>
				<span>修改时间：</span><input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/> - 
				        <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
							class="Wdate" readonly="readonly"/>
				<div class="click">
					<a href="javascript:;" ><div class="button" onclick="query()">查询</div></a>
					<a href="javascript:;" id = "cleanRemark" ><div class="button" >清空</div></a>
				</div>
			</div>
		</div>
	  </form>
	</div>

	 <div class="content content1">
      <table id="insuranceInfoList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
	 
</body>
</html>
