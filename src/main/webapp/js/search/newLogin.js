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
	
	//核对用户输入的账号
	function checkAccount(){
		var searchName= $.trim($("#searchName").val());
		if($.trim(searchName)==''){
			alert("请输入信息识别用户帐号");
			return;
		}
       	$.post("/loginUser/queryUserMember",{"paramValue":searchUser},function(data){
			 $("#search_user_list").html(data);
		});
		}
		
		//点击注册用户，显示注册文本
	function showRegUserAccount(){
	   $("#regist_userMobile").show();
	   $("#search_user_list").hide();
	   $("#searchName").val("");
	
	}
	
	//注册用户
	function regUserAccount(){
		var userPhone = $.trim($("#userPhone").val());
		if($.trim(userPhone)==''){
			alert("请输入11位电话号码");
			return;
		}
		$.ajax({
			url : '/loginUser/registUserMember',
			cache : false,
			async : false,
			data : {
				"mobileNumber":userPhone
				},
			type : "POST",
			datatype : "json",
			success: function(data){
			  if(data!=""){
			  	    $("#regist_userMobile").hide();
					alert("注册成功");
				}else{
					alert("注册失败");
				}
   			}
	    });
	}