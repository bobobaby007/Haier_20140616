﻿package  {	import flash.display.MovieClip		import flash.display.DisplayObject	import flash.geom.ColorTransform;	public class MouseM extends MovieClip{		public var _m:MovieClip=new MovieClip		static public var _mouseM:MouseM		public var _target:DisplayObject		private var _colorTrans:ColorTransform=new ColorTransform()		public function MouseM() {			_mouseM=this			_m.x=-7			_m.y=-7			addChild(_m)					}		public function set Target(target:DisplayObject){			var targetClass:Class=Object(target).constructor;			var duplicate:DisplayObject=new targetClass;			_target=duplicate			var _n:int=_m.numChildren			for(var i:int=0;i<_n;i++){				_m.removeChildAt(0)			}			_m.addChild(duplicate)					}				public function set _Color(__set:Number){			_colorTrans.color=__set			_m.transform.colorTransform=_colorTrans		}		public function get Target():DisplayObject{			return _target		}		public function set _Alpha(__set:Number){			_m.alpha=__set		}		public function set _Scale(__set:Number){			_m.scaleX=_m.scaleY=__set		}			}	}