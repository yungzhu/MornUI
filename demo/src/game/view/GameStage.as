package game.view {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.ui.SceneUI;
	import game.view.dialogs.DialogTest;
	import game.view.dialogs.DialogTest2;
	
	/**
	 * 游戏场景
	 */
	public class GameStage extends SceneUI {
		
		override public function GameStage() {
			btn1.addEventListener(MouseEvent.CLICK, onBtn1Click);
			btn2.addEventListener(MouseEvent.CLICK, onBtn2Click);
			btn3.addEventListener(MouseEvent.CLICK, onBtn3Click);
			App.stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize(null);
		}
		
		//测试相对定位
		private function onStageResize(e:Event):void {
			this.width = App.stage.stageWidth;
			this.height = App.stage.stageHeight;
		}
		
		/**测试普通窗口*/
		private function onBtn1Click(e:MouseEvent):void {
			DialogTest.instance.show();
		}
		
		/**测试普通窗口*/
		private function onBtn2Click(e:MouseEvent):void {
			DialogTest2.instance.show();
		}
		
		/**测试模式窗口*/
		protected function onBtn3Click(e:MouseEvent):void {
			CompTest.instance.popup();
		}
	}
}