package view {
	import flash.events.Event;
	import game.ui.comps.ProgressTestUI;
	
	/**进度条示例*/
	public class ProgressTest extends ProgressTestUI {
		
		public function ProgressTest() {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			progress1.barLabel.color = 0x333333;
			progress1.barLabel.stroke = "0xffffff";
		}
		
		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			progress1.value += 0.005;
			if (progress1.value >= 1) {
				progress1.value = 0;
			}
			progress1.label = "当前进度" + int(progress1.value * 100) + "%";
		}
	}
}