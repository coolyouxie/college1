
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>机票-人工同步数据</title>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/citychoose.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/platfrom.css" />
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript"> 
$(function() {	
		$("#depart").autocomplete({
		 	source: function(request, response) {
               $.ajax({
                   url: "city.do",
                   dataType: "json",
                   data: {cityName:$("#departCity").val()},
                   type:"POST",
                   success: function(data) {
//                 	   var citys = [];
//                 	   for(var i = 0;i<data.cities.length;i++){
// //                 		   alert(data.cities[i].name);
                		  
// 							citys[i]=data.cities[i].name;
                		   
//                 	   }    
                	  debugger;
                	   response($.map(data.cities, function(item) {
                		    return {
	                		     label: item.name,
	                		     value: item.name
                		    };
                		   }));
                   }
               });
            }
        });
		
		
		$("#arrive").autocomplete({
		 	source: function(request, response) {
               $.ajax({
                   url: "city.do", 
                   dataType: "json",
                   data: {cityName:$("#arriveCity").val()},
                   type:"POST",
                   success: function(data) {
//                 	   var citys = [];
//                 	   for(var i = 0;i<data.cities.length;i++){
// //                 		   alert(data.cities[i].name);
                		  
// 							citys[i]=data.cities[i].name;
                		   
//                 	   }    
                	  
                	   response($.map(data.cities, function(item) {
                		    return {
	                		     label: item.name,
	                		     value: item.name
                		    };
                		   }));
                   }
               });
            }
        });
	})
	
	//从51同步数据
	function getFrom51(){
		var toFlightParams = $("#toFlight").val().trim();
		alert(toFlightParams);
		$.ajax({
			url : "${request.contextPath}/vstTaskInit2Solr?params="+toFlightParams,
			cache : false,
			async : false,
			type : "GET",
			datatype : "json",
			success: function(data){
				alert(data);
	   		}
	    });
	}
	
	//向VST推关数据
	function sendToVst(){
		$.ajax({
			url : "${request.contextPath}/vstTaskSend2Vst?params="+toFlightParams,
			cache : false,
			async : false,
			type : "GET",
			datatype : "json",
			success: function(data){
				if (data != "" && data.status == "SUCCESS") {
					alert(data.message);
	   			}
	   		}
	    });
	}

</script>
	
</head>


<body>
<div class="build-wrap">
<input id="sessionUserId" type="hidden" name="sessionUserId" >
    <div class="content01 mt10 memberidentify">
	    
    </div>
    <div class="content01 mt10">
    	<form id="formId" action="${request.contextPath}/search" method="post">
    	<div class="per40 fl">
            <ul>
            	<dl>
                	<dt>拉取航线数据 ：</dt>
                    <dd>
                        <!-- <input name="" type="text" class="input_a per70" /> -->
                        <div>
                          <div>
                          	<input type="text" size="15" id="toFlight" name="toFlight"/>
                          	<div class="search_a" style="color:#fff;" onclick="getFrom51();"><a href="javascript:void(0);">执行</a>
                          </div>
                        </div>
                        <div>例：输入NKG-SYX:2-90:0-22,SYX-NKG:2-90:0-22
                        	 意即拉取 NKG-SYX T+2至T+90的数据，0点到22点之间可执行拉取</div>
                    </dd>
                </dl>
                
            	<dl style="display:none;">
                	<dt>推送到VST：</dt>
                    <dd>
                        <div class="demo">
                          <div>
                          	<input type="text" size="15" id="toVst" name="toVst"/>
                          	<a href="javascript:void(0);" onclick="sendToVst()">执行</a>
                          </div>
                        </div>
                    </dd>
                </dl>
            </ul>
        </div>
        </form>
    </div>
    <div style="height:0" class="jsContainer" id="jsContainer"> 
     <div style="display:none;position:absolute;z-index:999;overflow:hidden;" id="tuna_alert"></div> 
     <div style="visibility:hidden;position:absolute;z-index:120;" id="tuna_jmpinfo"></div> 
     <div style="width: 0px; height: 0px;">
      <div style="display:none;position:absolute;top:0;z-index:120;overflow:hidden;-moz-box-shadow:2px 2px 5px #333;-webkit-box-shadow:2px 2px 5px #333;" id="tuna_address">
       <div id="address_warp">
        <div id="address_message">
         &nbsp;
        </div>
        <div id="address_list">
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
         <a href="###" class="a1"><span>&nbsp;</span>&nbsp;</a>
        </div>
        <div id="address_p" class="address_pagebreak">
         <a name="p" href="javascript:;" id="address_arrowl">&lt;-</a>
         <a class="address_current" name="1" href="javascript:;" id="address_p1">1</a>
         <a name="2" href="javascript:;" id="address_p2">2</a>
         <a name="3" href="javascript:;" id="address_p3">3</a>
         <a name="4" href="javascript:;" id="address_p4">4</a>
         <a name="5" href="javascript:;" id="address_p5">5</a>
         <a name="n" href="javascript:;" id="address_arrowr">-&gt;</a>
        </div>
       </div>
      </div>
     </div>
    </div>
</div>

</body>
</html>
