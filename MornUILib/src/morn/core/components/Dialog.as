/**
 * Morn UI Version 3.2 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**对话框*/
	public class Dialog extends View {
		public static const CLOSE:String = "close";
		public static const CANCEL:String = "cancel";
		public static const SURE:String = "sure";
		public static const NO:String = "no";
		public static const OK:String = "ok";
		public static const YES:String = "yes";
		
		protected var _dragArea:Rectangle;
		protected var _popupCenter:Boolean = true;
		protected var _closeHandler:Handler;
		
		public function Dialog() {
		}
		
		override protected function initialize():void {
			var dragTarget:DisplayObject = getChildByName("drag");
			if (dragTarget) {
				dragArea = dragTarget.x + "," + dragTarget.y + "," + dragTarget.width + "," + dragTarget.height;
				removeElement(dragTarget);
			}
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		/**默认按钮处理*/
		protected function onClick(e:MouseEvent):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {
					case CLOSE: 
					case CANCEL: 
					case SURE: 
					case NO: 
					case OK: 
					case YES: 
						close(btn.name);
						break;
				}
			}
		}
		
		/**显示对话框(非模式窗口)
		 * @param closeOther 是否关闭其他对话框*/
		public function show(closeOther:Boolean = false):void {
			App.dialog.show(this, closeOther);
		}
		
		/**显示对话框(模式窗口)
		 * @param closeOther 是否关闭其他对话框*/
		public function popup(closeOther:Boolean = false):void {
			App.dialog.popup(this, closeOther);
		}
		
		/**关闭对话框*/
		public function close(type:String = null):void {
			App.dialog.close(this);
			if (_closeHandler != null) {
				_closeHandler.executeWith([type]);
			}
		}
		
		/**拖动区域(格式:x:Number=0, y:Number=0, width:Number=0, height:Number=0)*/
		public function get dragArea():String {
			return StringUtils.rectToString(_dragArea);
		}
		
		public function set dragArea(value:String):void {
			if (Boolean(value)) {
				var a:Array = StringUtils.fillArray([0, 0, 0, 0], value, int);
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
		
		/**是否弹出*/
		public function get isPopup():Boolean {
			return parent != null;
		}
		
		/**是否居中弹出*/
		public function get popupCenter():Boolean {
			return _popupCenter;
		}
		
		public function set popupCenter(value:Boolean):void {
			_popupCenter = value;
		}
		
		/**关闭回调(返回按钮名称name:String)*/
		public function get closeHandler():Handler {
			return _closeHandler;
		}
		
		public function set closeHandler(value:Handler):void {
			_closeHandler = value;
		}
	}
}