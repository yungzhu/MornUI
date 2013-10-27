package view {
	import flash.events.MouseEvent;
	import game.ui.comps.ButtonTestUI;
	import morn.core.handlers.Handler;
	
	/**按钮示例*/
	public class ButtonTest extends ButtonTestUI {
		
		private var _count:int;
		
		public function ButtonTest() {
			btn1.addEventListener(MouseEvent.CLICK, onBtn1Click);
			//利用clickHandler传参数
			btn2.clickHandler = new Handler(onBtn2Click, ["Hello World"]);
		}
		
		private function onBtn1Click(e:MouseEvent):void {
			_count++;
			btn1.label = "我被点了 " + _count + " 次";
		}
		
		private function onBtn2Click(word:String):void {
			btn2.label = word;
		}
	}
}