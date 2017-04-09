	//加载品牌
	 var tabTp = '<ul class="nav nav-tabs j-carBand">';
		//var url = ctx + '/base/financialproduct/getAllCarBand';
		$.ajax({
			type:"post",
			url: ctx + '/public/financialproduct/getAllCarBand',
			dataType:'json',
			success: function(data){
				if(data){
					var cbl = data.results;
					for (var cb in cbl){
						if(cbl[cb].id==1){
							tabTp += '<li class="itm active" ><a href="###" data-id="'+cbl[cb].id+'" >'+cbl[cb].carBrandCn+'</a></li>';
						}else {
							tabTp += '<li class="itm "><a href="###" data-id="'+cbl[cb].id+'">'+cbl[cb].carBrandCn+'</a></li>';
						}
					}
					$("#carBand").html(tabTp);
					
				}								
			}
			
		})
		
	var tab = {
       nav:$('#carBand'),
       cnt:$('#carSeries'),
      // snt:$('#subPage'),
       
       rnt:$('#sellRegion'),
      
       init:function(options){
           this.ops = $.extend({},options);
           this.nav.html(tabTp);
           this.cnt.html(html);
           /* this.snt.html(sntstr); */
           this.rnt.html(regionstr);
           
           this.$tabItm= this.nav.find('.itm');
           this.$cntPage = this.cnt.find('.tab_block');
          /*  this.$sntPage = this.snt.find('.ssss'); */
           this.$rntPage = this.rnt.find('.tab_block');
          
           this.bindEve();
       },
       bindEve:function(){
          var self = this;
          this.nav.on('click','.itm',function(){
            self.changeTo(self.$tabItm.index($(this)));
          })
       },
       changeTo:function(index){
         this.$tabItm.removeClass('active').eq(index).addClass('active');
         this.$cntPage.hide().eq(index).show();
         /* this.$sntPage.hide().eq(index).show(); */
         this.$rntPage.hide().eq(index).show();
           this.ops.cnt.changeTo(index);
           this.ops.cnt.changeTo.call(this,index);
           /* this.ops.snt.changeTo(index);
           this.ops.snt.changeTo.call(this,index); */
           this.ops.rnt.changeTo(index);
           this.ops.rnt.changeTo.call(this,index);
       }
    }
    var cnt = {
      changeTo:function(index){
        this.animateChange(index);
      },
      animateChange:function(index){
        $('#carSeries .tab_block').hide().eq(index).show();
      }
    } 
	/*  var snt = {
	      changeTo:function(index){
	        this.animateChange(index);
	      },
	      animateChange:function(index){
	        $('#subPage .ssss').hide().eq(index).show();
	      }
	    }  */
	  var rnt = {
	      changeTo:function(index){
	        this.animateChange(index);
	      },
	      animateChange:function(index){
	        $('#sellRegion .tab_block').hide().eq(index).show();
	      }
	    } 
			
		 var html ='<div class="m_car">';
		 var sntstr = '';
		 $.ajax({
			type:"post",
			url: ctx + '/public/financialproduct/getSeriesByCarBand',
			dataType:'json',
			success: function(data1){
				if(data1){
					var csl = data1.results;
					var ss = $('#carBand').find('.j-carBand .active a').data('id');
					for (var cs in csl){
						if(csl[cs].carBrandId==ss){
						//第一次加载日产系列车系
							html +='<div class="tab_block" ><input type="checkbox"  name="sercheck'+csl[cs].carBrandId+'" data-ser="ser'+csl[cs].carBrandId+'" id="rccheckAll'+csl[cs].carBrandId+'" /><span>全选</span><br>';
							for(var c in csl[cs].carSerId){
								
								html += '<div class="ch"><input type="checkbox" name="sercheck'+csl[cs].carBrandId+'" data-carseries-'+csl[cs].carBrandId+'="'+csl[cs].carSerId[c].id+'"/><span id="'+csl[cs].carSerId[c].id+'">'+csl[cs].carSerId[c].carSeriesCn+'</span></div>' ;
								
							}
							html+='</div></div>'
						}else{
							html +='<div class="tab_block" style="display:none "><input type="checkbox"  name="sercheck'+csl[cs].carBrandId+'" data-ser="ser'+csl[cs].carBrandId+'" id="rccheckAll'+csl[cs].carBrandId+'" /><span>全选</span><br>';
							for(var c in csl[cs].carSerId){
								
								html += '<div class="ch"><input type="checkbox" name="sercheck'+csl[cs].carBrandId+'" data-carseries-'+csl[cs].carBrandId+'="'+csl[cs].carSerId[c].id+'"/><span id="'+csl[cs].carSerId[c].id+'">'+csl[cs].carSerId[c].carSeriesCn+'</span></div>' ;
							}
							html+='</div></div>'
						
						}
						}
						$("#carSeries").html(html);
						//初始化车系
						tab.init({
						      cnt:cnt
						    });	
										
					 	var ss1 = $('#carBand').find('.j-carBand .active a').data('id');
						 
					 	//切换品牌，点击车系拼接车系并保存
					     $('body').on('click','[data-carseries-'+ss1+']',function(){
								var car = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss1)}).get().join(',')
								//var id =$(this).data('region');					
								 loadsuss(car,ss1);
								
						})
					}
					
				}
		})

		
		//加载经销商类型		
			
		var dlrstr = '<ul class="nav nav-tabs j-dealerType">';
		dlrstr+='<li class="itm active" ><a href="###" data-id="1" >所有经销商</a></li>';
		/* dlrstr+='<li class="itm " ><a href="###" data-id="2" >堡垒店</a></li>' */
		$("#dealerType").html(dlrstr);	
			
		var regionstr = '<div class="m_region">';
		$.ajax({
			type:"post",
			url: ctx + '/public/financialproduct/getAllRegion',
			dataType:'json',
			success: function(data){
				if(data){
					
					var csl = data.results;
					
					var ss = $('#carBand').find('.j-carBand .active a').data('id');
					for (var cs in csl){
						//var ss = $('#carBand').find('.j-carBand .active a').data('id');
					if(csl[cs].carBrandId==ss){							
						regionstr +='<div class="tab_block" ><input type="checkbox"  name="regcheck'+cs+'" data-reg="reg'+cs+'" id="regcheckAll'+cs+'" /><span>全选</span><br>';
						for(var c in csl[cs].brandList){
							
							regionstr += '<div class="ch"><input type="checkbox" name="regcheck'+cs+'" data-region-'+csl[cs].carBrandId+'="'+csl[cs].brandList[c].id+'"/><span id="'+csl[cs].brandList[c].id+'_'+ss+'">'+csl[cs].brandList[c].regionName+'</span></div>' ;
						}
						regionstr+='</div></div>'
					}else{
						regionstr +='<div class="tab_block" style="display:none " ><input type="checkbox"  name="regcheck'+cs+'" data-reg="reg'+cs+'" id="regcheckAll'+cs+'" /><span>全选</span><br>';
						for(var c in csl[cs].brandList){
							
							regionstr += '<div class="ch" ><input type="checkbox" name="regcheck'+cs+'" data-region-'+csl[cs].carBrandId+'="'+csl[cs].brandList[c].id+'"/><span id="'+csl[cs].brandList[c].id+'_'+ss+'">'+csl[cs].brandList[c].regionName+'</span></div>' ;
						}
						regionstr+='</div></div>'
						
					}
					}
					$("#sellRegion").html(regionstr);
					 tab.init({
					      rnt:rnt
					    }); 
					 
					   	var ss1 = $('#carBand').find('.j-carBand .active a').data('id');
					 
					   	//显示车系
					    var seriesIds =$('#finCarSeries'+ss1).val();
					   	if(seriesIds!=""){
					   		
							var result = seriesIds.split(',');
							for(var s in result){
								$('#carSeries').find("[data-carseries-"+ss1+"="+result[s]+"]").prop('checked', true)
							}
					   	} 
					   	
					   	//显示销售区域
					   	var rcregion =$('#finRegionId'+ss1).val();
					   	if(rcregion!=""){
					   		
							var result = rcregion.split(',');
							for(var s in result){
								$('.m_region').find("[data-region-"+ss1+"="+result[s]+"]").prop('checked', true);
							}
					   	} 	
					   	var regionId =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss1)}).get().join(',');
						loadProvince(regionId,ss1);
					
					//点击区域加载省份
					$('body').on('click','[data-region-'+ss1+']',function(){
					
						var regionId = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss1)}).get().join(',')
						//var id =$(this).data('region');					
						loadProvince(regionId,ss1);
						
					})
					//点击区域加载省份
					$('body').on('click','[data-carseries-'+ss1+']',function(){
					
						var carser = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss1)}).get().join(',')
						//var id =$(this).data('region');					
						loadsuss(carser,ss1);
						
					})
							
					//点击品牌切换区域并加载加载省份
					$("body").on("click",".j-carBand  a",function(){
						
						 $(".j-carBand li").removeClass("active");
					     $(this).parent().addClass("active");
					     var ss2 = $('#carBand').find('.j-carBand .active a').data('id');
					 	
					 	 	
					   		//加载车系
				   			var rcser =$('#finCarSeries'+ss2).val();
						   	if(rcser!=""){
								var result = rcser.split(',');
								for(var s in result){
									$('#carSeries').find("[data-carseries-"+ss2+"="+result[s]+"]").prop('checked', true);
								}
								var carser =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss2)}).get().join(',');
								loadsuss(carser,ss2);
						   	}
						   	
						  	//加载销售区域
				   			var rcregion =$('#finRegionId'+ss2).val();
						   	if(rcregion!=""){
								var result = rcregion.split(',');
								for(var s in result){
									$('#sellRegion').find("[data-region-"+ss2+"="+result[s]+"]").prop('checked', true);
								}
								var regionId =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss2)}).get().join(',');
								loadProvince(regionId,ss2);
						   	} 
					   
					 	 	//切换品牌时加载车系
						   	 $('#carSeries [data-carseries-'+ss2+']').each(function(){
						    	 var carseries =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss2)}).get().join(',');
						    	 loadsuss(carseries,ss2);
						     });
						   //切换品牌时加载区域
						     $('#sellRegion [data-region-'+ss2+']').each(function(){
						    	 var regionId =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss2)}).get().join(',');
								loadProvince(regionId,ss2);
						     });
					     	//切换品牌，点击车系拼接车系并保存
						     $('body').on('click','[data-carseries-'+ss2+']',function(){
									
									var car = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss2)}).get().join(',')
									//var id =$(this).data('region');					
									 loadsuss(car,ss2);
									
							})
							//切换品牌，点击区域拼接品牌并加载省份
							 $('body').on('click','[data-region-'+ss2+']',function(){
								
								var regionId = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss2)}).get().join(',')
								//var id =$(this).data('region');					
								loadProvince(regionId,ss2);
								
							})
					    
					})
					//点击全选车系，保存车系
					$('body').on('click','[data-ser]',function(){
							   checkseries(this);
							   var ss1 = $('#carBand').find('.j-carBand .active a').data('id');	
								var car = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-carseries-'+ss1)}).get().join(',');
								loadsuss(car,ss1);
						})
					
					//点击全选选择所有区域并加载省份
					$('body').on('click','[data-reg]',function(){
						checkseries(this);
						//var ss1 = $('#carBand').find('.j-carBand .active a').data('id');	
						var regionId = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-region-'+ss1)}).get().join(',');
						loadProvince(regionId,ss1);
					}); 
					
				}
			}
		})
		
		function loadProvince(regions,carbrandId){
			
			var ids="";
			var prostr = '<div class="m_province ">';
			if(regions!=""){
				ids = regions;
				prostr +='<div class="tab_block">'
			}else{
				ids="99999";
			}
			
			$('#finRegionId'+carbrandId).val(regions);
			
			
			$.ajax({
				type:"post",
				url: ctx + '/public/financialproduct/getProvinceByRegionId/'+ids,
				dataType:'json',
				success: function(data){
					if(data){
						var srl = data.results;
						
							for (var sr in srl){
									
								for(var s in srl[sr]){								 		
									prostr += '<div class="ch"><input type="checkbox" checked  name="procheck" data-province="'+srl[sr][s].id+'"/><span id="'+srl[sr][s].id+'">'+srl[sr][s].provinceName+'</span></div>' 
								}
							}
							prostr+='</div></div>'
					
						$("#province").html(prostr);
						
						var pro =$('#finProvinceId'+carbrandId).val();
						if(pro!=""){
							$('#province').find('input:checkbox').removeAttr('checked');
							
							var result = pro.split(',');
							//var result = pro.split(',');
							for(var s in result){
								$('.m_province').find("[data-province="+result[s]+"]").prop('checked', true)
							}
							$('#province').find('input:checkbox').prop('checked',true);
						}
						
						var provinceId = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-province')}).get().join(',');	
						loadDealer(provinceId,carbrandId);
						
						$('body').on('click','[data-province]',function(){
							var provinceId = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-province')}).get().join(',')
							//var id =$(this).data('region');
							//alert(regionId+"asas");
							loadDealer(provinceId,carbrandId);
							//loadsuss(provinceId);
						})
						
					}
					
				}
				
			})
		}
		
		function loadDealer(provinceIds,carBrandId){
			//var ss1 = $('#carBand').find('.j-carBand .active a').data('id');
			//var carBrandId = $('#carBand').find('.j-carBand .active a').data('id');
		 	
			$('#finProvinceId'+carBrandId).val(provinceIds);
			
			/* if(carBrandId == 1){
				
			}else if(carBrandId ==2){
				$('#finProvinceId2').val(provinceIds);
			} */
			//alert("1");
			var dealerType = $('#dealerType').find('.j-dealerType .active a').data('id');
			
			var provinceId = "";
			var dealerstr = '<div class="m_dealer" id = "">';
			 if( provinceIds !=""){
				 provinceId = provinceIds;
				dealerstr += '<div class="tab_block block_scr "  id="dealers">';
			}else{
				provinceId="99999";
			} 
			$.ajax({
				type:"post",
				url: ctx + '/public/financialproduct/getDealerByProvinceId/'+provinceId,
				data : {carBrandId:carBrandId,dealerType:dealerType},
				dataType:'json',
				success: function(data){
					if(data){
						var del = data.results;
						 //for (var de in del){
							 for (var de in del){
							 dealerstr +='<div class="deal"><span>'+del[de].cityName+'经销商</span><input type="checkbox" name="dealercheck'+del[de].cityId+'" data-city="check'+del[de].cityId+'" id="'+del[de].cityId+'" /><span>全选</span><br>'
							 for(var d in del[de].cityList){								
								dealerstr += '<div class="ch1"><input type="checkbox" checked name="dealercheck'+del[de].cityId+'" data-dealer="'+del[de].cityList[d].dlrCode+'"/><span id="'+del[de].cityList[d].dlrCode+'">'+del[de].cityList[d].dlrShortName+'</span></div>' 
								}
							 dealerstr +='</div><br>'
							} 
						dealerstr+='</div></div>'
						$("#dealer").html(dealerstr);
						
						var pro =$('#finDealerId'+carBrandId).val();
						if(pro!=""){
							$('#dealer').find('input:checkbox').removeAttr('checked');
							var result = pro.split(',');
							for(var s in result){
								$('.m_dealer').find("[data-dealer="+result[s]+"]").prop('checked', true);
							}
							$('#dealer').find('input:checkbox').prop('checked', true);
						}
						
						 /* if(carBrandId == 1){
							var pro =$('#finDealerId1').val();
							if(pro!=""){
							//$('.m_dealer').find("[data-dealer="+result[s]+"]").prop('checked', false)
								$('#dealer').find('input:checkbox').removeAttr('checked');
								var result = pro.split(',');
								for(var s in result){
									$('.m_dealer').find("[data-dealer="+result[s]+"]").prop('checked', true)
								}
							}
							
						}else if(carBrandId ==2){
							var pro2 =$('#finDealerId2').val();
							if(pro2!=""){
								$('#dealer').find('input:checkbox').removeAttr('checked');
								var result = pro2.split(',');
								for(var s in result){
									$('.m_dealer').find("[data-dealer="+result[s]+"]").prop('checked', true)
								}
							}
						}  */
						
						var dealerid = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-dealer')}).get().join(',');	
						loadsub(dealerid,carBrandId);
						
						$('body').on('click','[data-dealer]',function(){
							var dealerid = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-dealer')}).get().join(',')
							
							loadsub(dealerid,carBrandId);
							
						})
						
						
						/* $('body').on('click','.m_dealer [data-dealer]',function(){
							if(carBrandId == 1){
								// $('#finProvinceId1').val(provinceIds);
								 var dealerId =  $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-dealer')}).get().join(',');
							 	loadsub(dealerId)
								
							}else if(carBrandId ==2){
								//$('#finProvinceId2').val(provinceIds);
								$('#finDealerId2').val($('input[type=checkbox]:checked').map(function(){return $(this).attr('data-dealer')}).get().join(',');
								loadsub(dealerId)
							}
							
						}) */
						 
						/* var dea =$('#allDealer').val();
						if(dea!=""){
							var result = dea.split(',');
							for(var s in result){
								$('.m_dealer').find("[data-dealer="+result[s]+"]").prop('checked', true)
							}
						} */
						
						
					}
						 
					$('body').on('click','.m_dealer [data-city]',function(){
						checkseries(this);
						var dealerid = $('input[type=checkbox]:checked').map(function(){return $(this).attr('data-dealer')}).get().join(',')
						loadsub(dealerid,carBrandId)
					})
					}
					
			})
		} 
		//将经销商id存储到隐藏域中	
		function loadsub(dealer,carBrandId){
			
			$('#finDealerId'+carBrandId).val(dealer);
			/* var carBrandId = $('#carBand').find('.j-carBand .active a').data('id');
			if(carBrandId == 1){
				
			}else if(carBrandId ==2){
				$('#finDealerId2').val(dealer);
			}
			 */
		}
		//将车系id存储到隐藏域中	
		function loadsuss(ser,carBrandId){
			
			//var carBrandId = $('#carBand').find('.j-carBand .active a').data('id');
			
				 $('#finCarSeries'+carBrandId).val(ser);
			/* if(carBrandId == 1){
				
			}else if(carBrandId ==2){
				$('#finCarSeries2').val(ser);
			} */
			
		}
		
		
		function checkseries(val){
			
			var collid = document.getElementById(val.id);
			var coll = document.getElementsByName(val.name);
			
			if (collid.checked){
				for(var i = 0; i < coll.length; i++){
					coll[i].checked = true;  			    	 
				}
			}else{
				for(var i = 0; i < coll.length; i++){
			  		coll[i].checked = false;		  			    	 
				}
			}
		}