       <div class="office" style="align:center;top:300px;" id="addBspStroage">
			<div class="o_title">
				行程单入库<span class="o_close">X</span>	
			</div>
			<div class="o_content">
				<div class="ticket_num">
					<div class="t_begin">*起始单号：<input type="text" name="bspStartNos" id="bspStartNos" /></div>
					<div class="t_end">*终止单号：<input type="text" name="bspEndNos" id="bspEndNos" onblur="getCount()"/></div>
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
	
	<script type="text/javascript">
	function getCount(){
	 var bspStartNoVal=$.trim($("#bspStartNos").val());
	 var bspEndNoVal = $("#bspEndNos").val();
	 var count=0;
	 if(bspStartNoVal!="" && bspEndNoVal!=""){
	   count=bspEndNoVal-bspStartNoVal+1;
	 }
	 $(".o_totle span").html(count);
	}


   //添加行程单
   function addTicketBspStorage(){
     var bspStartNoVal=$.trim($("#bspStartNos").val());
     if (bspStartNoVal=="") {
		alert("请添加起始票号");
		return;
	   }
     var bspEndNoVal = $("#bspEndNos").val();
     if (bspEndNoVal=="") {
		alert("请添加终止票号");
		return;
	   }
	   var re = new RegExp(/^[0-9]*$/);
		if(!re.test(bspStartNoVal) || !re.test(bspEndNoVal)){
			alert('票号输入错误，必须为数字');
			return;
		}
     var bspRemarkVal = $("#bspRemark").val();
     var officeNosVal="";	
     $(".c_list input[name='genre']").each(function(){ 
         if($(this).get()[0].checked){
         officeNosVal+=$(this).val()+","; 
         }
	}) 
	
	if(officeNosVal!="" && officeNosVal!=null){
	  officeNosVal=officeNosVal.substring(0,officeNosVal.length-1)
	}else{
        alert("请选择入库office号");
		return;
      }
      
     $.ajax({
			url : "${request.contextPath}/ticket/saveBSPStore",
			type:'post',
	        dataType : "json",
			contentType : "application/json;",
			data : JSON.stringify({
				bspStartNo:bspStartNoVal,
				bspEndNo:bspEndNoVal,
				bspRemark:bspRemarkVal,
				officeNo:officeNosVal
				}),
			success: function(data){
			   alert(data.message);
			   $(".office").css("display","none");
			   searchTicketStorage();
   			},
   			error: function (data) {
             	alert(eval('(' + data.responseText + ')').message);
            }
	    });
   }
   
   function cancleTicketBspStorage(){
     $(".office").css("display","none");
   }
 </script>
