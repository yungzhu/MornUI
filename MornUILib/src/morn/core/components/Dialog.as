/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**对话框*/
	public class Dialog extends View {
		
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
		public function close():void {
			App.dialog.remove(this);
		}
	}
}