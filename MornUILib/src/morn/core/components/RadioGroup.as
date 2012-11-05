/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**单选按钮组*/
	public class RadioGroup extends Box implements IItems {
		private var _items:Vector.<RadioButton>;
		private var _selection:RadioButton;
		private var _changeHandler:Handler;
		private var _skin:String;
		private var _labels:String;
		
		public function RadioGroup(labels:String = null, skin:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		/**初始化*/
		public function initItems():void {
			_items = new Vector.<RadioButton>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:RadioButton = getChildByName("item" + i) as RadioButton;
				if (item == null) {
					break;
				}
				_items.push(item);
				item.selected = false;
				item.clickHandler = new Handler(itemClick, [item]);
			}
		}
		
		private function itemClick(item:RadioButton):void {
			selection = item;
			if (_changeHandler != null) {
				_changeHandler.executeWith([_selection.value]);
			}
		}
		
		/**被选择的单选按钮*/
		public function get selection():RadioButton {
			return _selection;
		}
		
		public function set selection(value:RadioButton):void {
			if (_selection != value) {
				if (_selection != null) {
					_selection.selected = false;
				}
				_selection = value;
				_selection.selected = true;
			}
		}
		
		/**被选择单选按钮的值*/
		public function get selectedValue():Object {
			return selection.value;
		}
		
		public function set selectedValue(value:Object):void {
			if (_items) {
				for (var i:int = 0, n:int = _items.length; i < n; i++) {
					var item:RadioButton = _items[i];
					if (item.value == value) {
						selection = item;
						break;
					}
				}
			}
		}
		
		/**选择被改变时执行的处理器*/
		public function get changeHandler():Handler {
			return _changeHandler;
		}
		
		public function set changeHandler(value:Handler):void {
			_changeHandler = value;
		}
		
		/**RadioButton皮肤*/
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
					var radio:RadioButton = new RadioButton(item, _skin);
					radio.name = "item" + i;
					addElement(radio, right, 0);
					right += radio.width;
				}
				initItems();
			}
		}
		
		/**按钮集合*/
		public function get items():Vector.<RadioButton> {
			return _items;
		}
	}
}