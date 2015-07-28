package view {
	import game.ui.comps.ComboBoxTestUI;
	import morn.core.handlers.Handler;
	
	/**下拉框示例*/
	public class ComboBoxTest extends ComboBoxTestUI {
		
		public function ComboBoxTest() {
			var arr:Array = [];
			for (var i:int = 0; i < 100; i++) {
				arr.push("这是第 " + i + " 项");
			}
			//combo1.labels = arr.join(",");
			combo2.labels = arr.join(",");
			
			combo2.selectHandler = new Handler(onCombo1Select);
		}
		
		private function onCombo1Select(index:int):void {
			label.text = "selectedIndex:" + combo2.selectedIndex + " selectedLabel:" + combo2.selectedLabel;
		}
	}
}