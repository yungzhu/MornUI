/**
 * Morn UI Version 2.5.1215 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	
	/**具有相对定位功能的容器*/
	public class Container extends Box {
		protected var _top:Number;
		protected var _bottom:Number;
		protected var _left:Number;
		protected var _right:Number;
		protected var _centerX:Number;
		protected var _centerY:Number;
		
		public function Container() {
			addEventListener(Event.ADDED, onAdded);
			addEventListener(Event.REMOVED, onRemoved);
		}
		
		private function onRemoved(e:Event):void {
			if (e.target == this) {
				parent.removeEventListener(Event.RESIZE, onResize);
			}
		}
		
		protected function onAdded(e:Event):void {
			if (e.target == this) {
				parent.addEventListener(Event.RESIZE, onResize);
				callLater(resetPosition);
			}
		}
		
		protected function onResize(e:Event):void {
			callLater(resetPosition);
		}
		
		/**居父容器顶上的距离*/
		public function get top():Number {
			return _top;
		}
		
		public function set top(value:Number):void {
			_top = value;
			callLater(resetPosition);
		}
		
		/**居父容器底部的距离*/
		public function get bottom():Number {
			return _bottom;
		}
		
		public function set bottom(value:Number):void {
			_bottom = value;
			callLater(resetPosition);
		}
		
		/**居父容器左边的距离*/
		public function get left():Number {
			return _left;
		}
		
		public function set left(value:Number):void {
			_left = value;
			callLater(resetPosition);
		}
		
		/**居父容器右边的距离*/
		public function get right():Number {
			return _right;
		}
		
		public function set right(value:Number):void {
			_right = value;
			callLater(resetPosition);
		}
		
		/**水平居中偏移位置*/
		public function get centerX():Number {
			return _centerX;
		}
		
		public function set centerX(value:Number):void {
			_centerX = value;
			callLater(resetPosition);
		}
		
		/**垂直居中偏移位置*/
		public function get centerY():Number {
			return _centerY;
		}
		
		public function set centerY(value:Number):void {
			_centerY = value;
			callLater(resetPosition);
		}
		
		override public function commitMeasure():void {
			exeCallLater(resetPosition);
		}
		
		protected function resetPosition():void {
			if (parent) {
				if (!isNaN(_centerX)) {
					x = (parent.width - displayWidth) * 0.5 + _centerX;
				} else if (!isNaN(_left)) {
					x = _left;
					if (!isNaN(_right)) {
						width = parent.width - _left - _right;
					}
				} else if (!isNaN(_right)) {
					x = parent.width - displayWidth - _right;
				}
				if (!isNaN(_centerY)) {
					y = (parent.height - displayHeight) * 0.5 + _centerY;
				} else if (!isNaN(_top)) {
					y = _top;
					if (!isNaN(_bottom)) {
						height = parent.height - _top - _bottom;
					}
				} else if (!isNaN(_bottom)) {
					y = parent.height - displayHeight - _bottom;
				}
			}
		}
	}
}