package view {
	import flash.events.MouseEvent;
	import game.ui.comps.CheckBoxTestUI;
	
	/**多选框示例*/
	public class CheckBoxTest extends CheckBoxTestUI {
		
		public function CheckBoxTest() {
			check.addEventListener(MouseEvent.CLICK, onCheckClick);
		}
		
		private function onCheckClick(e:MouseEvent):void {
			if (check.selected) {
				check.label = "我被选中了";
			} else {
				check.label = "我没有被选中";
			}
		}
	}
}