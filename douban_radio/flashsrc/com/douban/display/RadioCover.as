package com.douban.display {

    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.system.LoaderContext;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.DropShadowFilter;
    import com.douban.utils.Motion;
    import fl.transitions.easing.Regular;
    
    public class RadioCover extends Sprite{

        public var dropShadow:Boolean = true;
        private var _clickUrl:String = '';
        private var picUrl:String;
        private var oldLoader:Loader, workingLoader:Loader;
        private var picture, picMask, workingPic, oldPic;
        private var status:String;
        private var size;
        private static const DONE = '0', LOADING = '1', FADING = '2';

        public function RadioCover(theSize) {
            size = theSize;
            addEventListener(MouseEvent.CLICK, onClick);
            status = DONE;
            picture = new Sprite;
            workingPic = new Sprite;
            picMask = new Shape;
            addChild(picture);
            addChild(picMask);
            picture.addChild(workingPic);
            picMask.graphics.beginFill(0x000000);
            picMask.graphics.drawRect(0, 0, size, size);
            picture.mask = picMask;
        }
        public function set clickUrl(u){
            if (u) {
                u = /^http:/.test(u) ? u : "http://www.douban.com" + u;
                buttonMode = true;
            } else {
                buttonMode = false;
            }
            _clickUrl = u;
        }

        public function get clickUrl() {
            return _clickUrl;
        }

        private function onClick(e) {
            if (_clickUrl) {
                navigateToURL(new URLRequest(_clickUrl));
            }
        }

        public function showPicture(url) {
            if (url != picUrl) {
                picUrl = url;
                if (status == LOADING) {
                    try {
                        workingLoader.close();
                        workingLoader.unload();
                    } catch(e) { }
                } else {
                    if (status == FADING) {
                        onFadeInDone();
                    }
                    workingPic = new Sprite;
                    workingLoader = new Loader();
                    picture.addChild(workingPic);
                    workingPic.addChild(workingLoader);
                    workingLoader.addEventListener(IOErrorEvent.IO_ERROR, pic_ioError);
                    workingLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
                }
                var context = new LoaderContext(true);
                workingLoader.load(new URLRequest(url), context);
                status = LOADING;
                if (dropShadow) {
                    //distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout
                    var filter = new DropShadowFilter(2, 45, 0x000000, 0.7, 4,4, 0.7, 
                            BitmapFilterQuality.HIGH, false, false)

                    filters = [filter];
                }
            }
        }

        private function pic_ioError(e) {
            status = DONE;
            dispatchEvent(e);
        }

        private function onComplete(e) {
            var nowPic = e.target;
            if (workingLoader.content is Bitmap) {
                var bitmap:Bitmap = workingLoader.content as Bitmap;
                bitmap.smoothing = true;
            }
            if (nowPic.height >= nowPic.width) {
                workingPic.height = size * nowPic.height / nowPic.width;
                workingPic.width = size;
                workingPic.x = 0;
            } else {
                workingPic.height = size;
                workingPic.width = size * nowPic.width / nowPic.height;
                workingPic.x = 0 - (workingPic.width - size)/2;
            }
            var fadeInMo = new Motion(workingLoader, "alpha", Regular.easeOut, 0, 1, 24);
            fadeInMo.play(onFadeInDone);
            workingLoader.removeEventListener(IOErrorEvent.IO_ERROR, pic_ioError);
            if (workingLoader.contentLoaderInfo){
                workingLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
            }
            status = FADING;
        }

        private function onFadeInDone(...e) {
            if (status == FADING) {
                if (oldLoader) {
                    oldLoader.unload();
                    oldLoader.parent.removeChild(oldLoader);
                }
                if (oldPic) {
                    picture.removeChild(oldPic);
                    oldPic = null;
                }
                oldPic = workingPic;
                oldLoader = workingLoader;
                status = DONE;
            }
        }
    }
}
