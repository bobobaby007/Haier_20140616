﻿package  {	import flash.display.MovieClip;	import tf.senocular.display.TransformTool;	import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.display.DisplayObject;	import flash.events.Event;	import gs.TweenLite	public class MakingBoard extends MovieClip{		static public var _self:MakingBoard		public var _transformTool:TransformTool=new TransformTool()						public function MakingBoard() {			_self=this			setup()			_hideWater()		}		private function setup(){												this.addEventListener(Event.ADDED_TO_STAGE,addToStageHander)								}		public function _showWater(){			_container.visible=true			_container._water.alpha=0						TweenLite.to(_container._water,4,{alpha:1})		}		public function _hideWater(){			_container.visible=false		}		private function addToStageHander(event:Event){			this.addEventListener(Event.ENTER_FRAME,enterFrameHander)			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseHander)						DrawBoardContainer._self._Available=false		}		public function _reset(){			DrawBoardContainer._self._Clear()					}				private function enterFrameHander(event:Event){			if(_transformTool.target){				//DrawBoardContainer._self._Available=false			}else{				//DrawBoardContainer._self._Available=true			}		}		private function mouseHander(event:MouseEvent){			var _targetM:DisplayObject=event.target as DisplayObject			switch(event.type){				case MouseEvent.MOUSE_OVER:									break				case MouseEvent.MOUSE_OUT:									break				case MouseEvent.MOUSE_DOWN:									break				case MouseEvent.CLICK:									break			}		}			}	}