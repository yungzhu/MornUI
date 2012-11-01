/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import flash.events.Event;
	
	/**具有相对定位功能的容器*/
	public class Container extends Box {
		private var _top:Number;
		private var _bottom:Number;
		private var _left:Number;
		private var _right:Number;
		
		public function Container() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void {
			App.stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onRemovedFromStage(e:Event):void {
			App.stage.removeEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void {
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
		
		private function resetPosition():void {
			if (parent) {
				if (!isNaN(_left)) {
					x = _left;
					if (!isNaN(_right)) {
						width = parent.width - _left - _right;
					}
				} else if (!isNaN(_right)) {
					x = parent.width - width - _right;
				}
				if (!isNaN(_top)) {
					y = _top;
					if (!isNaN(_bottom)) {
						height = parent.height - _top - _bottom;
					}
				} else if (!isNaN(_bottom)) {
					y = parent.height - height - _bottom;
				}
			}
		}
	}
}