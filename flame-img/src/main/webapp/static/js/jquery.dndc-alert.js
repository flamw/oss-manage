/*
 * Alertter for jQuery
 * author sam
 *
 * Date: 1-1-2016
 * Version: 1.0
 */

(function($){
 	
	/**
	* Set it up as an object under the jQuery namespace
	*/
	$.dndcAlert = {};
	
	/**
	* Set up global options that the user can over-ride
	*/
	$.dndcAlert.options = {
		title:"",
        text:"",
        alert_type:"",
        warning_type:"",
        remove_time : 3000
	}
	
	/**
	* Add a Alertter notification to the screen
	* @see Alertter#add();
	*/
	$.dndcAlert.info = function(params){
		return Alertter._rander_info(params || {},$.dndcAlert.options);
	}
	
	/**
	* Remove a Alertter notification from the screen
	* @see Alertter#removeSpecific();
	*/
	$.dndcAlert.success = function(params){
		return Alertter._rander_success(params || {},$.dndcAlert.options);
	}
	
	/**
	* Remove a Alertter notification from the screen
	* @see Alertter#removeSpecific();
	*/
	$.dndcAlert.warning = function(params){
		return Alertter._rander_warning(params || {},$.dndcAlert.options);
	}
    
	/**
	* Remove a Alertter notification from the screen
	* @see Alertter#removeSpecific();
	*/
	$.dndcAlert.fail = function(params){
		return Alertter._rander_danger(params || {},$.dndcAlert.options);
	}
	
	
	/**
	* Big fat Alertter object
	* @constructor (not really since its object literal)
	*/
	var Alertter = {

		
		// Private - no touchy the private parts

		_tpl_item: '<div class="alert-wrap" style="[[item_style]]"><div class="alert [[alert_type]]"><button type="button" class="close" data-dismiss="alert"><i class="ace-icon fa fa-times"></i></button><p><strong><i class="ace-icon fa [[warning_type]]"></i>[[title]]</strong> [[message]]</p></div></div>',
		
		/**
		* Add a Alertter notification to the screen
		* @param {Object} params The object that contains all the options for drawing the notification
		*/
		add: function(params){
			// Basics
			var title = params.title, 
				text = params.text,
				item_style = params.item_style,
				position = $.dndcAlert.options.position,
                alert_type = params.alert_type,
                warning_type = params.warning_type;
            var tmp = this._tpl_item;


			tmp = this._str_replace(
				['[[alert_type]]','[[item_style]]', '[[warning_type]]', '[[title]]', '[[message]]'],
				[alert_type,item_style,warning_type,title,text], tmp
			);
			
			$("body").append(tmp);
		},
        
        remove:function(className,time){
            setTimeout(function(){$('.'+className).fadeOut(300,function(){$('.'+className).remove();})},time);
        },
		
		
		
		/**
		* An extremely handy PHP function ported to JS, works well for templating
		* @private
		* @param {String/Array} search A list of things to search for
		* @param {String/Array} replace A list of things to replace the searches with
		* @return {String} sa The output
		*/  
		_str_replace: function(search, replace, subject, count){
		
			var i = 0, j = 0, temp = '', repl = '', sl = 0, fl = 0,
				f = [].concat(search),
				r = [].concat(replace),
				s = subject,
				ra = r instanceof Array, sa = s instanceof Array;
			s = [].concat(s);
			
			if(count){
				this.window[count] = 0;
			}
		
			for(i = 0, sl = s.length; i < sl; i++){
				
				if(s[i] === ''){
					continue;
				}
				
				for (j = 0, fl = f.length; j < fl; j++){
					
					temp = s[i] + '';
					repl = ra ? (r[j] !== undefined ? r[j] : '') : r[0];
					s[i] = (temp).split(f[j]).join(repl);
					
					if(count && s[i] !== temp){
						this.window[count] += (temp.length-s[i].length) / f[j].length;
					}
					
				}
			}
			
			return sa ? s : s[0];
			
		},
		
        /**
		* rander the four type alert pop window
		* @private
		* @param {string}title begin of the line storng txt.
		* @options {object} 
		*/
        _rander_info:function(param,options){
            if(typeof(param) == 'string'){
				param = {text:param};
			}
            options.warning_type="";
            options.alert_type="alert-info";
            var _param=$.extend({},options,param);
            this.add(_param);
            if(_param.remove_time){
                this.remove("alert-info",_param.remove_time)
            }
        },
        _rander_success:function(param,options){
            options.warning_type="fa-check";
            options.alert_type="alert-success";
            if(typeof(param) == 'string'){
				param = {text:param};
			}
            var _param=$.extend({},options,param);
            this.add(_param);
           if(_param.remove_time){
                this.remove("alert-success",_param.remove_time)
            }
        },
        _rander_warning:function(param,options){
            if(typeof(param) == 'string'){
				param = {text:param};
			}
            options.warning_type="";
            options.alert_type="alert-warning";
            var _param=$.extend({},options,param);
            this.add(_param);
            if(_param.remove_time){
                this.remove("alert-warning",_param.remove_time)
            }
        },
        _rander_danger:function(param,options){
            if(typeof(param) == 'string'){
				param = {text:param};
			}
            options.warning_type="fa-times";
            options.alert_type="alert-danger";
            var _param=$.extend({},options,param);
            this.add(_param);
            if(_param.remove_time){
                this.remove("alert-danger",_param.remove_time)
            }
        }
	}
	
})(jQuery);
