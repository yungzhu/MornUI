/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**Tab标签*/
	public class Tab extends Box implements IItems {
		private var _items:Vector.<ISelectable>;
		private var _selectHandler:Handler;
		private var _selectedIndex:int;
		private var _skin:String;
		private var _labels:String;
		
		public function Tab(labels:String = null, skin:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		/**初始化*/
		public function initItems():void {
			_items = new Vector.<ISelectable>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:ISelectable = getChildByName("item" + i) as ISelectable;
				if (item == null) {
					break;
				}
				_items.push(item);
				item.selected = (i == _selectedIndex);
				item.clickHandler = new Handler(itemClick, [i]);
			}
		}
		
		private function itemClick(index:int):void {
			selectedIndex = index;
			if (_selectHandler != null) {
				_selectHandler.executeWith([index]);
			}
		}
		
		/**所选按钮的索引*/
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
				_items[index].selected = selected;
			}
		}
		
		/**选择被改变时执行的处理器*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**Button皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeLabels);
			}
		}
		
		/**标签集合*/
		public function get labels():String {
			return _labels;
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				callLater(changeLabels);
			}
		}
		
		protected function changeLabels():void {
			if (StringUtils.isNotEmpty(_labels)) {
				removeAllChild();
				var a:Array = _labels.split(",");
				var right:int = 0
				for (var i:int = 0, n:int = a.length; i < n; i++) {
					var item:String = a[i];
					var btn:Button = _skin != null ? new Button(_skin, item) : new LinkButton(item);
					btn.name = "item" + i;
					addElement(btn, right, 0);
					right += btn.width;
				}
				initItems();
			}
		}
		
		/**按钮集合*/
		public function get items():Vector.<ISelectable> {
			return _items;
		}
	}
}