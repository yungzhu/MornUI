package {
	import flash.display.Sprite;
	import game.view.GameStage;
	import morn.core.handlers.Handler;
	
	/**
	 * 主程序
	 */
	public class Main extends Sprite {
		
		public function Main() {
			//初始化组件
			App.init(this);
			//加载语言包，语言包可以做压缩或加密，这里为了简单直接用xml格式
			App.loader.loadTXT("en.xml", new Handler(loadLang));
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf", "assets/map.swf", "assets/nav.swf", "assets/other.swf", "assets/vector.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		
		/**测试多语言*/
		private function loadLang(content:*):void {
			var obj:Object = {};
			var xml:XML = new XML(content);
			for each (var item:XML in xml.item) {
				obj[item.@key] = String(item.@value);
			}
			//设置语言包
			App.lang.data = obj;
		}
		
		private function loadProgress(value:Number):void {
			//加载进度
			trace("loaded", value);
		}
		
		private function loadComplete():void {
			//实例化场景
			addChild(new GameStage());
		}
	}
}