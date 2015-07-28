package {
	import flash.display.Sprite;
	import flash.events.Event;
	import morn.core.handlers.Handler;
	
	/**Morn UI测试demo
	 * Morn UI官网：http://www.mornui.com*/
	
	public class Main extends Sprite {
		
		public function Main() {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void {
			//初始化组件
			App.init(this);
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf", "assets/vector.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		
		private function loadProgress(value:Number):void {
			//加载进度
			//trace("loaded", value);
		}
		
		private function loadComplete():void {
			//实例化场景
			addChild(new GameStage());
		}
	}
}