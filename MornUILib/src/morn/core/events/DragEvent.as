/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.events {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**拖动事件类*/
	public class DragEvent extends Event {
		public static const DRAG_START:String = "dragStart";
		public static const DRAG_DROP:String = "dragDrop";
		public static const DRAG_COMPLETE:String = "dragComplete";
		
		protected var _data:*;
		protected var _dragInitiator:DisplayObject;
		
		public function DragEvent(type:String, dragInitiator:DisplayObject = null, data:* = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_dragInitiator = dragInitiator;
			_data = data;
		}
		
		/**拖动的源对象*/
		public function get dragInitiator():DisplayObject {
			return _dragInitiator;
		}
		
		public function set dragInitiator(value:DisplayObject):void {
			_dragInitiator = value;
		}
		
		/**拖动传递的数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		
		override public function clone():Event {
			return new DragEvent(type, _dragInitiator, _data, bubbles, cancelable);
		}
	}
}