package com.douban.utils{
  
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  
  public class Motion extends EventDispatcher{
    
    private var _target:DisplayObject;
    private var proNum:Number;
    private var startNum:Number;
    private var endNum:Number;
    private var actionStr:String;
    private var num1:uint;
    private var num2:uint;
    private var func:Function;
    private var cbfunc;
    
    //构造函数与Tween基本上一样，只不过没有按时间计算，只有按帧运动
    //每个参数所表示的值也是一样的，fun:Function传入的参数和Tween一样，使用官方的fl.transitions.easing包
    public function Motion(target:DisplayObject,str:*,fun:Function,_start:Number = 0,_end:Number = 1,_pro:Number = 4){
      actionStr = str;
      _target = target;
      proNum = _pro;
      startNum = _start;
      endNum = _end;
      func = fun;
    }
    
    //创建Motion实例化后，并没有立即播放得执行play才播放，当然播放完一次，也能使用play继续播放
    public function play(callback=null){
      stop();
      num1 = 0;
      _target[actionStr] = startNum;
      cbfunc = callback;
      _target.addEventListener(Event.ENTER_FRAME,fun1);
    }
    
    //顺走所执行事件
    private function fun1(e:Event){
      var t = num1 ++;//当前运行时间
      var d = proNum;//总时间
      var b = startNum;//开始值
      var c = endNum - startNum;//要改变的值
      _target[actionStr] = func(t,b,c,d);//调用官方算法，并且传入4个参数，进行计算！
      if(t > d){//判断是否时间到了
        stop();//ok，播放完毕，那么我们停止吧
        _target[actionStr] = endNum;//并且把参数强制性变成最终值
      }
    }
    
    //反过来播放一次
    public function back(callback=null){
      stop();
      num2 = 0;
      _target[actionStr] = endNum;
      cbfunc = callback;
      _target.addEventListener(Event.ENTER_FRAME,fun2);
    }
    
    //反过来播放的执行事件
    private function fun2(e:Event){
      var t = num2 ++;
      var d = proNum;
      var b = endNum;
      var c = startNum - endNum;
      _target[actionStr] = func(t,b,c,d);
      if(t > d){
        stop();
        _target[actionStr] = startNum;
      }
    }
    
    //停止播放
    public function stop(){
      _target.removeEventListener(Event.ENTER_FRAME,fun1);
      _target.removeEventListener(Event.ENTER_FRAME,fun2);
      dispatchEvent(new Event("stop"));
      if(cbfunc){
          cbfunc();
          cbfunc = undefined;
      }
    }
  }
}
