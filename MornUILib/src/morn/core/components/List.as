/**
 * Morn UI Version 2.3.0810 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.editor.core.IList;
	
	/**选择项改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	/**项渲染时触发*/
	[Event(name="listRender",type="morn.core.events.UIEvent")]
	
	/**列表*/
	public class List extends Box implements IItem, IList {
		protected var _items:Vector.<Component>;
		protected var _renderHandler:Handler;
		protected var _length:int;
		protected var _itemCount:int;
		protected var _page:int;
		protected var _totalPage:int;
		protected var _scrollBar:ScrollBar;
		protected var _scrollSize:int = 1;
		protected var _startIndex:int;
		protected var _selectedIndex:int = -1;
		protected var _array:Array = [];
		protected var _selectHandler:Handler;
		protected var _itemRender:Class;
		protected var _repeatX:int
		protected var _repeatY:int;
		protected var _spaceX:int;
		protected var _spaceY:int;
		
		/**批量设置列表项*/
		public function setItems(items:Array):void {
			removeAllChild(_scrollBar);
			var index:int = 0;
			for (var i:int = 0, n:int = items.length; i < n; i++) {
				var item:Component = items[i];
				if (item) {
					item.name = "item" + index;
					addChildAt(item, 0);
					index++;
				}
			}
			initItems();
		}
		
		/**增加列表项*/
		public function addItem(item:Component):void {
			item.name = "item" + _items.length;
			addChildAt(item, 0);
			initItems();
		}
		
		/**初始化列表项*/
		public function initItems():void {
			_scrollBar = getChildByName("scrollBar") as ScrollBar;
			if (_scrollBar) {
				_scrollBar.scrollSize = _scrollSize;
				_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			}
			
			_items = new Vector.<Component>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:Component = getChildByName("item" + i) as Component;
				if (item == null) {
					break;
				}
				item.addEventListener(MouseEvent.MOUSE_DOWN, onItemMouse);
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
			if (e.type == MouseEvent.MOUSE_DOWN) {
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
			if (oldValue != _selectedIndex) {
				setSelectStatus();
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		protected function setSelectStatus():void {
			for (var i:int = 0, n:int = items.length; i < n; i++) {
				changeItemState(items[i], _selectedIndex == _startIndex + i, 1);
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
		
		/**选择项组件*/
		public function get selection():Component {
			return _selectedIndex != -1 ? _items[(_selectedIndex - _startIndex) % _itemCount] : null;
		}
		
		public function set selection(value:Component):void {
			selectedIndex = _startIndex + _items.indexOf(value);
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
			_page = (value < 0 ? 0 : (value >= _totalPage - 1 ? _totalPage - 1 : value));
			_startIndex = _page * _itemCount;
			callLater(refresh);
		}
		
		/**开始索引*/
		public function get startIndex():int {
			return _startIndex;
		}
		
		public function set startIndex(value:int):void {
			_startIndex = value > 0 ? value : 0;
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
			setSelectStatus();
			if (_renderHandler != null) {
				_renderHandler.executeWith([item, index]);
			}
			sendEvent(UIEvent.ITEM_RENDER, [item, index]);
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
			exeCallLater(changeItems);
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
			//重设当前选择项
			selectedIndex = _selectedIndex;
			//重设开始相
			callLater(refresh);
			if (_scrollBar) {
				//自动隐藏滚动条
				_scrollBar.visible = length > _itemCount;
				if (_scrollBar.visible) {
					_scrollBar.thumbPercent = _itemCount / length;
					_scrollBar.setScroll(0, Math.max(length - _itemCount, 0), _startIndex);
				}
			}
		}
		
		/**滚动条*/
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		/**列表数据总数*/
		public function get length():int {
			return _array.length;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Array) {
				array = value as Array
			} else {
				super.dataSource = value;
			}
		}
		
		/**滚动单位*/
		public function get scrollSize():int {
			return _scrollSize;
		}
		
		public function set scrollSize(value:int):void {
			if (_scrollBar) {
				_scrollBar.scrollSize = value;
			}
		}
		
		/**最大分页数*/
		public function get totalPage():int {
			return _totalPage;
		}
		
		public function set totalPage(value:int):void {
			_totalPage = value;
		}
		
		/**项渲染器*/
		public function get itemRender():Class {
			return _itemRender;
		}
		
		public function set itemRender(value:Class):void {
			_itemRender = value;
			callLater(changeItems);
		}
		
		/**X方向项数量*/
		public function get repeatX():int {
			return _repeatX;
		}
		
		public function set repeatX(value:int):void {
			_repeatX = value;
			callLater(changeItems);
		}
		
		/**Y方向项数量*/
		public function get repeatY():int {
			return _repeatY;
		}
		
		public function set repeatY(value:int):void {
			_repeatY = value;
			callLater(changeItems);
		}
		
		/**X方向项间隔*/
		public function get spaceX():int {
			return _spaceX;
		}
		
		public function set spaceX(value:int):void {
			_spaceX = value;
			callLater(changeItems);
		}
		
		/**Y方向项间隔*/
		public function get spaceY():int {
			return _spaceY;
		}
		
		public function set spaceY(value:int):void {
			_spaceY = value;
			callLater(changeItems);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeItems);
		}
		
		protected function changeItems():void {
			if (_itemRender) {
				//removeAllChild();
				for each (var item:Component in _items) {
					item.removeEventListener(MouseEvent.MOUSE_DOWN, onItemMouse);
					item.removeEventListener(MouseEvent.ROLL_OVER, onItemMouse);
					item.removeEventListener(MouseEvent.ROLL_OUT, onItemMouse);
					item.remove();
				}
				for (var k:int = 0; k < _repeatY; k++) {
					for (var l:int = 0; l < _repeatX; l++) {
						item = new _itemRender();
						item.name = "item" + (l + k * _repeatX);
						item.x += l * (_spaceX + item.width);
						item.y += k * (_spaceY + item.height);
						addChild(item);
					}
				}
				if (_scrollBar) {
					addChild(_scrollBar);
				}
				initItems();
			}
		}
	}
}