/**
 * Morn UI Version 2.4.1020 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**布局容器*/
	public class LayoutBox extends Box {
		protected var _space:int = 0;
		protected var _align:String = "none";
		
		public function LayoutBox() {
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			child.addEventListener(Event.RESIZE, onResize);
			callLater(changeItems);
			return super.addChild(child);
		}
		
		private function onResize(e:Event):void {
			callLater(changeItems);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			child.addEventListener(Event.RESIZE, onResize);
			callLater(changeItems);
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			child.removeEventListener(Event.RESIZE, onResize);
			callLater(changeItems);
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			getChildAt(index).removeEventListener(Event.RESIZE, onResize);
			callLater(changeItems);
			return super.removeChildAt(index);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeItems);
		}
		
		/**刷新*/
		public function refresh():void {
			callLater(changeItems);
		}
		
		protected function changeItems():void {
		
		}
		
		/**子对象的间隔*/
		public function get space():int {
			return _space;
		}
		
		public function set space(value:int):void {
			_space = value;
			callLater(changeItems);
		}
		
		/**子对象对齐方式*/
		public function get align():String {
			return _align;
		}
		
		public function set align(value:String):void {
			_align = value;
			callLater(changeItems);
		}
	}
}