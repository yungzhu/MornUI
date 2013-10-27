package view {
	import flash.events.MouseEvent;
	import game.ui.other.DataSourceTestUI;
	
	/**赋值示例*/
	public class DataSourceTest extends DataSourceTestUI {
		
		public function DataSourceTest() {
			btn.addEventListener(MouseEvent.CLICK, onBtnClick);
		}
		
		private function onBtnClick(e:MouseEvent):void {
			//默认属性赋值，改变组件的默认属性
			box1.dataSource = {label1: "改变了label1", label2: "改变了label2", check: true, progress: 0.8};
			
			//任意属性赋值，可以对组件任意属性进行修改
			box2.dataSource = {label1: {color: 0xff0000, bold: true, text: "改变了颜色，粗细"}, label2: "改变了label2", progress: 0.2};
			
			//List赋值
			var arr:Array = [];
			for (var i:int = 0; i < 10; i++) {
				arr.push({icon: i % 10, label: "This is index " + i});
			}
			list.array = arr;
		}
	}
}