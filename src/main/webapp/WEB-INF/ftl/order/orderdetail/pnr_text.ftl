<div class="office" id="pnrText" style="align: center; top: 300px; dispaly: none; border: 1px solid #e6e6e6;width:500px">
	<div class="o_title">PNR文本<span class="o_close" id="closePnrText" onclick="closePnrText()">X</span></div>
	<div class="o_content" style="text-align: left;">
		<table border="1px">
			<#if flightOrderPNRInfo??>
				<#list flightOrderPNRInfo as PNRInfo>
					<tr>
					    <input type="hidden" name="pnrId" value="${PNRInfo.id}" id="pnrId"/>
						<td style="text-align: left; width: 150px">
							<span>&nbsp;&nbsp;&nbsp;&nbsp;PNR:</span>
						</td>
						<td style="text-align: left; width: 350px">
							&nbsp;<input id="pnr" type="text" readonly="readonly" value="${(PNRInfo.pnr)!''}"></input>
						</td>
					</tr>
					<tr>
						<td style="text-align: left; width: 150px">
							<span>&nbsp;&nbsp;&nbsp;&nbsp;PNR文本:</span>
						</td>
					    <td style="width: 200px">
							<textarea id="pnrTxt" rows="5" cols="38">${(PNRInfo.pnrTxt)!''}</textarea>
				        </td>
				     </tr>
				 </#list>
			 </#if>
		</table>
	</div>
	<div class="o_submit">
		<a href="javascript:void(0);"><span class="cancle" onclick="savePnrText('${request.contextPath}/order/savePnrText')">保存</span></a>
		<a href="javascript:void(0);"><span class="cancle" onclick="closePnrText()">关闭</span></a>
	</div>
</div>
