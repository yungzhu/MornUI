/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.events.Event;
	import flash.utils.Dictionary;
	import morn.core.events.UIEvent;
	
	/**渲染管理器*/
	public class RenderManager {
		private var _methods:Dictionary = new Dictionary();
		
		public function RenderManager() {
		}
		
		private function invalidate():void {
			if (App.stage) {
				//render有一定几率无法触发，这里加上保险处理
				App.stage.addEventListener(Event.ENTER_FRAME, onValidate);
				App.stage.addEventListener(Event.RENDER, onValidate);
				App.stage.invalidate();
			}
		}
		
		private function onValidate(e:Event):void {
			App.stage.removeEventListener(Event.RENDER, onValidate);
			App.stage.removeEventListener(Event.ENTER_FRAME, onValidate);
			renderAll();
			App.stage.dispatchEvent(new Event(UIEvent.RENDER_COMPLETED));
		}
		
		/**执行所有延迟调用*/
		public function renderAll():void {
			for (var method:Object in _methods) {
				exeCallLater(method as Function);
			}
			for each (method in _methods) {
				return renderAll();
			}
		}
		
		/**延迟调用*/
		public function callLater(method:Function, args:Array = null):void {
			if (_methods[method] == null) {
				_methods[method] = args || [];
				invalidate();
			}
		}
		
		/**执行延迟调用*/
		public function exeCallLater(method:Function):void {
			if (_methods[method] != null) {
				var args:Array = _methods[method];
				delete _methods[method];
				method.apply(null, args);
			}
		}
	}
}