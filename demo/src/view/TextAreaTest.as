package view {
	import flash.events.Event;
	import flash.utils.getTimer;
	import game.ui.comps.TextAreaTestUI;
	import morn.core.events.UIEvent;
	
	/**文本域示例*/
	public class TextAreaTest extends TextAreaTestUI {
		public function TextAreaTest() {
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			//App.timer.doLoop(2000, changeText);
			//保持在底部
			area2.addEventListener(UIEvent.SCROLL, onArea2Scroll);
		}
		
		private function onRemovedFromStage(e:Event):void {
			App.timer.clearTimer(changeText);
		}
		
		private function changeText():void {
			area2.text += "\n" + getTimer();
		}
		
		private function onArea2Scroll(e:UIEvent):void {
			area2.scrollTo(area2.maxScrollV);
		}
	}
}