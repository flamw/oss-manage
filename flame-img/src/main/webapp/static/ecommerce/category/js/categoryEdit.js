//表格内容
function tableHtml(attrName, attrType, attrId, dataStr, sortOrder) {
	var attrHtml = '<tr data-id=' + attrId + ' dataStr=' + dataStr + '>'
			+ '	<td>' + attrName + '</td>' + '	<td>' + attrType + '</td>'
			+ '	<td><input class="sort-input" type="text"  onblur="onBblurCustom(this)"  name="x" value='
			+ sortOrder + ' /></td>'
			+ '	<td><a class="J-delete" href="javascript:;">删除</a></td>'
			+ '</tr>';
	$('#J-attr-table').append(attrHtml);
}

// 删除指定内容
function eachDelete(attrId) {
	$('#J-attr-table').find('tr').each(function(i, e) {
		var trId = $(this).attr('data-id');
		if (trId == attrId) {
			$(this).remove();
		}
	})
}

// 全选
$('.J-selectAll').on(
		'click',
		function() {

			var _thisParent = $(this).closest('.J-attr-list');
			// 全选按钮状态
			var status = $(this).prop("checked");
			var attrHtml = '';

			$(this).closest('.J-attr-list').find('.J-attr-checkbox').each(
					function(i, e) {
						var attrName = $(this).closest('label').text();
						var attrType = $(this).closest('.J-attr-list')
								.children('.J-attr-type').text();
						var attrId = $(this).attr('data-id');
						var dataStr = $(this).attr('data-json');
						// 当前状态
						var _thisStatus = $(this).prop('checked');

						$(this).prop("checked", status);
						if (status) {
							if (!_thisStatus) {
								tableHtml(attrName, attrType, attrId, dataStr,
										0)
							}
						} else {
							eachDelete(attrId)
						}
					});
		})

// 选择属性
$('.J-attr-list').find('.J-attr-checkbox').click(
		function() {

			var _thisParent = $(this).closest('.J-attr-list');
			var attrName = $(this).closest('label').text();
			var attrType = _thisParent.children('.J-attr-type').text();
			var attrId = $(this).attr('data-id');
			var items = _thisParent.find('.J-attr-checkbox');
			var status = $(this).prop("checked");
			var dataStr = $(this).attr('data-json');
			var attrHtml = '';

			_thisParent.find('.J-selectAll').prop('checked',
					items.length == items.filter(':checked').length);

			if (status) {
				tableHtml(attrName, attrType, attrId, dataStr, 0);
			} else {
				eachDelete(attrId)
			}
		})

// 所属父类
$('#parentId').on(
		'change',
		function() {
			var strId = $(this).children('option:selected').attr('data-strId')
					|| '';
			// 属性排序字符串
			var strOrders = $(this).children('option:selected').attr(
					'data-orders')
					|| '';

			// 字符串转数组
			var arrId = strId.split(',');

			var arrOrder = strOrders.split(',');

			var attrHtml = '';
			// 取消选择
			$('.J-attr-checkbox').prop('checked', false);
			$('.J-selectAll').prop('checked', false);

			// 删除所有已选择的属性
			$('#J-attr-table').find('tr').each(function(i, e) {
				var trId = $(this).attr('data-id');
				if (trId != '' && trId != null) {
					$(this).remove();
				}
			});

			$('.J-attr-list').find('.J-attr-checkbox').each(
					function(i, e) {
						var attrName = $(this).closest('label').text();
						var attrType = $(this).closest('.J-attr-list')
								.children('.J-attr-type').text();
						var attrId = $(this).attr('data-id');
						var status = $(this).prop("checked");
						var dataStr = $(this).attr('data-json');
						// 当前状态
						var _thisStatus = $(this).prop('checked');
						if (arrId.indexOf(attrId) >= 0) {
							$(this).prop("checked", true);
							var indext = arrId.indexOf(attrId);
							var sortOrder = arrOrder[indext];
							if (!_thisStatus) {

								tableHtml(attrName, attrType, attrId, dataStr,
										sortOrder);
							}
						} else {
							eachDelete(attrId)
						}
					});
		})
		
// 编辑
if(flag==1){
// 删除表格属性
$('#J-attr-table').delegate(
		'.J-delete',
		'click',
		function() {
			var deleteId = $(this).closest('tr').attr('data-id');

			$('.J-attr-checkbox').each(
					function(i, e) {
						var chooseId = $(this).attr('data-id');
						var selectAllStatus = $(this).closest('.J-attr-list')
								.find('.J-selectAll');
						var _this = $(this);
						if (chooseId == deleteId) {
							_this.prop('checked', false);
						}

						selectAllStatus.prop('checked', false);
					});

			$(this).closest('tr').remove();
		});
}
// 提交表单
function formSubmit( event) {
	
	$(event).prop("disabled",true);

	// 验证表单
	if (!$('#validation-form').valid())
		return;

	var treePath=$("#parentId").children('option:selected').val();
	var parentTreePath=$("#parentId").children('option:selected').attr("data-treePath");
	  if(parentTreePath!=null&&parentTreePath!=''&&parentTreePath!=','){
		  $("#treePath").val(parentTreePath+','+treePath);
	  }else{
		  $("#treePath").val(treePath);
	  }
	// 获取已选择的属性
	var dataArr = new Array();
	$('#J-attr-table').find('tr').each(function(i, e) {
		var dataStr = $(this).attr('dataStr');
		if (dataStr != '' && dataStr != null) {
			var order = $(this).find('input').val();
			if (order == '' || order == null) {
				order = 0;
			}

			dataStr += ',sortOrder:' + order + "}";
			dataArr.push(dataStr);
		}
	});

	var jsonStr = JSON.stringify(dataArr);
	// alert(jsonStr);
	if(flag==2){
		disables(false);
	}
	var formdata = $('#validation-form').serialize();
	formdata += '&jsonStr=' + jsonStr+"&flag=";
	
    var  actionUrl=ctx + '/ecm/commodity/updateCategory';
 // 编辑
    if(flag==1){
    	formdata +="1";
    // 删除
    }else if(flag==2){
    	formdata +="2";
    }
	$.ajax({
		type : 'post',
		url : actionUrl,
		dataType : 'json',
		data : formdata,
		success : function(data) {
			if (data.retnCode = '0') {
				$.dndcAlert.success({
					title :data.retnDesc,
//					title : "保存成功",
					// text : "保存成功",
					remove_time : 4000
				});
				setTimeout(function() {
					document.location = ctx + "/ecm/commodity/category";
				}, 2000);

			} else {
				$(event).prop("disabled",false);
				$.dndcAlert.fail({
					title : "保存失败！",
					text : data.retnDesc,
					remove_time : 4000
				});
			}
		}
	});
}

