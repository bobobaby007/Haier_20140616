package com.douban.event {
    import flash.events.Event;
    public class ListEvent extends Event{
        public static const LISTEVENT:String = "onlistevent";
        private var msg;
        public function ListEvent(){
            super(LISTEVENT);
        }
        public function set message(m){
            msg = m;
        }
        public function get message(){
            return msg;
        }
    }
}

