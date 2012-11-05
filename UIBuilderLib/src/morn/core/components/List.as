/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**列表*/
	public class List extends Box implements IItems {
		protected var _items:Vector.<DisplayObject>;
		protected var _renderHandler:Handler;
		protected var _length:int;
		protected var _itemCount:int;
		protected var _page:int;
		protected var _totalPage:int;
		protected var _scrollBar:VScrollBar;
		protected var _startIndex:int;
		
		/**初始化列表项*/
		public function initItems():void {
			_scrollBar = getChildByName("scrollBar") as VScrollBar;
			if (_scrollBar) {
				_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			}
			
			_items = new Vector.<DisplayObject>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:DisplayObject = getChildByName("item" + i);
				if (item == null) {
					break;
				}
				_items.push(item);
			}
			_itemCount = _items.length;
		}
		
		private function onScrollBarChange(e:Event):void {
			var start:int = Math.round(_scrollBar.value);
			if (_startIndex != start) {
				startIndex = start;
			}
		}
		
		/**当前页码*/
		public function get page():int {
			return _page;
		}
		
		public function set page(value:int):void {
			_page = (value < 1 ? 1 : (value >= _totalPage ? _totalPage : value));
			startIndex = (_page - 1) * _itemCount;
		}
		
		/**开始索引*/
		public function get startIndex():int {
			return _startIndex;
		}
		
		public function set startIndex(value:int):void {
			_startIndex = value;
			for (var i:int = 0; i < _itemCount; i++) {
				renderItem(_items[i], _startIndex + i);
			}
		}
		
		private function renderItem(item:DisplayObject, index:int):void {
			if (_renderHandler != null) {
				_renderHandler.executeWith([item, index]);
			}
		}
		
		/**列表数据总数*/
		public function get length():int {
			return _length;
		}
		
		public function set length(value:int):void {
			_length = value;
			_totalPage = Math.ceil(_length / _itemCount);
			if (_scrollBar) {
				_scrollBar.setScroll(0, _length - _itemCount, 0);
			}
			callLater(reset);
		}
		
		private function reset():void {
			startIndex = 0
		}
		
		/**列表项处理器*/
		public function get renderHandler():Handler {
			return _renderHandler;
		}
		
		public function set renderHandler(value:Handler):void {
			_renderHandler = value;
		}
		
		/**刷新列表*/
		public function refresh():void {
			startIndex = _startIndex;
		}
	}
}