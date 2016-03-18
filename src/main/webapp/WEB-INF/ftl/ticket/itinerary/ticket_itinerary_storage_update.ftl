<div class="main" style="align" id="updateStorageForm">
		<div class="office">
			<div class="o_title">
				行程单修改<span class="o_close">X</span>	
			</div>
			<div class="o_content">
				<div class="ticket_num">
					<div class="t_begin">*起始票号：<input type="text" name="updateBspStartNos" id="updateBspStartNos" /></div>
					<div class="t_end">*终止票号：<input type="text" name="updateBspEndNos" id="updateBspEndNos" onblur="getCount()"/></div>
				</div>
				<div class="o_totle">合计张数：<span>0</span></div>
			</div>
			<fieldset class="checked">
				<legend class="o_check">
					*入库OFFICE         <input type="checkbox" class="checkall">全选
				</legend>
				<#list officeList as office>
				<div class="c_list"><input type="checkbox" name="genre" id="genre" value="${office.officeNo}">${office.officeNo}</div>
				</#list>
			</fieldset>	
			<div class="o_remark">
				<span>备注：</span><textarea name="bspRemark" id="bspRemark" ></textarea>
			</div>
			<div class="o_submit">
				<a href="#"><span class="sure" onclick="addTicketBspStorage()">确定</span></a>
				<a href="#"><span class="cancle" onclick="cancleTicketBspStorage()">取消</span></a>
			</div>
		</div>
	</div>