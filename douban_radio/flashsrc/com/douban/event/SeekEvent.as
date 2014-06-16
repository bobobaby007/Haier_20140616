package com.douban.event {
	import flash.events.Event;
	public class SeekEvent extends Event{
		public static const ONSEEK:String = "onSeek";
		private var _where;
		public function SeekEvent(){
			super(ONSEEK);
		}
		public function set percent(per){
			_where = per;
		}
		public function get percent(){
			return _where;
		}
	}
}