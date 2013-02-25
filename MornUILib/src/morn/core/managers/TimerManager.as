/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**时钟管理器[同一函数多次计时，会被后者覆盖,delay小于1会立即执行]*/
	public class TimerManager {
		private var _shape:Shape = new Shape();
		private var _pool:Vector.<TimerHandler> = new Vector.<TimerHandler>();
		private var _handlers:Dictionary = new Dictionary();
		private var _currTimer:int = getTimer();
		private var _currFrame:int = 0;
		private var _count:int = 0;
		
		public function TimerManager() {
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			_currFrame++;
			_currTimer = getTimer();
			for each (var handler:TimerHandler in _handlers) {
				var t:int = handler.userFrame ? _currFrame : _currTimer;
				if (t >= handler.exeTime) {
					var method:Function = handler.method;
					var args:Array = handler.args;
					handler.repeat ? handler.exeTime += handler.delay : clearTimer(method);
					method.apply(null, args);
				}
			}
		}
		
		private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array = null):void {
			//先删除相同函数的计时
			clearTimer(method);
			//如果执行时间小于1，直接执行
			if (delay < 1) {
				method.apply(null, args)
				return;
			}
			var handler:TimerHandler = _pool.length > 0 ? _pool.pop() : new TimerHandler();
			handler.userFrame = useFrame;
			handler.repeat = repeat;
			handler.delay = delay;
			handler.method = method;
			handler.args = args;
			handler.exeTime = delay + (useFrame ? _currFrame : _currTimer);
			_handlers[method] = handler;
			_count++;
		}
		
		/**定时执行一次*/
		public function doOnce(delay:int, method:Function, args:Array = null):void {
			create(false, false, delay, method, args);
		}
		
		/**定时重复执行*/
		public function doLoop(delay:int, method:Function, args:Array = null):void {
			create(false, true, delay, method, args);
		}
		
		/**定时执行一次(基于帧率)*/
		public function doFrameOnce(delay:int, method:Function, args:Array = null):void {
			create(true, false, delay, method, args);
		}
		
		/**定时重复执行(基于帧率)*/
		public function doFrameLoop(delay:int, method:Function, args:Array = null):void {
			create(true, true, delay, method, args);
		}
		
		/**定时器执行数量*/
		public function get count():int {
			return _count;
		}
		
		/**清理**/
		public function clearTimer(method:Function):void {
			var handler:TimerHandler = _handlers[method];
			if (handler != null) {
				delete _handlers[method];
				handler.clear();
				_pool.push(handler);
				_count--;
			}
		}
	}
}

/**定时处理器*/
class TimerHandler {
	/**执行间隔*/
	public var delay:int;
	/**是否重复执行*/
	public var repeat:Boolean;
	/**是否用帧率*/
	public var userFrame:Boolean;
	/**执行时间*/
	public var exeTime:int;
	/**处理方法*/
	public var method:Function;
	/**参数*/
	public var args:Array;
	
	/**清理*/
	public function clear():void {
		method = null;
		args = null;
	}
}