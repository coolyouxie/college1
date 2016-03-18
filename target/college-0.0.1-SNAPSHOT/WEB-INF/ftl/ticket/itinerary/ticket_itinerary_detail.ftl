<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<title>行程单明细</title>
<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script src="${request.contextPath}/js/Calendar.js"></script>
<script type="text/javascript">
	 $(function(){
		initGrid();
		$(".checkall").click(function(){
			if($(".checkall").get()[0].checked){
				$(".c_list input[name='genre']").each(function(){
					$(this).get()[0].checked = true;
				});
			}
			else{
				$(".c_list input[name='genre']").each(function(){
					$(this).get()[0].checked = false;
				});
			}
		});
		
		$(".o_close").click(function(){
			$(".office").css("display","none");
		});
		$(".o_submit .cancle").click(function(){
			$(".office").css("display","none");
		});
	})
			
	function getQueryParams(){
    	return {
			'bspStartNo':$("#bspStartNo").val(),
			'bspEndNo':$("#bspEndNo").val(),
			'operName':$("#operName").val(),
			'startDetailDate':$("#startDetailDate").val(),
			'endDetailDate':$("#endDetailDate").val(),
			'bspStatusRequest':$("#bspStatus").find("option:selected").val(),
			'bspRecycleStatusRequest':$("#bspRecycleStatus").find("option:selected").val()
			}
	}
	
	
	function initGrid() {
		$("#ticketBspDetailList").jqGrid({
			url : "${request.contextPath}/ticket/searchBSPDetail",
			datatype : "json",
			postData : getQueryParams(),
			mtype : "POST",
			height:'auto',//高度，表格高度。可为数值、百分比或'auto'
	        autowidth:true,//自动宽
			colNames:['流水号','行程单号','票号','使用状态','回收状态','office','pnr','会员','操作者','操 作时间','操 作'],
			colModel : [ 
			{name : 'id',index:'id',editable:true,sortable:false,align:'center',width :60},
			{name : 'ticketBSPNo',index:'ticketBSPNo',sortable:false,align:'center'},
			{name : 'ticketNo',index:'ticketNo',sortable:false,align:'center'},
			{name : 'bspStatus',index:'bspStatus',sortable:false,align:'center',width :60},
			{name : 'bspRecycleStatus',index:'bspRecycleStatus',sortable:false,align:'center',width :60},
			{name : 'officeNo',index:'officeNo',sortable:false,align:'center'},
			{name : 'pnr',index:'pnr',sortable:false,align:'center',width :80},
			{name : 'customerName',index:'customerName',sortable:false,align:'center'},
			{name : 'operName',index:'operName',sortable:false,align:'center'},
			{name : 'createTime',index:'createTime',sortable:false,align:'center'},
			{name :'operate',index:'operate',width:120,align:"center",sortable:false}
			],
			
		 	rowNum:10,            //每页显示记录数
		 	autowidth: true,      //自动匹配宽度
		 	pager: '#pager',      //表格数据关联的分页条，html元素
		   	rowList:[10,20,30],   //分页选项，可以下拉选择每页显示记录数
		   	viewrecords: true,    //显示总记录数
			multiselect: true,    //可多选，出现多选框
			autoheight: true,     //设置高度
			gridview:true,        //加速显示
			multiselectWidth: 25, //设置多选列宽度
			sortable:true,        //可以排序
			sortname: 'bspStartNo',  //排序字段名
		    sortorder: "desc",    //排序方式：倒序，本例中设置默认按id倒序排序
			caption : "行程单入库查询",
			
			jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			},
			onPaging : function(pgButton) {
				$("#ticketBspDetailList").jqGrid('setGridParam', {
					postData : getQueryParams()
				});
			},
			
			 gridComplete:function(){  //在此事件中循环为每一行添加修改和删除链接
                    var ids=jQuery("#ticketBspDetailList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var model = jQuery("#ticketBspDetailList").jqGrid('getRowData', id);
                        var operateState=model.bspStatus;
                        var operateRecycle=model.bspRecycleStatus;
                        var operateOne="";
                        var operateTwo="";
                        var operateAjaxOne="";
                        var operateAjaxTwo="";
                        if(operateState=="未使用" && operateRecycle=="未回收"){
                          operateOne="设为已使用";
                          operateAjaxOne="disabledUsedBSPDetailAjax";
                        }if(operateState=="已使用" && operateRecycle=="未回收"){
                          operateOne="设为未使用";
                          operateTwo="作废";
                          operateAjaxOne="disabledUnusedBSPDetailAjax";
                          operateAjaxTwo="invalidBSPDetailAjax";
                        }if(operateState=="已作废" && operateRecycle=="未回收"){
                          operateOne="取消作废";
                          operateTwo="回收";
                          operateAjaxOne="cancelInvalidBSPDetailAjax";
                          operateAjaxTwo="recycleBSPDetailAjax";
                        }
                        operateClick= "<div><a href='#' style='color:#f60' onclick=showBspUsed('"+id+"','"+operateOne+"','"+operateAjaxOne+"')>"+operateOne+"</a>   <a href='#' style='color:#f60' onclick=showBspInvalid('"+id+"','"+operateTwo+"','"+operateAjaxTwo+"')>"+operateTwo+"</a></div>";   
                        jQuery("#ticketBspDetailList").jqGrid('setRowData', ids[i], {operate:operateClick});
                        
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

    //查询列表信息   
	function searchTicketBspDetail() {
		$("#ticketBspDetailList").jqGrid('setGridParam', {
			 url : "${request.contextPath}/ticket/searchBSPDetail",
			 datatype : "json",
			 mtype : "POST",
			 postData : getQueryParams()
		}).trigger("reloadGrid");
	}
	                
	 //显示设为已使用信息   
	function showBspUsed(id,opState,opAjax) {
	    if(opState!="" && opState=="设为已使用"){
	       $(".office").css("display","block");
	       $("#bspOrderNo").val("");
	       $("#bspRemark").val("");
		   $("#checkTicketNo").html("");
		   cleanBspTicket();
		   
	       $(".o_title p").html(opState);
	       $("#bstajaxType").val(opAjax)
		   $("#bspDetailID").val(id);
		   $("#bspDetailState").val(opState)
	    }if(opState!="" && opState=="设为未使用"){
	     if(confirm("确定要将行程单"+id+"重置未使用吗？")){
	        updateTicketBspState(id,opState,opAjax);
	     }
	    }if(opState!="" && opState=="取消作废"){
	     if(confirm("确定要将已作废行程单"+id+"重置为已使用吗？")){
	        updateTicketBspState(id,opState,opAjax);
	     }
	    }
		
	}
	
	 //显示设为作废，回收信息    
	function showBspInvalid(id,opState,opAjax) {
	   if(opState!="" && opState=="作废"){
	      $(".office").css("display","block");
	       $("#bspOrderNo").val("");
	       $("#bspRemark").val("");
		   $("#checkTicketNo").html("");
		   cleanBspTicket();
		   
	       $(".o_title p").html(opState);
	       $("#bstajaxType").val(opAjax)
		   $("#bspDetailID").val(id);
		   $("#bspDetailState").val(opState)
	    }if(opState!="" && opState=="回收"){
	     if(confirm("确定要将行程单"+id+"重置为回收吗？")){
	       updateTicketBspState(id,opState,opAjax);
	     }
	    }
	}
	
	//直接修改状态
	function updateTicketBspState(id,opState,opAjax) {
		 $.ajax({
			url : "${request.contextPath}/ticket/"+ opAjax,
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				id:id
			 }),
			success: function(data){
			   alert(data.message);
			   searchTicketBspDetail();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	}
	
	//验证票号，修改状态
	function updateTicketBspDetail() {
	    var updateId=$.trim($("#bspDetailID").val());
	    var bstajaxType=$.trim($("#bstajaxType").val());
	    var updateState=$.trim($("#bspDetailState").val());
	    
	    var bspTicketID=$.trim($("#bspTicketID").val());
	    var bspOrderID=$.trim($("#bspOrderID").val());
	    var bspTicketNo=$.trim($("#bspTicketNo").val());
	    var bspTicketPnr=$.trim($("#bspTicketPnr").val());
	    var bspRemark=$.trim($("#bspRemark").val());
	    var bspOrderNo=$.trim($("#bspOrderNo").val());
	    
	    if (bspOrderNo=="") {
			alert("请输入正确的订单号！");
			return;
		   }
	    if (bspTicketNo=="") {
			alert("请选择票号信息！！");
			return;
		  } 
	    if (bspTicketID=="" && bspOrderID=="") {
			alert("该票号已存在或者已使用，请输入订单号后选取票号信息！");
			return;
	     } 
	    
		 $.ajax({
			url : bstajaxType,
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				id:updateId,
				ticketId:bspTicketID,
				orderId: bspOrderID,
				bspRemark:bspRemark
			 }),
			success: function(data){
			   alert(data.message);
			   $(".office").css("display","none");
			   searchTicketBspDetail();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
	}
	   
	
		//取消设置
   function cancleTicketBspDetail(){
     $(".office").css("display","none");
   }
   
   
	//验证票号
	function validateBspTicketNo() {
	   var bspDetailStateVal=$("#bspDetailState").val();   
	   if(bspDetailStateVal!="" && bspDetailStateVal=="作废"){
	      return;
	   } 
        var bspTicketID=$.trim($("#bspTicketID").val());
		 $.ajax({
			url : "${request.contextPath}/ticket/validateBspDetailTicketNoAjax",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				ticketId:bspTicketID
			 }),
			success: function(data){
			 alert(data.message);
			if (data != "" && data.status == "SUCCESS") {
				$("#submitBsp").attr("disabled",false);
			  }else{
			     cleanBspTicket();
			     $("#submitBsp").attr("disabled",true);
			  }
   			},error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
             	cleanBspTicket();	
             	$("#submitBsp").attr("disabled",true);
            }
	    });
	}
	
	
	//验证通过订单号获取所有票号，pnr信息
	function searchBspTickInfoByOrderNo() {
        var bspOrderNo=$.trim($("#bspOrderNo").val());
	    if (bspOrderNo=="") {
			alert("请输入正确的订单号！");
			return;
		   }
		 $.ajax({
			url : "${request.contextPath}/ticket/searchBspTickInfoByOrderNoAjax",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				orderNo:bspOrderNo
			 }),
			success: function(data){
			if (data != "" && data.status == "SUCCESS") {
			    var appenStr="";
				$.each(data.results, function(i, value) {
					var ticketNo = value.ticketNo;
					var pnr = value.pnr;
					var orderId = value.flightTicketBSPDetailDto.orderId;
					var ticketId = value.flightTicketBSPDetailDto.ticketId;
					appenStr+='<div class="c_list">'
					+'<input type="radio" name="checkBspTicketNo" id="checkBspTicketNo"  onclick="selectTicketNo()" value="'+ticketNo+'" >'+ticketNo+'</input>'
					+'<input type="hidden" name="bspPnr'+ticketNo+'" id="bspPnr'+ticketNo+'" value="'+pnr+'" />'
					+'<input type="hidden" name="bspOrderId'+ticketNo+'" id="bspOrderId'+ticketNo+'" value="'+orderId+'" />'
					+'<input type="hidden" name="bspTicketId'+ticketNo+'" id="bspTicketId'+ticketNo+'" value="'+ticketId+'" /> </div>';
				})
				$("#checkTicketNo").html(appenStr)
			  }else{
			     alert("该订单号没有对应票号信息，请重新输入");
			     $("#bspOrderNo").val("")
			     $("#checkTicketNo").html("")
			  }
   			},error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
             	$("#checkTicketNo").html("")
            }
	    });
	}
	
