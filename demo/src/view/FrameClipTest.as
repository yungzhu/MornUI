package view {
	import flash.events.Event;
	import game.ui.comps.FrameClipTestUI;
	
	/**矢量图示例*/
	public class FrameClipTest extends FrameClipTestUI {
		private var _offset:Number = 0.01;
		
		public function FrameClipTest() {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			mc.interval = 50;
			mc.play();
		}
		
		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			mc.scale += _offset;
			if (mc.scale > 2.5 || mc.scale < 1) {
				_offset = -_offset;
			}
		}
	}
}