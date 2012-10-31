package game.view {
	import morn.core.components.Button;
	import flash.events.MouseEvent;
	import game.ui.TestDialogUI;
	/**
	 * 测试对话框
	 */
	public class TestDialog extends TestDialogUI {
		
		public static const instance:TestDialog = new TestDialog();
		public function TestDialog() {
			addEventListener(MouseEvent.CLICK, onClick);
		}		
		
		private function onClick(e:MouseEvent):void {
			var name:String = e.target.name;
			if (e.target is Button) {
				if (name == "closeBtn") {
					close();
				}
			}
		}
	}
}