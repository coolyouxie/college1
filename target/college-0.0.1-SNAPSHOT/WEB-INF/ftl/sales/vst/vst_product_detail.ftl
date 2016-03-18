<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/ui-common.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/ui-panel.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/iframe.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/button.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/css/normalize.css">
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
		<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
		<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				var $LI = $(".J_list").find("li");
				$IFRAME = $("#iframeMain");
				$LI.click(function () {
					$LI.removeClass("active"); 
					$(this).addClass("active");
				});
				
				$("#vstGoods").parent("li").click(function(){
					$("#iframeMain").attr("src","${request.contextPath}/sales/vst/toVstGoods?vstProductId=${vstProductId}");
				});
				
				$("#vstGoodsTimePrice").parent("li").click(function(){
					$("#iframeMain").attr("src","${request.contextPath}/sales/vst/toVstGoodsTimePrice?vstProductId=${vstProductId}");
				});
				
				$("#vstBasicTrafficFlight").parent("li").click(function(){
					$("#iframeMain").attr("src","${request.contextPath}/sales/vst/toVstBasicTrafficFlight?vstProductId=${vstProductId}");
				});
				
				$("#vstTrafficFlight").parent("li").click(function(){
					$("#iframeMain").attr("src","${request.contextPath}/sales/vst/toVstTrafficFlight?vstProductId=${vstProductId}");
				});
				
				$("#vstProductBranch").parent("li").click(function(){
					$("#iframeMain").attr("src","${request.contextPath}/sales/vst/toVstProductBranch?vstProductId=${vstProductId}");
				});
			});
		</script>
		
	</head>
	<body>
	<div class="pg_topbar">
        <h1 class="pg_title">产品信息&nbsp;&nbsp;&nbsp;&nbsp;产品ID：${vstProductId}</h1>
    </div>
    <div class="pg_aside">
        <div style="overflow-y: auto;" class="aside_box">
        	<input type="hidden" value="${vstProductId}" id="productId">
            <ul class="pg_list J_list">
                <li class="cc1 active">
                	<a id="vstGoods" href="javascript:void(0);" target="iframeMain">商品信息</a>
                </li>
               	<li class="cc1">
                	<a id="vstGoodsTimePrice" href="javascript:void(0);" target="iframeMain">商品时间价格信息</a>
                </li>
                <#--
                <li class="cc1">
                	<a id="vstBasicTrafficFlight" href="javascript:void(0);" target="iframeMain">基础航班信息</a>
                </li>
                -->
                <li class="">
                	<a id="vstTrafficFlight" href="javascript:void(0);" target="iframeMain">航班信息</a>
                </li>
                <li class="cc1">
                	<a id="vstProductBranch" href="javascript:void(0);" target="iframeMain">产品规格</a>
                </li>
            </ul>
        </div>
    </div>
    
    <div class="pg_main">
    	<iframe frameborder="0" style=" height:100%; background:#fff" src="${request.contextPath}/sales/vst/toVstGoods?vstProductId=${vstProductId}" name="iframeMain" id="iframeMain"></iframe>
	</div>
    
	
</body>
</html>