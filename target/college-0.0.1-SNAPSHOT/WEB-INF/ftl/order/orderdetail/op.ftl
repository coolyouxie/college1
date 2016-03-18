<div class="choose">
<#if operateMap??>
	<#list operateMap?keys as operatekey>
		 <#if operatekey="opLog">
			 <a  href="${request.contextPath}/order/toOrderRemarkList/${base.orderMainId}/${base.orderId}"  target="_blank">
			   <div class="button" id="opLog" value="${operateMap[operatekey].opLevel.cnName}">${operateMap[operatekey].desc}</div>
		    </a>
	    	</#if>
	    <#if operatekey="opRemark">
			 <a   href="${request.contextPath}/toOrderOpLogListPage/${base.orderId}"  target="_blank">
				<div class="button" id="opRemark" value="${operateMap[operatekey].opLevel.cnName}">${operateMap[operatekey].desc}</div>
			</a>
	  	</#if>
	
		<#if operatekey="waitCancel">
				<a href="javascript:void(0);"  onclick="openLimitDialog()">
					<div class="button" id="editlimtDialogButton" value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}</div>
				</a>
		   	</#if>
		<#if operatekey="bookingAgain">
				<a href="javascript:void(0);"  onclick="verifyBookingAgain('${request.contextPath}/bookingAgain/verify')">
					<div class="button" id="bookingAgainButton"  value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}</div>
				</a>
		    </#if>
		 <#if operatekey="applyCTMT">
				<a href="${request.contextPath}/ticket/ctmt/apply/${base.orderMainId}/${base.orderId}">
					<div class="button" id="ctmtApply" value="${operateMap[operatekey].opLevel.cnName}">${operateMap[operatekey].desc}</div>
				</a>
     	</#if>
		<#if operatekey="applyRTVT">
			   <a href="${request.contextPath}/ticket/rtvt/apply/${base.orderMainId}/${base.orderId}"  >
				<div class="button" id="rtvtApply" value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}</div>
			  </a>
	     </#if>
		 
		<#if operatekey="applySuppRTVT">
			<a href="javascript:void(0);"  onclick="applySuppRTVT('${request.contextPath}/ticket/rtvt/applySuppRTVT/${base.orderId}')">
				<div class="button" id="applySuppRTVT" value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}</div>
			</a>
		</#if>
		<#if operatekey="syncSuppIssue">
			<a href="javascript:void(0);"  onclick="syncSuppIssue('${request.contextPath}/ticket/issue/syncSuppIssue')">
				<div class="button" id="syncSuppIssueButton" value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}</div>
			</a>
		</#if>
		<#if operatekey="syncSuppRTVT">
			<a href="javascript:void(0);"  onclick="syncSuppRTVT('${request.contextPath}/ticket/rtvt/manualSyncSuppRTVT')">
				<div class="button" id="syncSuppRTVTButton" value="${operateMap[operatekey].opLevel.cnName}" >${operateMap[operatekey].desc}/div>
			</a>
		</#if>
		<!-- 审核通过 -->
		<#if operatekey="auditPass">
		<#if opType == "ISSUE">
			<a href="javascript:void(0);"  onclick="issueAuditPass('${request.contextPath}/ticket/issue/auditPass')">
				<div class="button" id="issueAuditPass" value="${operateMap[operatekey].opLevel.cnName}" >审核通过</div>
			</a>
		<#elseif opType = "CTMT">
		    <a href="javascript:void(0);"  onclick="ctmtAuditPass('${request.contextPath}/ticket/ctmt/auditPass')">
				<div class="button" id="ctmtAuditPass" value="${operateMap[operatekey].opLevel.cnName}" >审核通过</div>
			</a>
		<#elseif opType = "RTVT">
		    <a href="javascript:void(0);"  onclick="rtvtAuditPass('${request.contextPath}/ticket/rtvt/auditPass')">
				<div class="button" id="rtvtAuditPass" value="${operateMap[operatekey].opLevel.cnName}" >审核通过</div>
			</a>
		</#if>
		</#if>
		
		<!-- 审核驳回 -->
		<#if operatekey="auditReject">
		<#if opType == "ISSUE">
			<a href="javascript:void(0);"  onclick="issueAuditReject('${request.contextPath}/ticket/issue/auditReject')">
				<div class="button" id="issueAuditReject" value="${operateMap[operatekey].opLevel.cnName}" >审核驳回</div>
			</a>
		<#elseif opType = "CTMT">
		   	<a href="javascript:void(0);"  onclick="ctmtAuditReject('${request.contextPath}/ticket/ctmt/auditReject')">
				<div class="button" id="ctmtAuditReject" value="${operateMap[operatekey].opLevel.cnName}" >审核驳回</div>
			</a>
		<#elseif opType = "RTVT">
		    <a href="javascript:void(0);"  onclick="rtvtAuditReject('${request.contextPath}/ticket/rtvt/auditReject')">
				<div class="button" id="rtvtAuditReject" value="${operateMap[operatekey].opLevel.cnName}" >审核驳回</div>
			</a>
		</#if>
		</#if>
		
		<!-- 处理通过 -->
		<#if operatekey="opPass">
			<#if opType == "ISSUE">
			<a href="javascript:void(0);"  onclick="issueOpPass('${request.contextPath}/ticket/issue/opPass')">
				<div class="button" id="issueOpPass" value="${operateMap[operatekey].opLevel.cnName}" >出票完成</div>
			</a>
		<#elseif opType = "CTMT">
		   	<a href="javascript:void(0);"  onclick="ctmtOpPass('${request.contextPath}/ticket/ctmt/opPass')">
				<div class="button" id="ctmtOpPass" value="${operateMap[operatekey].opLevel.cnName}" >改签完成</div>
			</a>
		<#elseif opType = "RTVT">
		    <a href="javascript:void(0);"  onclick="rtvtOpPass('${request.contextPath}/ticket/rtvt/opPass')">
				<div class="button" id="rtvtOpPass" value="${operateMap[operatekey].opLevel.cnName}" >退票完成</div>
			</a>
		</#if>
		</#if>
		
		<!-- 处理驳回 -->
		<#if operatekey="opReject">
			<#if opType == "ISSUE">
			<a href="javascript:void(0);"  onclick="issueOpReject('${request.contextPath}/ticket/issue/opReject')">
				<div class="button" id="issueOpReject" value="${operateMap[operatekey].opLevel.cnName}" >出票驳回</div>
			</a>
		<#elseif opType = "CTMT">
		   	<a href="javascript:void(0);"  onclick="ctmtOpReject('${request.contextPath}/ticket/ctmt/opReject')">
				<div class="button" id="ctmtOpReject" value="${operateMap[operatekey].opLevel.cnName}" >改签驳回</div>
			</a>
		<#elseif opType = "RTVT">
		    <a href="javascript:void(0);" onclick="rtvtOpReject('${request.contextPath}/ticket/rtvt/opReject')">
				<div class="button" id="rtvtOpReject" value="${operateMap[operatekey].opLevel.cnName}" >退票驳回</div>
			</a>
		</#if>
		</#if>
		     
		</#list>
	  </#if>
  
</div>
