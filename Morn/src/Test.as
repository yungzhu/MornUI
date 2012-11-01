package {
	import morn.core.handlers.Handler;
	import flash.display.Sprite;
	import game.view.Scene;
	
	public class Test extends Sprite {
		
		public function Test():void {
			App.init(this);
			loadRes();
		}
		
		private function loadRes():void {
			App.loader.loadSWF("assets/comp.swf");
			App.loader.loadSWF("assets/hero.swf");
			App.loader.loadSWF("assets/map.swf");
			App.loader.loadSWF("assets/nav.swf");
			App.loader.loadSWF("assets/vector.swf", new Handler(loadComplete));
		}
		
		private function loadComplete(content:*):void {
			addChild(new Scene());
		}
	}
}