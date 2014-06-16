package com.douban.media
{
    import flash.events.IOErrorEvent;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.net.URLRequest;
    import flash.utils.setTimeout;
    import flash.utils.Timer;
    import com.douban.event.CompleteEvent;
    import com.douban.event.ProgressEvent;
    import com.douban.event.PlayErrorEvent;

    public class AudioPlayer extends EventDispatcher {

        public static const PLAY = 0, PAUSE = 1, STOP = 2;
        private var soundLength, percentBuffered;
        private var _status;
        private var soundUrl:String;
        private var sound:Sound;
        private var channel:SoundChannel;
        private var tryTimes = 0;
        private var lg;
        private var timer:Timer;
        private var idleTime=0, holdTime=0, recentPlayed, position;
        private var vol = 1;
        private var infoLength = 0;
        
        public function AudioPlayer(...args) {
            _status = STOP;
            var nfunc = function(...e){};
            lg = args.length > 0 ? args[0] : {'log': nfunc, 'report': nfunc};

            sound = new Sound();
            sound.addEventListener(IOErrorEvent.IO_ERROR,sound_ioError);
            timer = new Timer(40);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
            loadSound(url);
        }

        public function set url(newUrl) {
            loadSound(url);
        }

        public function get url() {
            return soundUrl;
        }

        public function set volume(v) {
            vol = v;
            if (channel) {
                channel.soundTransform = new SoundTransform(v);
            }
        }

        public function get volume() {
            return vol;
        }

        public function play(url=null, len=0) {
            if (url && url != soundUrl) {
                loadSound(url);
                infoLength = int(len);
            }

            if (_status != PAUSE){
                position = 0;
            }
            if (channel){
                channel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
            }
            try {
                channel = sound.play(position);
            } catch(e) {
                sound_ioError(e);
            }
            channel.addEventListener(Event.SOUND_COMPLETE, onComplete);

            channel.soundTransform = new SoundTransform(vol);
            _status = PLAY;
            timer.start();
            //setTimeout(onComplete, 4000);
        }

        public function stop() {
            if (channel) {
                channel.stop();
            }
            _status = STOP;
            timer.stop();
        }

        public function pause() {
            channel.stop();
            _status = PAUSE;
            timer.stop();
        }

        public function get status(){
            return _status;
        }

        private function seek(percent) {
            if (_status == PLAY && channel) {
                channel.stop();
                channel = sound.play(soundLength * percent);
            } else {
                channel = sound.play(soundLength * percent);
                position = channel.position;
                channel.stop();
            }
            channel.soundTransform = new SoundTransform(vol);
        }

        private function loadSound(url=null) {
            if(url) {
                if (channel) {
                    channel.stop();
                }
                try {
                    sound.close();
                    sound.removeEventListener(IOErrorEvent.IO_ERROR, sound_ioError);
                } catch(e) {};
                soundUrl = url;
                try {
                    sound = new Sound();
                    sound.addEventListener(IOErrorEvent.IO_ERROR, sound_ioError);
                    sound.load(new URLRequest(soundUrl));
                } catch(e) {
                    sound_ioError(e);
                }
            }
        }

        private function onTimer(event:TimerEvent):void {
            try {
                var loaded = sound.bytesLoaded;
                var total = sound.bytesTotal;
                soundLength = sound.length;
                position = channel.position;
                percentBuffered = loaded / total;
                soundLength /= percentBuffered;
                var percentPlayed = position / soundLength;
            } catch (e) {
                lg.log(e.message);
                return;
            }

            if (idleTime > 30 * 2) {
                idleTime = 0;
                onComplete();
            } else if (holdTime > 30 * 13) {
                holdTime = 0;
                lg.report('not_play pos:' + loaded + '/' + total + 
                        ' percent played:' + percentPlayed + ' ' + soundUrl, 'ra000');
                onError(PlayErrorEvent.ERROR_LOAD_TIMEOUT);
            }

            if (sound.isBuffering && position > 0) {
                onError(PlayErrorEvent.ERROR_BUFFERING);
            }

            if (sound.isBuffering && position == 0) {
                onProgress(0);
            } else if (_status == PLAY) {
                onProgress(position);
            }

            if (_status == PLAY && ((percentPlayed === recentPlayed) || isNaN(percentPlayed))) {
                holdTime ++;
            } else {
                holdTime = 0;
            }

            if ((percentPlayed === recentPlayed) && (percentPlayed > 0.5) && 
                    (!sound.isBuffering) && _status == PLAY && position > 0) {
                if ((infoLength && position / 1000 >= infoLength) 
                        || percentPlayed >= 1) onComplete();
                idleTime++;
            } else {
                idleTime = 0;
            }
            //lg.log('idle:'+ idleTime + '  ' + recentPlayed + '  ' + percentPlayed);
            if (percentPlayed > recentPlayed) {
                tryTimes = 0;
            }
            recentPlayed = percentPlayed;
        }

        private function sound_ioError(e) {
            lg.report('sound_ioerror ' + soundUrl + ' ' + (tryTimes+1) + ' times. ' + e.text, 'ra009');
            lg.log('load sound io error:' + e.toString() + ' retry in 2 secs');

            if (tryTimes >= 2) {
                tryTimes = 0;
                onError(PlayErrorEvent.ERROR_IOERROR);

            } else {
                tryTimes ++;
                var f = function() {
                    sound.close();
                    sound.load(new URLRequest(soundUrl));
                }
                setTimeout(loadSound, 2000, soundUrl);
            }
        }

        private function onError(err) {
            var ev = new PlayErrorEvent;
            ev.error = err;
            dispatchEvent(ev);
        }

        private function onComplete(...e) {
            timer.stop();
            if (channel) {
                try {
                    channel.stop();
                } catch(e) {
                    lg.log(e.message)
                }
            }
            _status = STOP;
            var ev = new CompleteEvent;
            dispatchEvent(ev);
        }

        private function onProgress(p) {
            var ev = new ProgressEvent;
            ev.progress = p;
            dispatchEvent(ev);
        }
    }
}
