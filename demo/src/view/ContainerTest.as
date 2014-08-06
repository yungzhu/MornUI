package view {
	import flash.display.Graphics;
	import flash.events.Event;
	import game.ui.comps.ContainerTestUI;
	
	/**相对定位容器示例*/
	public class ContainerTest extends ContainerTestUI {
		private var _offset:int = 1;
		
		public function ContainerTest() {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);		
		}
		
		private function onEnterFrame(e:Event):void {
			if (_width < 400 || _width > 600) {
				_offset = -_offset;
			}
			width += _offset;
			height += _offset;
			drawBg();
		}
		
		private function drawBg():void {
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1, 0x999999);
			g.drawRect(0, 0, _width, _height);
			g.beginFill(0xffffff);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
		}
	}
}