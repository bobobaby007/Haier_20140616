package com.douban.display{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    public class SimBtn extends MovieClip {

        private var _disable = false;

        public function SimBtn() {
            stop();
            buttonMode = true;
            addEventListener(MouseEvent.MOUSE_OVER, onOver);
            addEventListener(MouseEvent.MOUSE_DOWN, onDown);
            addEventListener(MouseEvent.MOUSE_OUT, onNorm);
            addEventListener(MouseEvent.MOUSE_UP, onOver);
        }

        public function onOver(e) {
            if (_disable) return;
            gotoAndStop('over');
        }

        public function onDown(e) {
            if (_disable) return;
            gotoAndStop('down');
        }

        public function onNorm(e) {
            if (_disable) return;
            gotoAndStop('norm');
        }

        public function set disabled(disable) {
            _disable = disable;
            if(disable) {
                gotoAndStop('disabled');
            } else {
                gotoAndStop('norm');
            }
        }

        public function get disabled() {
            return _disable;
        }
    }
}
