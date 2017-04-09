$(function(){
	$("#propertyGroupId").val($(".groupName").val());
	$(".groupName").change(function(){
		var id = $(this).val();
	//	alert("id="+id);
		document.getElementById("propertyGroupId").value = id;
	//s	alert("000");
	})
	//复选框-单属性值模板
	function publicAttrHtml(){
//		var opName = opName || '';
//		var opValue = opValue || '';
		var attrHtml =  '<div class="attr-list">'+
						'	<input type="text" id="propertyOptions" name="propertyOptions" value=""/>'+
						'	<i class="J-delete delete fa fa-close"></i>'+
						'</div>';	
		return 	attrHtml;	
	}

	//下拉-值模板
	function publicDropdownHtml(){
		var dropdownHtml =  '<div class="dropdown-list clearfix">'+
							'	<input type="text" name="propertyOptions" value=""/>'+
							'	<i class="J-delete delete fa fa-close"></i>'+
							'</div>';

		return 	dropdownHtml;	
	}

	//1-文本框，2-日期，3-是/否，4-复选框，5-下拉
	$('select[name="propertyType"]').on('change',function(){
		var selectedVal =  parseInt($(this).children('option:selected').val());
		var extraHtml = '';
//		var extraValHtml = '';
//		var select = [
//				    {"name":"文本框","html":'<label class="col-sm-2 control-label">默认值:</label><div class="col-sm-8 frame"><input type="text" id="propertyDefaultValue" name="propertyDefaultValue"/></div>'},
//				    {"name":"日期","html":""},
//				    {"name":"是/否","html":""},
//				    {"name":"是/否","html":""},
//				    {"name":"是/否","html":""},
//				    {"name":"是/否","html":""}      
//				  ];
//		
//		for(var i = 0;i<select.length;i++){
//			alert(11);
//			if(select[i].name==selectedVal){
//				extraHtml = select[i].html;
//				break;
//			}
//		}
		switch(selectedVal){
			  
			case 1:
				extraHtml = '<label class="col-sm-2 control-label">默认值:</label>'+
							'<div class="col-sm-8 frame">'+
							'	<input type="text" id="propertyDefaultValue" name="propertyOptions"/>'+
							'</div>	';
				break;
			case 2:	
				extraHtml = '<label class="col-sm-2 control-label">日期:</label>'+
				'<div class="col-sm-8 frame">'+
				'<input type="text" class="" placeholder="开始时间" id="startDate" name="propertyOptions" data-date-format="yyyy-mm-dd HH:mm:ss" />'+
				'</div>	';
				break;
			case 3:
				extraHtml = '<label class="col-sm-2 control-label">属性值:</label>'+
							'<div class="col-sm-8 frame custom">'+
							'	<input type="text" name="propertyOptions" value="是" checked="true">'+
							'	<input type="text" name="propertyOptions" value="否">'+
							'</div>';
				break;
			case 4:  
				extraValHtml = publicAttrHtml();
				extraHtml = '<label class="col-sm-2 control-label">属性值:</label>'+
							'<div class="col-sm-8 frame">'+
							'	<div class="attr">'+
							'		<div id="J-category-attr" class="inside clearfix">'+
									extraValHtml+
							'		</div>'+
							'		<a id="J-category-attr-add" class="btn btn-info" href="javascript:void(0);">添加</a>'+
							'	</div>'+
							'	<div class="attr-data" style="display:none;">'+
							'		<p>获取公共数据库</p>'+
							'		<select name="propertyBusinessType">'+
							'			<option value="0">请选择</option>'+
							'			<option value="1">变速箱类型</option>'+
							'			<option value="2">外观颜色</option>'+
							'			<option value="3">内饰颜色</option>'+
							'			<option value="4">经销商</option>'+
							'			<option value="5">城市</option>'+
							'		</select>'+
							'	</div>'+
							'</div>';
				break;
			case 5:
				extraValHtml = publicDropdownHtml();
				extraHtml =	'<div class="col-sm-2 control-label">下拉列表值:</div>'+
							'<div class="col-sm-8 frame dropdown">'+
							'	<div id="J-category-dropdown" class="inside">'+
								extraValHtml+
							'	</div>'+
							'	<a id="J-category-dropdown-add" class="btn btn-info" href="javascript:void(0);">添加</a>'+
							'</div>';
				break;
		}

		if(extraHtml){
			$('#J-category-extra').show();	
		}else{
			$('#J-category-extra').hide();	
		}
		
		$('#J-category-extra').empty().append(extraHtml);
		
		//1-文本框，2-日期，3-是/否，4-复选框，5-下拉
		if(selectedVal == 2){
		 	$('#startDate').datepicker({
	//	 		$("#startDate").datetimepicker();
		 	});
	
			jQuery(function($){  
				 $.datepicker.regional['zh-CN'] = {clearText: '清除', clearStatus: '清除已选日期',  
		
				  closeText: '关闭', closeStatus: '不改变当前选择',  
		
				  prevText: '<上月', prevStatus: '显示上月',  
		
				  nextText: '下月>', nextStatus: '显示下月',  
		
				  currentText: '今天', currentStatus: '显示本月',  
		
				  monthNames: ['一月','二月','三月','四月','五月','六月',  
		
				  '七月','八月','九月','十月','十一月','十二月'],  
		
				  monthNamesShort: ['一','二','三','四','五','六',  
		
				  '七','八','九','十','十一','十二'],  
		
				  monthStatus: '选择月份', yearStatus: '选择年份',  
		
				  weekHeader: '周', weekStatus: '年内周次',  
		
				  dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],  
		
				  dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],  
		
				  dayNamesMin: ['日','一','二','三','四','五','六'],  
		
				  dayStatus: '设置 DD 为一周起始', dateStatus: '选择 m月 d日, DD',  
		
				  dateFormat: 'yy-mm-dd', firstDay: 1,   
		
				  initStatus: '请选择日期', isRTL: false};  
		
				 $.datepicker.setDefaults($.datepicker.regional['zh-CN']);  
		
				}); 
		}
	})

	//5-复选框 获取公共数据库
	$('#J-category-extra').delegate('select[name="propertyBusinessType"]', 'change', function(){
		var selectedVal = parseInt($(this).children('option:selected').val());
		var attrHtml = '';
		 $.ajax({
		 	url: ctx+'/pro/property/save',
		 	type: 'POST',
		 	dataType: 'json',
		 	data: selectedVal,
		    success: function(msg){
		        alert( "Data Saved: " );
		      }
		 });
//		 .done(function(data) {
//			 alert('asfasdfccccc')
//				if(!data){
//					attrHtml = publicAttrHtml();
//				}else{
//					$(data).each(function(i,e){
//						attrHtml += publicAttrHtml(data[i].option_name,data[i].option_value)
//			
//					})
//				}
//				$('#J-category-attr').empty().append(attrHtml);
//		 })		

//	    var data = [{
//	        "option_name": "123",
//	        "option_value":"未知"
//	    },{
//	    	"name":"333 ",
//	    	"option_value":"顶顶顶顶"
//	    }]


	})

	//5-复选框 添加值
	$('#J-category-extra').delegate('#J-category-attr-add', 'click', function(){
		var attrHtml =  publicAttrHtml();						
		$('#J-category-attr').append(attrHtml)
	})

	//6-下拉 添加值
	$('#J-category-extra').delegate('#J-category-dropdown-add','click',function(){
		var dropdownHtml =  publicDropdownHtml();
		$('#J-category-dropdown').append(dropdownHtml)		
	})

	//通用删除值
	$('#J-category-extra').delegate('.J-delete', 'click', function(){
		$(this).closest('div').remove();
	})

	// 提交
	$('#J-goods-add-submit').on('click',function(){
		
//		//序列化表单值
		var _data = $(this).closest('form').serialize();
		
		_data = decodeURI(_data);
		//alert(_data);
		$.ajax({
			url: ctx+'/ecm/property/save',
			type: 'post',
			dataType: 'json',
			data:_data,
		})
		.done(function(data) {
			console.log("success");
		})
	})
})