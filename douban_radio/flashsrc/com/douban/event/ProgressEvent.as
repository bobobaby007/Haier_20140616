package com.douban.event {
    import flash.events.Event;
    public class ProgressEvent extends Event{
        public static const PROGRESS:String = "onProgress";
        private var pro;
        public function ProgressEvent(){
            super(PROGRESS);
        }
        public function set progress(p){
            pro = p;
        }
        public function get progress(){
            return pro;
        }
    }
}

