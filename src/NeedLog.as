﻿package  {	import flash.display.MovieClip;	import flash.events.MouseEvent;	import gs.TweenLite	import gs.easing.Back	public class NeedLog extends MovieClip{		static public var _self:NeedLog		static public var _status_need_log:String="_status_need_log"		static public var _status_need_contact:String="_status_need_contact"		static public var _status_ready:String="_status_ready"		private var _currentStatus:String		public function NeedLog() {			_self=this			setup()			_hide()			//trace("ok")		}		private function setup(){			_button.addEventListener(MouseEvent.CLICK,btnHander)		}		private function btnHander(event:MouseEvent){			switch(_currentStatus){				case _status_need_log:					DouBan._Self._logAction()				break				case _status_need_contact:					DouBan._Self._contectAction()				break				case _status_ready:					_go()				break			}		}		public function _hide(){			this.visible=false		}		public function _show(){			this.visible=true					this.scaleX=this.scaleY=0			TweenLite.to(this,0.4,{scaleX:1,scaleY:1,ease:Back.easeOut})		}		public function _go(){			_hide()					}		public function _needLog(){			_currentStatus=_status_need_log						_button.gotoAndStop(1)			_text.gotoAndStop(1)			_show()		}		public function _needContact(){			_currentStatus=_status_need_contact			_button.gotoAndStop(2)			_text.gotoAndStop(2)			_show()		}		public function _ready(){			_currentStatus=_status_ready			//_button.gotoAndStop(1)			_show()		}			}	}