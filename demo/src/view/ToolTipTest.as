package view {
	import game.ui.other.MyToolTipUI;
	import game.ui.other.ToolTipTestUI;
	import morn.core.handlers.Handler;
	
	/**鼠标提示示例*/
	public class ToolTipTest extends ToolTipTestUI {
		private var _myToolTip:MyToolTipUI = new MyToolTipUI();
		
		public function ToolTipTest() {
			//鼠标提示为文本
			image.toolTip = "这是个图像，<b>粗体</b><br><font color='#ff0000'>换行</font><br>鼠标提示，鼠标提示，鼠标提示";
			
			//自定义的鼠标提示
			/*[IF-FLASH]*/check.toolTip = showTips1;
			//[IF-JS]check.toolTip = iflash.method.bind(this,showTips1);
			
			//携带参数
			clip.toolTip = new Handler(showTips2, ["Morn UI"]);
		}
		
		private function showTips1():void {
			_myToolTip.label.text = "测试自定义鼠标提示，选择框" + (check.selected ? "选中了" : "未选中");
			App.tip.addChild(_myToolTip);
		}
		
		private function showTips2(name:String):void {
			_myToolTip.label.text = "测试带参数的鼠标提示，参数[" + name + "]";
			App.tip.addChild(_myToolTip);
		}
	}
}