﻿package  {	import flash.display.MovieClip;	import flash.events.MouseEvent;		public class StepButtons extends MovieClip{		static public var _self:StepButtons		private var _stepNum:int=0		public function StepButtons() {			_self=this			setup()		}		private function setup(){			_pre.addEventListener(MouseEvent.CLICK,btnHander)			_next.addEventListener(MouseEvent.CLICK,btnHander)			_reset.addEventListener(MouseEvent.CLICK,btnHander)		}		public function set _StepNum(__set:int){			_stepNum=__set			switch(_stepNum){				case 2:					_pre.visible=true					_next.visible=true					_reset.visible=false				break				case 3:					_pre.visible=true					_next.visible=true					_reset.visible=false				break				case 4:					_pre.visible=true					_next.visible=true					_reset.visible=true				break			}		}				public function get _StepNum():int{			return _stepNum		}		private function btnHander(event:MouseEvent){			switch(event.currentTarget){				case _pre:					switch(_stepNum){						case 2:							Main._self._Page="startPage"						break						case 3:							Main._self._Page="makingPage"						break						case 4:							Main._self._Page="choosePage"						break						case 5:														Main._self._Page="drawingPage"						break					}				break				case _next:					switch(_stepNum){						case 2:							//Main._self._saveImage()							Main._self._Page="choosePage"						break						case 3:							Main._self._saveDemoImage()							//Main._self._Page="drawingPage"						break						case 4:							Main._self._saveImage()							//Main._self._Page=""						break						case 5:							Main._self._Page=""						break					}				break				case _reset:					switch(_stepNum){						case 4:							KeyBoardInputer._self._reset()							KeyBoardInputer._self._setFocusIn()							DrawBoardContainer._self._Clear()						break											}				break			}		}		public function _show(){			this.visible=true		}		public function _hide(){			this.visible=false		}	}	}