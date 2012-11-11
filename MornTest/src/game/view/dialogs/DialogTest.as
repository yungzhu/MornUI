package game.view.dialogs {
	import game.ui.dialogs.DialogTestUI;
	import morn.core.handlers.Handler;
	
	/**
	 * 对话框测试
	 */
	public class DialogTest extends DialogTestUI {
		public static const instance:DialogTest = new DialogTest();
		
		public function DialogTest() {
			closeBtn.clickHandler = new Handler(close);
		}
	}
}