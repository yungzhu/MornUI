/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	import flash.display.DisplayObject;
	
	/**视图类*/
	public class ViewStack extends Box implements IItems {
		private var _items:Vector.<DisplayObject>;
		private var _setIndexHandler:Handler = new Handler(setIndex);
		private var _selectedIndex:int;
		
		/**设置视图*/
		public function setItems(... displays):void {
			var index:int = 0;
			for (var i:int = 0, n:int = displays.length; i < n; i++) {
				var item:DisplayObject = displays[i];
				if (item != null) {
					item.name = "item" + index;
					addChild(item);
					index++;
				}
			}
			initItems();
		}
		
		/**增加视图*/
		public function addItem(item:DisplayObject):void {
			item.name = _items.length + "";
			initItems();
		}
		
		/**初始化视图*/
		public function initItems():void {
			_items = new Vector.<DisplayObject>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:DisplayObject = getChildByName("item" + i);
				if (item == null) {
					break;
				}
				_items.push(item);
				item.visible = (i == _selectedIndex);
			}
		}
		
		/**当前视图索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				setSelect(_selectedIndex, false);
				_selectedIndex = value;
				setSelect(_selectedIndex, true);
			}
		}
		
		private function setSelect(index:int, selected:Boolean):void {
			if (_items != null && index > -1 && index < _items.length) {
				_items[index].visible = selected;
			}
		}
		
		/**索引设置处理器*/
		public function get setIndexHandler():Handler {
			return _setIndexHandler;
		}
		
		public function set setIndexHandler(value:Handler):void {
			_setIndexHandler = value;
		}
		
		private function setIndex(index:int):void {
			selectedIndex = index;
		}
		
		/**视图集合*/
		public function get items():Vector.<DisplayObject> {
			return _items;
		}
	}
}