/**
 * Morn UI Version 2.0.0526 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.events.Event;
	import flash.utils.Dictionary;
	import morn.core.events.UIEvent;
	
	/**渲染管理器*/
	public class RenderManager {
		private var _methods:Dictionary = new Dictionary();
		
		private function invalidate():void {
			App.stage.addEventListener(Event.RENDER, onValidate);
			//render有一定几率无法触发，这里加上保险处理
			App.stage.addEventListener(Event.ENTER_FRAME, onValidate);
			if (App.stage) {
				App.stage.invalidate();
			}
		}
		
		private function onValidate(e:Event):void {
			App.stage.removeEventListener(Event.RENDER, onValidate);
			App.stage.removeEventListener(Event.ENTER_FRAME, onValidate);
			render();
			App.stage.dispatchEvent(new Event(UIEvent.RENDER_COMPLETED));
		}
		
		private function render():void {
			for (var method:Object in _methods) {
				exeCallLater(method as Function);
			}
		}
		
		public function exeCallLater(method:Function):void {
			if (_methods[method] != null) {
				var args:Array = _methods[method];
				delete _methods[method];
				method.apply(null, args);
			}
		}
		
		/**延迟调用*/
		public function callLater(mothod:Function, args:Array = null):void {
			if (_methods[mothod] == null) {
				_methods[mothod] = args || [];
				invalidate();
			}
		}
	}
}