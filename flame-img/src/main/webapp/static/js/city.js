/**
 * Created by ly-zhangxianggeng on 2016/1/8.
 */
    //更多地区点击的弹出层


    //加载省份
    function getProvinces(dateAll){
        //var j=arrP.length;
    	$('.province').parent().remove();
        var j=dateAll.data.privince.length;
        var str='';
        for(var i=0;i<j;i++){
            str+='<div class="m-city " ><input class="province" id="province'+(dateAll.data.privince[i].id)+'" data-province-id="'+(dateAll.data.privince[i].id)+'" type="checkbox"/><label for="province'+(dateAll.data.privince[i].id)+'">'+dateAll.data.privince[i].name+'</label></div>';
        }
        $('.provinceBox').append(str);
        $('.provinceAll').on('click',function(){
            if(this.checked) {
                $('.u-city-tt').show();
                console.log();
                $('.province').each(function (index, el) {
                    if( el.checked){
                    }else{
                        el.checked=true;
                        showcity(el);
                    }
                   //el.checked?'':el.checked=true&&showcity(el);
                });
            }else{
                $('.province').each(function (index, el) {
                    hidecity(el);
                    el.checked=false;
                    $('.cityAll').get(0).checked=false;
                    $('.u-anchor').next().is('.m-citys')?'':$('.u-city-tt').hide();
                });
            }
        });
    };
    function cityInit(strinfo){
       var cityId=strinfo.split(',');
        cityId.shift();
        if(cityId!=''){
            $('.province').each(function(index,el){
                var p= $(el).attr('data-province-id');
                if(dateAll.data[p]) {
                for(var i=0;i<dateAll.data[p].length;i++){
                    for(var j=0;j<cityId.length;j++){
                        if(dateAll.data[p][i].id==cityId[j]){
                            el.checked=true;
                            showcity(el);
                            $('[data-city-id="'+cityId[j]+'"]').get(0).checked=true;
                            cityId.splice(j,1);
                        }
                    }
                 }
                }
            });
        }
    };


   
    function showcity(el){
            var j=$(el).attr('data-province-id');
            var str='<div class="m-citys">';
            if(dateAll.data[j]) {
            for(var i=0;i<dateAll.data[j].length;i++){
                str+='<div class="m-city " ><input class="city" id="city'+dateAll.data[j][i].id+'"  data-city-id="'+dateAll.data[j][i].id+'" data-province-id="'+j+'" type="checkbox"/><label for="city'+dateAll.data[j][i].id+'">'+dateAll.data[j][i].name+'</label></div>';
            }}
            str+='</div>';
            $('.cityBox').append(str);
    }
    function hidecity(el){
        var j = $(el).attr('data-province-id');
        var strc = 'data-city-id';
        if(dateAll.data[j]) {
        for (var i = 0; i < dateAll.data[j].length; i++) {
            $('[data-city-id=' + dateAll.data[j][i].id + ']').next().empty().remove();
            $('[data-city-id=' + dateAll.data[j][i].id + ']').parent().parent().remove();
        }
       }
    } 
    //选择省返回其市区的数组
    $('#modalcityBox').on('show.bs.modal', function () {

    })
    $('.cityAll').on('click',function(){
        if(this.checked) {
            $('.city').each(function (index, el) {
                el.checked=true;
                $(el).on('click',function(){
                    if(el.checked){}else{
                        $('.cityAll').get(0).checked=false;
                        console.log( $('.cityAll').get(0));
                    }
                });
            });
        }else{
            $('.city').each(function (index, el) {
                el.checked=false;
            });
        }
    });

   
    $('.p-cancel').on('click',function(){
        $('.city').each(function (index, el) {
            el.checked=false;
        });
        $('.province').each(function (index, el) {
            hidecity(el);
            el.checked=false;
            $('.cityAll').get(0).checked=false;
            $('.u-anchor').next().is('.m-citys')?'':$('.u-city-tt').hide();
        });
        $('.provinceAll').get(0).checked=false;

        $('.moreArea').get(0).checked=false;
    });
    function getCity(){
    	$('.province').on('click',function(){
	        $('.u-city-tt').show();
	        if(this.checked){
	            showcity(this);
	        }else {
	            hidecity(this);
	            $('.provinceAll').get(0).checked=false;
	        }
	        $('.u-anchor').next().is('.m-citys')?'':$('.u-city-tt').hide();
});     
    }
    
    
   

function  getProCityname(strinfo,name) {
	
    var cityId = strinfo.split(',');
    cityId.shift();
    if (cityId != '') {
        for (var i = 0; i < dateAll.data.privince.length; i++) {
            if (dateAll.data[dateAll.data.privince[i].id]) {
                for (var j = 0; j < dateAll.data[dateAll.data.privince[i].id].length; j++) {
                    for (var k = 0; k < cityId.length; k++) {
                        if (dateAll.data[dateAll.data.privince[i].id][j].id == cityId[k]) {
                            name.push(dateAll.data.privince[i].name + '-' + dateAll.data[dateAll.data.privince[i].id][j].name);
                            cityId.splice(k, 1);
                        }
                    }
                }
            }
        }
    }
}

    
   
    
