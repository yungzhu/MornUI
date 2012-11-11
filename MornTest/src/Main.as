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
			//加载资源
			App.loader.loadSWF("assets/comp.swf");
			App.loader.loadSWF("assets/map.swf");
			App.loader.loadSWF("assets/nav.swf");
			App.loader.loadSWF("assets/other.swf");
			App.loader.loadSWF("assets/vector.swf", new Handler(loadComplete));
		}
		
		private function loadComplete(content:*):void {
			addChild(new GameStage());
		}
	}
}