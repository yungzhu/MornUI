package view {
	import flash.events.MouseEvent;
	import game.ui.comps.ListTestUI;
	import morn.core.components.Box;
	import morn.core.components.CheckBox;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**列表示例*/
	public class ListTest extends ListTestUI {
		
		public function ListTest() {
			//数据源
			var arr:Array = [];
			for (var i:int = 0; i < 95; i++) {
				arr.push({icon: i % 10, label: "Index " + i});
			}
			//页面嵌套list
			pageList.array = arr;
			
			//Boxlist
			boxList.array = arr;
			
			//自定义list
			autoList.array = arr;
			prePage.addEventListener(MouseEvent.CLICK, onPageClick);
			nextPage.addEventListener(MouseEvent.CLICK, onPageClick);
			
			//多行多列list
			vlist.array = arr;
			
			//横向list
			hlist.array = arr;
			
			//带有checkBox的list
			var arr2:Array = [];
			for (i = 0; i < 10; i++) {
				arr2.push({check: false, label: "Index " + i});
			}
			checkList.array = arr2;
			checkList.mouseHandler = new Handler(onCheckListMouse);
			
			//自定义渲染的list，可以按照自己的逻辑渲染List
			renderList.renderHandler = new Handler(listRender);
			renderList.dataSource = arr;
		}
		
		/**按照指定的逻辑渲染List*/
		private function listRender(cell:Box, index:int):void {
			if (index < renderList.length) {
				var label:Label = cell.getChildByName("label") as Label;
				label.text = "这里是" + index;
			}
		}
		
		/**处理选择框选中效果*/
		private function onCheckListMouse(e:MouseEvent, index:int):void {
			if (e.type == MouseEvent.CLICK) {
				var cell:Box = checkList.getCell(index);
				var checkBox:CheckBox = cell.getChildByName("check") as CheckBox;
				cell.dataSource["check"] = checkBox.selected;
			}
		}
		
		/**翻页*/
		private function onPageClick(e:MouseEvent):void {
			autoList.page += (e.currentTarget == prePage ? -1 : 1);
		}
	}
}