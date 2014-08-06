/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import morn.core.handlers.Handler;
	
	/**视图类*/
	public class ViewStack extends Box implements IItem {
		protected var _items:Vector.<DisplayObject>;
		protected var _setIndexHandler:Handler = new Handler(setIndex);
		protected var _selectedIndex:int;
		
		public function ViewStack() {
		}
		
		/**批量设置视图*/
		public function setItems(views:Array):void {
			removeAllChild();
			var index:int = 0;
			for (var i:int = 0, n:int = views.length; i < n; i++) {
				var item:DisplayObject = views[i];
				if (item) {
					item.name = "item" + index;
					addChild(item);
					index++;
				}
			}
			initItems();
		}
		
		/**增加视图*/
		public function addItem(view:DisplayObject):void {
			view.name = "item" + _items.length;
			addChild(view);
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
		
		protected function setSelect(index:int, selected:Boolean):void {
			if (_items && index > -1 && index < _items.length) {
				_items[index].visible = selected;
			}
		}
		
		/**选择项*/
		public function get selection():DisplayObject {
			return _selectedIndex > -1 && _selectedIndex < _items.length ? _items[_selectedIndex] : null;
		}
		
		public function set selection(value:DisplayObject):void {
			selectedIndex = _items.indexOf(value);
		}
		
		/**索引设置处理器(默认接收参数index:int)*/
		public function get setIndexHandler():Handler {
			return _setIndexHandler;
		}
		
		public function set setIndexHandler(value:Handler):void {
			_setIndexHandler = value;
		}
		
		protected function setIndex(index:int):void {
			selectedIndex = index;
		}
		
		/**视图集合*/
		public function get items():Vector.<DisplayObject> {
			return _items;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is int || value is String) {
				selectedIndex = int(value);
			} else {
				super.dataSource = value;
			}
		}
	}
}