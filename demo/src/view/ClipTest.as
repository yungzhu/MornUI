package view {
	import flash.events.MouseEvent;
	import game.ui.comps.ClipTestUI;
	
	/**位图切片示例*/
	public class ClipTest extends ClipTestUI {
		
		public function ClipTest() {
			btn1.addEventListener(MouseEvent.CLICK, onBtn1Click);
			btn2.addEventListener(MouseEvent.CLICK, onBtn2Click);
		}
		
		private function onBtn2Click(e:MouseEvent):void {
			if (clip2.isPlaying) {
				clip2.stop()
			} else {
				clip2.play()
			}
		}
		
		private function onBtn1Click(e:MouseEvent):void {
			clip1.frame = Math.random() * 10;
		}
	}
}