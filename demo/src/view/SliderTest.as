package view {
	import flash.events.Event;
	import game.ui.comps.SliderTestUI;
	
	/**滚动条*/
	public class SliderTest extends SliderTestUI {
		
		public function SliderTest() {
			slider.addEventListener(Event.CHANGE, onSliderChange);
		}
		
		private function onSliderChange(e:Event):void {
			trace(slider.value);
		}
	}
}