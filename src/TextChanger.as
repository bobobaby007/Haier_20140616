﻿package  {	import flash.text.TextField;	import flash.text.Font	import flash.text.TextFormat;	public class TextChanger {		static private var _self:TextChanger		//private var _textFormatEN:TextFormat=new TextFormat()		//private var _textFormatCN:TextFormat=new TextFormat()		static public var Font_EN:String=""		static public var Font_CN:String=""		public function TextChanger() {			// constructor code		}		public function _changeText(__text:TextField,__enSize:int=0,__cnSize:int=0,__enSpaceing:Number=0,__cnSpaceing:Number=0):Boolean{			var _hasEn:Boolean=false						var _textFormatEN:TextFormat=new TextFormat()			var _textFormatCN:TextFormat=new TextFormat()						_textFormatEN.kerning						_textFormatEN.font=Font_EN//"Volvo Broad"			_textFormatCN.font=Font_CN//"Hei Regular"			if(__enSize!=0){				_textFormatEN.size=__enSize			}			if(__cnSize!=0){				_textFormatCN.size=__cnSize			}			if(__enSpaceing!=0){				_textFormatEN.letterSpacing=__enSpaceing			}			if(__cnSpaceing!=0){				_textFormatCN.letterSpacing=__cnSpaceing			}			var _str:String=__text.text			for(var i:int=0;i<_str.length;i++){								if(_str.charCodeAt(i)<500){					__text.setTextFormat(_textFormatEN,i,i+1)					__text.defaultTextFormat=_textFormatCN					_hasEn=true				}else{					__text.setTextFormat(_textFormatCN,i,i+1)				}							}			return _hasEn		}		static public function get _Self():TextChanger{						if(!_self){				_self=new TextChanger()				var _array:Array=Font.enumerateFonts(false)								for(var a:int=0;a<_array.length;a++){					trace(_array[a].fontName)				}			}			return _self		}	}	}