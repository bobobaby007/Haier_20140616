package com.douban.event {
    import flash.events.Event;
    public class SongEvent extends Event{

        public static const SONG_EVENT:String = "songEvent";

        private var songData;
        public function SongEvent(){
            super(SONG_EVENT);
        }
        public function set data(d){
            songData = d;
        }
        public function get data(){
            return songData;
        }
    }
}

