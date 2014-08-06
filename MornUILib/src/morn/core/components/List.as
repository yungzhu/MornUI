/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import morn.core.events.DragEvent;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.editor.core.IRender;
	
	/**selectedIndex属性变化时调度*/
	[Event(name="change",type="flash.events.Event")]
	/**单元格渲染时触发*/
	[Event(name="listRender",type="morn.core.events.UIEvent")]
	
	/**列表*/
	public class List extends Box implements IRender, IItem {
		protected var _content:Box;
		protected var _scrollBar:ScrollBar;
		protected var _itemRender:*;
		protected var _repeatX:int;
		protected var _repeatY:int;
		protected var _repeatX2:int;
		protected var _repeatY2:int;
		protected var _spaceX:int;
		protected var _spaceY:int;
		protected var _cells:Vector.<Box> = new Vector.<Box>();
		protected var _array:Array;
		protected var _startIndex:int;
		protected var _selectedIndex:int = -1;
		protected var _selectHandler:Handler;
		protected var _renderHandler:Handler;
		protected var _mouseHandler:Handler;
		protected var _page:int;
		protected var _totalPage:int;
		protected var _selectEnable:Boolean = true;
		protected var _isVerticalLayout:Boolean = true;
		protected var _cellSize:Number = 20;
		
		public function List() {
		}
		
		override protected function createChildren():void {
			addChild(_content = new Box());
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			return child != _content ? super.removeChild(child) : null;
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			return getChildAt(index) != _content ? super.removeChildAt(index) : null;
		}
		
		/**内容容器*/
		public function get content():Box {
			return _content;
		}
		
		/**滚动条*/
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		public function set scrollBar(value:ScrollBar):void {
			if (_scrollBar != value) {
				_scrollBar = value;
				if (value) {
					addChild(_scrollBar);
					_scrollBar.target = this;
					_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
					_isVerticalLayout = _scrollBar.direction == ScrollBar.VERTICAL;
				}
			}
		}
		
		/**单元格渲染器，可以设置为XML或类对象*/
		public function get itemRender():* {
			return _itemRender;
		}
		
		public function set itemRender(value:*):void {
			_itemRender = value;
			callLater(changeCells);
		}
		
		/**X方向单元格数量*/
		public function get repeatX():int {
			return _repeatX > 0 ? _repeatX : _repeatX2 > 0 ? _repeatX2 : 1;
		}
		
		public function set repeatX(value:int):void {
			_repeatX = value;
			callLater(changeCells);
		}
		
		/**Y方向单元格数量*/
		public function get repeatY():int {
			return _repeatY > 0 ? _repeatY : _repeatY2 > 0 ? _repeatY2 : 1;
		}
		
		public function set repeatY(value:int):void {
			_repeatY = value;
			callLater(changeCells);
		}
		
		/**X方向单元格间隔*/
		public function get spaceX():int {
			return _spaceX;
		}
		
		public function set spaceX(value:int):void {
			_spaceX = value;
			callLater(changeCells);
		}
		
		/**Y方向单元格间隔*/
		public function get spaceY():int {
			return _spaceY;
		}
		
		public function set spaceY(value:int):void {
			_spaceY = value;
			callLater(changeCells);
		}
		
		protected function changeCells():void {
			if (_itemRender) {
				//销毁老单元格
				for each (var cell:Box in _cells) {
					cell.removeEventListener(MouseEvent.CLICK, onCellMouse);
					cell.removeEventListener(MouseEvent.ROLL_OVER, onCellMouse);
					cell.removeEventListener(MouseEvent.ROLL_OUT, onCellMouse);
					cell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouse);
					cell.removeEventListener(MouseEvent.MOUSE_UP, onCellMouse);
					cell.remove();
				}
				_cells.length = 0;
				//获取滚动条
				scrollBar = getChildByName("scrollBar") as ScrollBar;
				
				//自适应宽高
				cell = _itemRender is XML ? View.createComp(_itemRender) as Box : new _itemRender();
				
				if (_repeatX < 1 && !isNaN(_width)) {
					_repeatX2 = Math.round(_width / (cell.width + _spaceX));
				}
				if (_repeatY < 1 && !isNaN(_height)) {
					_repeatY2 = Math.round(_height / (cell.height + _spaceY));
				}
				
				var listWidth:Number = isNaN(_width) ? ((cell.width + _spaceX) * repeatX - _spaceX) : _width;
				var listHeight:Number = isNaN(_height) ? ((cell.height + _spaceY) * repeatY - _spaceY) : _height;
				
				if (_isVerticalLayout && _scrollBar) {
					_scrollBar.height = listHeight;
				} else if (_isVerticalLayout && _scrollBar) {
					_scrollBar.width = listWidth;
				}
				setContentSize(listWidth, listHeight);
				
				//创建新单元格				
				var numX:int = _isVerticalLayout ? repeatX : repeatY;
				var numY:int = (_isVerticalLayout ? repeatY : repeatX) + (_scrollBar ? 1 : 0);
				for (var k:int = 0; k < numY; k++) {
					for (var l:int = 0; l < numX; l++) {
						cell = _itemRender is XML ? View.createComp(_itemRender) as Box : new _itemRender();
						cell.x = (_isVerticalLayout ? l : k) * (_spaceX + cell.width);
						cell.y = (_isVerticalLayout ? k : l) * (_spaceY + cell.height);
						cell.name = "item" + (k * numX + l);
						_content.addChild(cell);
						addCell(cell);
					}
				}
				
				if (_array) {
					array = _array;
					exeCallLater(renderItems);
				}
			}
		}
		
		protected function addCell(cell:Box):void {
			cell.addEventListener(MouseEvent.CLICK, onCellMouse);
			cell.addEventListener(MouseEvent.ROLL_OVER, onCellMouse);
			cell.addEventListener(MouseEvent.ROLL_OUT, onCellMouse);
			cell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouse);
			cell.addEventListener(MouseEvent.MOUSE_UP, onCellMouse);
			_cells.push(cell);
		}
		
		public function initItems():void {
			if (!_itemRender) {
				for (var i:int = 0; i < int.MAX_VALUE; i++) {
					var cell:Box = getChildByName("item" + i) as Box;
					if (cell) {
						addCell(cell);
						continue;
					}
					break;
				}
			}
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeCells);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeCells);
		}
		
		/**设置可视区域大小*/
		public function setContentSize(width:Number, height:Number):void {
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0xff0000, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			_content.width = width;
			_content.height = height;
			if (_scrollBar) {
				_content.scrollRect = new Rectangle(0, 0, width, height);
			}
		}
		
		protected function onCellMouse(e:MouseEvent):void {
			var cell:Box = e.currentTarget as Box;
			var index:int = _startIndex + _cells.indexOf(cell);
			if (e.type == MouseEvent.CLICK || e.type == MouseEvent.ROLL_OVER || e.type == MouseEvent.ROLL_OUT) {
				if (e.type == MouseEvent.CLICK) {
					if (_selectEnable) {
						selectedIndex = index;
					} else {
						changeCellState(cell, true, 0);
					}
				} else if (_selectedIndex != index) {
					changeCellState(cell, e.type == MouseEvent.ROLL_OVER, 0);
				}
			}
			if (_mouseHandler != null) {
				_mouseHandler.executeWith([e, index]);
			}
		}
		
		protected function changeCellState(cell:Box, visable:Boolean, frame:int):void {
			var selectBox:Clip = cell.getChildByName("selectBox") as Clip;
			if (selectBox) {
				selectBox.visible = visable;
				selectBox.frame = frame;
			}
		}
		
		protected function onScrollBarChange(e:Event):void {
			exeCallLater(changeCells);
			var rect:Rectangle = _content.scrollRect;
			var scrollValue:Number = _scrollBar.value;
			var index:int = int(scrollValue / _cellSize) * (_isVerticalLayout ? repeatX : repeatY);
			if (index != _startIndex) {
				startIndex = index;
			}
			if (_isVerticalLayout) {
				rect.y = scrollValue % _cellSize;
			} else {
				rect.x = scrollValue % _cellSize;
			}
			_content.scrollRect = rect;
		}
		
		/**是否可以选中，默认为true*/
		public function get selectEnable():Boolean {
			return _selectEnable;
		}
		
		public function set selectEnable(value:Boolean):void {
			_selectEnable = value;
		}
		
		/**选择索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				_selectedIndex = value;
				changeSelectStatus();
				sendEvent(Event.CHANGE);
				//兼容老版本
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([value]);
				}
			}
		}
		
		protected function changeSelectStatus():void {
			for (var i:int = 0, n:int = _cells.length; i < n; i++) {
				changeCellState(_cells[i], _selectedIndex == _startIndex + i, 1);
			}
		}
		
		/**选中单元格数据源*/
		public function get selectedItem():Object {
			return _selectedIndex != -1 ? _array[_selectedIndex] : null;
		}
		
		public function set selectedItem(value:Object):void {
			selectedIndex = _array.indexOf(value);
		}
		
		/**选择单元格组件*/
		public function get selection():Box {
			return getCell(_selectedIndex);
		}
		
		public function set selection(value:Box):void {
			selectedIndex = _startIndex + _cells.indexOf(value);
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**单元格渲染处理器(默认返回参数cell:Box,index:int)*/
		public function get renderHandler():Handler {
			return _renderHandler;
		}
		
		public function set renderHandler(value:Handler):void {
			_renderHandler = value;
		}
		
		/**单元格鼠标事件处理器(默认返回参数e:MouseEvent,index:int)*/
		public function get mouseHandler():Handler {
			return _mouseHandler;
		}
		
		public function set mouseHandler(value:Handler):void {
			_mouseHandler = value;
		}
		
		/**开始索引*/
		public function get startIndex():int {
			return _startIndex;
		}
		
		public function set startIndex(value:int):void {
			_startIndex = value > 0 ? value : 0;
			callLater(renderItems);
		}
		
		protected function renderItems():void {
			for (var i:int = 0, n:int = _cells.length; i < n; i++) {
				renderItem(_cells[i], _startIndex + i);
			}
			changeSelectStatus();
		}
		
		protected function renderItem(cell:Box, index:int):void {
			if (index < _array.length) {
				cell.visible = true;
				cell.dataSource = _array[index];
			} else {
				cell.visible = false;
				cell.dataSource = null;
			}
			sendEvent(UIEvent.ITEM_RENDER, [cell, index]);
			if (_renderHandler != null) {
				_renderHandler.executeWith([cell, index]);
			}
		}
		
		/**列表数据源*/
		public function get array():Array {
			return _array;
		}
		
		public function set array(value:Array):void {
			exeCallLater(changeCells);
			_array = value || [];
			var length:int = _array.length;
			_totalPage = Math.ceil(length / (repeatX * repeatY));
			//重设selectedIndex
			_selectedIndex = _selectedIndex < length ? _selectedIndex : length - 1;
			//重设startIndex
			startIndex = _startIndex;
			//重设滚动条
			if (_scrollBar) {
				//自动隐藏滚动条
				var numX:int = _isVerticalLayout ? repeatX : repeatY;
				var numY:int = _isVerticalLayout ? repeatY : repeatX;
				var lineCount:int = Math.ceil(length / numX);
				_scrollBar.visible = _totalPage > 1;
				if (_scrollBar.visible) {
					_scrollBar.scrollSize = _cellSize;
					_scrollBar.thumbPercent = numY / lineCount;
					_scrollBar.setScroll(0, (lineCount - numY) * _cellSize, _startIndex / numX * _cellSize);
				} else {
					_scrollBar.setScroll(0, 0, 0);
				}
			}
		}
		
		/**最大分页数*/
		public function get totalPage():int {
			return _totalPage;
		}
		
		public function set totalPage(value:int):void {
			_totalPage = value;
		}
		
		/**当前页码*/
		public function get page():int {
			return _page;
		}
		
		public function set page(value:int):void {
			_page = value
			if (_array) {
				_page = value > 0 ? value : 0;
				_page = _page < _totalPage ? _page : _totalPage - 1;
				startIndex = _page * repeatX * repeatY;
			}
		}
		
		/**列表数据总数*/
		public function get length():int {
			return _array.length;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is int || value is String) {
				selectedIndex = int(value);
			} else if (value is Array) {
				array = value as Array
			} else {
				super.dataSource = value;
			}
		}
		
		/**单元格集合*/
		public function get cells():Vector.<Box> {
			exeCallLater(changeCells);
			return _cells;
		}
		
		/**滚动条皮肤*/
		public function get vScrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set vScrollBarSkin(value:String):void {
			removeChildByName("scrollBar");
			var scrollBar:ScrollBar = new VScrollBar();
			scrollBar.name = "scrollBar";
			scrollBar.right = 0;
			scrollBar.skin = value;
			addChild(scrollBar);
			callLater(changeCells);
		}
		
		/**滚动条皮肤*/
		public function get hScrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set hScrollBarSkin(value:String):void {
			removeChildByName("scrollBar");
			var scrollBar:ScrollBar = new HScrollBar();
			scrollBar.name = "scrollBar";
			scrollBar.bottom = 0;
			scrollBar.skin = value;
			addChild(scrollBar);
			callLater(changeCells);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeCells);
		}
		
		/**刷新列表*/
		public function refresh():void {
			array = _array;
		}
		
		/**获取单元格数据源*/
		public function getItem(index:int):Object {
			if (index > -1 && index < _array.length) {
				return _array[index];
			}
			return null;
		}
		
		/**修改单元格数据源*/
		public function changeItem(index:int, source:Object):void {
			if (index > -1 && index < _array.length) {
				_array[index] = source;
				//如果是可视范围，则重新渲染
				if (index >= _startIndex && index < _startIndex + _cells.length) {
					renderItem(getCell(index), index);
				}
			}
		}
		
		/**添加单元格数据源*/
		public function addItem(souce:Object):void {
			_array.push(souce);
			array = _array;
		}
		
		/**添加单元格数据源*/
		public function addItemAt(souce:Object, index:int):void {
			_array.splice(index, 0, souce);
			array = _array;
		}
		
		/**删除单元格数据源*/
		public function deleteItem(index:int):void {
			_array.splice(index, 1);
			array = _array;
		}
		
		/**获取单元格*/
		public function getCell(index:int):Box {
			exeCallLater(changeCells);
			if (index > -1 && _cells) {
				return _cells[(index - _startIndex) % _cells.length];
			}
			return null;
		}
		
		/**滚动到某个索引位置*/
		public function scrollTo(index:int):void {
			startIndex = index;
			if (_scrollBar) {
				var numX:int = _isVerticalLayout ? repeatX : repeatY;
				_scrollBar.value = (index / numX) * _cellSize;
			}
		}
		
		/**获取list内拖动结束位置的索引*/
		public function getDropIndex(e:DragEvent):int {
			var target:DisplayObject = e.data.dropTarget;
			for (var i:int = 0, n:int = _cells.length; i < n; i++) {
				if (_cells[i].contains(target)) {
					return _startIndex + i;
				}
			}
			return -1;
		}
	}
}