// 选择票号信息
function selectTicketNo() {
    cleanBspTicket();
	var ticketNoVal = $("input[name='checkBspTicketNo']:checked").val();
    $("#bspTicketNo").val(ticketNoVal);
	$("#bspTicketID").val($("#bspTicketId"+ticketNoVal).val());
	$("#bspOrderID").val($("#bspOrderId"+ticketNoVal).val());
	$("#bspTicketPnr").val($("#bspPnr"+ticketNoVal).val());
	$("#bspPnr").val($("#bspPnr"+ticketNoVal).val());
	
	validateBspTicketNo();
}

function cleanBspTicket(){
    $("#bspTicketNo").val("")
    $("#bspTicketID").val("");
    $("#bspOrderID").val("");
    $("#bspTicketPnr").val("");
    $("#bspPnr").val("");
   
}
</script> 
</head>
<body>
	<div class="content content1">
	 <form>
	    <input type="hidden" name="bspTicketNo" id="bspTicketNo" />
	    <input type="hidden" name="bspOrderID" id="bspOrderID" />
	    <input type="hidden" name="bspTicketID" id="bspTicketID" />
	    <input type="hidden" name="bspTicketPnr" id="bspTicketPnr" />
	    
	    <input type="hidden" name="bspDetailState" id="bspDetailState" /> 
	    <input type="hidden" name="bspDetailID" id="bspDetailID" />
	    <input type="hidden" name="bstajaxType" id="bstajaxType" />
		<div class="breadnav"><span>首页</span> > 行程单明细</div>
		<div class="cheak">
			<div class="part part1">
				<span>行程单号：</span><input type="text" name="bspStartNo" id="bspStartNo" /> 至 <input type="text" name="bspEndNo" id="bspEndNo" />
				<span>使用状态：</span>
				<select id="bspStatus" name="bspStatus" >
					<#list ticketBSPStatusEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
		     	<span>回收状态：</span>
				<select id="bspRecycleStatus" name="bspRecycleStatus" >
					<#list ticketBSPRecycleStatusEnum as val>
					   <option value="${val}">${val.cnName}</option>
					</#list>  
		     	</select>	
			</div>
			<div class="part part2">
			    <span>入库时间：</span><input type="text" name="startDetailDate" id="startDetailDate" onClick="new Calendar().show(this);" readonly /> 至 <input type="text" name="endDetailDate" id="endDetailDate" onClick="new Calendar().show(this);" readonly />		
				<span>操作员：</span><input type="text" name="operName" id="operName" />
				<div class="click">
					<a href="javascript:void(0);"><div class="button" onclick="searchTicketBspDetail()" >查询</div></a>
				</div>
			</div>
		</div>
	</form>
	</div>
	
	<!-- 暂时不做
	<div id="operClick" >
		<a href="#"><input type="button" class="btn" id="invalid_btn" value="作废" onclick="invalidBspBtn()" /></a>
	    <a href="#"><input type="button" class="btn" id="recycle_btn" value="回收" onclick="recycleBspBtn()" /> </a>
	    <a href="#"><input type="button" class="btn" id="optionsUsed_btn" value="设为已使用" onclick="optionsUsedBspBtn()" /> </a>
	    <a href="#"><input type="button" class="btn" id="regainUsed_btn" value="恢复未使用" onclick="regainUsedBtn()" /> </a>
     </div>
     -->
     
	<div class="content content1">
     <table id="ticketBspDetailList"></table>
     <div id="pager"></div>
     </div>
     <br>
     <br>
     <div style="display:none;">
     
         <select id="ticketStatus_NORMAL">
			<option value="">全部</option>
			<#list orderTicketIssueStatusEnum as val>  
			   	<option value="${val}">${val.cnName}</option>
			</#list>
		</select>
		 
		<select id="ticketStatus_RTVT">
			<option value="">全部</option>
			<#list orderTicketRTVTStatusEnum as val> 
			   	<option value="${val}">${val.cnName}</option>
			</#list>
		</select>	
		 
		<select id="ticketStatus_CTMT">
			<option value="">全部</option>
			<#list orderTicketCTMTStatusEnum as val>  
			    <option value="${val}">${val.cnName}</option>
			</#list>
		</select>	
    
    </div>
     
          
          <div class="office" style="align:center;top:300px;" id="updateBspDetail">
			<div class="o_title">
			<p></p>	
            <span class="o_close">X</span>	
			</div>
			<div class="o_content">
			<div class="ticket_num">
				<div class="t_begin">*订单号：<input type="text" name="bspOrderNo" id="bspOrderNo" onchange="searchBspTickInfoByOrderNo()"/></div>
			</div>
			</div>
			
			<fieldset class="checked">
				<legend class="o_check">*选取票号</legend>
				 <div id="checkTicketNo"></div>
		    </fieldset>
		  
		  <div class="o_content">
		     <div class="ticket_num">
				<div class="t_end">pnr：<input type="text" name="bspPnr" id="bspPnr" readonly/></div>
			 </div>
		  </div>
		
			<div class="o_remark">
				<span>备注：</span><textarea name="bspRemark" id="bspRemark" ></textarea>
			</div>
			<div class="o_submit">
				<a href="javascript:void(0);"><span class="sure" onclick="updateTicketBspDetail()" id="submitBsp">确定</span></a>
				<a href="javascript:void(0);"><span class="cancle" onclick="cancleTicketBspDetail()">取消</span></a>
			</div>
		</div>
</body>
</html>
