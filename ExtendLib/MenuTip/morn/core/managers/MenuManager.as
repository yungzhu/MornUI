/**
 * Morn UI Version 2.3.0810 http://www.mornui.com/
 * Author yungzhu@gmail.com http://weibo.com/newyung
 * Creator H大仙 lihandi@gmail.com 
 */
package morn.core.managers {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.components.LinkButton;
	import morn.core.components.Styles;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	
	/**菜单管理类*/
	public class MenuManager extends Sprite {
		public static var offsetX:int = 15;
		public static var offsetY:int = 15;
		private var _menuBox:Sprite;
		private var _defaultMenuHandler:Function;
		private var _clickMenuHandler:Handler;
		
		public function MenuManager() {
			_menuBox = new Sprite();
			addEventListener(MouseEvent.ROLL_OVER, onMouse);
			addEventListener(MouseEvent.ROLL_OUT, onMouse);
			addEventListener(MouseEvent.CLICK, onMouse);
			_defaultMenuHandler = showDefaultMenu;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(UIEvent.SHOW_MENU, onStageShowMenu);
			stage.addEventListener(UIEvent.HIDE_MENU, onStageHideMenu);
		}
		
		private function onStageHideMenu(e:UIEvent):void {
			App.timer.doOnce(200, closeAll);
		}
		
		private function onStageShowMenu(e:UIEvent):void {
			App.timer.doOnce(Config.tipDelay, showMenu, [e.data]);
		}
		
		
		
		private function showMenu(menu:Object):void {
			if (menu is Handler) {
				(menu as Handler).execute();
			} else if (menu is Function) {
				(menu as Function).apply();
			} else if (menu is Object) {
				if (Boolean(menu)) {
					_defaultMenuHandler(menu);
				}
			}
			onStageMouseMove(null);
		}
		
		private function showDefaultMenu(menu:Object):void {
			while (_menuBox.numChildren) {
				_menuBox.removeChildAt(i);
				_menuBox.graphics.clear();
			}
			var btn:LinkButton;
			for (var i:int = 0; i < menu.labels.length; i++) {
				btn = new LinkButton(menu.labels[i].title);
				btn.labelSize = 13;
				btn.labelColors = (menu.labels[i].color?menu.labels[i].color:"0xFFFF00")+",0xFF0000,0xFF0000";
				btn.labelBold = true;
				btn.name = menu.labels[i].name;
				btn.x = 8;
				btn.y = 5+i * (btn.height + 5);
				_menuBox.addChild(btn);
			}
			_clickMenuHandler = menu.handler?menu.handler:null;
			
			_menuBox.graphics.lineStyle(1, 0x333333, 0.9);
			_menuBox.graphics.beginFill(0x555555, 0.8);
			_menuBox.graphics.drawRoundRect(0, 0, _menuBox.width+20,  _menuBox.height + 10,10);
			_menuBox.graphics.endFill();
			addChild(_menuBox);
		}
		
		public function set clickHandler(_h:Handler):void {
			_clickMenuHandler = _h;
		}
		
		private function onMouse(e:MouseEvent):void {
			if (e.type == MouseEvent.ROLL_OVER) {
				App.timer.clearTimer(App.menu.closeAll);
			}else if (e.type == MouseEvent.ROLL_OUT) {
				App.menu.closeAll();
			}else if (e.type == MouseEvent.CLICK) {
				if(_clickMenuHandler){
					_clickMenuHandler.executeWith([e]);
				}
				App.menu.closeAll();
			}
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
		
		/**关闭所有菜单*/
		public function closeAll():void {
			App.timer.clearTimer(closeAll);
			App.timer.clearTimer(showMenu);
			_clickMenuHandler = null;
			for (var i:int = numChildren - 1; i > -1; i--) {
				removeChildAt(i);
			}
		}
		
	}
}