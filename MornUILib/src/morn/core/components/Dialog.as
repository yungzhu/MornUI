/**
 * Version 1.0.0203 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.MouseEvent;
	
	/**对话框*/
	public class Dialog extends View {
		
		public static const CLOSE:String = "close";
		public static const CANCEL:String = "cancel";
		public static const OK:String = "ok";
		
		public function Dialog() {
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
	}
}