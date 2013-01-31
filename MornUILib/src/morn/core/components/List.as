/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	
	/**选择项改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**列表*/
	public class List extends Box implements IItem {
		protected var _items:Vector.<Component>;
		protected var _renderHandler:Handler;
		protected var _length:int;
		protected var _itemCount:int;
		protected var _page:int;
		protected var _totalPage:int;
		protected var _scrollBar:ScrollBar;
		protected var _startIndex:int;
		protected var _selectedIndex:int = -1;
		protected var _array:Array = [];
		protected var _selectHandler:Handler;
		
		/**初始化列表项*/
		public function initItems():void {
			_scrollBar = getChildByName("scrollBar") as ScrollBar;
			if (_scrollBar) {
				_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			}
			
			_items = new Vector.<Component>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:Component = getChildByName("item" + i) as Component;
				if (item == null) {
					break;
				}
				item.addEventListener(MouseEvent.CLICK, onItemMouse);
				if (item.getChildByName("selectBox")) {
					item.addEventListener(MouseEvent.ROLL_OVER, onItemMouse);
					item.addEventListener(MouseEvent.ROLL_OUT, onItemMouse);
				}
				_items.push(item);
			}
			_itemCount = _items.length;
		}
		
		protected function onMouseWheel(e:MouseEvent):void {
			_scrollBar.value -= e.delta;
		}
		
		protected function onItemMouse(e:MouseEvent):void {
			var item:Component = e.currentTarget as Component;
			var index:int = _startIndex + _items.indexOf(item);
			if (e.type == MouseEvent.CLICK) {
				selectedIndex = index;
			} else if (_selectedIndex != index) {
				changeItemState(item, e.type == MouseEvent.ROLL_OVER, 0);
			}
		}
		
		protected function changeItemState(item:Component, visable:Boolean, frame:int):void {
			var selectBox:Clip = item.getChildByName("selectBox") as Clip;
			if (selectBox) {
				selectBox.visible = visable;
				selectBox.frame = frame;
			}
		}
		
		/**选择索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			var oldValue:int = _selectedIndex;
			_selectedIndex = (value < -1 ? -1 : (value >= _array.length ? _array.length - 1 : value));
			callLater(refresh);
			if (oldValue != _selectedIndex) {
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**选择项数据*/
		public function get selectedItem():Object {
			return _selectedIndex != -1 ? _array[_selectedIndex] : null;
		}
		
		public function set selectedItem(value:Object):void {
			selectedIndex = _array.indexOf(value);
		}
		
		protected function onScrollBarChange(e:Event):void {
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
			_page = (value =< 1 ? 1 : (value >= _totalPage ? _totalPage : value));
			_startIndex = (_page - 1) * _itemCount;
			callLater(refresh);
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
		
		protected function renderItem(item:Component, index:int):void {
			if (index < _array.length) {
				item.visible = true;
				item.dataSource = _array[index];
			} else {
				item.visible = false;
			}
			//选中处理
			if (item.visible) {
				changeItemState(item, _selectedIndex == index, 1);
			}
			if (_renderHandler != null) {
				_renderHandler.executeWith([item, index]);
			}
		}
		
		/**列表项处理器(默认返回参数item:Component,index:int)*/
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
		
		/**项集合*/
		public function get items():Vector.<Component> {
			return _items;
		}
		
		/**列表数据*/
		public function get array():Array {
			return _array;
		}
		
		public function set array(value:Array):void {
			_array = value || [];
			var length:int = _array.length;
			_totalPage = Math.ceil(length / _itemCount);
			//重设当前页数
			page = _page;
			//重设当前选择项
			selectedIndex = _selectedIndex;
			if (_scrollBar) {
				//自动隐藏滚动条
				_scrollBar.visible = length > _itemCount;
				_scrollBar.setScroll(0, Math.max(length - _itemCount, 0), _startIndex);
			}
		}
		
		/**列表数据总数*/
		public function get length():int {
			return _array.length;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = array = value as Array;
		}
	}
}
