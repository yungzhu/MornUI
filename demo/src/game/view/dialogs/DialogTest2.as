package game.view.dialogs {
	import game.ui.dialogs.DialogTest2UI;
	
	/**
	 * 对话框测试
	 */
	public class DialogTest2 extends DialogTest2UI {
		private static var _instance:DialogTest2;
		
		public function DialogTest2() {
		
		}
		
		/**单例*/
		public static function get instance():DialogTest2 {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new DialogTest2();
			}
		}
	}
}