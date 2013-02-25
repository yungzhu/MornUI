/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**鼠标提示管理类*/
	public class TipManager extends Sprite {
		private var _tipBox:Sprite;
		private var _tipText:TextField;
		
		public function TipManager() {
			_tipBox = new Sprite();
			_tipBox.addChild(_tipText = new TextField());
			_tipText.autoSize = "left";
			_tipText.multiline = true;
			_tipText.x = _tipText.y = 5;
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(UIEvent.SHOW_TIP, onStageShowTip);
			stage.addEventListener(UIEvent.HIDE_TIP, onStageHideTip);
		}
		
		private function onStageHideTip(e:UIEvent):void {
			closeAll();
		}
		
		private function onStageShowTip(e:UIEvent):void {
			App.timer.doOnce(Config.tipDelay, showTip, [e.data]);
		}
		
		private function showTip(tip:Object):void {
			if (tip is String) {
				var text:String = tip as String;
				if (StringUtils.isNotEmpty(text)) {
					showDefaultTip(text);
				}
			} else if (tip is Handler) {
				(tip as Handler).execute();
			} else if (tip is Function) {
				(tip as Function).apply();
			}
			if (Config.tipFollowMove) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			}
			onStageMouseMove(null);
		}
		
		private function onStageMouseDown(e:MouseEvent):void {
			closeAll();
		}
		
		private function onStageMouseMove(e:MouseEvent):void {
			var x:int = stage.mouseX + 10;
			var y:int = stage.mouseY + 15;
			if (x < 0) {
				x = 0;
			} else if (x > stage.stageWidth - width) {
				x = stage.stageWidth - width;
			}
			if (y < 0) {
				y = 0;
			} else if (y > stage.height - height) {
				y = stage.stageWidth - height;
			}
			this.x = x;
			this.y = y;
		}
		
		/**关闭所有鼠标提示*/
		public function closeAll():void {
			App.timer.clearTimer(showTip);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			for (var i:int = numChildren - 1; i > -1; i--) {
				removeChildAt(i);
			}
		}
		
		private function showDefaultTip(text:String):void {
			_tipText.htmlText = text;
			var g:Graphics = _tipBox.graphics;
			g.clear();
			g.lineStyle(1, 0xC0C0C0);
			g.beginFill(0xFFFFFF);
			g.drawRoundRect(0, 0, _tipText.width + 10, _tipText.height + 10, 4, 4);
			g.endFill();
			addChild(_tipBox);
		}
	}
}