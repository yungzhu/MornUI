package game.view.dialogs {
	import game.ui.dialogs.DialogTestUI;
	
	/**
	 * 对话框测试
	 */
	public class DialogTest extends DialogTestUI {
		private static var _instance:DialogTest;
		
		public function DialogTest() {
		
		}
		
		/**单例*/
		public static function get instance():DialogTest {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new DialogTest();
			}
		}
	}
}