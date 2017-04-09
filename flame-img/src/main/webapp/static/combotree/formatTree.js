function formatMenu(menus){	
		var _roots = [] ;
		var map = {} ;
		$( menus ).each(function(){
			
			if( !this.pid ){
				_roots.push(this) ;//root
			}else{
				map[this.pid] = map[ this.pid ]||[] ;
				map[this.pid].push( this ) ;
			}
			
		}) ;
		
		formatChild(_roots,map) ;
		return _roots ;
	}
	
	function formatChild(menus,map){
		$(menus).each(function(){
			if(map[this.id]){
				
				this.children = map[this.id] ;
				formatChild( this.children ,map) ;
			}
		}) ;
	}