// 校验
// jQuery(function($) {
$('#validation-form').validate(
		{
			errorElement : 'div',
			errorClass : 'help-block',
			focusInvalid : false,
			ignore : "",
			rules : {
				categoryName : {
					required : true,
					maxlength :250
				},
				categoryDesc : {
					maxlength :250
				},
				sortOrder : {
					required:true,
					number:true,
					maxlength :250
				}
			},

		/*	messages : {
				categoryName : {
					//required : "请输入分类名称",
				   maxlength : "请提供文本长度<250."
				},
				categoryDesc : {
					maxlength :"请提供文本长度<250."
				},
				sortOrder : {
					required:true,
					number:true,
					maxlength :250
				},
				state : "Please choose state",
				subscription : "Please choose at least one option",
				gender : "Please choose gender",
				agree : "Please accept our policy"
			},*/

			highlight : function(e) {
				$(e).closest('.form-group').removeClass('has-info').addClass(
						'has-error');
			},

			success : function(e) {
				$(e).closest('.form-group').removeClass('has-error');// .addClass('has-info');
				$(e).remove();
			},

			errorPlacement : function(error, element) {
				if (element.is('input[type=checkbox]')
						|| element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if (controls.find(':checkbox,:radio').length > 1)
						controls.append(error);
					else
						error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				} else if (element.is('.select2')) {
					error.insertAfter(element
							.siblings('[class*="select2-container"]:eq(0)'));
				} else if (element.is('.chosen-select')) {
					error.insertAfter(element
							.siblings('[class*="chosen-container"]:eq(0)'));
				} else
					error.insertAfter(element.parent());
			},

			submitHandler : function(form) {
			},
			invalidHandler : function(form) {
			}
		});



// 编辑渲染商品分类已选择的属性
function editRender(strId,strOrders){
	// var strId = $(this).children('option:selected').attr('data-strId') || '';
	// 字符串转数组
	var arrId = strId.split(',');
	var arrOrder= strOrders.split(',');
	var attrHtml='';
	// 取消选择
	$('.J-attr-checkbox').prop('checked',false); 
	$('.J-selectAll').prop('checked',false); 
	
	// 删除所有已选择的属性
	$('#J-attr-table').find('tr').each(function(i, e) {
		var trId = $(this).attr('data-id');
		if (trId != '' && trId != null) {
			$(this).remove();
		}
	});
	
	$('.J-attr-list').find('.J-attr-checkbox').each(function(i,e){
		var attrName = $(this).closest('label').text();
		var attrType = $(this).closest('.J-attr-list').children('.J-attr-type').text();
		var attrId = $(this).attr('data-id');
		var status = $(this).prop("checked");
		var dataStr = $(this).attr('data-json');
		
		// 当前状态
		var _thisStatus = $(this).prop('checked');

		if(arrId.indexOf(attrId) >= 0){
			$(this).prop("checked",true);
			
			var indext=arrId.indexOf(attrId);
			var sortOrder=arrOrder[indext];
			
			if((typeof sortOrder == 'undefined')||sortOrder==''||sortOrder==null){
				sortOrder=0;
			}
			if(!_thisStatus){
				
				tableHtml(attrName,attrType,attrId,dataStr,sortOrder);
			}
		}else{
			eachDelete(attrId)
		}
	});
 }
// 编辑
if(flag==1){
//	 编辑渲染商品分类已选择的属性
	editRender(proIds,sortOrders);
// 删除
}else if(flag==2){
//	 编辑渲染商品分类已选择的属性
	editRender(proIds,sortOrders);
	$(".choose-frame").hide();
	disables(true);
	
}

function disables(flag){

	$('#validation-form').find('input[type=text]').each(function(i, e) {
		 $(this).prop('disabled',flag);
	})
	$('#validation-form').find('input[type=radio]').each(function(i, e) {
		$(this).prop('disabled',flag);
	})
	
	$('#validation-form').find('textarea').each(function(i, e) {
		 $(this).prop('disabled',flag);
	})
	
	$('#validation-form').find('select').each(function(i, e) {
		$(this).prop('disabled',flag);
	})
/*	$('#validation-form').find('input[type=text]').each(function(i, e) {
		$(this).prop('disabled','disabled');
	})
	$('#validation-form').find('input[type=radio]').each(function(i, e) {
		$(this).prop('disabled','disabled');
	})
	
	$('#validation-form').find('textarea').each(function(i, e) {
		$(this).prop('disabled','disabled');
	})
	
	$('#validation-form').find('select').each(function(i, e) {
		$(this).prop('disabled','disabled');
	})
*/}


function onBblurCustom(e){
	var inpVal=$(e).val();
	if (isNaN(inpVal)||inpVal.indexOf(".") >=0) {
		$(e).val('0');
	}
}
