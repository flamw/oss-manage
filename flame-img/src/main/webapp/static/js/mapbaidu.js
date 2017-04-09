/**
 * Created by ly-zhangxianggeng on 2016/1/12.
 */


    /////////////////////百度地图Api////////////////////////////////////////
    var cityStr;
    var streetStr;
    //传入坐标信息
    function mapPop(lng,lat,city,others){
        mapinfo.lng=lng;
        mapinfo.lat=lat;
        city?mapinfo.city=city:'';
        others?mapinfo.others=others:'';
    }
    var mapinfo={
        lng:'',
        lat:'',
        province:'省',
        city:'市',
        district:'区',
        street:'街道',
        streetNumber:'门牌号',
        others:'具体信息'
    }
    /////////////////显示弹出窗///////////////////////////
   // mapBaiduclick(116.404, 39.915);
  // function mapBaiduclick(lng,lat){
        $('.mapBaidu').on('click', function () {
            $('#modalmapBox').modal();
          //  mapPop(lng,lat);//初始化
        });
    // }
    ////////////////弹出窗显示出来之后再加载地图////////////////////////////////
    $('#modalmapBox').on('shown.bs.modal', function (e) {
        /////////////初始化地图，要求传入坐标信息//////////////////////////
       var map=mapInit();
        $('.j-confirm').on('click',function(){
            map.clearOverlays();
            var cityPopStr=$('.u-input-cityPop').val();
            var steerPopStr=$('.u-map-inPop').val();
            if(cityPopStr==''){
                function getCity(result){
                    var cityName = result.name;
                    cityPopStr=cityName;
                }
                var myCity = new BMap.LocalCity();
                myCity.get(getCity);
            }
            var myGeo = new BMap.Geocoder();
            // 将地址解析结果显示在地图上,并调整地图视野
            myGeo.getPoint(steerPopStr, function(point){
                if (point) {
                    map.centerAndZoom(point, 17);
                    returnPoint(point.lng,point.lat);
                    mapPop(point.lng,point.lat,cityPopStr,steerPopStr);
                    map.addOverlay(new BMap.Marker(point));
                }else{
                    alert("您选择地址没有解析到结果!");
                }
            }, cityPopStr);

        });
    })
    /////////////地图初始化////////////////////////
    function mapInit(){
        // 百度地图API功能
        var map = new BMap.Map("find4S");    // 创建Map实例
        var point=new BMap.Point(mapinfo.lng, mapinfo.lat);//传入经纬度
        map.centerAndZoom(point, 17);  // 初始化地图,设置中心点坐标和地图级别
        map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
        map.setCurrentCity("北京");          // 设置地图默认显示的城市 此项是必须设置的
        map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
        var marker = new BMap.Marker(point); // 创建点
        add_overlay(map,marker);//添加点
        //读取经纬度
        if(mapinfo.lng!=''&&mapinfo.lat!=''){
            //当经纬度传进来了
            initPosition(map,mapinfo.lng,mapinfo.lat);
            marker=new BMap.Marker(new BMap.Point(map,mapinfo.lng, map,mapinfo.lat));
            add_overlay(map,marker)
        }else{
            if(mapinfo.city=='市'){
                    function myFun(result){
                        var cityName = result.name;
                        map.setCenter(cityName);
                        //alert("当前定位城市:"+cityName);
                    }
                    var myCity = new BMap.LocalCity();
                    myCity.get(myFun);
                    map.clearOverlays();
            }else{
                var myGeo = new BMap.Geocoder();
                // 将地址解析结果显示在地图上,并调整地图视野
                mapinfo.city!=''?cityStr=mapinfo.city:cityStr='北京';
                streetStr=mapinfo.others;
                myGeo.getPoint(streetStr, function(point){
                    if (point) {
                        map.centerAndZoom(point, 17);
                        returnPoint(point.lng,point.lat);
                        map.addOverlay(new BMap.Marker(point));
                    }else{
                        alert("您选择地址没有解析到结果!");
                    }
                }, cityStr);
            }
        }
        //添加控件和比例尺
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
        add_control(map,top_left_control,top_left_navigation);
        map.addEventListener("click", showInfo);
        return map;
    }
    //添加控件和比例尺
    function add_control(map,top_left_control,top_left_navigation){
        map.addControl(top_left_control);
        map.addControl(top_left_navigation);
    }
    function add_overlay(map,marker) {
        map.addOverlay(marker);            //增加点
    }
    function showInfo(e){
        var geoc = new BMap.Geocoder();
        this.clearOverlays();
        var pointLeft;
        var pointTop;
        //点击地图返回的点
        returnPoint(e.point.lng,e.point.lat);
        pointLeft=e.point.lng;
        pointTop=e.point.lat;

        var marker = new BMap.Marker(new BMap.Point(pointLeft, pointTop)); // 创建点
        add_overlay(this,marker);
        var pt = e.point;
        geoc.getLocation(pt, function(rs){
            var addComp = rs.addressComponents;
            mapinfo.province=addComp.province;
            mapinfo.district=addComp.district;
            mapinfo.street=addComp.street;
            mapinfo.streetNumber=addComp.streetNumber;
            mapPop(pointLeft,pointTop,addComp.city,addComp.district + " " + addComp.street + " " + addComp.streetNumber)
           $('.u-input-cityPop').val(addComp.city);
            $('.u-map-inPop').val(  addComp.district + " " + addComp.street + " " + addComp.streetNumber);
        });
    }
    ///////////返回的经纬度到隐藏域中////////////////////
    function returnPoint(lng,lat){
        mapinfo.lng=lng;
        mapinfo.lat=lat;
        return mapinfo;
    }
    //初始时根据经纬度判断位置
    function initPosition(map,lng,lat){
        map.setCenter(new BMap.Point(lng, lat));
    }
    $('.j-commit').on('click',function(){
        console.log(mapinfo);
    })

















