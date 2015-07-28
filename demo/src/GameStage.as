package {
	import flash.events.MouseEvent;
	import game.ui.GameStageUI;
	import morn.core.components.Button;
	import view.ButtonTest;
	import view.CheckBoxTest;
	import view.ClipTest;
	import view.ComboBoxTest;
	import view.ContainerTest;
	import view.DataSourceTest;
	import view.FrameClipTest;
	import view.LabelTest;
	import view.LanguageTest;
	import view.LayOutBoxTest;
	import view.ListTest;
	import view.PanelTest;
	import view.ProgressTest;
	import view.RadioGroupTest;
	import view.SliderTest;
	import view.TabTest;
	import view.TextAreaTest;
	import view.TextInputTest;
	import view.ToolTipTest;
	import view.ViewStackTest;
	
	/**游戏舞台*/
	public class GameStage extends GameStageUI {
		
		public function GameStage() {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			this
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.label) {
					case "按钮": 
						new ButtonTest().show(true);
						break;
					case "多选框": 
						new CheckBoxTest().show(true);
						break;
					case "位图切片": 
						new ClipTest().show(true);
						break;
					case "矢量动画": 
						new FrameClipTest().show(true);
						break;
					case "下拉框": 
						new ComboBoxTest().show(true);
						break;
					case "相对定位": 
						new ContainerTest().show(true);
						break;
					case "文本": 
						new LabelTest().show(true);
						break;
					case "布局容器": 
						new LayOutBoxTest().show(true);
						break;
					case "列表": 
						new ListTest().show(true);
						break;
					case "面板": 
						new PanelTest().show(true);
						break;
					case "进度条": 
						new ProgressTest().show(true);
						break;
					case "滑动条": 
						new SliderTest().show(true);
						break;
					case "单选框": 
						new RadioGroupTest().show(true);
						break;
					case "标签": 
						new TabTest().show(true);
						break;
					case "输入框": 
						new TextInputTest().show(true);
						break;
					case "文本域": 
						new TextAreaTest().show(true);
						break;
					case "多视图": 
						new ViewStackTest().show(true);
						break;
					case "赋值": 
						new DataSourceTest().show(true);
						break;
					case "鼠标提示": 
						new ToolTipTest().show(true);
						break;
					case "多语言": 
						new LanguageTest().show(true);
						break;
				}
			}
		}
	}
}