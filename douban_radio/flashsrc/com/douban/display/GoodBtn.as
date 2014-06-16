package com.douban.display{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    public class GoodBtn extends MovieClip {
        private var _isSelected = false;
        private var _disable = false;
        
        public function GoodBtn() {
            stop();
            buttonMode = true;
            addEventListener(MouseEvent.MOUSE_OVER, onOver);
            addEventListener(MouseEvent.MOUSE_OUT, onNorm);
            addEventListener(MouseEvent.MOUSE_UP, onOver);
        }

        private function onOver(e) {
            if (!_disable) {
                if (_isSelected) {
                    gotoAndStop('selected_hover');
                } else {
                    gotoAndStop('norm_hover');
                }
            }
        }
        private function onNorm(e) {
            if (!_disable) {
                if (_isSelected) {
                    gotoAndStop('selected');
                } else {
                    gotoAndStop('norm');
                }
            }
        }

        public function set selected(select) {
            _isSelected = select;
            if (!_disable) {
                onNorm(0);
            }
        }
        public function get selected() {
            return _isSelected;
        }

        public function set disabled(disable) {
            _disable = disable;
            if (_disable) {
                gotoAndStop('disabled');
            } else {
                if (_isSelected) {
                    gotoAndStop('selected');
                } else {
                    gotoAndStop('norm');
                }
            }
        }
        public function get disabled() {
            return _disable;
        }
    }
}
