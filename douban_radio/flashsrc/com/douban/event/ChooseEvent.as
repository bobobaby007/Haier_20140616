package com.douban.event{
	import flash.events.Event;
	public class ChooseEvent extends Event {
		public static const ONCHOOSE:String="onChoose";
		private var _value;
		public var channel;
		public function ChooseEvent() {
			super(ONCHOOSE);
		}
		public function set value(v) {
			_value=v;
		}
		public function get value() {
			return _value;
		}
	}
}