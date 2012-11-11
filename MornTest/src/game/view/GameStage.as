package game.view {
	import flash.events.MouseEvent;
	import game.ui.SceneUI;
	import game.view.dialogs.DialogTest;
	
	/**
	 * 游戏场景
	 */
	public class GameStage extends SceneUI {
		
		public function GameStage() {
			btn1.addEventListener(MouseEvent.CLICK, onBtn1Click);
			btn2.addEventListener(MouseEvent.CLICK, onBtn2Click);
		}
		
		/**测试普通窗口*/
		private function onBtn1Click(e:MouseEvent):void {
			DialogTest.instance.show();
		}
		
		/**测试模式窗口*/
		protected function onBtn2Click(e:MouseEvent):void {
			App.dialog.modal = CompTest.instance;
		}
	}
}