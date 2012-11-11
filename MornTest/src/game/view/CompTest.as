package game.view {
	import flash.display.DisplayObject;
	import game.ui.CompTestUI;
	import morn.core.components.Box;
	import morn.core.components.Clip;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**
	 * 组件使用实例
	 */
	public class CompTest extends CompTestUI {
		public static const instance:CompTest = new CompTest();
		
		public function CompTest() {
			testBtn();
			testList();
			testTab();
			closeBtn.clickHandler = new Handler(close);
		}
		
		/**测试按钮*/
		private function testBtn():void {
			btn.clickHandler = new Handler(onBtnClick);
		}
		
		private function onBtnClick():void {
			checkbox.selected = !checkbox.selected;
			radioGroup.selectedValue = "item0";
			progressBar.value = Math.random();
			hSlider.value = Math.random() * 100;
			clip.index = Math.random() * 9;
		}
		
		private var _listData:Array = ["label1", "label2", "label3", "label4", "label5", "label6", "label7", "label8", "label9", "label10", "label11", "label12", "label13", "label14", "label15", "label16", "label17", "label18", "label19", "label20"];
		
		/**测试list*/
		private function testList():void {
			list.length = _listData.length;
			list.renderHandler = new Handler(listRender);
		}
		
		private function listRender(item:DisplayObject, index:int):void {
			var box:Box = item as Box;
			var icon:Clip = box.getChildByName("icon") as Clip;
			var label:Label = box.getChildByName("label") as Label;
			icon.index = index % 10;
			label.text = _listData[index];
		}
		
		/**测试Tab及viewStack*/
		private function testTab():void {
			tab.selectHandler = viewStack.setIndexHandler;
		}
	}
}