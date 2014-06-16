package com.douban.event {
    import flash.events.Event;
    public class PlayErrorEvent extends Event{

        public static const PLAY_ERROR:String = "playError";

        public static const ERROR_LOAD_TIMEOUT = "errorLoadTimeout";
        public static const ERROR_BUFFERING = "errorBuffering";
        public static const ERROR_IOERROR = "errorIOError";

        private var err;
        public function PlayErrorEvent(){
            super(PLAY_ERROR);
        }
        public function set error(e){
            err = e;
        }
        public function get error(){
            return err;
        }
    }
}

