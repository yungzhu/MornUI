package game.view {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.ui.SceneUI;
	
	/**
	 * 测试view
	 */
	public class Scene extends SceneUI {
		
		public function Scene() {
			App.stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize(null);
			chatArea.editable = false;
			btn.addEventListener(MouseEvent.CLICK, onBtnClick);
			btn2.addEventListener(MouseEvent.CLICK, onBtn1Click);
		}
		
		private function onBtn1Click(e:MouseEvent):void {
			App.dialog.modal = TestDialog.instance;
		}
		
		protected function onBtnClick(e:MouseEvent):void {
			TestDialog.instance.show();
		}
		
		private function onStageResize(e:Event):void {
			x = (Config.gameWidth - App.stage.stageWidth) * 0.5;
			y = (Config.gameHeight - App.stage.stageHeight) * 0.5;
			width = App.stage.stageWidth;
			height = App.stage.stageHeight;
		}
	}
}