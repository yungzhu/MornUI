package {
	import flash.display.Sprite;
	import game.view.GameStage;
	import morn.core.components.List;
	import morn.core.handlers.Handler;
	
	/**
	 * 主程序
	 */
	public class Main extends Sprite {
		private var list:List;
		
		public function Main() {
			//初始化组件
			App.init(this);
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf", "assets/map.swf", "assets/nav.swf", "assets/other.swf", "assets/vector.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		
		private function loadProgress(value:Number):void {
			trace("loaded", value);
		}
		
		private function loadComplete():void {
			addChild(new GameStage());
		}
	}
}