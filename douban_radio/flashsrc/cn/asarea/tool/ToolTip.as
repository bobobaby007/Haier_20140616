/**
*Author: ATHER Shu 2008.7.15
* ToolTip类: 鼠标提示类
* 功能：
* 1.绑定某DisplayObject以显示鼠标提示 BindDO
* 2.去除某DisplayObject绑定 LooseDO
* 3.动态更改某DisplayObject鼠标提示信息 setDOInfo
* 4.测试某DisObject是否已经绑定 TestDOBinding
* 5.动态隐藏所有鼠标提示 hideToolTip
* 6.动态显示所有鼠标提示 showToolTip
* 7.清空所有鼠标提示 removeToolTip
* 8.设定全局鼠标提示样式 setTipProperty
* http://www.asarea.cn
* ATHER Shu(AS)
*/
package cn.asarea.tool{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	import flash.display.Stage;

	public class ToolTip extends Sprite {
		static private  var m_stage:Stage;//注，tooltip必须加到stage下
		static private  var m_ntxtcolor:uint=0x666666;
		static private  var m_font:String='_sans';
		static private  var m_ntxtsize:int=12;
		static private  var m_nbordercolor:uint=0xfff1c0;
		static private  var m_nbgcolor:uint=0xfff1c0;
		static private  var m_nmaxtxtwidth:Number=200;
		//
		static private  var m_uniqueInstance:ToolTip;
		//
		private var m_arrDOTips:Array;
		private var m_tipTxt:TextField;
		//
		public function ToolTip() {
			super();
			m_arrDOTips = new Array();
		}
		//获取全局唯一实例
		private static function getInstance():ToolTip {
			if (m_uniqueInstance == null) {
				m_uniqueInstance = new ToolTip();
				m_uniqueInstance.visible = false;
				m_uniqueInstance.m_tipTxt = new TextField();
				m_uniqueInstance.m_tipTxt.autoSize = TextFieldAutoSize.LEFT;
				m_uniqueInstance.m_tipTxt.selectable = false;
				m_uniqueInstance.addChild(m_uniqueInstance.m_tipTxt);
				//
				m_stage.addChild(m_uniqueInstance);
			}
			return m_uniqueInstance;
		}
		//清空tooltips，注：不是隐藏所有，而是彻底清空，如果要隐藏，某一时刻又显示出来的话，采用hide和show
		public static function removeToolTip():void {
			for (var i:int=0; i<getInstance().DOTips.length; i++) {
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.ROLL_OVER, showtip);
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.ROLL_OUT, hidetip);
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.MOUSE_MOVE, movetip);
				getInstance().DOTips[i] = null;
				m_stage.removeChild(getInstance());
				m_uniqueInstance = null;
			}
		}
		//暂时隐藏
		public static function hideToolTip():void {
			m_stage.removeChild(getInstance());
		}
		//再次show
		public static function showToolTip():void {
			m_stage.addChild(getInstance());
		}
		//添加某DO的tip绑定
		public static function BindDO(DO:DisplayObject, info:String):void {
			//test if already been binded
			if (TestDOBinding(DO) == -1) {
				//add to array
				var dotip:Object = {DO:DO, info:info};
				getInstance().DOTips.push(dotip);
				//
				DO.addEventListener(MouseEvent.ROLL_OVER, showtip);
				DO.addEventListener(MouseEvent.ROLL_OUT, hidetip);
				DO.addEventListener(MouseEvent.MOUSE_MOVE, movetip);
			}
		}
		//去除某DO的tip绑定
		public static function LooseDO(DO:DisplayObject):void {
			if (TestDOBinding(DO) != -1) {
				for (var i:int=TestDOBinding(DO); i<getInstance().DOTips.length-1; i++) {
					getInstance().DOTips[i] = getInstance().DOTips[i+1];
				}
				getInstance().DOTips.pop();
                getInstance().visible = false;
				DO.removeEventListener(MouseEvent.ROLL_OVER, showtip);
				DO.removeEventListener(MouseEvent.ROLL_OUT, hidetip);
				DO.removeEventListener(MouseEvent.MOUSE_MOVE, movetip);
			}
		}
		//更改某绑定DO的文字信息
		public static function setDOInfo(DO:DisplayObject, info:String):void {
			if (TestDOBinding(DO) == -1) {
				BindDO(DO, info);
			} else {
				getInstance().DOTips[TestDOBinding(DO)].info = info;
                getInstance().visible = false;
			}
		}//测试是否已经绑定，绑定则返回数组中的次序，否则返回-1
		public static function TestDOBinding(DO:DisplayObject):int {
			var flag:Boolean = false;
			for (var i:int=0; i<getInstance().DOTips.length; i++) {
				if (getInstance().DOTips[i].DO == DO) {
					flag = true;
					break;
				}
			}
			return flag?i:-1;
		}
		//
		private static function showtip(evt:MouseEvent):void {
			getInstance().x = evt.stageX;
			getInstance().y = evt.stageY + 20;//注，20是鼠标高度
			getInstance().m_tipTxt.wordWrap = false;
			getInstance().m_tipTxt.text = getInstance().DOTips[TestDOBinding(evt.target as DisplayObject)].info;
			updatetip();
			getInstance().visible = true;
		}
		private static function hidetip(evt:MouseEvent):void {
			getInstance().visible = false;
		}
		private static function movetip(evt:MouseEvent):void {
			getInstance().x = evt.stageX;
			if(getInstance().x + getInstance().width > m_stage.stageWidth){
				getInstance().x -= getInstance().x + getInstance().width - m_stage.stageWidth
			}
			
			getInstance().y = evt.stageY + 20;
			if(getInstance().y + getInstance().height > m_stage.stageHeight){
				getInstance().y -= getInstance().y + getInstance().height - m_stage.stageHeight
			}
		}
		private static function updatetip():void {
			getInstance().m_tipTxt.textColor = m_ntxtcolor;
			if (getInstance().m_tipTxt.width > m_nmaxtxtwidth) {
				getInstance().m_tipTxt.wordWrap = true;
				getInstance().m_tipTxt.width = m_nmaxtxtwidth;
			}
			
			var tf:TextFormat = new TextFormat();
			tf.size = m_ntxtsize;
			tf.font = m_font
			getInstance().m_tipTxt.setTextFormat(tf);
			//
			var gp:Graphics = getInstance().graphics;
			gp.clear();
			gp.lineStyle(0, m_nbordercolor);
			gp.beginFill(m_nbgcolor);
			gp.drawRect(0, 0, getInstance().m_tipTxt.width, getInstance().m_tipTxt.height);
			gp.endFill();
			//
			//getInstance().filters =[new DropShadowFilter(2)];
		}
		//
		public static function set stage(stage:Stage):void {
			m_stage = stage;
		}
		public static function setTipProperty(txtcolor:uint=0x666666, txtsize:int=12, maxtxtwidth:int=200, bordercolor:uint=0xfff1c0, bgcolor:uint=0xfff1c0, font='_sans'):void {
			m_ntxtcolor = txtcolor;
			m_ntxtsize = txtsize;
			m_nmaxtxtwidth = maxtxtwidth;
			m_nbordercolor = bordercolor;
			m_nbgcolor = bgcolor;
			m_font = font;
		}
		//
		private function get DOTips():Array {
			return m_arrDOTips;
		}
	}
}
