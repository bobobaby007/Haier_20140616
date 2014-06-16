package com.douban.display{
	import flash.display.MovieClip;
	public class PlayBtn extends MovieClip {
		public function PlayBtn() {
			this.stop();
			this.buttonMode = true;
		}
		public function showPlay() {
			this.gotoAndStop('play');
		}
		public function showPause() {
			this.gotoAndStop('pause');
		}
	}
}