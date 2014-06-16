﻿package  {	import flash.display.MovieClip		import flash.net.FileReference;	import flash.display.Loader;	import flash.events.Event;	import flash.utils.ByteArray;	import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.display.Bitmap;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize	import flash.display.SimpleButton;	import flash.ui.Mouse		import flash.display.DisplayObject;		import AsPreloader.Preloader			public class ImageInputer extends MovieClip{		static public var EVENT_PICIN:String="EVENT_PICIN"				private var _fileReference:FileReference=new FileReference		private var _loader:Loader=new Loader		public var _image:Sprite=new Sprite()		private var _imageIn:Boolean=false				public var _imageWidth:Number=400		public var _imageHeigh:Number=300				private var _mask:Sprite				private var _btn:SimpleButton		public var _mover:Sprite				private var _picByLoad:MovieClip=new MovieClip()		static public var _imageInputer:ImageInputer			private var _preloader:Preloader=new Preloader()										public function ImageInputer() {			_imageInputer=this			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHander)								}		private function addToStageHander(event:Event){			setUp()		}		private function setUp(){			_btn=_btn_btn			_btn.useHandCursor=false						_mover=_mover_mc			_mover.visible=false									_mask=_mask_mc			_imageWidth=_mask.width+4			_imageHeigh=_mask.height+4						_preloader.setColor(0xffffff)				_preloader.visible=false			addChildAt(_preloader,1)						addChildAt(_image,1)						//_mask.visible=false			_image.mask=_mask			_image.x=0.5*_mask.width			_image.y=0.5*_mask.height									_btn.addEventListener(MouseEvent.MOUSE_OVER,btnHander)			_btn.addEventListener(MouseEvent.MOUSE_OUT,btnHander)			_btn.addEventListener(MouseEvent.MOUSE_DOWN,btnHander)						this.addEventListener(Event.ENTER_FRAME,enterFrameHander)		}		private function enterFrameHander(event:Event){			_mover.x=mouseX			_mover.y=mouseY		}										private function btnHander(event:MouseEvent){			switch(event.type){				case MouseEvent.MOUSE_DOWN:										_image.startDrag()					stage.addEventListener(MouseEvent.MOUSE_UP,stageHander)				break				case MouseEvent.MOUSE_OVER:						if(_imageIn){						_mover.visible=true						//Mouse.hide()					}									break				case MouseEvent.MOUSE_OUT:										_mover.visible=false					Mouse.show()				break			}		}		private function stageHander(event:MouseEvent){			stopDrag()			stage.removeEventListener(MouseEvent.MOUSE_UP,stageHander)		}		public function _openFile(){			_fileReference.addEventListener(Event.SELECT,fileReferenceHander)			_fileReference.addEventListener(Event.COMPLETE,fileReferenceHander)			_fileReference.browse()		}		private function fileReferenceHander(event:Event){			switch(event.type){				case Event.SELECT:					_fileReference.load()				break				case Event.COMPLETE:					var _byteArray:ByteArray=_fileReference.data					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderHander)					_loader.loadBytes(_byteArray)									break			}					}		public function _loadPic(__picPath:String){									_preloader.x=0.5*_mask.width			_preloader.y=0.5*_mask.height						_preloader.visible=true						ImageLoader.loadAt(__picPath,_picByLoad,_imageWidth,_imageHeigh,_loadedHander,ImageLoader.SHOW_ALL)					}		private function _loadedHander(){						_preloader.visible=false						_picByLoad.scaleX=_picByLoad.scaleY=1						_Pic=_picByLoad		}		public function set _Pic(__pic:DisplayObject){			var _n:int=_image.numChildren			for(var i:int=0;i<_n;i++){				_image.removeChildAt(0)			}						_image.scaleX=_image.scaleY=1			_image.rotation=0			_image.x=0.5*_mask.width			_image.y=0.5*_mask.height						var _scale:Number=Math.max(_imageWidth/__pic.width,_imageHeigh/__pic.height)			__pic.scaleX=__pic.scaleY=_scale						__pic.x=-0.5*__pic.width			__pic.y=-0.5*__pic.height			_image.addChild(__pic)						_imageIn=true			this.dispatchEvent(new Event(EVENT_PICIN))		}				private function loaderHander(event:Event){			var _bitemap:Bitmap=Bitmap(event.target.content)			_bitemap.smoothing=true						this._Pic=_bitemap		}					}	}