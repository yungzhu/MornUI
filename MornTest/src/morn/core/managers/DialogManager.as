/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.managers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import morn.core.components.Box;
	import morn.core.components.Dialog;
	import morn.core.utils.ObjectUtils;
	
	/**
	 * 对话框管理器
	 */
	public class DialogManager extends Sprite {
		private var _box:Box = new Box();
		private var _mask:Box = new Box();
		private var _modal:Dialog;
		
		public function DialogManager() {
			addChild(_box);
			_mask.addChild(ObjectUtils.createBitmap(Config.gameWidth, Config.gameHeight, 0, 0.4));
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event):void {
			var display:DisplayObject = _mask.getChildAt(0);
			display.width = App.stage.stageWidth;
			display.height = App.stage.stageHeight;
			_mask.x = (Config.gameWidth - display.width) * 0.5;
			_mask.y = (Config.gameHeight - display.height) * 0.5;
			if (_modal) {
				_modal.x = (_mask.width - _modal.width) * 0.5;
				_modal.y = (_mask.height - _modal.height) * 0.5;
			}
		}
		
		/**显示对话框(会关闭已经打开的非模式窗口)*/
		public function show(dialog:Dialog, x:int = 0, y:int = 0):void {
			removeAll();
			popup(dialog, x, y);
		}
		
		/**显示对话框*/
		public function popup(dialog:Dialog, x:int = 0, y:int = 0):void {
			if (dialog != null) {
				if (x == 0 && y == 0) {
					x = (Config.gameWidth - dialog.width) * 0.5;
					y = (Config.gameHeight - dialog.height) * 0.5;
				}
				_box.addElement(dialog, x, y);
			}
		}
		
		/**删除对话框(非模式窗口)*/
		public function remove(dialog:Dialog):void {
			if (_modal != dialog) {
				dialog.remove();
			} else {
				modal = null;
			}
		}
		
		/**删除所有对话框*/
		public function removeAll():void {
			_box.removeAllChild();
		}
		
		/**模式窗口*/
		public function get modal():Dialog {
			return _modal;
		}
		
		public function set modal(value:Dialog):void {
			if (_modal != null) {
				_modal.remove();
			}
			_modal = value;
			if (_modal != null) {
				addChild(_mask);
				var x:int = (_mask.width - _modal.width) * 0.5;
				var y:int = (_mask.height - _modal.height) * 0.5;
				_mask.addElement(_modal, x, y);
			} else {
				removeChild(_mask);
			}
		}
	}
}