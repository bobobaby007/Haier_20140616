﻿package  {	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.text.TextField;	import flash.events.FocusEvent;	import flash.display.MovieClip;		public class Unity {				public function Unity() {			// constructor code		}		static public function _randomArray(__array:Array){			for(var i:int=0;i<__array.length;i++){				var _a:int=Math.floor(Math.random()*__array.length)				var _aOject=__array[_a]				var _b:int=Math.floor(Math.random()*__array.length)				var _bOject=__array[_b]								__array[_a]=_bOject				__array[_b]=_aOject							}					}		static public function _repeat(__functionA:Function,__functionB:Function,__interval:Number=1):Timer{			var _timer:Timer=new Timer(__interval*1000)			var _t:int=1			_timer.addEventListener(TimerEvent.TIMER,timerHander)			_timer.start()			function timerHander(event:TimerEvent){				if(_t==1){					__functionA.call()					_t=0				}else{					__functionB.call()					_t=1				}			}			return _timer		}		static public function _waitToAction(__function:Function,__interval:Number=1,__times:int=1):Timer{			var _timer:Timer=new Timer(__interval*1000,__times)						_timer.addEventListener(TimerEvent.TIMER,timerHander)			_timer.start()			function timerHander(event:TimerEvent){								__function.call()								}			return _timer		}		static public function _timeStr(__set:int):String{						var _str:String			var _time:int=__set						if(_time<0){				_time=0			}			var _secT:int=_time%60			var _secStr:String=_secT>=10?_secT.toString():"0"+_secT.toString()												var _minT:int=Math.floor(_time/60)			var _minStr:String=_minT>=10?_minT.toString():"0"+_minT.toString()												_str=_minStr+":"+_secStr						return _str		}				//		static public function _TextDefault(__text:TextField,__default:String,__defaultColor:uint=0x999999){			__text.text=__default			__text.addEventListener(FocusEvent.FOCUS_IN,textHander)			__text.addEventListener(FocusEvent.FOCUS_OUT,textHander)						var __Color:uint=__text.textColor						__text.textColor=__defaultColor						function textHander(event:FocusEvent){				switch(event.type){					case FocusEvent.FOCUS_IN:						if(__text.text==__default){							__text.text=""							__text.textColor=__Color						}					break					case FocusEvent.FOCUS_OUT:						if(__text.text==""){							__text.text=__default							__text.textColor=__defaultColor						}					break				}			}		}		static public function _DistanceAt(__showing:Number,__self:Number,__length:Number):Number{			var _distance:Number						var _revert:int=1						var _d_1:Number=__self-__showing			var _d_2:Number			if(__self>=__showing){				_d_2=__length+__showing-__self							}else{				_d_2=__length-__showing+__self							}			var _d:Number=Math.min(Math.abs(_d_1),Math.abs(_d_2))						if(Math.abs(_d_1)==_d){				_distance=_d_1			}else{				if(__self<.5*__length){					_distance=_d_2				}else{					_distance=-_d_2				}							}						return _distance*_revert					}		static public function _ClearMovieClip(__movie:MovieClip){			var _n:int=__movie.numChildren			for(var i:int=0;i<_n;i++){				__movie.removeChildAt(0)			}		}			}	}