/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import morn.core.events.UIEvent;
	import morn.core.utils.StringUtils;
	
	/**对话框*/
	public class Dialog extends View {
		
		public static const CLOSE:String = "close";
		public static const CANCEL:String = "cancel";
		public static const OK:String = "ok";
		
		protected var _dragArea:Rectangle;
		
		public function Dialog() {
			addEventListener(UIEvent.VIEW_CREATED, onViewCreated);
		}
		
		private function onViewCreated(e:UIEvent):void {
			var dragTarget:DisplayObject = getChildByName("drag");
			if (dragTarget) {
				dragArea = dragTarget.x+","+dragTarget.y+","+dragTarget.width+","+dragTarget.height;
				removeElement(dragTarget);
			}
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {
					case CLOSE: 
					case CANCEL: 
					case OK: 
						close(btn.name);
						break;
				}
			}
		}
		
		/**显示对话框(会关闭已打开的非模式窗口)*/
		public function show():void {
			App.dialog.show(this);
		}
		
		/**显示对话框(不会关闭其他窗口)*/
		public function popup():void {
			App.dialog.popup(this);
		}
		
		/**作为模式窗口打开*/
		public function modal():void {
			App.dialog.modal = this;
		}
		
		/**关闭对话框*/
		public function close(type:String = null):void {
			App.dialog.remove(this);
		}
		
		/**拖动区域(格式:x:Number=0, y:Number=0, width:Number=0, height:Number=0)*/
		public function get dragArea():String {
			return StringUtils.rectToString(_dragArea);
		}
		
		public function set dragArea(value:String):void {
			if (StringUtils.isNotEmpty(value)) {
				var a:Array = StringUtils.fillArray([0, 0, 0, 0], value);
				_dragArea = new Rectangle(a[0], a[1], a[2], a[3]);
				addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			} else {
				_dragArea = null;
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
		}
		
		private function onMouseDown(e:MouseEvent):void {
			if (_dragArea.contains(mouseX, mouseY)) {
				App.drag.doDrag(this);
			}
		}
	}
}