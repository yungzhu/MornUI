package view {
	import flash.events.MouseEvent;
	import game.ui.other.LanguageTestUI;
	import morn.core.handlers.Handler;
	
	/**多语言测试*/
	public class LanguageTest extends LanguageTestUI {
		
		public function LanguageTest() {
			//点击重新生成视图，会自动切换语言
			btn.addEventListener(MouseEvent.CLICK, onBtnClick);
		}
		
		private function onBtnClick(e:MouseEvent):void {
			//加载语言包，语言包可以做压缩或加密，这里为了简单直接用xml格式
			//一般在实例化页面之前加载语言包，直接显示相应的语言，这里为了测试临时加载
			App.loader.loadTXT("en.xml", new Handler(langLoaded));
		}
		
		/**测试多语言*/
		private function langLoaded(content:*):void {
			var obj:Object = {};
			var xml:XML = new XML(content);
			for each (var item:XML in xml.item) {
				obj[item.@key] = String(item.@value);
			}
			//设置语言包
			App.lang.data = obj;
			
			//如果是实例所有页面之前语言包，就不需要reCreate，这里是临时加载
			reCreate(box);
		}
	}
}