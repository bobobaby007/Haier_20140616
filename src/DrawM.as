﻿package  {	import flash.display.MovieClip;	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.DisplayObject;		public class DrawM extends MovieClip{		private var _bitmap:Bitmap		private var _bitmapData:BitmapData		public function DrawM() {			// constructor code		}		private function setup(){					}		public function _drawObject(__object:DisplayObject,__width:Number=0,__height:Number=0){			if(!_bitmap){				if(__width!=0){					_bitmapData=new BitmapData(__width,__height,true,0x00000000)				}else{					_bitmapData=new BitmapData(__object.width/__object.scaleX,__object.height/__object.scaleY+5,true,0x00000000)				}								_bitmap=new Bitmap(_bitmapData,"auto",true)				addChild(_bitmap)			}			_bitmapData.fillRect(_bitmapData.rect,0x00000000)			_bitmapData.draw(__object)					}			}	}