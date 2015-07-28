/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.managers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import morn.core.events.DragEvent;
	
	/**拖动管理类*/
	public class DragManager {
		private var _dragInitiator:DisplayObject;
		private var _dragImage:Sprite;
		private var _data:*;
		
		public function DragManager() {
		}
		
		/**开始拖动
		 * @param dragInitiator 拖动的源对象
		 * @param dragImage 显示拖动的图片，如果为null，则是源对象本身
		 * @param data 拖动传递的数据
		 * @param offset 鼠标居拖动图片的偏移*/
		public function doDrag(dragInitiator:Sprite, dragImage:Sprite = null, data:* = null, offset:Point = null):void {
			_dragInitiator = dragInitiator;
			_dragImage = dragImage ? dragImage : dragInitiator;
			_data = data;
			if (_dragImage != _dragInitiator) {
				if (!_dragImage.parent) {
					App.stage.addChild(_dragImage);
				}
				offset = offset || new Point();
				var p:Point = _dragImage.globalToLocal(new Point(App.stage.mouseX, App.stage.mouseY));
				_dragImage.x = p.x - offset.x;
				_dragImage.y = p.y - offset.y;
				_dragImage.visible = false;
			}
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		/**放置把拖动条拖出显示区域*/
		private function onStageMouseMove(e:MouseEvent):void {
			if (!_dragImage.visible) {
				_dragImage.visible = true;
				_dragImage.startDrag();
				_dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_START, _dragInitiator, _data));
			}
			if (e.stageX <= 0 || e.stageX >= App.stage.stageWidth || e.stageY <= 0 || e.stageY >= App.stage.stageHeight) {
				_dragImage.stopDrag();
			} else {
				_dragImage.startDrag();
			}
		}
		
		private function onStageMouseUp(e:Event):void {
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			_dragImage.stopDrag();
			var dropTarget:DisplayObject = getDropTarget(_dragImage.dropTarget);
			if (dropTarget) {
				dropTarget.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP, _dragInitiator, _data));
			}
			_dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_COMPLETE, _dragInitiator, _data));
			if (_dragInitiator != _dragImage && _dragImage.parent) {
				_dragImage.parent.removeChild(_dragImage);
			}
			_dragInitiator = null;
			_data = null;
			_dragImage = null;
		}
		
		private function getDropTarget(value:DisplayObject):DisplayObject {
			while (value) {
				if (value.hasEventListener(DragEvent.DRAG_DROP)) {
					return value;
				}
				value = value.parent;
			}
			return null;
		}
	}
}