package com.douban.display{

    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.display.Loader;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.events.MouseEvent;
    import flash.net.SharedObject;
    import flash.external.ExternalInterface;
    import com.douban.event.ChooseEvent;
    import com.douban.utils.Motion;
    import fl.transitions.easing.Regular;

    public class ChannelSelect extends Sprite{

        private var _anonyMode:Boolean = true;
        private var chans:Sprite, maskRect:Shape;
        private var btnsArr:Array = [];
        private var so:SharedObject;
        private var _channel, _channelName;
        private var maxPage, nowPage = 0;

        private var CHANNELS = {
            "channels":
                [
                    {"channel_id":0, "seq_id":0, "name":"私人电台", "name_en":"Personal Radio", "abbr_en":""},

                    {"channel_id":1, "seq_id":1, "name":"华语", "name_en":"Chinese", "abbr_en": "CH"},
                    {"channel_id":6, "seq_id":2, "name":"粤语", "name_en":"Cantonese", "abbr_en":"HK"},
                    {"channel_id":2, "seq_id":3, "name":"欧美", "name_en":"Euro-American", "abbr_en":"EN"},
                    {"channel_id":17, "seq_id":4, "name":"日语", "name_en":"Japanese", "abbr_en":"JP"},
                    {"channel_id":13, "seq_id":5, "name":"爵士", "name_en":"Jazz", "abbr_en":"Jazz"},
                    {"channel_id":14, "seq_id":6, "name":"电子", "name_en":"Electronic", "abbr_en":"Elec"},

                    {"channel_id":16, "seq_id":7, "name":"R&B", "name_en":"R&B", "abbr_en":"R&B"},
                    {"channel_id":15, "seq_id":8, "name":"说唱", "name_en":"Rap", "abbr_en":"Rap"},
                    {"channel_id":7, "seq_id":9, "name":"摇滚", "name_en":"Rock", "abbr_en":"Rock"},
                    {"channel_id":8, "seq_id":10, "name":"民谣", "name_en":"Folk", "abbr_en":"Folk"},
                    {"channel_id":10, "seq_id":11, "name":"电影原声", "name_en":"Original", "abbr_en":"Ori"},
                    {"channel_id":9, "seq_id":12, "name":"轻音乐", "name_en":"Easy Listening", "abbr_en":"Easy"},

                    {"channel_id":3, "seq_id":13, "name":"七零", "name_en":"70", "abbr_en":"70"},
                    {"channel_id":4, "seq_id":14, "name":"八零", "name_en":"80", "abbr_en":"80"},
                    {"channel_id":5, "seq_id":15, "name":"九零", "name_en":"90", "abbr_en":"90"},
                    //{"channel_id":12, "seq_id":16, "name":"KFC情人节", "name_en":"KFC", "abbr_en":"KFC"},
                ] };

        public function ChannelSelect() {
            closeBtn.buttonMode = true;
            closeBtn.addEventListener(MouseEvent.CLICK, function(e) { y = -300; });

            chans = new Sprite;
            chans.x = 150;
            chans.y = 48;
            addChild(chans);

            maskRect = new Shape;
            maskRect.x = 144;
            maskRect.y = 40;
            addChild(maskRect);
            maskRect.graphics.beginFill(0x000000);
            maskRect.graphics.drawRect(0, 0, 237, 113);
            chans.mask = maskRect;

            var chs = CHANNELS.channels;
            var chanBtn, page, row, col;

            chanBtn0.buttonMode = true;
            chanBtn0.addEventListener(MouseEvent.CLICK, onChanBtnClick);
            btnsArr.push(chanBtn0);
            maxPage = int((chs.length - 1) / 6);

            for (var i=1; i<chs.length; i++) {
                chanBtn = new ChannelBtn;
                chanBtn.nameTxt.text = chs[i].name;
                chanBtn.name = 'chanBtn' + chs[i].channel_id;
                chanBtn.addEventListener(MouseEvent.CLICK, onChanBtnClick);
                page = int((i - 1) / 6);
                row = int((i - 1) % 6 / 3);
                col = int((i - 1) % 3);
                chanBtn.x = page * 240 + col * 80 + 0.3;
                chanBtn.y = row * 57 + 0.7 * (row+1);
                chanBtn.buttonMode = true;

                /*
                if (i == 1) {
                    var snow = new Loader();
                    snow.addEventListener(IOErrorEvent.IO_ERROR, snow_ioError);
                    try {
                        snow.load(new URLRequest('/pics/radio/snow-2010.png'));
                    } catch(e) {snow_ioError(e)}
                    chanBtn.addChild(snow);
                    snow.x = -10;
                    snow.y = -10;
                }
                */

                chans.addChild(chanBtn);
                btnsArr.push(chanBtn);
            }

            prevPage.addEventListener(MouseEvent.CLICK, prevPageClick);
            nextPage.addEventListener(MouseEvent.CLICK, nextPageClick);

            so = SharedObject.getLocal('douban_radio','/');

        }

        private function nextPageClick(e) {
            if (nowPage < maxPage) {
                showPage(nowPage + 1);
            }
        }

        private function prevPageClick(e) {
            if (nowPage > 0) {
                showPage(nowPage - 1);
            }
        }

        private function showPage(page) {
            nowPage = page;
            var slideMo = new Motion(chans, 'x', Regular.easeInOut, chans.x, 150 - 240 * page, 10);
            slideMo.play();
            nextPage.disabled = nowPage >= maxPage;
            prevPage.disabled = nowPage <= 0;
        }

        private function onChanBtnClick(e) {
            var chanBtn = e.target.parent;
            var chan = chanBtn.name.split('Btn')[1];
            if(anonyMode && chan == 0){
                so.data.toMyRadioFailed = true;
                so.flush();
                trace('should open login');
                ExternalInterface.call('DBR.show_login');
            } else {
                setChannel(chan);
                y = -300;
            }
        }

        public function set channel(chan) {
            setChannel(chan);
        }

        public function get channel() {
            return _channel;
        }

        public function get channelName() {
            return _channelName;
        }

        public function set anonyMode(mode){
            _anonyMode = mode;
        }
        
        public function get anonyMode(){
            return _anonyMode;
        }

        private function setChannel(chan) {
            var cids = CHANNELS.channels.map(
                    function(c){return String(c['channel_id'])});
            if (cids.indexOf(chan) == -1 || (_anonyMode && chan == '0')) {
                chan = 1;
            }

            var ev = new ChooseEvent;
            ev.value = {'channel': chan};
            _channel = chan;

            for (var i=0; i<btnsArr.length; i++) {
                if (btnsArr[i].name.split('Btn')[1] != chan) {
                    btnsArr[i].selected = false;
                } else {
                    btnsArr[i].selected = true;
                    _channelName = ev.value.name = btnsArr[i].nameTxt.text;
                    showPage(int((i - 1) / 6));
                }
            }
            so.data.channel = chan;
            so.flush();
            dispatchEvent(ev);
        }

        private function snow_ioError(e) {
            trace('>'+e.toString());
        }
    }
}
