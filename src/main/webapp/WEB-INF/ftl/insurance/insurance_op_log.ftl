<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
	<title>投保日志</title>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script src="${request.contextPath}/js/Calendar.js"></script>

</head>
  
<body>

	<div class="tankuang">
        <div class="toubaorizhi tk_info">
			<div class="title"><span class="close tk_close" tk-close-name="toubaorizhi"></span>投保日志</div>
			<div class="message">
				<div class="message_title">
					<span class="title1">操作时间</span>
					<span class="title2">操作人</span>
					<span class="title1">操作内容</span>
				</div>
				<#list insuredOpLog as opLog>
					<div class="message_content">
						<span class="title1">${opLog.createTime?string("yyyy-MM-dd hh:mm:ss")}</span>
						<span class="title2">${(opLog.oper)!''}</span>
						<span class="title1">${(opLog.desc)!''}</span>
					</div>
				</#list>
				<span class="close tk_close" tk-close-name="toubaorizhi">关闭</span>
			</div>
		</div>
	</div>


</body>
</html>