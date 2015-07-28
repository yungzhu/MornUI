/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.managers {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**时钟管理器[同一函数多次计时，默认会被后者覆盖,delay小于1会立即执行]*/
	public class TimerManager {
		private var _shape:Shape = new Shape();
		private var _pool:Vector.<TimerHandler> = new Vector.<TimerHandler>();
		private var _handlers:Dictionary = new Dictionary();
		private var _currTimer:int = getTimer();
		private var _currFrame:int = 0;
		private var _count:int = 0;
		private var _index:uint = 0;
		
		public function TimerManager() {
			_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			_currFrame++;
			_currTimer = getTimer();
			for (var key:Object in _handlers) {
				var handler:TimerHandler = _handlers[key];
				var t:int = handler.userFrame ? _currFrame : _currTimer;
				if (t >= handler.exeTime) {
					var method:Function = handler.method;
					var args:Array = handler.args;
					if (handler.repeat) {
						while (t >= handler.exeTime && (key in _handlers) && handler.repeat) {
							handler.exeTime += handler.delay;
							method.apply(null, args);
						}
					} else {
						/*[IF-FLASH]*/clearTimer(key);
						//[IF-SCRIPT]clearTimer(iflash.method.DICKEY(key));
						method.apply(null, args);
					}
				}
			}
		}
		
		private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array = null, cover:Boolean = true):Object {
			var key:Object;
			if (cover) {
				//先删除相同函数的计时
				clearTimer(method);
				key = method;
			} else {
				key = _index++;
			}
			
			//如果执行时间小于1，直接执行
			if (delay < 1) {
				method.apply(null, args)
				return -1;
			}
			var handler:TimerHandler = _pool.length > 0 ? _pool.pop() : new TimerHandler();
			handler.userFrame = useFrame;
			handler.repeat = repeat;
			handler.delay = delay;
			handler.method = method;
			handler.args = args;
			handler.exeTime = delay + (useFrame ? _currFrame : _currTimer);
			/*[IF-FLASH]*/_handlers[key] = handler;
			//[IF-SCRIPT]_handlers[iflash.method.DIC(key)] = handler;
			_count++;
			return key;
		}
		
		/**定时执行一次
		 * @param	delay  延迟时间(单位毫秒)
		 * @param	method 结束时的回调方法
		 * @param	args   回调参数
		 * @param	cover  是否覆盖(true:同方法多次计时，后者覆盖前者。false:同方法多次计时，不相互覆盖)
		 * @return  cover=true时返回回调函数本身，cover=false时，返回唯一ID，均用来作为clearTimer的参数*/
		public function doOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true):Object {
			return create(false, false, delay, method, args, cover);
		}
		
		/**定时重复执行
		 * @param	delay  延迟时间(单位毫秒)
		 * @param	method 结束时的回调方法
		 * @param	args   回调参数
		 * @param	cover  是否覆盖(true:同方法多次计时，后者覆盖前者。false:同方法多次计时，不相互覆盖)
		 * @return  cover=true时返回回调函数本身，cover=false时，返回唯一ID，均用来作为clearTimer的参数*/
		public function doLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true):Object {
			return create(false, true, delay, method, args, cover);
		}
		
		/**定时执行一次(基于帧率)
		 * @param	delay  延迟时间(单位为帧)
		 * @param	method 结束时的回调方法
		 * @param	args   回调参数
		 * @param	cover  是否覆盖(true:同方法多次计时，后者覆盖前者。false:同方法多次计时，不相互覆盖)
		 * @return  cover=true时返回回调函数本身，cover=false时，返回唯一ID，均用来作为clearTimer的参数*/
		public function doFrameOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true):Object {
			return create(true, false, delay, method, args, cover);
		}
		
		/**定时重复执行(基于帧率)
		 * @param	delay  延迟时间(单位为帧)
		 * @param	method 结束时的回调方法
		 * @param	args   回调参数
		 * @param	cover  是否覆盖(true:同方法多次计时，后者覆盖前者。false:同方法多次计时，不相互覆盖)
		 * @return  cover=true时返回回调函数本身，否则返回唯一ID，均用来作为clearTimer的参数*/
		public function doFrameLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true):Object {
			return create(true, true, delay, method, args, cover);
		}
		
		/**定时器执行数量*/
		public function get count():int {
			return _count;
		}
		
		/**清理定时器
		 * @param	method 创建时的cover=true时method为回调函数本身，否则method为返回的唯一ID
		 */
		public function clearTimer(method:Object):void {
			/*[IF-FLASH]*/var handler:TimerHandler = _handlers[method];
			//[IF-SCRIPT]var handler:TimerHandler = _handlers[iflash.method.DICKEY(method)];
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
	public function TimerHandler() {
	}
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