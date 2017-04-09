	var CBB = {
	selectAll:function(obj,name,callback){
		$(obj).on('click',function(){
			$(name).each(function(i,e){
				$(this).prop("checked",$(obj).prop("checked"));
			});
			callback ? callback() : '';
		})

		$(name).click(function(){
			var _items=$(name);
			$(obj).prop('checked',_items.length==_items.filter(':checked').length);
			callback ? callback() : '';
		})
	}	
}
//组合属性
	var combination = function(options){

		var _tableTh = options.arrTh;   //表头
		var _tableTd = options.arrTd;   //表内容
		var _dlFlag = true;   //dl开关
		var _combinationHtml = '';  //拼接内容
		var _group;           //属性组合
		var _newArr = [];     //属性组
		var _newArrLength;    //属性组长度
		var _dtArr = [];     //表头数组
		    
	    return {
	        init: function(){
	        	var that = this;
	        	//清空搭配表
	        	$(options.container).empty();
				//遍历属性
				$(options.arrObj).find('dl').each(function(index, el) {
					var _dlThis = $(this);
			
					$(this).find('input').each(function(index, el) {
						if($(this).prop('checked') && _dlFlag){
							//获取name值
							var _name = _dlThis.find('input:first').prop('name');
							_dtArr.push(_dlThis.find('dt').text());
							
							_newArr.push(that._arrEach('input[name='+_name+']'));

							_dlFlag = false;
						}
					});

					_dlFlag = true;
				});

				//数组反转
				_dtArr.reverse();
				for(var i=0; i<_dtArr.length; i++){
					_tableTh.unshift(_dtArr[i])
				}

				//属性组数量
				_newArrLength = _newArr.length;

				//组合
				if(_newArrLength == 1){
					_group = _newArr;
				}else{
				    _group = this._groupFn(_newArr[0],_newArr[1],1);
				    _newArrLength >= 3? _group = this._groupFn(_group,_newArr[2],2): '';
				    _newArrLength >= 4? _group = this._groupFn(_group,_newArr[3],2): '';
				    _newArrLength >= 5? _group = this._groupFn(_group,_newArr[4],2): '';
			    }

			    //表头拼接
			    _combinationHtml = this._attrThHtml();

			    //表内容拼接
				if(_newArrLength == 1){
					//单属性
					for (var i = 0; i < _newArr[0].length; i++) {
						_combinationHtml += '<tr>';

						_combinationHtml += '<td data-id="'+_newArr[0][i]['enName']+':'+_newArr[0][i]['id']+','+_newArr[0][i]['enName']+'Name:\''+_newArr[0][i]['name']+'\'">'+_newArr[0][i]['name']+'</td>';

					    for(k=0; k<_tableTd.length; k++){
					    	_combinationHtml += '<td><input type="text" name="@'+_tableTd[k]+'" value=""/></td>';
						}

						_combinationHtml += '</tr>';
					}
				}else{
				    //多属性
				    for (var i = 0; i < _group.length; i++) {

				        _combinationHtml += '<tr>';
				     
			            for (var j = 0;j < _group[i].length; j++) {
			                _combinationHtml += '<td data-id="'+_group[i][j]['enName']+':'+_group[i][j]['id']+','+_group[i][j]['enName']+'Name:\''+_group[i][j]['name']+'\'">'+_group[i][j]['name']+'</td>';
			            }
 
			            for(k=0; k<_tableTd.length; k++){ 
			            	_combinationHtml += '<td ><input type="text" name="@'+_tableTd[k]+'['+i+']" value=""/></td>';
			        	}

				        _combinationHtml += '</tr>';
				    
				    }
			    }

			    //输出
			    $(options.container).append(_combinationHtml);

				var arrId = []; 
				$(options.container).find('tr').each(function(){
					$(this).find('td').each(function(){
						var _id = $(this).attr('data-id');	
						if(_id){
							arrId.push(_id)
						}
					})	
					$(this).attr('data-arrId',arrId);
					arrId = [];
				})

			    //合并单元格
				var result = new mergeRowsCell('J-result-table');
				$(options.arrObj).find('dl').each(function(index, el) {
					result.merge(0,index);
				});



				// $('#J-result-table')
	        },
	        //组合
		    _groupFn:function(arr1,arr2,method){
		        var newArr = [];
		        for (var i = 0; i < arr1.length; i++) {
		            for (var j = 0; j < arr2.length; j++) {
		                if(method === 1){
		                    newArr.push([arr1[i],arr2[j]]);    
		                }else{
		                    newArr.push(arr1[i].concat(arr2[j]));
		                }
		                
		            }
		        }
		        return newArr;
		    },
		    //表头拼接
		    _attrThHtml:function(){
			    var _html = '<tr>';
			    for(i=0; i<_tableTh.length; i++){
			        _html += '<th>'+_tableTh[i]+'</th>';
			    } 
			    _html += '</tr>';
			    return _html;
		    },
		    //属性值遍历
	        _arrEach:function(obj){
	        	var arr=[];
				$(obj).each(function(index, el) {
					var label = $(this).closest('label');
					var name = label.text();
					var enName = $(this).prop('name')
					var dataId = $(this).val();
					var status = $(this).prop('checked');
					var obj = {
						name:name,
						enName:enName,
						id:dataId
					}
					if(status){
						arr.push(obj);
					}
				});
				return arr;
	        },
	    };
}
