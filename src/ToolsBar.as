﻿package  {	import flash.display.MovieClip		import flash.events.MouseEvent;	import flash.events.Event;	public class ToolsBar extends MovieClip{		private var _controlType:String		public var _currentImageInputer:ImageInputer		static public var _self:ToolsBar		public function ToolsBar() {			_self=this			setUp()		}		public function setUp(){			for(var i:int=2;i<=5;i++){				this["_btn"+i].addEventListener(MouseEvent.CLICK,btnHander)				this["_btn"+i].addEventListener(MouseEvent.MOUSE_DOWN,btnHander)			}			this["_upload"].addEventListener(MouseEvent.CLICK,btnHander)		}				private function btnHander(event:MouseEvent){						switch(event.type){				case MouseEvent.MOUSE_DOWN:					switch(event.currentTarget.name){												case "_btn2":							_controlType="+"							this.addEventListener(Event.ENTER_FRAME,enterFrameHander)						break						case "_btn3":							_controlType="-"							this.addEventListener(Event.ENTER_FRAME,enterFrameHander)						break						case "_btn4":							_controlType=">"							this.addEventListener(Event.ENTER_FRAME,enterFrameHander)						break						case "_btn5":							_controlType="<"							this.addEventListener(Event.ENTER_FRAME,enterFrameHander)						break																							}					stage.addEventListener(MouseEvent.MOUSE_UP,stageHander)				break				case MouseEvent.CLICK:					if(!_currentImageInputer){						return					}					switch(event.currentTarget.name){						case "_btn1":							_currentImageInputer._openFile()						break						case "_btn2":							_currentImageInputer._image.scaleX+=0.01							_currentImageInputer._image.scaleY+=0.01						break						case "_btn3":							_currentImageInputer._image.scaleX-=0.01							_currentImageInputer._image.scaleY-=0.01						break						case "_btn4":													break						case "_btn5":													break												case "_upload":							_currentImageInputer._openFile()						break											}				break								}								}		private function stageHander(event:MouseEvent){			this.removeEventListener(Event.ENTER_FRAME,enterFrameHander)		}		private function enterFrameHander(event:Event){			if(!_currentImageInputer){				return			}			var _ss:Number=_currentImageInputer._image.scaleX			switch(_controlType){				case "+":										_currentImageInputer._image.scaleX+=_ss*0.01					_currentImageInputer._image.scaleY+=_ss*0.01				break				case "-":					_currentImageInputer._image.scaleX-=_ss*0.01					_currentImageInputer._image.scaleY-=_ss*0.01				break				case ">":					_currentImageInputer._image.rotation-=1				break				case "<":					_currentImageInputer._image.rotation+=1				break							}		}			}	}