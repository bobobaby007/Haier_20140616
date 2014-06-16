package com.douban.event {
	import flash.events.Event;
	public class CompleteEvent extends Event{
		public static const COMPLETE:String = "onComplete";
		public function CompleteEvent(){
			super(COMPLETE);
		}
	}
}

