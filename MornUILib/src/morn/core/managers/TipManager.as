/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import morn.core.components.Styles;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	
	/**鼠标提示管理类*/
	public class TipManager extends Sprite {
		public static var offsetX:int = 10;
		public static var offsetY:int = 15;
		private var _tipBox:Sprite;
		private var _tipText:TextField;
		private var _defaultTipHandler:Function;
		
		public function TipManager() {
			_tipBox = new Sprite();
			_tipBox.addChild(_tipText = new TextField());
			_tipText.autoSize = "left";
			_tipText.textColor = Styles.tipTextColor;
			_tipText.multiline = true;
			_tipText.x = _tipText.y = 5;
			mouseEnabled = mouseChildren = false;
			_defaultTipHandler = showDefaultTip;
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
				var text:String = String(tip);
				if (Boolean(text)) {
					_defaultTipHandler(text);
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
			var x:int = stage.mouseX + offsetX;
			var y:int = stage.mouseY + offsetY;
			if (x < 0) {
				x = 0;
			} else if (x > stage.stageWidth - width) {
				x = stage.stageWidth - width;
			}
			if (y < 0) {
				y = 0;
			} else if (y > stage.stageHeight - height) {
				y = stage.stageHeight - height;
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
			g.lineStyle(1, Styles.tipBorderColor);
			g.beginFill(Styles.tipBgColor);
			g.drawRoundRect(0, 0, _tipText.width + 10, _tipText.height + 10, 4, 4);
			g.endFill();
			addChild(_tipBox);
		}
		
		/**默认鼠标提示函数*/
		public function get defaultTipHandler():Function {
			return _defaultTipHandler;
		}
		
		public function set defaultTipHandler(value:Function):void {
			_defaultTipHandler = value;
		}
	}
}