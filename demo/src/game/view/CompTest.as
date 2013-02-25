package game.view {
	import game.ui.CompTestUI;
	import game.ui.TestTipsUI;
	import morn.core.components.Component;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**
	 * 组件使用实例
	 */
	public class CompTest extends CompTestUI {
		public static const instance:CompTest = new CompTest();
		private var _testTips:TestTipsUI = new TestTipsUI();
		
		override public function CompTest() {
			testDataSource();
			testTips();
			testBtn();
			testList();
			testTab();
			testLang();
		}
		
		/**测试数据赋值*/
		protected function testDataSource():void {
			//简单的赋值操作，改变组件的默认属性
			dataSource = {label: "改变了label", checkbox: true};
			//复杂的赋值操作实例，可以对组件任意属性赋值
			//dataSource = {label: {text:"改变了label",size:14}, checkbox: true};
		}
		
		/**测试鼠标提示*/
		private function testTips():void {
			//简单tips
			btn2.toolTip = "这个是大按钮这个是<b>大按钮</b><br>这个是大按钮这个是大按钮这个是大按钮这个是大按钮<br>这个是大按钮这个是大按钮";
			//复杂tips
			btn1.toolTip = showTips1;
			//带参数的tips
			clip.toolTip = new Handler(showTips2, ["clip"]);
		}
		
		private function showTips1():void {
			_testTips.label.text = "这里是按钮[" + btn1.label + "]";
			App.tip.addChild(_testTips);
		}
		
		private function showTips2(name:String):void {
			_testTips.label.text = "这里是" + name;
			App.tip.addChild(_testTips);
		}
		
		/**测试按钮*/
		private function testBtn():void {
			btn1.clickHandler = new Handler(onBtnClick);
			btn2.clickHandler = new Handler(onBtnClick);
		}
		
		private function onBtnClick():void {
			checkbox.selected = !checkbox.selected;
			radioGroup1.selectedIndex = Math.random() * 2;
			radioGroup2.selectedIndex = Math.random() * 3;
			progressBar.value = Math.random();
			hslider.value = Math.random() * 100;
			clip.frame = Math.random() * 9;
			combo.selectedIndex = Math.random() * 2;
		}
		
		/**测试list*/
		private function testList():void {
			//list赋值
			list.dataSource = [{icon: 0, label: "label1"}, {icon: 1, label: "label2"}, {icon: 2, label: "label3"}, {icon: 3, label: "label4"}, {icon: 4, label: "label5"}, {icon: 5, label: "label6"}, {icon: 6, label: "label7"}, {icon: 7, label: "label8"}, {icon: 8, label: "label9"}, {icon: 9, label: "label10"}, {icon: 0, label: "label11"}, {icon: 1, label: "label12"}];
			//自定义项渲染方式
			list.renderHandler = new Handler(listRender);
		}
		
		/**自定义List项渲染*/
		private function listRender(item:Component, index:int):void {
			if (index < list.length) {
				var label:Label = item.getChildByName("label") as Label;
				label.text = list.array[index].label + "[" + index + "]";
			}
		}
		
		/**测试Tab及viewStack*/
		private function testTab():void {
			tab.selectHandler = viewStack.setIndexHandler;
		}
		
		/**测试多语言参数的使用*/
		protected function testLang():void {
			label.text = App.lang.getLang("测试多语言{0}{1}", "lang", int(Math.random() * 10));
		}
	}
}